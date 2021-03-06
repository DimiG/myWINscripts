<#
.SYNOPSIS

This script for Avid DNxHD MXF making.
Tested by Avid Media Composer 7.0.4

Version: 1.0.0

.DESCRIPTION

Avid DNxHD MXF Video Making with separated audio files.

.NOTES

File Name : EncAvidMXF_2016.ps1
Author : Dmitri G. (2016) - dimi615@pisem.net
Requires : PowerShell Version 4.0

.LINK

No any links. Internal use ;)

.EXAMPLE

EncAvidMXF_2016.ps1 FileName -Mode Four_Thirds -Proj Name

Description
-----------
Convert video file to Avid DNxHD MXF with separated audio files

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
[string]$SourceFile,
[ValidateSet("Four_Thirds","Wide")]
[string]$Mode="Wide",
[string]$Proj="ProjEnc"

) #end param

process {

########################################################################
# Variables SET
########################################################################

# Current Directory Name
[string]$directory = [System.IO.Path]::GetDirectoryName($SourceFile)

# Current File Name without Extension
[string]$strippedFileName = [System.IO.Path]::GetFileNameWithoutExtension($SourceFile)

# Output file name creation
[string]$outFilePath = [System.IO.Path]::Combine($directory, $strippedFileName)

# Get file extension and file name
[string]$extension = [System.IO.Path]::GetExtension($SourceFile)
[string]$newFileName = $strippedFileName + $extension

# Temporary Names and Params
[string]$videoTMP = "$strippedFileName" + ".dnxhd"
[string]$audioTMP = "$strippedFileName" + ".wav"

If ($Mode -Match "Wide") {
  [string]$strScale = "scale=1280:720"
} else {
  [string]$strScale = "scale=960:720"
}

# Command strings creation
$strCommand1 =  [string]::Concat(
  "ffmpeg -i",
  " ",
  $newFileName,
  " ",
  "-c:v dnxhd -b:v 60M -an -sws_flags lanczos -vf `"",
  $strScale,
  ", smartblur=1.0:-1.0`"",
  " ",
  $videoTMP,
  " ",
  "-vn -ar 48000 -c:a pcm_s16le",
  " ",
  $audioTMP
)

$strCommand2 = [string]::Concat(
  "raw2bmx",
  " ",
  "-t avid -f 25 --project",
  " ",
  $Proj,
  " ",
  "--clip",
  " ",
  $strippedFileName,
  " ",
  "-o",
  " ",
  $outFilePath,
  " ",
  "--vc3_720p_1252",
  " ",
  $videoTMP,
  " ",
  "--wave",
  " ",
  $audioTMP
)

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

function cleanTMP {
# Message
Write-Host "`nОчистка...`n" -ForegroundColor Yellow

# CleanUp temporary files
If (Test-Path $videoTMP) {
    Write-Host "Удаляю $videoTMP" -ForegroundColor Red
	Remove-Item $videoTMP
}

If (Test-Path $audioTMP) {
    Write-Host "Удаляю $audioTMP`n" -ForegroundColor Red
	Remove-Item $audioTMP
}

}

########################################################################
# Program START HERE
########################################################################

infStart

# Debug
# Write-Host "`nDebug OUTPUT`n" -ForegroundColor Yellow
# Write-Host "`nYour ffmpeg command is: $strCommand1`n" -ForegroundColor Yellow
# Write-Host "`nYour raw2bmx command is: $strCommand2`n" -ForegroundColor Yellow
# Write-Host "`nYour file path is: $directory`n" -ForegroundColor Green

Write-Host "`nОбработка Видео Avid DNxHD MXF $SourceFile, Ждите...`n" -ForegroundColor Red
Invoke-Expression -Command:$strCommand1

If ((Test-Path $videoTMP) -and (Test-Path $audioTMP)) {
  Write-Host "`nУпаковка в MXF, Ждите...`n" -ForegroundColor Red
  Invoke-Expression -Command:$strCommand2
}

cleanTMP

infStop

}
