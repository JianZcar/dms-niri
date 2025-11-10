#!/bin/bash

echo "::group:: ===$(basename "$0")==="

set -ouex pipefail

/ctx/helper/config-apply.sh

grep -E '^greetd:' /usr/etc/passwd | tee -a /etc/passwd
grep -E '^greeter:' /usr/etc/passwd | tee -a /etc/passwd
grep -E '^greetd:' /usr/etc/group | tee -a /etc/group
grep -E '^greeter:' /usr/etc/group | tee -a /etc/group

echo "debugging"
cat /etc/pam.d/greetd
getent passwd greeter
groups greeter

sed -i 's/^#AutomaticUpdatePolicy=none/AutomaticUpdatePolicy=stage/' /etc/rpm-ostreed.conf
sed -i 's/^#LockLayering=false/LockLayering=true/' /etc/rpm-ostreed.conf
sed -i 's/#UserspaceHID.*/UserspaceHID=true/' /etc/bluetooth/input.conf

curl -Lo /etc/flatpak/remotes.d/flathub.flatpakrepo https://dl.flathub.org/repo/flathub.flatpakrepo && \
echo "Default=true" | tee -a /etc/flatpak/remotes.d/flathub.flatpakrepo > /dev/null
flatpak remote-add --if-not-exists --system flathub /etc/flatpak/remotes.d/flathub.flatpakrepo
flatpak remote-modify --system --enable flathub

echo "::endgroup::"
