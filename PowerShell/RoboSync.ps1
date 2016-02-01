<#
.SYNOPSIS
This script for Avid Media Server BackUP by internal Robocopy.exe

.DESCRIPTION
Backup media from Avid Media Server by Windows Robocopy.exe util
This scrypt is not fully tested and may work incorrectly.
Russian localisation

.NOTES
File Name : RoboSync.ps1
Author : Dmitri G. (2016) - dimi615@pisem.net
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

RoboSyn.ps1 -SourcePath -DestPath -Copy -Fast

Description
-----------
Multi-threaded fast copying

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
[Parameter(Mandatory=$true)]
[string]$DestPath,
[switch]$Copy,
[switch]$Fast,
[switch]$Log

) #end param

########################################################################
# Variables SET
########################################################################

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
        if ($Log) { $strSwitches = ("/MIR", "/XJ", "/FFT", "/NP", "/R:7", "/TEE", "/LOG:$strLogfile") }
        elseif ($Fast){ $strSwitches = ("/MIR", "/XJ", "/FFT", "/MT","/R:7", "/TEE") }
        else { $strSwitches = ("/MIR", "/XJ", "/FFT", "/IPG:30","/R:7", "/TEE") }
    }

    default 
    {
      Write-Host "`nНЕЧЕГО ДЕЛАТЬ, Просто демонстрация...`n" -ForegroundColor Magenta
      $strSwitches = ("/MIR", "/XJ", "/FFT", "/R:7", "/TEE", "/L")
    }
}

& robocopy $SourcePath $DestPath $strSwitches

Write-Host "`nКомманда выполнена, Спасибо!`n" -ForegroundColor Green
