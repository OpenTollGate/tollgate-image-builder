#!/bin/bash
set -e

# Require root privileges
if [ "$EUID" -ne 0 ]; then
    echo "Please run with sudo"
    exit 1
fi


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


# Preserve the original user's GOPATH
ORIGINAL_USER=$(logname)
export GOPATH="/home/$ORIGINAL_USER/go"
export PATH="$PATH:/usr/local/go/bin:$GOPATH/bin"

# Create a directory for the project
echo "Creating directory for Blossom..."
mkdir -p /opt/blossom
cd /opt/blossom

# Clone the repository if not exists
if [ ! -d "blossom" ]; then
    git clone https://git.fiatjaf.com/blossom .
fi

# Download Go dependencies
echo "Downloading Go dependencies..."
go mod download

# Build the project
echo "Building Blossom..."
go build -o blossom .

# Make the binary executable and move to system-wide location
echo "Installing Blossom system-wide..."
chmod +x blossom
cp blossom /usr/local/bin/

# Print success message
echo "Blossom has been successfully installed!"
echo "The blossom binary is now available system-wide in /usr/local/bin"

# Deactivate the virtual environment (optional, but good practice)
deactivate

echo "Dependencies installed successfully within the virtual environment."
