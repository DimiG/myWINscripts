<# 
 .Synopsis
   PowerShell convert Module
   This module contains a set of encoding scripts
   by ffmpeg and HandBrakeCLI
   
   *Note: This module script is not fully tested, and may not work correctly

 .Description
   File Name : video.psm1
   Author : Dmitri Guslinsky - dimi615@pisem.net
   Requires : PowerShell Version 2.0 and ffmpeg, HandBrakeCLI for Windows.
   Important : ffmpeg and HandBrakeCLI MUST BE LOCATED in "C:\bin\"
   
   This script posted to:
   http://github.com/dimig
   
   1. video2mp4 convert any video file to mp4 AVC AAC 

 .Example
  video2mp4 <file name>
  
  Description
  -----------
  To process only one file in time
  
 .Example
  vcMainMenu
  
  Description
  -----------
  Will encode all files in current directory. Be careful.
   
#>

# PowerShell Script for video converting

# ... Functions ...

function infStart {
  # Prepare the screen
    Clear-Host
    Write-Host "`nStarting..."
}

function infStop {
  # Stop here
    Write-Host "`a`n`nComplete... Have a good day!`n"
}

function userRequest($sentence) {
  # Set the color for input
    [console]::ForegroundColor = "yellow"
  # [console]::BackgroundColor= "black"
  
    $answer = Read-Host $sentence
                       
  # Reset the color back to default
    [console]::ResetColor()
    return $answer
}

function errorInput {
    Write-Host "`n`a"
    Write-Warning "Invalid input. Please enter a valid option. Restart the script!"
    throw "Stopping the script..."
}

function formatDecisionBlock {
  # Check Out file extension
        
        [string]$strExtension = userRequest $strMessage1
        
      # Check Out if ENTER
        if (($strExtension -eq " ") -or ($strExtension -eq "")) {$strExtension = "mkv"}
              
    switch ($strExtension)
    {
        "mkv"
        {
            return "*." + $strExtension
        }
        "mp4"
        {
            return "*." + $strExtension
        }
        "mov"
        {
            return "*." + $strExtension
        }
        "avi"
        {
            return "*." + $strExtension
        }
        default
        {
            errorInput
        }
    }

}

function colorDecisionBlock {
  # Check Out TV system PAL/NTSC
    
        [string]$strTvSystem = userRequest $strMessage2
        
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
            errorInput
        }
    }

}

function requestAspect {

    [double]$inpt = userRequest $strMessage3

    # Check out if EXIT
    if (($inpt -eq " ") -or ($inpt -eq "")) {break}
    
    return $inpt
}

function requestVolume {

    [int]$inpt = userRequest $strMessage4
    
    # Check Out if ENTER
    if (($inpt -eq " ") -or ($inpt -eq "")) {[int]$inpt = 256}

    return $inpt
}

function requestTitle {

    [int]$inpt = userRequest $strMessage5

    # Check Out if ENTER
    if (($inpt -eq " ") -or ($inpt -eq "")) {[int]$inpt = 1}
    
    return $inpt
}

function runConvert2MPG {
  # Set Variables
    [int]$vRes = 480
    [double]$fps = 23.976
    [string]$strMessage1 = "`nPlease Enter extension for file you plan to convert ( mkv/mp4/mov/avi ) or press `"Enter`" for mkv`a"
    [string]$strMessage2 = "`nPlease Enter TV system you plan to use ( PAL 25/NTSC 23.976 ) or press `"Enter`" for NTSC`a"
    [string]$strMessage3 = "`nPlease Input source aspect ratio ( 1.33 for 4:3, 1.78 for 16:9 ) or press `"Enter`" to FINISH`a"
    [string]$strMessage4 = "`nPlease Input Volume parameter ( 768 for UP ) or press `"Enter`" for Normal ( 256 )`a"
  
  # Set Variables by Functions
    [string]$strExt = formatDecisionBlock
    [string]$strTvSys = colorDecisionBlock
    [double]$aspect = requestAspect
    [int]$vol = requestVolume
    
  # Set vertical resolution
    if ($strTvSys -eq "PAL") {[int]$vRes = 576; [double]$fps = 25}
  
  # Vertical size calculation
    if ($vRes -eq 576) {
        [int]$vSize = [math]::Round((720/$aspect)*(64/45))
    } else {
        [int]$vSize = [math]::Round((720/$aspect)*(32/27))
    }
      
    [int]$vPad = [math]::Round(($vRes-$vSize)/2)
    
  # Check if vPad negative  
    if ($vPad -lt 0) {[int]$vPad = 0}
    
  # Make command string
    [string]$strPad = "scale=720:" + $vSize + ",pad=720:" + $vRes + ":0:" + $vPad + ":black,unsharp"

    Write-Host "`nVideo source file extension is $strExt"
    Write-Host "TV system is $strTvSys"
    Write-Host "Frame rate is $fps"
    Write-Host "Volume is $vol"
    Write-Host "Aspect is $aspect"
    Write-Host "vRes is $vRes"
    Write-Host "vSize is $vSize"
    Write-Host "vPad is $vPad"
    Write-Host "strPad is $strPad"
        
  # Main Command HERE
  
  # Collect the files
    [Environment]::CurrentDirectory=(Get-Location -PSProvider FileSystem).ProviderPath
    $files = get-childitem -Recurse -Include $strExt

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
            -threads 4 -g 45 -bf 2 -trellis 2 -cmp 2 -subcmp 2 -s 720x$vRes -aspect 16:9 `
            -b:v 3300k -bt 300k -r $fps -acodec mp2 -ac 2 -ab 192k -ar 48000 `
            -vol $vol -async 1 -y -f vob $destname
            }
        }
        default
        {
            if (!(test-path $destname)) {
            & "C:\bin\ffmpeg.exe" -i $file -vcodec mpeg2video -pix_fmt yuv420p -me_method epzs `
            -threads 4 -g 45 -bf 2 -trellis 2 -cmp 2 -subcmp 2 -aspect 16:9 -vf $strPad `
            -b:v 3300k -bt 300k -r $fps -acodec mp2 -ac 2 -ab 192k -ar 48000 `
            -vol $vol -async 1 -y -f vob $destname
            }
        }
    }
  }
  infStop
}

function runConvert2MP4 {
  # Set Variables

  # Main Command HERE

  # Collect the files  
    [Environment]::CurrentDirectory=(Get-Location -PSProvider FileSystem).ProviderPath
    $files = get-childitem -Recurse -Include "*.mkv"

  # Collect the files
  foreach ($file in $files) {
    $subpath = $file.DirectoryName.Replace([Environment]::CurrentDirectory , "")
    $destname = $file.BaseName + ".mp4"
 
        if (!(test-path $destname)) {
        & "C:\bin\HandBrakeCLI.exe" -i $file -o $destname --crop 0:0:0:0 -b 2700 -B 160 -X 720 `
            -e x264 -q 20.0 -a 1 -E faac -6 dpl2 -R Auto -D 0.0 -f mp4 --strict-anamorphic `
            -x ref=2:bframes=2:subme=6:mixed-refs=0:weightb=0:8x8dct=0:trellis=0
        }
  }
  infStop
}

function runDVDrip {
  # Set Variables
    [string]$strMessage5 = "`nInput a title to Encode or press `"Enter`" for the FIRST one`a"
  
  # Set Variables by Functions
    [int]$vTitle = requestTitle $strMessage5

  # Main Command HERE
    Write-Host "`nYour title is $vTitle`n"
    Write-Debug "Your output file name is DVDout.mp4`n"
    
  # Collect the files  
    $subpath = (Get-Location -PSProvider FileSystem).ProviderPath
    $destname = "DVDout.mp4"

  # Collect the files
    if (!(test-path $destname)) {
        & "C:\bin\HandBrakeCLI.exe" -i $subpath -o $destname -t $vTitle --crop 0:0:0:0 -b 2700 -B 160 -X 720 `
        -e x264 -q 20.0 -a 1 -E faac -6 dpl2 -R Auto -D 0.0 -f mp4 --strict-anamorphic `
        -x ref=2:bframes=2:subme=6:mixed-refs=0:weightb=0:8x8dct=0:trellis=0
    }
  infStop
}

function video2mp4 {
  # Convert video for iPod Touch 1g

  # Set Variables

  # Main Command HERE

  # Collect the files  
    [Environment]::CurrentDirectory=(Get-Location -PSProvider FileSystem).ProviderPath

  # Get file list and filter folders
    $files = get-childitem -Recurse -Include "*.*" | where { ! $_.PSIsContainer }

  # Collect the files
  foreach ($file in $files) {
    $subpath = $file.DirectoryName
    $destname = $subpath + "\" + $file.BaseName + ".mp4"
    Write-Host "`nEncoding files one by one in folder ...`n" -ForegroundColor Blue

  # Create iPod Touch 1g video
        if (!(test-path $destname)) {
            & "C:\bin\HandBrakeCLI.exe" -Z 'iPod Legacy' -i $file -o $destname
        }
  }
    Write-Host "`a`nEncoding files complete ...`n" -ForegroundColor Green
}

function vcMainMenu {
  # Set Variables
    [string]$strMessageMenu = "`nEnter a number for an option or type `"q`" for quit`a"
    
    infStart

      # Show Menu
        Write-Host "`n"
        Write-Host "============"
        Write-Host "= MAINMENU ="
        Write-Host "============`n"
        Write-Host "1. Press '1' for MKV/MP4/MOV to MPG conversion"
        Write-Host "2. Press '2' for MKV/MPG/MOV to MP4 conversion"
        Write-Host "3. Press '3' for Rip DVD VIDEO_TS to MP4"
        
      # Request Input
        [string]$strResponse = userRequest $strMessageMenu

      # Make a choice        
        switch ($strResponse)
        {
            "1"
            {
                runConvert2MPG
            }
            "2"
            {
                runConvert2MP4
            }
            "3"
            {
                runDVDrip
            }
            "q"
            {
                infStop
            }
            default
            {
                #  Nothing to do, recover 
            }
        }
        
        Write-Host "`n"
}

# Export vcMainMenu, video2mp4
Export-ModuleMember vcMainMenu, video2mp4

# End of Script
