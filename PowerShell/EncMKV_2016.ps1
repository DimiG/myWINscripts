<#
.SYNOPSIS

This script for MKV (Matroska) making

Version: 1.0.0

.DESCRIPTION

Create the MKV file with encoded multichannel and stereo sound.

Russian localisation

.NOTES

File Name : EncMKV_2016.ps1
Author : Dmitri G. (2016)
Requires : PowerShell Version 4.0
Requires : ffmpeg, aften (A/52 audio encoder), mkvmerge

.LINK

No any links. Internal use ;)

.EXAMPLE

EncMKV_2016.ps1 FileName -Mode CleanUp

Description
-----------
Convert video file to MKV (Matroska) with Encoded Multichannel and Stereo Audio
Delete the temporary files

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
[ValidateSet("CleanUp","NoCleanUp")]
[string]$Mode="CleanUp"

) #end param

process {

########################################################################
# Variables SET
########################################################################

# Current File Name without Extension
[string]$strippedFileName = [System.IO.Path]::GetFileNameWithoutExtension($SourceFile)

# Get new file name
[string]$Prefix = "_H264.AAC.AC3"
[string]$newFileName = $strippedFileName + $Prefix + [DateTime]::Now.ToString(".yyMMdd") + ".mkv"

# Temporary Names and Params
[string]$videoH264tmp = "video" + ".h264"
[string]$audioWAVtmp = "audio" + ".wav"
[string]$audioAACtmp = "audio" + ".m4a"
[string]$audioAC3tmp = "audio" + ".ac3"
[array]$tempFiles = @($videoH264tmp,$audioWAVtmp,$audioAACtmp,$audioAC3tmp)

# Command strings creation
[array]$strCommands = @("ffmpeg -i $SourceFile -vn -map 0:1 -acodec pcm_s16le -ac 6 $audioWAVtmp",
                        "aften $audioWAVtmp $audioAC3tmp",
                        "ffmpeg -i $audioWAVtmp -c:a aac -b:a 160k -ac 2 $audioAACtmp",
                        [string]::Concat("ffmpeg -i $SourceFile -an -c:v libx264 -b:v 6000k ",
                        "-minrate 6000k -maxrate 6000k -bufsize 2835k ",
                        "-pix_fmt yuv420p $videoH264tmp"),
                        "mkvmerge -o $newFileName $videoH264tmp $audioAACtmp $audioAC3tmp"
                        )

########################################################################
# Functions
########################################################################

function infStart {
  # Prepare the screen
  # Clear-Host
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
Write-Host "`nОчистка временных файлов...`n" -ForegroundColor Yellow

# CleanUp temporary files
foreach ($curFile in $tempFiles) {
    If (Test-Path $curFile) {
        Write-Host "Удаляю $curFile" -ForegroundColor Red
        Remove-Item $curFile
    }
}
}

########################################################################
# Program START HERE
########################################################################

infStart

# Debug
# Write-Host "`nDebug OUTPUT" -ForegroundColor Yellow
# Write-Host "Your mode is: $Mode" -ForegroundColor Yellow

If ($Mode -eq "CleanUp") {
  cleanTMP
}

Write-Host "`nОбработка Видео $SourceFile, Ждите...`n" -ForegroundColor Red

foreach ($curCommand in $strCommands) {

    If ($strCommands.IndexOf($curCommand) -eq 4) {
        Write-Host "`nУпаковка в MKV, Ждите...`n" -ForegroundColor Red
    }
    
    Invoke-Expression -Command:$curCommand
}

infStop

}
