#!/bin/bash

echo "::group:: ===$(basename "$0")==="

set -ouex pipefail

shopt -s nullglob

dnf install niri --setopt=install_weak_deps=False
dnf install quickshell xwayland-satellite dms accountsservice dms-greeter
