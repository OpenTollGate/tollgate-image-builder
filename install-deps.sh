#!/bin/bash
set -e

# Install system dependencies
apt-get update
apt-get install -y gawk coreutils curl tar qemu-system-arm qemu-system-mips qemu-img socat
# Install python dependencies
if ! [ -x "$(command -v pip3)" ]; then
    apt-get install -y python3-pip
fi
pip3 install requests nostr
apt-get install -y libncurses5-dev libncursesw5-dev curl tar pigz
pip3 install -r requirements.txt
