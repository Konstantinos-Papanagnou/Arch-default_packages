#!/bin/bash

echo "Installing basic utilities"
pacman -S inetutils openssh git go make cmake nikto nmap nc firefox xterm hydra python-pip metasploit gdb radare2 chromium terminator
cd /opt
echo "Downloading SecLists..."
git clone https://github.com/danielmiessler/SecLists.git

echo "Downloading rockyou.txt.gz..."
wget https://github.com/praetorian-inc/Hob0Rules/raw/master/wordlists/rockyou.txt.gz
echo "Unpacking rockyou.txt.gz..."
gunzip rockyou.txt.gz

echo "Downloading gobuster..."
git clone https://github.com/OJ/gobuster.git
cd gobuster/
echo "Installing gobuster"
go get && go build
go install

echo "[+] In order to add gobuster binary to your path you can either move it to /bin directory or modify your PATH variable to include ~/go/bin folder"

echo "Downloading init..."
cd ..
git clone https://github.com/Konstantinos-Papanagnou/init.git
echo "Installing init..."
cd init
chmod +x setup.sh init.sh manual_init.sh
./setup.sh

echo "Downloading PhoneInformationTracer..."
cd /opt
git clone https://github.com/Konstantinos-Papanagnou/PhoneInformationTracer.git
echo "Installing PhoneInformationTracer..."
cd PhoneInformationTracer
chmod +x setup.sh PhoneInformationTracer.py
./setup.sh
pip install phonenumbers argparse

echo "Downloading IPTrace..."
cd /opt
git clone https://github.com/Konstantinos-Papanagnou/ipTrace.git
echo "Installing IPTrace..."
cd ipTrace/
chmod +x setup.sh iptrace.py
./setup.sh

echo "Downloading ffuf..."
cd /opt
git clone https://github.com/ffuf/ffuf
echo "Installing ffuf..."
cd ffuf
go get; go build
go install


echo "Configuring sublime-text installation..."
cd /opt
curl -O https://download.sublimetext.com/sublimehq-pub.gpg && sudo pacman-key --add sublimehq-pub.gpg && sudo pacman-key --lsign-key 8A8F901A && rm sublimehq-pub.gpg
rm sublimehq-pub.gpg
echo -e "\n[sublime-text]\nServer = https://download.sublimetext.com/arch/stable/x86_64" | sudo tee -a /etc/pacman.conf
echo "Downloading and installing sublime-text..."
pacman -Syu sublime-text


firefox https://portswigger.net/burp/communitydownload &

echo "Downloading GEF..."
cd /opt
wget -O ~/.gdbinit-gef.py -q http://gef.blah.cat/py
echo "Installing GEF..."
echo source ~/.gdbinit-gef.py >> ~/.gdbinit

echo "Downloading Ghidra..."
wget https://github.com/NationalSecurityAgency/ghidra/releases/download/Ghidra_10.0.4_build/ghidra_10.0.4_PUBLIC_20210928.zip
echo "Extracting Ghidra..."
unzip ghidra_10.0.4_PUBLIC_20210928.zip
rm ghidra_10.0.4_PUBLIC_20210928.zip
wget https://github.com/adoptium/temurin11-binaries/releases/download/jdk-11.0.13%2B8/OpenJDK11U-jdk_x64_linux_hotspot_11.0.13_8.tar.gz
tar -xzf OpenJDK11U-jdk_x64_linux_hotspot_11.0.13_8.tar.gz 
rm OpenJDK11U-jdk_x64_linux_hotspot_11.0.13_8.tar.gz
mv jdk-11.0.13+8/ jdk-11/
echo "Configure ghidra..."
echo "JDK Directory: /opt/jdk-11"
./ghidraRun
echo "Creating symlink for ghidra..."
ln -s /opt/ghidra_10.0.4_PUBLIC/ghidraRun /usr/bin/ghidra

echo "Downloading IDA Free..."
cd /opt
wget https://out7.hex-rays.com/files/idafree76_linux.run
echo "Please leave the default installation path"
chmod +x idafree76_linux.run && ./idafree76_linux.run
echo "Creating symlink for IDA..."
ln -s $HOME/idafree-7.6/ida64 /usr/bin/ida64
rm idafree76_linux.run


