<# 
 .Synopsis
   PowerShell MKV to MP4 lossless converter
   This script contains a MKV converter script
   by mkvmerge, mkvextract and MP4Box.
      
   *Note: This script in infinite developing and may not work correctly ;)

 .Description
   File Name : MKVripper.ps1
   Author : Dmitri G. - dimi615@pisem.net
   Requires :  PowerShell Version 4.0 and mkvmerge for Windows - http://www.bunkus.org/videotools/mkvtoolnix/downloads.html
               mkvextract for Windows - http://www.bunkus.org/videotools/mkvtoolnix/downloads.html
               MP4Box for Windows - http://gpac.sourceforge.net
   Important : All utilities MUST BE LOCATED in "C:\bin\" (PATH specified also)
               MP4 doesn't officially support AC3 audio so the audio track
               should be converted into a supported format (eg. AAC, MP3)
               if you want the file to be playable with something else than VLC.
   
   This script posted to:
   http://github.com/dimig

 .Example
  MKVripper.ps -FilePath .\MyVIDEO.mkv -Info
  
  Description
  -----------
  Getting information about MKV video file structure

 .Example
  MKVripper.ps -FilePath .\MyVIDEO.mkv -AudioFormat AC3 -Rip
  
  Description
  -----------
  Ripping the MKV to elementary streams: video.h264 and audio.aac

 .Example
  MKVripper.ps -FilePath .\video.h264 -AudioFormat AC3 -FPS 25 -Mux
  
  Description
  -----------
  Mux audio and video into mp4 containter
  
#>

########################################################################
# Created By: Dmitri G. (2014)
########################################################################

# Turn on/off DEBUG reporting

# DEBUG ON
# $DebugPreference = "Continue"
# DEBUG OFF
# $DebugPreference = "SilentlyContinue"

# PowerShell Script MKV video ripping

param(
#[ValidateNotNullorEmpty()]
 [Parameter(Position=1,Mandatory=$True,
  HelpMessage="The file for processing MUST BE entered!!!")]
 [string]$FilePath = "",
 [ValidateSet("AAC","AC3")]
 [string]$AudioFormat = "AAC",
 [string]$FPS = "23.976",
 [switch]$Info,
 [switch]$Rip,
 [switch]$Mux

) #end param

process {

########################################################################
# Functions
########################################################################

function infStart {
  # Prepare the screen
    Clear-Host
    $Time=Get-Date
    Write-Host "`n$Time Starting..." -ForegroundColor Green
}

function infStop {
  # Stop here
    $Time=Get-Date
    Write-Host "`a`n`n$Time JOB Complete... Have a good day!`n" -ForegroundColor Green
    exit
}

########################################################################
# Variables SET
########################################################################

#$subpath = (Get-Location -PSProvider FileSystem).ProviderPath

Set-Variable H264name -option Constant -value 'video.h264'
Set-Variable DestOutputName -option Constant -value 'video.mp4'
Set-Variable AACname -option Constant -value 'audio.aac'
Set-Variable AC3name -option Constant -value 'audio.ac3'

# Test output audio format
if ($AudioFormat -eq "AC3") {

    [string]$AudioName = $AC3name

} else {

    [string]$AudioName = $AACname

}

########################################################################
# Program START HERE
########################################################################

infStart

# Messages HERE!!!
if ($Rip) {
  Write-Host "`nYour INPUT file is $FilePath`n" -ForegroundColor Magenta
  Write-Host "The ripped audio format is $AudioName`n" -ForegroundColor Yellow
  Write-Host "Only FIRST audio track will be ripped`n" -ForegroundColor Cyan
}

if ($Mux) {
  Write-Host "`nYour INPUT file is $FilePath`n" -ForegroundColor Magenta
  Write-Host "The muxed audio format is $AudioName`n" -ForegroundColor Yellow
  Write-Host "Only ONE audio track will be muxed`n" -ForegroundColor Cyan
  Write-Host "$FPS frames per second`n" -ForegroundColor Magenta
  Write-Host "*Notes: MP4 doesn't officially support AC3 audio, so the audio track `
        should be converted into a supported format (eg. AAC, MP3) `
        if you want the file to be playable with something else than VLC. ;)" -ForegroundColor Cyan
}

if ($Info) {
  Write-Host "`nYour INPUT file is $FilePath`n" -ForegroundColor Magenta
  Write-Host "`nGET information about MKV videofile`n" -ForegroundColor Cyan
}

# Write-Debug "`nYour output file name is $DestName`n"

Write-Host "`nPress ANY KEY to CONTINUE ... or Ctrl+C to abort`n"
$inpt = $host.UI.RawUI.ReadKey("NoEcho,IncludeKeyUp")

# Main coding ROUTINE

########################################################################
# Getting MKV video file information
########################################################################

if ($Info) {

    if (test-path $FilePath) {

        & "C:\bin\mkvmerge.exe" --identify $FilePath

    } else {

        Write-Host "`nNO input file entered. Please point me!!!`n" -ForegroundColor Red

    }

infStop

}


########################################################################
# RiP MKV file
########################################################################

if ($Rip) {

    if (test-path $FilePath) {

            & "C:\bin\mkvextract.exe" tracks $FilePath 0:$H264name 1:$AudioName

    } else {

            Write-Host "`nNO input file entered. Please point me!!!`n" -ForegroundColor Red
        
    }

infStop

}

########################################################################
# Mux audio and video into mp4 containter
########################################################################


if ($Mux) {

    if (test-path ".\video.h264") {

            & "C:\bin\MP4Box.exe" -fps $FPS -add $FilePath -add $AudioName $DestOutputName

    } else {

            Write-Host "`nNO input file entered. Please point me!!!`n" -ForegroundColor Red
        
    }

infStop

}

}