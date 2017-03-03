<#
.SYNOPSIS

This script for Avid Media Server BackUP by internal Robocopy.exe

Version: 1.0.4

.DESCRIPTION

Backup media from Avid Media Server by Windows Robocopy.exe util
This scrypt is not fully tested and may work incorrectly.
Russian localisation

.NOTES

File Name : RoboSync.ps1
Author : Dmitri G. (2017) - dimi615@pisem.net
Requires : PowerShell Version 4.0
Be careful with sync direction. Mirror command may delete files.

.LINK

No any links. Internal use ;)

.EXAMPLE

RoboSyn.ps1 -SourcePath -DestPath -Log -Copy

Description
-----------
Backup with Log file

.EXAMPLE

RoboSyn.ps1 -SourcePath -DestPath

Description
-----------
Dry run

.EXAMPLE

RoboSyn.ps1 -SourcePath -DestPath -Copy -Mode Fast

Description
-----------
Multi-threaded fast copying

.EXAMPLE

RoboSyn.ps1 -SourcePath -DestPath -Copy -Mode SrvResume

Description
-----------
Resume big files copy from BAD server

.EXAMPLE

RoboSyn.ps1 -SourcePath -DestPath -Copy -Mode SrvCopy

Description
-----------
Copy files without Mirror (NO PURGE) from Server

.EXAMPLE

RoboSyn.ps1 -SourcePath -DestPath -Copy -Mode NormalCopy

Description
-----------
Copy files without Mirror (NO PURGE) locally

#>

########################################################################
# Created By: Dmitri G. (2016)
########################################################################

# Turn on/off DEBUG reporting

# DEBUG ON
# $DebugPreference = "Continue"
# DEBUG OFF
# $DebugPreference = "SilentlyContinue"

param(
[Parameter(Mandatory=$true)]
[string]$SourcePath,
[Parameter(Mandatory=$false)]
[string]$DestPath,
[switch]$Copy,
[ValidateSet("Server","SrvResume","SrvCopy","Normal","NormalCopy","Fast","Log")]
[string]$Mode="Normal",
[string]$IPG="30"

) #end param

########################################################################
# Variables SET
########################################################################

# The help message output
If ($SourcePath.Equals("--help") -or $SourcePath.Equals("/?")) {
  Write-Host "`n*** Надёжное копирование файлов ***`n" -ForegroundColor Yellow
  Write-Host "Варианты:" -ForegroundColor Yellow
  Write-Host "---------" -ForegroundColor Yellow
  Write-Host "> RoboSync.ps1 -SourcePath -DestPath" -ForegroundColor Yellow
  Write-Host "> RoboSync.ps1 -SourcePath -DestPath -Copy -Mode Fast" -ForegroundColor Yellow
  Write-Host "> RoboSync.ps1 -SourcePath -DestPath -Copy -Mode SrvResume" -ForegroundColor Yellow
  Write-Host "> RoboSync.ps1 -SourcePath -DestPath -Copy -Mode SrvCopy" -ForegroundColor Yellow
  Write-Host "> RoboSync.ps1 -SourcePath -DestPath -Copy -Mode NormalCopy`n`a" -ForegroundColor Yellow
  Break
}

[string]$strLogfile = "RoboSyncLog.txt"

Clear-Host

########################################################################
# Program START HERE
########################################################################

switch ($Copy)
{
    true
    {
        Write-Host "`nКопировка Файлов, ждите...`n`a" -ForegroundColor Red
        switch ($Mode)
        {
            "Server"
            {
                $strSwitches = ("/MIR", "/XJ", "/FFT", "/IPG:$IPG", "/R:7", "/TEE")
            }

            "SrvResume"
            {
                $strSwitches = ("/MIR", "/Z", "/XJ", "/FFT", "/IPG:$IPG", "/R:13", "/TEE")
            }

            "SrvCopy"
            {
                $strSwitches = ("/E", "/XJ", "/FFT", "/IPG:$IPG", "/R:7", "/TEE")
            }

            "Normal"
            {
                $strSwitches = ("/MIR", "/XJ", "/FFT", "/R:7", "/TEE")
            }

            "NormalCopy"
            {
                $strSwitches = ("/E", "/XJ", "/FFT", "/R:7", "/TEE")
            }

            "Fast"
            {
                $strSwitches = ("/MIR", "/XJ", "/FFT", "/MT", "/R:7", "/TEE")
            }

            "Log"
            {
                $strSwitches = ("/MIR", "/XJ", "/FFT", "/NP", "/R:7", "/TEE", "/LOG:$strLogfile")
            }

            default
            {
                Write-Host "`nОшибочка вышла...`n" -ForegroundColor Red
            }
        }
    }

    default
    {
      Write-Host "`nНЕЧЕГО ДЕЛАТЬ, Просто демонстрация...`n" -ForegroundColor Magenta
      $strSwitches = ("/MIR", "/XJ", "/FFT", "/R:7", "/TEE", "/L")
    }
}

& robocopy $SourcePath $DestPath $strSwitches

Write-Host "`nКомманда выполнена, Спасибо!`n" -ForegroundColor Green

