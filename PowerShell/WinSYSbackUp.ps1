<#
.SYNOPSIS

This script helps to make Windows System BackUp to target device

Version: 0.1.0

.DESCRIPTION

This script helps to make Windows System BackUp to target device

.NOTES

File Name : WinSYSbackUp.ps1
Author : Dmitri G. (2019)
Requires : PowerShell Version 4.0

.LINK

No Links here

.EXAMPLE

WinSYSbackUp.ps1 G:

Description
-----------
Starting the Windows System Disk C: backup to target disk G:

.EXAMPLE

WinSYSbackUp.ps1 /?

Description
-----------
Get short HELP...

.EXAMPLE

WinSYSbackUp.ps1 --help

Description
-----------
Get short HELP...

#>

########################################################################
# Created By: Dmitri G. (2019)
########################################################################

param(
    [parameter(Mandatory=$false)]
    [string]$option

) #end param

process {

########################################################################
# Variables SET
########################################################################

# Turn on/off DEBUG reporting. Uncomment it if ON!
# $DebugPreference = "Continue"

# The help message output
If ($option.Equals("--help") -or $option.Equals("/?") -or $option.Equals("")) {
  Write-Host "`n"
  Write-Host "  Usage:" -ForegroundColor Cyan
  Write-Host "  ------" -ForegroundColor Cyan
  Write-Host -NoNewline "> WinSYSbackUp.ps1 G:" -ForegroundColor Yellow
  Write-Host "  # Create Windows System BackUp on target disk G:" -ForegroundColor Cyan
  Write-Host -NoNewline "> WinSYSbackUp.ps1 /?" -ForegroundColor Yellow
  Write-Host "  # Get current help message" -ForegroundColor Cyan
  Write-Host "`n"
  Write-Host "  Notes:" -ForegroundColor Cyan
  Write-Host "  ------" -ForegroundColor Cyan
  Write-Host "  Assumes that your system located on disk C:" -ForegroundColor Magenta
  Write-Host "  Don't forget to check the free space on target disk!" -ForegroundColor Magenta
  Write-Host "`n`a"
  Break
}

# Constants setup
# Set-Variable VariableName -option Constant -value ''

# Variables setup
[string]$strMessage1 = "Write-Host '`nMaking the Windows System Backup... Please Wait...`a' -ForegroundColor Yellow; "
[string]$strMessage2 = "Write-Host '`nDo Nothing!!!' -ForegroundColor Green; "

[string]$strCommand1 = "wbAdmin start backup -backupTarget:" + "$option" + " -include:C: -allCritical -quiet; "

[string[]]$argList = @('-NoExit')

$argList += $strMessage1 + $strCommand1

########################################################################
# Functions
########################################################################

function exception {
  Write-Host "`nSomething is going WRONG!!!`n`a" -ForegroundColor Red
}

function isAdministrator {
  $user = [Security.Principal.WindowsIdentity]::GetCurrent();
  (New-Object Security.Principal.WindowsPrincipal $user).IsInRole([Security.Principal.WindowsBuiltinRole]::Administrator)
}

function isUacEnabled {

  (Get-ItemProperty HKLM:\Software\Microsoft\Windows\CurrentVersion\Policies\System).EnableLua -ne 0
}

function actAsUAC {
  Write-Debug "`nUAC enabled"
  try { & Start-Process PowerShell.exe -Verb Runas -ArgumentList $argList } catch { exception }
}

function actASadmin {
  Write-Debug "`nForce Admin"
  try { & Start-Process PowerShell.exe -Credential Admin -ArgumentList $argList } catch { exception }
}

function action {
        try {
            Invoke-Expression -Command:$strMessage1
            Invoke-Expression -Command:$strCommand1
        } catch { exception }
}

########################################################################
# Program START HERE
########################################################################

if (isAdministrator) {
  Write-Debug "`nI'm Administrator"
  action
} else {
  Write-Debug "`nI'm NOT an Administrator"
  if (isUacEnabled) { actAsUAC } else { actASadmin }
}
}
