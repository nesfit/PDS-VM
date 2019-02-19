#!/bin/bash

function appendLine {
    FILENAME="$1"
    LINE="$2"
    if [ -e "$FILENAME" ]
    then
        grep -q "^\s*$LINE" "$FILENAME" || echo "$LINE" >> "$FILENAME"
    else
        echo "$LINE" >> "$FILENAME"
    fi
}

function run_install {
    set -x
    set -e

    apt update
    apt upgrade -y

    # Install OpenJDK 11
    add-apt-repository -y ppa:openjdk-r/ppa
    apt update -q
    apt install -y openjdk-11-jdk

    # Install Dotnet SDK 2.2
    wget -q https://packages.microsoft.com/config/ubuntu/18.04/packages-microsoft-prod.deb
    dpkg -i packages-microsoft-prod.deb
    add-apt-repository -y universe
    apt install -y apt-transport-https 
    apt update
    apt install -y dotnet-sdk-2.2
    appendLine 'DOTNET_CLI_TELEMETRY_OPTOUT=1' /etc/environment

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
}


(cd /tmp; run_install)