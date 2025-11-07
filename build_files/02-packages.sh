#!/bin/bash

echo "::group:: ===$(basename "$0")==="

set -ouex pipefail

shopt -s nullglob

PKGS_TO_INSTALL=(
    @base-graphical
    @hardware-support
    @multimedia
    @fonts

    zram-generator-defaults

    git
    yq
    unzip

    fedora-release-ostree-desktop
    flatpak

    ptyxis
    nautilus
    morewaita-icon-theme
    adw-gtk3-theme

    nerd-fonts
    jetbrains-mono-fonts
    wl-copy

    ffmpegthumbnailer

    libmtp
    gvfs-mtp
    gvfs-gphoto2
)

PKGS_TO_UNINSTALL=(
)

dnf5 -y install "${PKGS_TO_INSTALL[@]}"
# dnf5 -y remove "${PKGS_TO_UNINSTALL[@]}"

echo "::endgroup::"
