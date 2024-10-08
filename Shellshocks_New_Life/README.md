# Comprehensive Tool Documentation

This document provides an overview and description of each tool installed by the setup script. Each section includes the name of the tool, a brief description, and basic usage instructions.

## Automate the installation process for any cloud environment.
1. Download the script from a remote GitHub repository.
2. Modify the script's permissions to make it executable.
3. Execute the script with elevated (sudo) permissions.
```bash
curl -O https://raw.githubusercontent.com/Shellshock9001/Automation/refs/heads/main/Shellshocks_New_Life/shellshocks_new_life.sh && sudo chmod +x shellshocks_new_life.sh && sudo ./shellshocks_new_life.sh
```

## Common Dependencies
- **libcurl4-openssl-dev**
  - **Description:** Development files and documentation for libcurl (OpenSSL flavor).
- **libre2-dev**
  - **Description:** RE2 is a fast, safe, thread-friendly alternative to backtracking regular expression engines like those used in PCRE, Perl, and Python.
- **jq**
  - **Description:** Command-line JSON processor.
  - **Usage:** `jq '.' file.json`
- **ruby-full**
  - **Description:** A metapackage that installs the Ruby development environment.
- **zlib1g**
  - **Description:** Compression library - runtime.
- **libxml2, libxml2-dev**
  - **Description:** GNOME XML library.
- **libxslt-dev**
  - **Description:** XSLT 1.0 processing library - development kit.
- **ruby-dev**
  - **Description:** Header files for compiling extension modules for Ruby.
- **libgmp-dev**
  - **Description:** Multiprecision arithmetic library developers tools.
- **zlib1g-dev**
  - **Description:** Development files for the zlib compression library.
- **build-essential**
  - **Description:** Informational list of build-essential packages.
- **libssl-dev**
  - **Description:** SSL development libraries, header files, and documentation.
- **libffi-dev**
  - **Description:** Development files for the Foreign Function Interface (FFI) library.
- **python-dev-is-python3**
  - **Description:** This package is an alias for the default Python 3 development package.
- **libldns-dev**
  - **Description:** Development files for the LDNS library.
- **python3-dnspython**
  - **Description:** DNS toolkit for Python.
- **python3.venv**
  - **Description:** Package to create isolated Python environments.
- **python3-pip**
  - **Description:** Python package installer.
- **python3-poetry**
  - **Description:** Python dependency management and packaging made easy.
- **python3-setuptools**
  - **Description:** Easily download, build, install, upgrade, and uninstall Python packages.
- **python3-wheel**
  - **Description:** A built-package format for Python.
- **git**
  - **Description:** Fast, scalable, distributed revision control system.
- **rename**
  - **Description:** Perl-based file renaming utility with advanced features.
- **xdotool**
  - **Description:** Fake keyboard/mouse input, window management, and more.
- **fuse3**
  - **Description:** Filesystem in Userspace (FUSE) libraries and utilities.
- **curl**
  - **Description:** Command-line tool for transferring data with URL syntax.
- **wget**
  - **Description:** Non-interactive network downloader.
- **flex**
  - **Description:** A tool for generating scanners (programs that recognize lexical patterns in text).
- **pkg-config**
  - **Description:** Manage compile and link flags for libraries.
- **libewf-dev**
  - **Description:** Library for support of the Expert Witness Compression Format (EWF).
- **libreadline-dev**
  - **Description:** GNU readline and history libraries, development files.
- **libsqlite3-dev**
  - **Description:** SQLite 3 development files.
- **libncurses-dev**
  - **Description:** Developer's libraries for ncurses.
- **libnl-genl-3-dev**
  - **Description:** Development library for libnl.
- **libpcap-dev**
  - **Description:** Development files for libpcap (Packet Capture library).
- **libnm-dev**
  - **Description:** NetworkManager development files.
- **libcap-dev**
  - **Description:** Development files for libcap.
- **libxext-dev**
  - **Description:** X11 miscellaneous extensions library (development headers).
- **libxrender-dev**
  - **Description:** X Rendering Extension client library (development headers).
- **libxtst-dev**
  - **Description:** X11 Testing -- Record extension library (development headers).

## Exploitation Tools
- **backdoor-factory**
  - **Description:** A tool designed to patch executables with shellcode.
  - **Usage:** `sudo backdoor-factory`
- **bulk_extractor**
  - **Description:** Extracts useful information without parsing the file system or file system structures.
  - **Usage:** `bulk_extractor -o output_dir input_file`
- **commix**
  - **Description:** Automated All-in-One OS Command Injection and Exploitation Tool.
  - **Usage:** `sudo commix`
- **setoolkit (Social Engineering Toolkit)**
  - **Description:** An open-source penetration testing framework designed for social engineering.
  - **Usage:** `sudo setoolkit`
- **sqlmap-dev**
  - **Description:** Automatic SQL injection and database takeover tool.
  - **Usage:** `python sqlmap.py`
- **thc-ipv6**
  - **Description:** The most powerful IPv6 network penetration testing toolkit.
  - **Usage:** `sudo thc-ipv6`
- **yersinia**
  - **Description:** A network protocol attack framework.
  - **Usage:** `sudo yersinia -G`

## Forensics Tools
- **binwalk**
  - **Description:** A fast, easy-to-use tool for analyzing, reverse engineering, and extracting firmware images.
  - **Usage:** `binwalk firmware.bin`
- **capstone-tool**
  - **Description:** Lightweight multi-platform, multi-architecture disassembly framework.
  - **Usage:** Integrated into other tools.
- **chntpw**
  - **Description:** Utility to overwrite Windows SAM passwords.
  - **Usage:** `sudo chntpw -l /path/to/SAM/file`
- **dc3dd**
  - **Description:** Patched version of GNU dd for forensics and security.
  - **Usage:** `dc3dd if=input_file of=output_file`
- **gddrescue**
  - **Description:** Copies data from one file or block device to another, trying hard to rescue data in case of read errors.
  - **Usage:** `ddrescue input_file output_file log_file`
- **extundelete**
  - **Description:** Utility to recover deleted files from ext3/ext4 partition.
  - **Usage:** `extundelete --restore-all /dev/sdX`
- **foremost**
  - **Description:** A console program to recover files based on their headers, footers, and internal data structures.
  - **Usage:** `foremost -i image.dd`
- **galleta**
  - **Description:** An Internet Explorer cookie forensic analysis tool.
  - **Usage:** `galleta cookie_file`
- **ghidra**
  - **Description:** A software reverse engineering (SRE) suite of tools.
  - **Usage:** `ghidra`
- **guymager**
  - **Description:** A forensic imager for media acquisition.
  - **Usage:** `guymager`
- **p0f**
  - **Description:** A versatile passive OS fingerprinting, masquerade detection, and OS fingerprinting tool.
  - **Usage:** `p0f -i eth0`
- **py-pdf-parser**
  - **Description:** PDF parser library in Python.
  - **Usage:** `python -m py_pdf_parser yourfile.pdf`
- **regripper**
  - **Description:** A Windows Registry data extraction tool.
  - **Usage:** `rip.pl -r registry_file -f plugin`

## Frameworks
- **beef-xss**
  - **Description:** The Browser Exploitation Framework Project.
  - **Usage:** `sudo beef-xss`
- **Covenant**
  - **Description:** A collaborative .NET C2 framework for red teamers.
  - **Usage:** `sudo docker run -it -p 7443:7443 -p 80:80 -p 443:443 --name covenant -v /opt/shellshock/tools/Covenant/Covenant/Data:/app/Data covenant`
- **Empire**
  - **Description:** A post-exploitation framework that includes a pure-PowerShell 2.0 Windows agent, and communications.
  - **Usage:** `sudo ./ps-empire`
- **Havoc**
  - **Description:** Modern and malleable post-exploitation command and control framework.
  - **Usage:** `sudo ./havoc server --profile ./profiles/havoc.yaotl -v --debug`
- **osrframework**
  - **Description:** OSRFramework is a GNU AGPLv3+ set of libraries developed by i3visio to perform Open Source Intelligence (OSINT) tasks.
  - **Usage:** `sudo python3 osrframework`
- **routersploit**
  - **Description:** The Router Exploitation Framework.
  - **Usage:** `source shellshock_routersploit/bin/activate && python3 rsf.py`
- **sliver**
  - **Description:** A general purpose cross-platform implant framework that supports C2 over Mutual-TLS, HTTP(S), and DNS.
  - **Usage:** `sudo ./sliver`

## Hardware Hacking Tools
- **android-sdk**
  - **Description:** A development environment for building applications for the Android platform.
  - **Usage:** Integrated into other tools.
- **apktool**
  - **Description:** A tool for reverse engineering Android apk files.
  - **Usage:** `apktool d app.apk`
- **arduino**
  - **Description:** An open-source electronics platform based on easy-to-use hardware and software.
  - **Usage:** `arduino`
- **dex2jar**
  - **Description:** Tools to work with Android .dex and Java .class files.
  - **Usage:** `d2j-dex2jar app.apk`
- **smali**
  - **Description:** An assembler/disassembler for Android's dex format.
  - **Usage:** `smali disassemble class.dex`

## Information Gathering Tools
- **asnlookup**
  - **Description:** ASN Lookup - Look up for information about ASNs.
  - **Usage:** `asnlookup ASN`
- **arp-scan**
  - **Description:** A command-line tool for system discovery and fingerprinting.
  - **Usage:** `sudo arp-scan -l`
- **bing-ip2hosts**
  - **Description:** Uses Bing search engine to find virtual hosts on the same IP address.
  - **Usage:** `python bing-ip2hosts.py`
- **dirsearch**
  - **Description:** A simple command line tool designed to brute force directories and files in webservers.
  - **Usage:** `python3 dirsearch.py -u example.com`
- **dmitry**
  - **Description:** Deepmagic Information Gathering Tool.
  - **Usage:** `dmitry -winsepfb target`
- **dnsenum**
  - **Description:** Perl script to enumerate DNS information.
  - **Usage:** `dnsenum example.com`
- **dnsmap**
  - **Description:** A subdomain brute-forcing tool.
  - **Usage:** `dnsmap example.com`
- **dnsrecon**
  - **Description:** DNS Enumeration Script.
  - **Usage:** `dnsrecon -d example.com`
- **dnstracer**
  - **Description:** Trace DNS queries to the source.
  - **Usage:** `dnstracer example.com`
- **dnswalk**
  - **Description:** DNS debugger.
  - **Usage:** `dnswalk example.com`
- **enum4linux**
  - **Description:** A Linux alternative to enum.exe for enumerating data from Windows machines.
  - **Usage:** `enum4linux target_ip`
- **ffuf**
  - **Description:** A fast web fuzzer written in Go.
  - **Usage:** `ffuf -u https://example.com/FUZZ -w wordlist.txt`
- **fierce**
  - **Description:** A DNS reconnaissance tool for locating non-contiguous IP space.
  - **Usage:** `fierce --domain example.com`
- **firewalk**
  - **Description:** A network security auditing tool.
  - **Usage:** `firewalk -n -S 3 -i eth0 -p TCP -d 10.0.0.1 -r 10.0.0.2`
- **hping3**
  - **Description:** A network tool able to send custom TCP/IP packets and to display target replies.
  - **Usage:** `hping3 -S -p 80 -c 1 example.com`
- **httprobe**
  - **Description:** Take a list of domains and probe for working HTTP and HTTPS servers.
  - **Usage:** `cat domains.txt | httprobe`
- **knock.py**
  - **Description:** A python tool designed to enumerate subdomains on a target domain through a wordlist.
  - **Usage:** `knockpy example.com`
- **lazys3**
  - **Description:** A ruby script to bruteforce for AWS S3 buckets using different permutations.
  - **Usage:** `ruby lazys3.rb example`
- **lynis**
  - **Description:** Security auditing tool for Unix-based systems.
  - **Usage:** `sudo lynis audit system`
- **masscan**
  - **Description:** Mass IP port scanner, very fast.
  - **Usage:** `sudo masscan -p1-65535 10.0.0.0/8`
- **massdns**
  - **Description:** A high-performance DNS stub resolver for bulk lookups and reconnaissance.
  - **Usage:** `./massdns -r resolvers.txt -t A -o S -w results.txt example.com`
- **nbtscan-unixwiz**
  - **Description:** A command-line tool that scans for open NETBIOS nameservers on a local or remote TCP/IP network.
  - **Usage:** `nbtscan 10.0.0.1/24`
- **net-tools**
  - **Description:** A collection of programs that form the base set of the NET-3 networking distribution.
  - **Usage:** Integrated into other tools.
- **nmap**
  - **Description:** Network exploration tool and security/port scanner.
  - **Usage:** `nmap -sV -A example.com`
- **ntopng**
  - **Description:** High-speed web-based traffic analysis and flow collection tool.
  - **Usage:** `ntopng`
- **nuclei**
  - **Description:** Fast and customizable vulnerability scanner based on simple YAML based DSL.
  - **Usage:** `nuclei -u https://example.com`
- **parsero**
  - **Description:** A robot.txt audit tool.
  - **Usage:** `parsero -o output.html https://example.com`
- **recon-ng**
  - **Description:** A full-featured Web Reconnaissance framework written in Python.
  - **Usage:** `source shellshock_reconng/bin/activate && recon-ng`
- **SecLists**
  - **Description:** A collection of multiple types of lists used during security assessments.
  - **Usage:** Integrated into other tools.
- **SIPVicious**
  - **Description:** A set of tools for auditing SIP-based VoIP systems.
  - **Usage:** `svmap example.com`
- **smbmap**
  - **Description:** A handy SMB enumeration tool.
  - **Usage:** `smbmap -H example.com`
- **sntop**
  - **Description:** An ncurses-based utility that polls hosts to determine connectivity.
  - **Usage:** `sntop`
- **sslyze**
  - **Description:** Fast and comprehensive SSL/TLS configuration analyzer.
  - **Usage:** `sslyze example.com`
- **subfinder**
  - **Description:** A subdomain discovery tool that discovers valid subdomains for websites.
  - **Usage:** `subfinder -d example.com`
- **sublist3r**
  - **Description:** Fast subdomains enumeration tool for penetration testers.
  - **Usage:** `sublist3r -d example.com`
- **teh_s3_bucketeers**
  - **Description:** S3 bucket finder.
  - **Usage:** `ruby s3_bucketeers.rb example`
- **unfurl**
  - **Description:** Extract URLs and data from a variety of inputs.
  - **Usage:** `echo 'http://example.com' | unfurl`
- **urlcrazy**
  - **Description:** Domain typo generator for detecting typo squatting, phishing, and corporate espionage.
  - **Usage:** `urlcrazy example.com`
- **wfuzz**
  - **Description:** Web application brute forcer.
  - **Usage:** `wfuzz -c -z file,wordlist.txt -u https://example.com/FUZZ`
- **wireshark**
  - **Description:** Network protocol analyzer.
  - **Usage:** `wireshark`
- **whois**
  - **Description:** An intelligent WHOIS client.
  - **Usage:** `whois example.com`

## Password Attacks Tools
- **john**
  - **Description:** John the Ripper, a password cracking tool.
  - **Usage:** `john --wordlist=rockyou.txt hash.txt`
- **hashcat**
  - **Description:** The fastest password recovery tool.
  - **Usage:** `hashcat -m 0 -a 0 hash.txt wordlist.txt`
- **hydra**
  - **Description:** A very fast network logon cracker which supports many different services.
  - **Usage:** `hydra -l admin -P passwords.txt example.com http-get /`
- **medusa**
  - **Description:** A speedy, massively parallel, modular, login brute-forcer.
  - **Usage:** `medusa -h example.com -u admin -P passwords.txt -M ssh`
- **ncrack**
  - **Description:** High-speed network authentication cracking tool.
  - **Usage:** `ncrack -p 22,80,443 example.com`

## Reverse Engineering Tools
- **radare2**
  - **Description:** Open-source software for reverse engineering and analyzing binaries.
  - **Usage:** `r2 -d binary`
- **cutter**
  - **Description:** Free and open-source reverse engineering platform powered by radare2.
  - **Usage:** `./Cutter-v2.3.4-Linux-x86_64.AppImage`

## Wireless Testing Tools
- **reaver**
  - **Description:** Brute force attack against WiFi Protected Setup (WPS).
  - **Usage:** `sudo reaver -i wlan0 -b BSSID -vv`
- **aircrack-ng**
  - **Description:** A set of tools for auditing wireless networks.
  - **Usage:** `aircrack-ng -w wordlist capture_file`
- **wifite**
  - **Description:** An automated wireless attack tool.
  - **Usage:** `sudo wifite`

## Web Application Analysis Tools
- **burp**
  - **Description:** Integrated platform for performing security testing of web applications.
  - **Usage:** `burpsuite`
```bash
cd /opt/shellshock/tools
sudo mkdir burpsuite
cd /opt/shellshock/tools/burpsuite
sudo wget "https://portswigger-cdn.net/burp/releases/download?product=community&version=2024.5.5&type=Linux" -O burpsuite_community_linux.sh
sudo chmod +x burpsuite_community_linux.sh
sudo ./burpsuite_community_linux.sh &
sleep 15
window_id=$(xdotool search --onlyvisible --class install4j-installer 2>/dev/null | head -n 1)
[ -n "$window_id" ] && xdotool windowactivate --sync $window_id && xdotool type --delay 500 "/opt/shellshock/tools/burpsuite" && xdotool key --delay 500 Return && sleep 5 && xdotool key --delay 500 Return && sleep 5 && xdotool key --delay 500 Return && sleep 10 && xdotool key --delay 500 Return && sleep 15 && xdotool key --delay 500 Tab && xdotool key --delay 500 Return || echo "Installer window not found. Please check if the installer is running correctly."
``` 
- **nikto**
  - **Description:** A web server scanner which performs comprehensive tests against web servers.
  - **Usage:** `nikto -h example.com`
- **wpscan**
  - **Description:** WordPress security scanner.
  - **Usage:** `wpscan --url example.com`
- **zap**
  - **Description:** OWASP Zed Attack Proxy (ZAP).
  - **Usage:** `zap`

## Miscellaneous Tools
- **tmux**
  - **Description:** Terminal multiplexer.
  - **Usage:** `tmux`
- **vim**
  - **Description:** Highly configurable text editor.
  - **Usage:** `vim`
- **nano**
  - **Description:** Easy-to-use text editor.
  - **Usage:** `nano`
- **htop**
  - **Description:** Interactive process viewer.
  - **Usage:** `htop`

## Maintaining Access Tools
- **dns2tcp**
  - **Description:** TCP over DNS tunnel.
  - **Usage:** `dns2tcpc -z example.com`
- **httptunnel**
  - **Description:** Tunnels a data stream in HTTP requests.
  - **Usage:** `hts -F localhost:22 -p 8888`
- **nishang**
  - **Description:** PowerShell for penetration testing and offensive security.
  - **Usage:** Integrated into other tools.
- **polenum**
  - **Description:** Extracts password policy information for Windows machines.
  - **Usage:** `polenum target`
- **pwnat**
  - **Description:** NAT to NAT client-server communication tool.
  - **Usage:** `pwnat -s`
- **sbd**
  - **Description:** Netcat-clone, designed to be portable and offer strong encryption.
  - **Usage:** `sbd example.com 80`
