<#
.SYNOPSIS

This script help install the Windows Updates

Version: 1.0.2

.DESCRIPTION

This script help install the Windows Updates via Windows Update PowerShell Module

.NOTES

File Name : PSWinUpdate.ps1
Author : Dmitri G. (2017)
Requires : PowerShell Version 4.0
Notes: Windows Update PowerShell Module can be located in
C:\Windows\System32\WindowsPowerShell\v1.0\Modules

.LINK

Windows Update PowerShell Module:
https://gallery.technet.microsoft.com/scriptcenter/2d191bcd-3308-4edd-9de2-88dff796b0bc

.EXAMPLE

PSWinUpdate.ps1 -start

Description
-----------
Start Windows Updates...

.EXAMPLE

PSWinUpdate.ps1

Description
-----------
List Windows Updates...

.EXAMPLE

PSWinUpdate.ps1 /?

Description
-----------
Get short HELP...

#>

########################################################################
# Created By: Dmitri G. (2017)
########################################################################

param(
    [parameter(Mandatory=$false)]
    [string]$option,
    [switch]$setup

) #end param

process {

########################################################################
# Variables SET
########################################################################

# Turn on/off DEBUG reporting. Uncomment it if ON!
# $DebugPreference = "Continue"

# The help message output
If ($option.Equals("--help") -or $option.Equals("/?")) {
  Write-Host "`n"
  Write-Host "  Usage:" -ForegroundColor Cyan
  Write-Host "  ------" -ForegroundColor Cyan
  Write-Host -NoNewline "> PSWinUpdate.ps1 -setup" -ForegroundColor Yellow
  Write-Host "  # Setup Microsoft Updates" -ForegroundColor Cyan
  Write-Host -NoNewline "> PSWinUpdate.ps1" -ForegroundColor Yellow
  Write-Host "  # List Microsoft Updates" -ForegroundColor Cyan
  Write-Host "`n"
  Write-Host "  Notes:" -ForegroundColor Cyan
  Write-Host "  ------" -ForegroundColor Cyan
  Write-Host "  Windows Update PowerShell Module download at:" -ForegroundColor Magenta
  Write-Host "  https://gallery.technet.microsoft.com/scriptcenter/2d191bcd-3308-4edd-9de2-88dff796b0bc" -ForegroundColor Magenta
  Write-Host "`n"
  Write-Host "  Windows Update PowerShell Module can be located in:" -ForegroundColor Magenta
  Write-Host "  C:\Windows\System32\WindowsPowerShell\v1.0\Modules" -ForegroundColor Magenta
  Write-Host "`n`a"
  Break
}

# Constants setup
# Set-Variable VariableName -option Constant -value ''

# Variables setup
[string]$strMessage1 = "Write-Host '`nSetup Windows Updates... Please Wait...`a' -ForegroundColor Yellow; "
[string]$strMessage2 = "Write-Host '`nList Windows Updates... Please Wait...' -ForegroundColor Green; "

[string]$strCommand0 = "PowerShell -Command Import-Module PSWindowsUpdate; "
[string]$strCommand1 = "Get-WUInstall -NotCategory 'Language packs' -NotTitle Skype -AcceptAll -IgnoreReboot"
[string]$strCommand2 = "Get-WUInstall -ListOnly"

[string[]]$argList = @('-NoExit')

if ($setup) {

  $argList += $strMessage1 + $strCommand0 + $strCommand1

} else {

  $argList += $strMessage2 + $strCommand0 + $strCommand2

}

########################################################################
# Functions
########################################################################

function exception {

  Write-Host "`nDid U install Windows Update PowerShell Module?!!`n`a" -ForegroundColor Red

}

function IsAdministrator {

  $user = [Security.Principal.WindowsIdentity]::GetCurrent();
  (New-Object Security.Principal.WindowsPrincipal $user).IsInRole([Security.Principal.WindowsBuiltinRole]::Administrator)

}

function IsUacEnabled {

  (Get-ItemProperty HKLM:\Software\Microsoft\Windows\CurrentVersion\Policies\System).EnableLua -ne 0
}

function updateAsUAC {

  Write-Debug "`nUAC enabled"
  try { & Start-Process PowerShell.exe -Verb Runas -ArgumentList $argList } catch { exception }

}

function updateASadmin {

  Write-Debug "`nForce Admin"
  try { & Start-Process PowerShell.exe -Credential Admin -ArgumentList $argList } catch { exception }

}

function update {

  try {

    if ($setup) {
      Invoke-Expression -Command:$strMessage1
      Invoke-Expression -Command:$strCommand1
    } else {
      Invoke-Expression -Command:$strMessage2
      Invoke-Expression -Command:$strCommand2
    }

    } catch { exception }
}

########################################################################
# Program START HERE
########################################################################

if (IsAdministrator) {

  Write-Debug "`nI'm administrator"
  update

} else {

  Write-Debug "`nI'm NOT administrator"
  if (IsUacEnabled) { updateAsUAC } else { updateASadmin }

}

}
