<#
.SYNOPSIS

This script for DVD-VIDEO converting into ISO or VIDEO file
*** Recreated in 2016 ***

Version: 0.0.1

.DESCRIPTION

Modes List. Choose Mode format from table below:
ISO : Create ISO image
MP4 : Create MP4 file

Russian localisation

.NOTES

File Name : ConvertDVD_2016.ps1
Author : Dmitri G. (2016)

Requires : PowerShell Version 4.0
Requires : `mkisofs.exe' and `HandBrakeCLI.exe'

.LINK

No any links. Internal use ;)

.EXAMPLE

ConvertDVD_2016.ps1 SourceFolder -Mode ISO

Description
-----------
Convert DVD-VIDEO folder to ISO
SourceFolder is a where VIDEO_TS folder located

.EXAMPLE

ConvertDVD_2016.ps1 SourceFolder -Mode MP4

Description
-----------
Convert DVD-VIDEO folder to MP4 video file
SourceFolder is a VIDEO_TS folder

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
[string]$SourceFolder,
[ValidateSet("ISO","MP4")]
[string]$Mode="MP4",
[string]$Title="1"

) #end param

process {

########################################################################
# Variables SET
########################################################################

# Temporary Names and Params
[string]$OutputName1 = "DVD.mp4"
[string]$OutputName2 = "DVD.iso"

# Command strings creation
switch ($Mode)
{
    "MP4"
    {
        $strCommand =  [string]::Concat(
        "HandBrakeCLI.exe -i",
        " ",
        $SourceFolder,
        " ",
        "-o",
        " ",
        $OutputName1,
        " ",
        "-t",
        " ",
        $Title,
        " ",
        "-r 25 --cfr -d --crop 0:0:0:0 -b 4000 -B 160 -X 720 -e x264 -a 1 -E faac -6 dpl2 -R Auto -D 0.0 -f mp4",
        " ",
        "--strict-anamorphic -x ref=2:bframes=2:subme=6:mixed-refs=0:weightb=0:8x8dct=0:trellis=0"
        )
    }

    "ISO"
    {
        $strCommand =  [string]::Concat(
        "mkisofs.exe -dvd-video -o",
        " ",
        $OutputName2,
        " ",
        $SourceFolder,
        "/"
        )
    }

    default
    {
        Write-Host "`nОшибочка вышла...`n" -ForegroundColor Red
    }
}

########################################################################
# Functions
########################################################################

function infStart {
  # Prepare the screen
    Clear-Host
    $Time=Get-Date
    Write-Host "`n$Time Начали..." -ForegroundColor Green
}

function infStop {
  # Stop here
    $Time=Get-Date
    Write-Host "`a`n$Time Кодирование выполнено, Спасибо!`n" -ForegroundColor Green
    exit
}

########################################################################
# Program START HERE
########################################################################

infStart

# Debug
# Write-Host "`nDebug OUTPUT`n" -ForegroundColor Yellow
# Write-Host "`nYour command is: $strCommand`n" -ForegroundColor Yellow

Write-Host "`nОбработка DVD Видео $SourceFolder, Ждите...`n" -ForegroundColor Red
Invoke-Expression -Command:$strCommand

infStop

}
