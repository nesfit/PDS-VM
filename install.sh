#!/bin/bash

set -x
set -e

cd /tmp

apt update
apt upgrade -y

# Install OpenJDK 11
add-apt-repository ppa:openjdk-r/ppa
apt update -q
apt install -y openjdk-11-jdk

# Install Dotnet SDK 2.2
wget -q https://packages.microsoft.com/config/ubuntu/18.04/packages-microsoft-prod.deb
dpkg -i packages-microsoft-prod.deb
add-apt-repository universe
apt install -y apt-transport-https 
apt update
apt install -y dotnet-sdk-2.2
echo 'DOTNET_CLI_TELEMETRY_OPTOUT=1' >> /etc/environment

# Install GCC/G++
apt install -y gcc g++ build-essential

# Install Python
apt install -y python3.6 python3-pip

# Check installed core packages
java --version
dotnet --version
gcc --version
g++ --version
python3 --version
pip3 --version

# Install miscellaneous packages
apt install -y htop git

# Remove tracks
rm /root/.bash_history || true
rm /home/student/.bash_history || true
rm -rf /home/student/.ssh || true
