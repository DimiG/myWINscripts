<#
.SYNOPSIS
    This script converts MP4 files to MPG by ffmpeg
.DESCRIPTION
    This script firsts collects the MP4 files in current directory and sub dirs,
    after invokes the FFMPEG to convert them to MPG files.
    For better results locate the video files U're going to convert into
    one folder with same params.
    Encode VIDEO for SONY SMP-U10 USB player
    *Note: This script is not fully tested, and may not work correctly
.NOTES
    File Name : ConvertMP4toMPG.ps1
    Author : Dmitri Guslinsky - dimi615@pisem.net
    Requires : PowerShell Version 2.0 and ffmpeg for Windows
.LINK
    This script posted to:
    http://github.com/dimig
.EXAMPLE
    Just run it in MP4 files directory!
#>

# PowerShell Script for video converting

# ... Functions ...

function infStart {
  # Prepare the screen
    Write-Host "`nStarting...`n"
}

function infStop {
  # Stop here
    Write-Host "`a`n`nComplete... Have a good day!`n"
}

function requestData {
  # Prepare the screen
    Clear-Host

  # Set the color for input
    [console]::ForegroundColor = "yellow"
  # [console]::BackgroundColor= "black"
          
  # Request data from user
    [double]$input = Read-Host "`nInput source aspect ratio or press `"Enter`" to finish`a"

  # Reset the color back to default
    [console]::ResetColor()

  # Check out if EXIT
    if (($input -eq " ") -or ($input -eq "")) {exit}
    return $input
}

function checkData($option) {
  # Check If all is OK
    Write-Debug "Check if ALL is OK"
    
    Write-Host "`nYour input was $option`a`n"
}

function colorDecisionBlock {
  # Check Out TV system PAL/NTSC

      # Set the color for input
        [console]::ForegroundColor = "yellow"
        [string]$strTvSystem = Read-Host "Please Enter TV system you plan to use ( PAL/NTSC ) or press `"Enter`" for NTSC"
                       
      # Reset the color back to default
        [console]::ResetColor()
        
      # Check Out if ENTER
        if (($strTvSystem -eq " ") -or ($strTvSystem -eq "")) {$strTvSystem = "NTSC"}
              
    switch ($strTvSystem)
    {
        "NTSC"
        {
            return $strTvSystem
        }
        "PAL"
        {
            return $strTvSystem
        }
        default
        {
          # Set the color for input
            [console]::ForegroundColor = "red"
            
            Write-Host "`n`nInvalid input. Please enter a valid option. Restart the script!`a"
            
          # Reset the color back to default
            [console]::ResetColor()
            exit
        }
    }

}

function runCommand1 {
  # Set Variables
    [int]$vRes = 480
    
    $input = requestData
    $null = checkData $input
    $strTvSys = colorDecisionBlock
    
  # Set vertical resolution
    if ($strTvSys -eq "PAL") {[int]$vRes = 576}
  
  # Vertical size calculation
    if ($vRes -eq 576) {
        [int]$vSize = [math]::Round((720/$input)*(64/45))
    } else {
        [int]$vSize = [math]::Round((720/$input)*(32/27))
    }
      
    [int]$vPad = [math]::Round(($vRes-$vSize)/2)
          
    Write-Host "`nTV system is $strTvSys"
    Write-Host "vSize is $vSize"
    Write-Host "vPad is $vPad`n"
        
  # Main Command HERE
  
  # Collect the files
    [Environment]::CurrentDirectory=(Get-Location -PSProvider FileSystem).ProviderPath
    $files = get-childitem -Recurse -Include "*.mp4"

  # Transcoding...
  foreach ($file in $files) {
    $subpath = $file.DirectoryName.Replace([Environment]::CurrentDirectory , "")
    $destname = $file.BaseName + ".mpg"
    
    switch ($vPad)
    {
        0
        {
            if (!(test-path $destname)) {
            & "C:\bin\ffmpeg.exe" -i $file -vcodec mpeg2video -pix_fmt yuv420p -me_method epzs `
            -threads 4 -g 45 -bf 2 -trellis 2 -cmp 2 -subcmp 2 -s 720x$vRes `
            -b:v 4000k -bt 300k -acodec mp2 -ac 2 -ab 192k -ar 48000 -async 1 -y -f vob $destname
            }
        }
        default
        {
            if (!(test-path $destname)) {
            & "C:\bin\ffmpeg.exe" -i $file -vcodec mpeg2video -pix_fmt yuv420p -me_method epzs `
            -threads 4 -g 45 -bf 2 -trellis 2 -cmp 2 -subcmp 2 -s 720x$vSize -vf pad=720:$vRes:0:$vPad -aspect 16:9 `
            -b:v 4000k -bt 300k -acodec mp2 -ac 2 -ab 192k -ar 48000 -async 1 -y -f vob $destname
            }
        }
    }
  }
}

function runMain {
    infStart
    runCommand1
    infStop
}

# Invoke the MAIN routine
runMain