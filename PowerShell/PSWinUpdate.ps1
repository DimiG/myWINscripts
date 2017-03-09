<#
.SYNOPSIS

This script help install the Windows Updates

Version: 1.0.0

.DESCRIPTION

This script help install the Windows Updates via Windows Update PowerShell Module

.NOTES

File Name : PSWinUpdate.ps1
Author : Dmitri G. (2017)
Requires : PowerShell Version 4.0
Notes: Windows Update PowerShell Module can be located in
%WINDIR%\System32\WindowsPowerShell\v1.0\Modules

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

#>

########################################################################
# Created By: Dmitri G. (2017)
########################################################################

param(
    [parameter(Mandatory=$false)]
    [string]$option,
    [switch]$start

) #end param

process {

########################################################################
# Functions
########################################################################

function update {

  try {
    [string[]]$argList = @('-NoExit')

    if ($start) {
      $argList += "Write-Host '`nSetup Windows Updates... Please Wait...`a' -ForegroundColor Yellow; "
      $argList += "Get-WUInstall -NotCategory 'Language packs' -NotTitle Skype -AcceptAll -IgnoreReboot"
    } else {
      $argList += "Write-Host '`nList Windows Updates... Please Wait...' -ForegroundColor Green; "
      $argList += "Get-WUInstall -ListOnly"
    }

    & Start-Process PowerShell.exe -Verb Runas -ArgumentList $argList

    } catch {
      Write-Host "`nDid U install Windows Update PowerShell Module?!!`n`a" -ForegroundColor Red
    }
}

########################################################################
# Variables SET
########################################################################

# The help message output
If ($option.Equals("--help") -or $option.Equals("/?")) {
  Write-Host "`n"
  Write-Host "Usage:" -ForegroundColor Cyan
  Write-Host "------" -ForegroundColor Cyan
  Write-Host "> PSWinUpdate.ps1 -start" -ForegroundColor Yellow
  Write-Host "  Setup Updates" -ForegroundColor Cyan
  Write-Host "> PSWinUpdate.ps1" -ForegroundColor Yellow
  Write-Host "  List Updates" -ForegroundColor Cyan
  Write-Host "`n"
  Write-Host "Notes:" -ForegroundColor Cyan
  Write-Host "------" -ForegroundColor Cyan
  Write-Host "Windows Update PowerShell Module at:" -ForegroundColor Magenta
  Write-Host "  https://gallery.technet.microsoft.com/scriptcenter/2d191bcd-3308-4edd-9de2-88dff796b0bc" -ForegroundColor Magenta
  Write-Host "`n"
  Write-Host "Windows Update PowerShell Module can be located in:" -ForegroundColor Magenta
  Write-Host "  %WINDIR%\System32\WindowsPowerShell\v1.0\Modules" -ForegroundColor Magenta
  Write-Host "`n`a"
  Break
}

########################################################################
# Program START HERE
########################################################################

update

}
