FROM scratch AS ctx
COPY build_files /build_files
COPY press_kit /press_kit
COPY assets /assets


FROM ghcr.io/ublue-os/bazzite-nvidia-open:stable

RUN --mount=type=bind,from=ctx,source=/,target=/ctx \
    --mount=type=cache,dst=/var/cache \
    --mount=type=cache,dst=/var/log \
    --mount=type=tmpfs,dst=/tmp \
    /ctx/build_files/build.sh && \
    /ctx/build_files/github.sh && \
    /ctx/build_files/plasma.sh && \
    ostree container commit

# Copy ctx contents to final image so they're available at runtime
COPY --from=ctx / /ctx/
    
RUN bootc container lint
