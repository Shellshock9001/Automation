#!/bin/bash

# Sweet Tunes to listen to while everything installs
# This will open a headless YouTube player. Playing songs in the background without interrupting any active windows
# If you don't like the music, you can easily change it.
# Just paste new YouTube links in the array of YouTube video URLs
sudo apt-get install mpv -y

# Store the list of YouTube videos in an array
YouTube_Videos=(
  "https://www.youtube.com/watch?v=1OrNS2zbTZg"
  "https://www.youtube.com/watch?v=C3GouGa0noM"
  "https://www.youtube.com/watch?v=D818z-7BzuA"
  "https://www.youtube.com/watch?v=vpCTMddpQNs&list=PLjpNA1ed0KpUkW9BdxBCemsexf2ILTCpM&index=42"
)

# Create a temporary playlist file
shellshocks_playlist=$(mktemp /tmp/shellshocks_playlist.XXXXXX)

# Write the YouTube video URLs to the playlist file
for video in "${YouTube_Videos[@]}"; do
  echo "$video" >> "$shellshocks_playlist"
done

# Play the playlist in the background
mpv --no-video --quiet --cache=yes --cache-secs=25 --demuxer-readahead-secs=20 --volume=60 --playlist="$shellshocks_playlist" &

sleep 5
echo "Updating package lists..."
sudo apt-get update

echo "Upgrading existing packages..."
sudo apt-get upgrade -y

# Install GNOME Tweak Tool
echo "Installing GNOME Tweak Tool..."
sudo apt-get install gnome-tweak-tool -y

# Set Interface Text size to System-ui 15
echo "Setting Desktop Interface System-ui 15..."
gsettings set org.gnome.desktop.interface font-name 'System-ui 15'

# Set Document Text size to System-ui 15
echo "Setting Interface Text System-ui 15..."
gsettings set org.gnome.desktop.interface document-font-name 'System-ui 15'

# Set Monospace Text size to System-ui 15
echo "Setting Monospace Text size to System-ui 15..."
gsettings set org.gnome.desktop.interface monospace-font-name 'System-ui 15'

# Set Scaling Factor to 1.10
echo "Setting scaling factor to 1.10..."
gsettings set org.gnome.desktop.interface text-scaling-factor 1.10

echo "Font sizes and scaling factor have been updated."

# Checks to see if Sublime Text exists. If not then it will install it.

# Function to check if a command exists
command_exists() {
    command -v "$1" >/dev/null 2>&1
}

if command_exists subl; then
    echo "Sublime Text is already installed."
else
    echo "Sublime Text is not installed. Installing now..."

    # Ensure apt is set up to work with https sources
    sudo apt-get install apt-transport-https -y

    # Install the GPG key
    wget -qO - https://download.sublimetext.com/sublimehq-pub.gpg | gpg --dearmor | sudo tee /etc/apt/trusted.gpg.d/sublimehq-archive.gpg > /dev/null

    # Select the channel to use (Stable)
    echo "deb https://download.sublimetext.com/ apt/stable/" | sudo tee /etc/apt/sources.list.d/sublime-text.list

    # Update apt and install Sublime Text
    sudo apt-get update
    sudo apt-get install sublime-text -y

    # Verify the installation
    if command_exists subl; then
        echo "Sublime Text installation successful."
    else
        echo "Sublime Text installation failed."
        exit 1
    fi
fi

echo "Sublime Text setup complete."

echo "Installing common dependencies..."
sudo apt-get install -y \
    libcurl4-openssl-dev \
    libre2-dev \
    jq \
    ruby-full \
    zlib1g \
    libxml2 \
    libxml2-dev \
    libxslt-dev \
    ruby-dev \
    libgmp-dev \
    zlib1g-dev \
    build-essential \
    libssl-dev \
    libffi-dev \
    python-dev-is-python3 \
    libldns-dev \
    python3-dnspython \
    python3.venv \
    python3-pip \
    python3-poetry \
    python3-setuptools \
    python3-wheel \
    git \
    rename \
    xdotool \
    fuse3 \
    curl \
    wget \
    wmctrl \
    flex \
    pkg-config \
    libewf-dev \
    libreadline-dev \
    libsqlite3-dev \
    libncurses-dev \
    libnl-genl-3-dev \
    libpcap-dev \
    libnm-dev \
    libcap-dev \
    libxext-dev \
    libxrender-dev \
    libxtst-dev

echo "Cleaning up..."
sudo apt-get autoremove -y
sudo apt-get clean

echo "Common dependencies installation completed."

echo "Installing golang-go..."
sudo apt install golang-go -y
if [ $? -ne 0 ]; then
    echo "Failed to install Go"
    exit 1
fi

# Add Go binary to PATH
export PATH=$PATH:$(go env GOPATH)/bin
echo 'export PATH=$PATH:$(go env GOPATH)/bin' >> ~/.bashrc
source ~/.bashrc

#Creates a directory for tools to be installed, keeping the tools installed from this script separate from those in the original /opt/shellshock/tools directory.
sudo mkdir -p /opt/shellshock/tools

# Install Docker Using APT
cd /opt/shellshock/tools && sudo apt update && sudo apt install -y apt-transport-https ca-certificates curl gnupg-agent software-properties-common && curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add - && sudo add-apt-repository -y "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" && sudo apt update && sudo apt install -y docker-ce docker-ce-cli containerd.io

# Use this command to get the list of active docker containers
# sudo docker ps -a
# sudo docker rm "ID"
# sudo docker rm 45b4d969bcf0
# You will need this command after installing Covenant to run the docker and access Covenant
# sudo docker run -it -p 7443:7443 -p 80:80 -p 443:443 --name covenant -v /opt/shellshock/tools/Covenant/Covenant/Data:/app/Data covenant

# Start Havoc
# Install musl Compiler & Build Binary (From Havoc Root Directory)
# make ts-build

# Run the teamserver
# sudo ./havoc server --profile ./profiles/havoc.yaotl -v --debug

# Certain python scripts such as routersploit, knock.py and recon-ng required virtual enviornments variables to run each time
# They will have meaningfull names such as venv shellshock_setoolkit

# I am testing this symlink 
# cd /opt/shellshock/tools && sudo git clone https://github.com/threat9/routersploit && sudo chown -R $USER:$USER /opt/shellshock/tools/routersploit && cd /opt/shellshock/tools/routersploit && python3 -m venv shellshock_routersploit && source shellshock_routersploit/bin/activate && pip install setuptools future && pip install -r requirements.txt && python3 rsf.py && deactivate && echo '#!/bin/bash\nsource /opt/shellshock/tools/routersploit/shellshock_routersploit/bin/activate\npython3 /opt/shellshock/tools/routersploit/rsf.py "$@"\ndeactivate' > /opt/shellshock/tools/routersploit/rsf && chmod +x /opt/shellshock/tools/routersploit/rsf && sudo ln -s /opt/shellshock/tools/routersploit/rsf /usr/local/bin/rsf
# this will create a wrapper to activate the shellshock_routersploit venv
# making it executable and allowing you to run rsf.py in any directory

# You will have to move into the routersploit directory and activate the venv anytime you want to use it for now
# source shellshock_routersploit/bin/activate
# ./rsf.py

#### Exploitation Tools ####

# backdoor-factory
sudo apt-get install backdoor-factory -y

# bulk_extractor
cd /opt/shellshock/tools && sudo git clone --recurse-submodules https://github.com/simsong/bulk_extractor.git && cd /opt/shellshock/tools/bulk_extractor && sudo chmod +x bootstrap.sh && sudo ./bootstrap.sh && sudo ./configure && sudo make && sudo make install

# commix
sudo snap install commix

# set
cd /opt/shellshock/tools && sudo git clone https://github.com/trustedsec/social-engineer-toolkit/ setoolkit/ && sudo chown -R $USER:$USER /opt/shellshock/tools/setoolkit && cd /opt/shellshock/tools/setoolkit && python3 -m venv shellshock_setoolkit && source shellshock_setoolkit/bin/activate && pip install -r requirements.txt || true && deactivate && sudo python3 setup.py install

# sqlmap-dev
cd /opt/shellshock/tools && sudo git clone --depth 1 https://github.com/sqlmapproject/sqlmap.git sqlmap-dev

# thc-ipv6
sudo apt-get install thc-ipv6 -y

# yersinia
sudo apt-get install yersinia -y

#### Forensics Tools ####

# binwalk
sudo apt-get install binwalk -y

# capstone-tool
sudo apt-get install capstone-tool -y

# chntpw
sudo apt-get install chntpw -y

# dc3dd
sudo apt-get install dc3dd -y

# ddrescue
sudo apt-get install gddrescue -y

# extundelete
sudo apt-get install extundelete -y

# foremost
sudo apt-get install foremost -y

# galleta
sudo apt-get install galleta -y

# ghidra
sudo snap install ghidra

# guymager
sudo apt-get install guymager -y

# p0f
sudo apt-get install p0f -y

# pdf-parser
pip3 install py-pdf-parser

# regripper
sudo apt-get install regripper -y

#### Frameworks ####

# beef-xss
sudo apt-get install beef -y

# Covenant
cd /opt/shellshock/tools && sudo git clone --recurse-submodules https://github.com/cobbr/Covenant && cd /opt/shellshock/tools/Covenant/Covenant && sudo docker build -t covenant .

# Empire
cd /opt/shellshock/tools && sudo git clone --recursive https://github.com/BC-SECURITY/Empire.git && cd /opt/shellshock/tools/Empire && sudo ./setup/checkout-latest-tag.sh && sudo ./ps-empire install -y

# havoc
cd /opt/shellshock/tools && sudo git clone https://github.com/HavocFramework/Havoc.git && cd /opt/shellshock/tools/Havoc && cd teamserver && sudo go mod download golang.org/x/sys && sudo go mod download github.com/ugorji/go && cd .. && sudo make ts-build

# osrframework
cd /opt/shellshock/tools && sudo pip3 install osrframework && sudo pip3 install osrframework --upgrade

# routersploit
cd /opt/shellshock/tools && sudo git clone https://github.com/threat9/routersploit && sudo chown -R $USER:$USER /opt/shellshock/tools/routersploit && cd /opt/shellshock/tools/routersploit && python3 -m venv shellshock_routersploit && source shellshock_routersploit/bin/activate && pip install setuptools future && pip install -r requirements.txt && echo "exit" | python3 rsf.py && deactivate

# sliver
cd /opt/shellshock/tools && sudo git clone https://github.com/BishopFox/sliver.git && cd sliver && sudo make

#### Hardware Hacking Tools ####

# android-sdk
sudo apt-get install android-sdk -y

# apktool
sudo apt-get install apktool -y

# arduino
sudo apt-get install arduino -y

# dex2jar
cd /opt/shellshock/tools && sudo git clone https://github.com/pxb1988/dex2jar.git

# smali
sudo apt-get install smali -y

#### Information Gathering Tools ####

# anslookup
cd /opt/shellshock/tools && sudo git clone https://github.com/yassineaboukir/Asnlookup asnlookup/ && sudo chown -R $USER:$USER /opt/shellshock/tools/asnlookup && cd /opt/shellshock/tools/asnlookup && python3 -m venv shellshock_asnlookup && source shellshock_asnlookup/bin/activate && pip install -r requirements.txt || true && deactivate

# arp-scan
sudo apt-get install arp-scan -y

# bing-ip2hosts
cd /opt/shellshock/tools && sudo git clone https://github.com/urbanadventurer/bing-ip2hosts

# dirsearch
sudo apt-get install dirsearch -y

# dmitry
sudo apt-get install dmitry -y

# dnsenum
sudo apt-get install dnsenum -y

# dnsmap
sudo apt-get install dnsmap -y

# dnsrecon
sudo apt-get install dnsrecon -y

# dnstracer
sudo apt-get install dnstracer -y

# dnswalk
sudo apt-get install dnswalk -y

# enum4linux
sudo snap install enum4linux

# ffuf
sudo apt-get install ffuf -y

# fierce
sudo apt-get install fierce -y

# firewalk
sudo apt-get install firewalk -y

# hping3
sudo apt-get install hping3 -y

# httprobe
cd /opt/shellshock/tools && sudo go install github.com/tomnomnom/httprobe@latest

# knock.py
sudo apt-get install knockpy -y

# lazys3
cd /opt/shellshock/tools && sudo git clone https://github.com/nahamsec/lazys3.git

# lynis
sudo apt-get install lynis -y

# masscan
sudo apt-get install masscan -y

# massdns
cd /opt/shellshock/tools && sudo git clone https://github.com/blechschmidt/massdns.git

# nbtscan-unixwiz
cd /home/shellshock/tools && sudo git clone https://github.com/resurrecting-open-source-projects/nbtscan/ && cd /home/shellshock/tools/nbtscan && sudo ./autogen.sh && sudo ./configure && sudo make && sudo make install

# net-tools
sudo apt-get install net-tools -y

# nmap
sudo apt-get install nmap -y

# ntopng
sudo apt-get install ntopng -y

# ntopng-data
sudo apt-get install ntopng-data -y

# ntopng-doc
sudo apt-get install ntopng-doc -y

# nuclei
sudo go install -v github.com/projectdiscovery/nuclei/v3/cmd/nuclei@latest

# parsero
sudo apt-get install parsero -y

# recon-ng
cd /opt/shellshock/tools && sudo git clone https://github.com/lanmaster53/recon-ng.git && sudo chown -R $USER:$USER /opt/shellshock/tools/recon-ng && cd /opt/shellshock/tools/recon-ng && python3 -m venv shellshock_reconng && source shellshock_reconng/bin/activate && pip install -r REQUIREMENTS && deactivate

# seclist
cd /opt/shellshock/tools && sudo git clone https://github.com/danielmiessler/SecLists.git && cd /opt/shellshock/tools/SecLists/Discovery/DNS && sudo bash -c 'cat dns-Jhaddix.txt | head -n -14 > clean-jhaddix-dns.txt'

# SIPVicious
sudo apt-get install sipvicious -y

# smbmap
sudo apt-get install smbmap -y

# sntop
sudo apt-get install sntop -y

# sslyze
sudo pip3 install --upgrade sslyze

# subfinder
go install -v github.com/projectdiscovery/subfinder/v2/cmd/subfinder@latest

# sublist3r
sudo apt-get install sublist3r -y

# teh_s3_bucketeers.git
cd /opt/shellshock/tools && sudo git clone https://github.com/tomdev/teh_s3_bucketeers.git

# unfurl
cd /opt/shellshock/tools && sudo go install github.com/tomnomnom/unfurl@latest

# urlcrazy
sudo mkdir /home/shellshock/tools/ && cd /home/shellshock/tools/ && sudo gem install json colorize async async-dns async-http && sudo git clone https://github.com/urbanadventurer/urlcrazy.git

# wfuzz
sudo apt-get install wfuzz -y

# wireshark
echo 'wireshark-common wireshark-common/install-setuid boolean false' | sudo debconf-set-selections && sudo apt update && sudo apt install -y wireshark

# whois
sudo apt-get install whois -y

#### Password Attacks Tools ####

# john the rippah
sudo apt-get install john -y

# hashcat
sudo apt-get install hashcat -y

# hydra
sudo apt-get install hydra -y

# medusa
sudo apt-get install medusa -y

# ncrack
sudo apt-get install ncrack -y

#### Reverse Engineering Tools ####

# radare2
sudo apt-get install radare2 -y

# cutter
cd /opt/shellshock/tools && sudo mkdir cutter && cd /opt/shellshock/tools/cutter && sudo wget https://github.com/rizinorg/cutter/releases/download/v2.3.4/Cutter-v2.3.4-Linux-x86_64.AppImage && sudo chmod +x Cutter-v2.3.4-Linux-x86_64.AppImage

#### Wireless Testing Tools ####

# reaver
sudo apt-get install reaver -y

# aircrack-ng
sudo apt-get install aircrack-ng -y

# wifite
sudo apt-get install wifite -y

#### Web Application Analysis Tools ####

# burp
cd /opt/shellshock/tools && sudo mkdir burpsuite && cd burpsuite && sudo wget "https://portswigger-cdn.net/burp/releases/download?product=community&version=2024.5.5&type=Linux" -O burpsuite_community_linux.sh && sudo chmod +x burpsuite_community_linux.sh && sudo ./burpsuite_community_linux.sh & wait_for_window() { local window_name="$1"; local window_id; echo "Waiting for window: $window_name"; while true; do window_id=$(xdotool search --onlyvisible --name "$window_name" 2>/dev/null | head -n 1); if [ -n "$window_id" ]; then xdotool windowactivate --sync $window_id; echo "Window $window_name is active."; sleep 1; break; fi; sleep 0.5; done; }; perform_action() { local window_name="$1"; local action="$2"; wait_for_window "$window_name"; eval "$action"; }; perform_action "Setup - Burp Suite Community Edition" 'xdotool type --delay 200 "/opt/shellshock/tools/burpsuite" && xdotool key --delay 200 Return' && perform_action "Setup - Burp Suite Community Edition" 'xdotool key --delay 200 Return' && perform_action "Setup - Burp Suite Community Edition" 'xdotool key --delay 200 Return' && perform_action "Setup - Burp Suite Community Edition" 'xdotool key --delay 200 Return' && perform_action "Setup - Burp Suite Community Edition" 'xdotool key --delay 200 Tab && xdotool key --delay 200 Return' && echo "Installation process completed."

# nikto
sudo apt-get install nikto -y

# wpscan
cd /opt/shellshock/tools && sudo git clone https://github.com/wpscanteam/wpscan.git && cd /opt/shellshock/tools/wpscan && sudo bundle install --without test && sudo gem install wpscan

# zap
sudo snap install zaproxy --classic --channel=stable

#### Miscellaneous Tools ####

# tmux
sudo apt-get install tmux -y

# vim
sudo apt-get install vim -y

# nano
sudo apt-get install nano -y

# htop
sudo apt-get install htop -y

#### Maintaining Access Tools ####

# dns2tcp
sudo apt-get install dns2tcp -y

# httptunnel
sudo apt-get install httptunnel -y

# nishang
cd /opt/shellshock/tools && sudo git clone https://github.com/samratashok/nishang.git && echo 'export PATH=\"$PATH:/opt/shellshock/tools/nishang\"' >> ~/.bashrc && source ~/.bashrc

# polenum
sudo apt-get install polenum -y

# pwnat
cd /opt/shellshock/tools && sudo git clone https://github.com/samyk/pwnat.git && cd /opt/shellshock/tools/pwnat && sudo make

# sbd
sudo apt-get install sbd -y

echo "Installation complete!"
