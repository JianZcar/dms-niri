#!/bin/bash

echo "::group:: ===$(basename "$0")==="

set -ouex pipefail

RELEASE="$(rpm -E %fedora)"
mkdir -p /var/roothome

dnf5 -y install dnf5-plugins

COPRS=(
    ublue-os/staging

    trixieua/morewaita-icon-theme
    che/nerd-fonts
    yalter/niri
    ulysg/xwayland-satellite
    avengemedia/dms
    avengemedia/danklinux
    errornointernet/quickshell
)

for COPR in "${COPRS[@]}"; do
    echo "Enabling copr: $COPR"
    dnf5 -y copr enable "$COPR"
done

# REPOFILES=(
#     https://negativo17.org/repos/fedora-nvidia.repo
# )
#
# for REPO in "${REPOFILES[@]}"; do
#     dnf5 -y config-manager addrepo --from-repofile="$REPO"
# done

dnf5 -y config-manager setopt "*".exclude="*.aarch64"
dnf5 -y config-manager setopt "*fedora*".priority=1 "*fedora*".exclude="kernel-core-* kernel-modules-* kernel-uki-virt-*"
dnf5 -y config-manager setopt "*akmods*".priority=2
eval "$(/ctx/helper/dnf5-setopt.sh setopt '*negativo17*' priority=3 exclude='mesa-* *xone*')"
