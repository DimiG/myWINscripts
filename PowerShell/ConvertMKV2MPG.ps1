<#
.SYNOPSIS
    This script converts MKV files to MPG by ffmpeg
.DESCRIPTION
    This script firsts collects the MKV files in current directory and
    invokes the FFMPEG to convert them to MPG files in NTSC format.
    Encode VIDEO for SONY SMP-U10 USB player (23.976 fps to NTSC MPG)
.NOTES
    File Name : ConvertMKV2MPG.ps1
    Author : Dmitri Guslinsky - dimi615@pisem.net
    Requires : PowerShell Version 2.0 and ffmpeg for Windows
.LINK
    This script posted to:
    http://github.com/dimig
.EXAMPLE
    Just run it in MKV files directory!
#>

# PowerShell Script for video converting

# Prepare the screen
Clear-Host

# Set the color for input
[console]::ForegroundColor = "yellow"
#[console]::BackgroundColor= "black"

# Calculating the Pad size
$input = Read-Host "`nEnter aspect ratio or type `"quit`" to finish`a"

# Reset the color back to default
[console]::ResetColor()

# Check out if EXIT
if (($input -eq "quit") -or ($input -eq "")) {exit}

$vSize = [math]::Round(720/$input)
$vPad = [math]::Round((480-$vSize)/2)

Write-Host "`n`nU entered for NTSC = $input`n"
Write-Host "Vertical size is = $vSize"
Write-Host "The Pad size is = $vPad"

Write-Host "`nStarting...`n"

# Collect the files
[Environment]::CurrentDirectory=(Get-Location -PSProvider FileSystem).ProviderPath
$files = get-childitem -Recurse -Include "*.mkv"

# Transcoding...
foreach ($file in $files) {
 $subpath = $file.DirectoryName.Replace([Environment]::CurrentDirectory , "")
 $destname = $file.BaseName + ".mpg"
 
 if (!(test-path $destname)) {
 & "C:\bin\ffmpeg.exe" -i $file -vcodec mpeg2video -pix_fmt yuv420p -me_method epzs -threads 4 -g 45 -bf 2 -trellis 2 -cmp 2 -subcmp 2 -s 720x$vSize -vf pad=720:480:0:$vPad -b:v 2500k -bt 300k -acodec mp2 -ac 2 -ab 192k -ar 48000 -async 1 -y -f vob $destname
 }
}

# Stop here
Write-Host "`a`n`nComplete... Have a good day!`n"
