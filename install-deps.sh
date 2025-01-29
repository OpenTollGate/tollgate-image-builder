#!/bin/bash

# Set the virtual environment directory (you can change this if needed)
VENV_DIR=".venv"

# Install system dependencies
sudo apt-get update
sudo apt-get install -y gawk coreutils curl tar qemu-system-arm qemu-system-mips socat

# Create the virtual environment if it doesn't exist
if [ ! -d "$VENV_DIR" ]; then
  echo "Creating virtual environment..."
  python3 -m venv "$VENV_DIR"
  if [ $? -ne 0 ]; then
    echo "Error creating virtual environment."
    exit 1
  fi
else
  echo "Virtual environment already exists."
fi

# Update apt and install build dependencies
sudo apt-get update
sudo apt-get install -y build-essential libssl-dev

# Activate the virtual environment
source "$VENV_DIR/bin/activate"

# Install dependencies using pip (replace with your actual dependencies)
echo "Installing dependencies..."
pip3 install nostr --no-deps
pip3 install cffi>=1.15.0 cryptography>=37.0.4 pycparser>=2.21

# Deactivate the virtual environment (optional, but good practice)
deactivate

echo "Dependencies installed successfully within the virtual environment."
