#!/bin/bash

function append_line {
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
    apt install -y openjdk-11-jdk ant maven

    # Install Dotnet SDK 3.1
    wget https://packages.microsoft.com/config/ubuntu/20.04/packages-microsoft-prod.deb -O packages-microsoft-prod.deb
    sudo dpkg -i packages-microsoft-prod.deb
    add-apt-repository -y universe
    apt install -y apt-transport-https 
    apt update
    apt install -y dotnet-sdk-3.1
    append_line 'DOTNET_CLI_TELEMETRY_OPTOUT=1' /etc/environment

    # Install GCC/G++
    apt install -y gcc g++ build-essential libssl-dev libpcap-dev libboost-dev libnet1-dev

    # Install Python3
    apt install -y python3 python3-pip
    pip3 install cython

    # Check installed core packages
    java --version
    dotnet --version
    gcc --version
    g++ --version
    python3 --version
    pip3 --version

    # Install miscellaneous packages
    apt install -y htop git nano mc zerofree cmake

    # Clean apt
    apt autoremove -y
    apt clean -y

    # Setup keyboard input sources
    gsettings set org.gnome.desktop.input-sources sources "[('xkb', 'cz'), ('xkb', 'us')]"

    chown -R student:student /home/student

    rm -f /root/.bash_history /home/student/.bash_history || true
    rm -rf /home/student/.ssh || true

    echo 'Installation completed'
}

(cd /tmp; run_install)