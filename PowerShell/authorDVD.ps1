<# 
 .Synopsis
   PowerShell authorDVD routine
   This script contains a DVD authoring script
   by ffmpeg, dvdauthor and mkisofs. 
   ISO burn by ISOWriter console program.
   
   *Note: This script in infinite developing and may not work correctly ;)

 .Description
   File Name : authorDVD.ps1
   Author : Dmitri G. - dimi615@pisem.net
   Requires :  PowerShell Version 4.0 and FFmpeg for Windows - http://ffmpeg.zeranoe.com/builds/
               dvdauthor for Windows - http://download.videohelp.com/gfd/edcounter.php?file=download/dvdauthor_winbin.zip
               mkisofs for Windows - http://smithii.com/cdrtools
               ISOWriter for Windows (command-line image-burning utility) - http://isorecorder.alexfeinman.com/ISOWriter.htm
   Important : All utilities MUST BE LOCATED in "C:\bin\" (PATH specified also)
   
   This script posted to:
   http://github.com/dimig

 .Example
  authorDVD.ps -FilePath .\MyVIDEO.mp4 -TargetFormat NTSC -MakeFile
  
  Description
  -----------
  Process converting input file to DVD compliant MPEG2 video

 .Example
  authorDVD.ps -MakeAuthor
  
  Description
  -----------
  Process authoring and DVD-VIDEO structure creating

 .Example
  authorDVD.ps -Burn
  
  Description
  -----------
  Process dvd.iso BURN to DVD-R disc recorder
  
#>

########################################################################
# Created By: Dmitri G. (2014)
########################################################################

# Turn on/off DEBUG reporting

# DEBUG ON
# $DebugPreference = "Continue"
# DEBUG OFF
# $DebugPreference = "SilentlyContinue"


# PowerShell Script for DVD authoring

param(
 [string]$FilePath = "",
 [ValidateSet("NTSC","PAL")]
 [string]$TargetFormat = "NTSC",
 [switch]$MakeFile,
 [switch]$MakeAuthor,
 [switch]$Burn

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

Set-Variable DestName -option Constant -value 'movie4dvd.mpg'

# Test output color system format
if ($TargetFormat -eq "PAL") {

    [string]$Target = "pal-dvd"

} else {

    [string]$Target = "ntsc-dvd"

}


########################################################################
# Program START HERE
########################################################################

infStart

# Messages HERE!!!
if ($MakeFile) {
        Write-Host "`nYour INPUT file path is $FilePath`n" -ForegroundColor Magenta
        Write-Host "Your target color format is $TargetFormat`n" -ForegroundColor Magenta
}

if ($MakeAuthor) {
        Write-Host "`nAuthoring MODE in progress...`n" -ForegroundColor Cyan
        Write-Host "Check OUT if dvd.xml created manually in current folder!" -ForegroundColor Magenta
        Write-Host "The dvd.xml is important for DVD authoring process`n" -ForegroundColor Magenta
}

if ($Burn) {
        Write-Host "`nDVD burning MODE turned ON!`n" -ForegroundColor Cyan 
}

# Write-Debug "`nYour output file name is $DestName`n"

Write-Host "`nPress ANY KEY to CONTINUE ... or Ctrl+C to abort`n"
$inpt = $host.UI.RawUI.ReadKey("NoEcho,IncludeKeyUp")

# Main coding routine

########################################################################
# Converting input video file to DVD MPG2 compliant format
########################################################################

if ($MakeFile) {

    if (!(test-path $DestName)) {

        & "C:\bin\ffmpeg.exe" -i $FilePath -aspect 4:3 -target $Target $DestName

    } else {

        Write-Host "`nOutput file exist. Please RENAME or DELETE IT!!!`n" -ForegroundColor Red

    }

infStop

}


########################################################################
# Start DVD authoring into DVD folder
########################################################################

if ($MakeAuthor) {

if (!(test-path ".\DVD")) { Write-Host "`nCreating DVD folder..." -ForegroundColor Yellow; mkdir DVD }

if ((test-path ".\dvd.xml")) {

        Write-Host "`a`nCreating DVD-VIDEO structure`n" -ForegroundColor Green

        & "C:\bin\dvdauthor.exe" -o .\DVD -x .\dvd.xml
        
        Write-Host "`a`nCreating DVD-VIDEO ISO file`n" -ForegroundColor Green

        & "C:\bin\mkisofs.exe" -dvd-video -o dvd.iso DVD/

} else {
 
        Write-Host "`nFor authoring process the dvd.xml file should be persist!!! Create IT!`n" -ForegroundColor Red
 
}

infStop

}

########################################################################
# Start dvd.iso burning to DVD-R disc
########################################################################

if ($Burn) {

        Write-Host "`a`nIf U wanna write dvd.iso file to DVD-R disc insert it to DVD recorder," -ForegroundColor Cyan
        Write-Host "`nPress ANY KEY to CONTINUE ... or Ctrl+C to abort`n"
        $inpt = $host.UI.RawUI.ReadKey("NoEcho,IncludeKeyUp")

        & "C:\bin\ISOWriter.exe" -h -e dvd.iso
                
infStop

}


}