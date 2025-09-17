#!/bin/bash

set -ouex pipefail

dnf5 install -y tmux syncthing restic rclone micro

systemctl enable podman.socket
