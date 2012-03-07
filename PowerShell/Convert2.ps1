<#
.SYNOPSIS
    This script is universal converter/ripper for MKV/MP4/MOV/MPG and DVD Video files
    by ffmpeg and HandBrakeCLI
.DESCRIPTION
    This script firsts collects the MKV/MP4/MOV/MPG or VIDEO_TS files in current directory
    and sub dirs, after invokes the FFMPEG or HandBrakeCLI to convert them to your choice.
    For better results locate the video files U're going to convert into
    one folder with same params.
    Encode MPEG VIDEO for SONY SMP-U10 USB player
    *Note: This script is not fully tested, and may not work correctly
.NOTES
    File Name : Convert2.ps1
    Author : Dmitri Guslinsky - dimi615@pisem.net
    Requires : PowerShell Version 2.0 and ffmpeg, HandBrakeCLI for Windows.
    Important : ffmpeg and HandBrakeCLI MUST BE LOCATED in "C:\bin\"
.LINK
    This script posted to:
    http://github.com/dimig
.EXAMPLE
    Just run it in MKV/MP4/MOV/MPG or VIDEO_TS files directory!
#>

# PowerShell Script for video converting

# ... Functions ...

function infStart {
  # Prepare the screen
    Write-Host "`nStarting..."
}

function infStop {
  # Stop here
    Write-Host "`a`n`nComplete... Have a good day!`n"
    exit
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
  # Set the color for output
    [console]::ForegroundColor = "red"
            
    Write-Host "`n`nInvalid input. Please enter a valid option. Restart the script!`a"
            
  # Reset the color back to default
    [console]::ResetColor()
    exit
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

    [double]$input = userRequest $strMessage3

    # Check out if EXIT
    if (($input -eq " ") -or ($input -eq "")) {exit}
    return $input
}

function requestTitle {

    [int]$input = userRequest $strMessage4

    # Check out if EXIT
    if (($input -eq " ") -or ($input -eq "")) {exit}
    return $input
}

function runConvert2MPG {
  # Set Variables
    [int]$vRes = 480
    [string]$strMessage1 = "`nPlease Enter extension for file you plan to convert ( mkv/mp4/mov ) or press `"Enter`" for mkv`a"
    [string]$strMessage2 = "`nPlease Enter TV system you plan to use ( PAL/NTSC ) or press `"Enter`" for NTSC`a"
    [string]$strMessage3 = "`nInput source aspect ratio (1.33 for 4:3, 1.78 for 16:9) or press `"Enter`" to finish`a"
  
  # Set Variables by Functions
    [string]$strExt = formatDecisionBlock
    [string]$strTvSys = colorDecisionBlock
    [double]$strAspect = requestAspect
    
  # Set vertical resolution
    if ($strTvSys -eq "PAL") {[int]$vRes = 576}
  
  # Vertical size calculation
    if ($vRes -eq 576) {
        [int]$vSize = [math]::Round((720/$strAspect)*(64/45))
    } else {
        [int]$vSize = [math]::Round((720/$strAspect)*(32/27))
    }
      
    [int]$vPad = [math]::Round(($vRes-$vSize)/2)
    
  # Check if vPad negative  
    if ($vPad -lt 0) {[int]$vPad = 0}
    
  # Make command string
    [string]$strPad = "pad=720:" + $vRes + ":0:" + $vPad

    Write-Host "`nVideo source file extension is $strExt"
    Write-Host "TV system is $strTvSys"
    Write-Host "Aspect $strAspect"
    Write-Host "vRes is $vRes"
    Write-Host "vSize is $vSize"
    Write-Host "vPad is $vPad"
    Write-Host "strPad is $strPad`n"
        
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
            -threads 4 -g 45 -bf 2 -trellis 2 -cmp 2 -subcmp 2 -s 720x$vRes `
            -b:v 4000k -bt 300k -acodec mp2 -ac 2 -ab 192k -ar 48000 -vol 768 -async 1 -y -f vob $destname
            }
        }
        default
        {
            if (!(test-path $destname)) {
            & "C:\bin\ffmpeg.exe" -i $file -vcodec mpeg2video -pix_fmt yuv420p -me_method epzs `
            -threads 4 -g 45 -bf 2 -trellis 2 -cmp 2 -subcmp 2 -s 720x$vSize -vf $strPad -aspect 16:9 `
            -b:v 4000k -bt 300k -acodec mp2 -ac 2 -ab 192k -ar 48000 -vol 768 -async 1 -y -f vob $destname
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
            -e x264  -q 20.0 -a 1 -E faac -6 dpl2 -R Auto -D 0.0 -f mp4 --strict-anamorphic `
            -x ref=2:bframes=2:subme=6:mixed-refs=0:weightb=0:8x8dct=0:trellis=0
        }
  }
  infStop
}

function runDVDrip {
  # Set Variables
    [string]$strMessage4 = "`nInput a title to Encode or press `"Enter`" to finish`a"
  
  # Set Variables by Functions
    [int]$vTitle = requestTitle $strMessage4

  # Main Command HERE
    Write-Host "`nYour title is $vTitle`n"
    Write-Debug "Your output file name is DVDout.mp4`n"
    
  # Collect the files  
    $subpath = (Get-Location -PSProvider FileSystem).ProviderPath
    $destname = "DVDout.mp4"

  # Collect the files
    if (!(test-path $destname)) {
        & "C:\bin\HandBrakeCLI.exe" -i $subpath -o $destname -t $vTitle --crop 0:0:0:0 -b 2700 -B 160 -X 720 `
        -e x264  -q 20.0 -a 1 -E faac -6 dpl2 -R Auto -D 0.0 -f mp4 --strict-anamorphic `
        -x ref=2:bframes=2:subme=6:mixed-refs=0:weightb=0:8x8dct=0:trellis=0
    }
  infStop
}

function mainMenu
{
  # Set Variables
    [string]$strMessageMenu = "`nEnter a number for an option or type `"q`" for quit`a"
    
    infStart
    
    do
    {
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
      
      Clear-Host
      
    } until ($strResponse -eq "q")
  
}

# Turn on/off DEBUG reporting

# DEBUG ON
# $DebugPreference = "Continue"

# DEBUG OFF
# $DebugPreference = "SilentlyContinue"

# Invoke the MAIN MENU routine
mainMenu
