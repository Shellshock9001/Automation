# Shellshocks Shattering Throw (No Win Trading) PowerShell Script

### Overview

`shellshocks_shattering_throw_none_win_trading.ps1` is a streamlined PowerShell script designed to automate security checks on Windows systems.
Unlike its counterpart, the original `shellshocks_shattering_throw.ps1`, this version **does not rely on** external vulnerability databases like `win_trading.ps1` nor does it **automatically check for or exploit CVEs**.
This makes it a safer alternative for penetration testers or system administrators working in environments with strict rules (e.g., **OSCP** guidelines), where exploitation or vulnerability checking could be disallowed.

##
### Features

- **Tool Execution Automation**: The script automates the execution of various security tools, including **Sherlock**, **PowerUp**, **JAWS**, **PowerView**, and **SharpHound**.
- **Customizable Setup**: It allows for the customization of tool paths and output file locations to suit different Windows environments.
- **OSCP Compliant**: The script **does not perform any automated vulnerability exploitation**, making it appropriate for use in educational environments like OSCP labs where exploit scripts are disallowed.

##
### Tools Integrated

### 1. **Sherlock**
Sherlock is used to find local privilege escalation vulnerabilities on the target system.

### 2. **PowerUp**
PowerUp is used to enumerate potential misconfigurations and perform privilege escalation checks.

### 3. **JAWS (Just Another Windows Script)**
JAWS performs comprehensive enumeration of Windows systems, providing detailed information on various aspects of the target system’s configuration.

### 4. **PowerView**
PowerView is used for network and domain enumeration, allowing insight into user accounts, group memberships, and more.

### 5. **SharpHound**
SharpHound collects data for BloodHound, which helps identify privilege escalation paths within Active Directory environments.

##
### Usage
### Prerequisites

Ensure that all the necessary security tools (**Sherlock**, **PowerUp**, **JAWS**, **PowerView**, **SharpHound**) are hosted on a server or available for download. You can modify the script to point to specific URLs for tool downloads if necessary.

##
### Steps to Run Shellshocks Shattering Throw:
1. Pre-Download the Required Scripts from GitHub:
First, you need to download the required security tools (Sherlock, PowerUp, JAWS, PowerView, SharpHound) from my GitHub repository and host them on a simple Python web server.

Clone or Download the Repository:

```bash
git clone https://github.com/Shellshock9001/your-repo-name
```
Host a Python Web Server: Navigate to the folder containing the scripts you’ve downloaded and run a Python web server:

```bash
cd /path/to/your/downloaded/scripts
```
```bash
python3 -m http.server 8000
```
2. Set the $AttackerMachine to Your IP:
You'll need to set the $AttackerMachine variable in the shellshocks_shattering_throw_none_win_trading.ps1 script to point to your IP address. Replace the current value with the IP of your Python web server. For example:

```powershell
$AttackerMachine = "http://Your_AttackingMachine_IP"
```
3. Transfer the Script to the Target Machine:
Download or transfer the script to the target system or testing environment. This can be done through SCP, a USB drive, or any other preferred method.

4. Run the Script:
Open PowerShell as Administrator on the target system, navigate to the directory where the script is located, and run the script:

```powershell
./shellshocks_shattering_throw_none_win_trading.ps1
```
5. Review the Results:
The script will automatically:
- Create the required directories (`C:\Temp\Shellshock`).
- Download and execute the tools (Sherlock, PowerUp, JAWS, PowerView, and SharpHound).
- Save the output to the following file:
`C:\Temp\Shellshock\shellshocks_security_checks.txt`
- The results will show potential local privilege escalation vulnerabilities and misconfigurations found by the tools in the Windows environment.

##
### Customization
You can modify several hardcoded variables in the script to suit your environment:

- OutputFile: Where the results of the tools will be saved (default: `C:\\Temp\\Shellshock\\shellshocks_security_checks.txt`).
- ToolDownloadDir: Directory where downloaded tools will be stored (default: `C:\\Temp\\Shellshock`).
- AttackerMachine: URL where the tools are hosted for downloading (you can host your tools on a web server).

##
### Example Execution
When executed, the script will produce output similar to the following in the PowerShell console:
```sql
Starting security checks...
Running Sherlock...
Sherlock completed and output saved.
Running PowerUp...
PowerUp completed and output saved.
...
All security checks are complete. Results saved to C:\\Temp\\Shellshock\\shellshocks_security_checks.txt.
```
##
### Security Considerations
- User Privileges: The script requires administrator privileges to run effectively, as many tools like Sherlock and PowerUp need elevated permissions.
- Network Access: Ensure your environment permits access to the external server hosting the tools.

##
### Known Limitations
- Tool Availability: The script relies on specific tools like Sherlock and PowerUp being available for download or hosted on an internal server. Users must ensure these are correctly configured.
- No Exploit Checks: By design, this version does not check for vulnerabilities or perform any exploits. If you're looking for a version that includes vulnerability checks, consider using the full shellshocks_shattering_throw.ps1 script (which may be restricted in environments like OSCP).
