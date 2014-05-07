<# 
 .Synopsis
   PowerShell ripDVD routine
   This script contains a rip DVD encoding script
   by HandBrakeCLI
   
   *Note: This script is not fully tested, and may not work correctly

 .Description
   File Name : ripDVD.ps1
   Author : Dmitri G. - dimi615@pisem.net
   Requires :  PowerShell Version 3.0 and HandBrakeCLI MinGW x86_64 for Windows - http://handbrake.fr
               dd for Windows http://www.chrysocome.net/dd
   Important :`HandBrakeCLI` and `dd` MUST BE LOCATED in "C:\bin\"
   
   This script posted to:
   http://github.com/dimig

 .Example
  ripDVD.ps -Disk E: -Title 2
  
  Description
  -----------
  Process DVD rip for Title 2 on disk E:
 
 .Example
  ripDVD.ps -MakeISO
  
  Description
  -----------
  Process DVD copy to ISO file
  
#>

########################################################################
# Created By: Dmitri G. (2014)
########################################################################

# Turn on/off DEBUG reporting

# DEBUG ON
# $DebugPreference = "Continue"
# DEBUG OFF
# $DebugPreference = "SilentlyContinue"


# PowerShell Script for DVD ripping

param(
 [ValidateSet("E:","F:")]
 [string]$Disk = "F:",
 [int]$Title = 1,
 [switch]$HighQuality,
 [switch]$MakeISO

) #end param

process {

# ... Functions ...

function infStart {
  # Prepare the screen
    Clear-Host
    $Time=Get-Date
    Write-Host "`n$Time Starting..." -ForegroundColor Green
}

function infStop {
  # Stop here
    $Time=Get-Date
    Write-Host "`a`n`n$Time Complete... Have a good day!`n" -ForegroundColor Green
    exit
}

########################################################################
# Variables SET
########################################################################

#$subpath = (Get-Location -PSProvider FileSystem).ProviderPath

Set-Variable destname -option Constant -value 'DVDout.mp4'

[int]$vTitle = $Title
[string]$subpath = "$Disk\VIDEO_TS"

# Function Start
infStart

# If MakeISO key given
if ($MakeISO){ 
    Write-Host "`nMAKING ISO, waiting...`n`a" -ForegroundColor Magenta
    dd if=\\?\Device\CdRom0 of=DVDout.iso bs=2048 --progress
    infStop
}

# Messages HERE
Write-Host "`nYour Title is $vTitle" -ForegroundColor Magenta
Write-Host "Your DVD path is $subpath" -ForegroundColor Magenta
Write-Host "Your output File Name is $destname`n" -ForegroundColor Magenta
Write-Host "High Quality Mode!`n" -ForegroundColor Yellow

# Write-Debug "`nYour output file name is $destname`n"

Write-Host "Press ANY KEY to CONTINUE ... or Ctrl+C to abort`n"
$inpt = $host.UI.RawUI.ReadKey("NoEcho,IncludeKeyUp")

# Main coding routine
if (!(test-path $destname)) {
    if ($HighQuality){ 
    & "C:\bin\HandBrakeCLI.exe" -i $subpath -o $destname -t $vTitle --crop 0:0:0:0 `
    -X 720 -q 15.0 --preset="High Profile"
    } else {
    & "C:\bin\HandBrakeCLI.exe" -i $subpath -o $destname -t $vTitle --crop 0:0:0:0 -b 2700 -B 160 -X 720 `
    -e x264 -a 1 -E faac -6 dpl2 -R Auto -D 0.0 -f mp4 --strict-anamorphic `
    -x ref=2:bframes=2:subme=6:mixed-refs=0:weightb=0:8x8dct=0:trellis=0
    }
}


infStop

}