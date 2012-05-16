<# 
 .Synopsis
  These functions are handy for me for graphics processing

 .Description
  Pictures processing

 .Example
  gi FileToProcess.jpg | photo2
  
  Description
  -----------
  To process only one file in time
  
 .Example
  gi *.jpg | photo2
  
  Description
  -----------
  To process many files in time
   
#>

function roundCorner {
  Param ([string]$strFN1, [string]$strFN2)

  # Show process
        Write-Host "`nRound Corner effect in progress for $strFN1 ..."
    
        & "C:\bin\ImageMagick\convert.exe" $strFN1 `( +clone -alpha extract `
          `( -size 30x30 xc:black -draw 'fill white circle 30,30 30,0' -write mpr:arc +delete `) `
          `( mpr:arc `) -gravity northwest -composite `
          `( mpr:arc -flip `) -gravity southwest -composite `
          `( mpr:arc -flop `) -gravity northeast -composite `
          `( mpr:arc -rotate 180 `) -gravity southeast -composite `) `
          -alpha off -compose CopyOpacity -composite $strFN2
          
    Write-Host "`nDone for $strFN2 ..." -ForegroundColor Green
}

function shadow {
  Param ([string]$strFN1, [string]$strFN2)
  
  # Show process
    Write-Host "`nShadow effect in progress for $strFN1 ..."
        
        & "C:\bin\ImageMagick\convert.exe" -page +4+4 $strFN1 `
        -matte `( +clone -background navy -shadow 60x4+4+4 `) +swap `
        -background none -mosaic $strFN2 
      
    Write-Host "`nDone for $strFN2 ..." -ForegroundColor Green
}

function photo2 {
  Param ([switch]$ShadowOnly)

  # Set Variables
    $env:path += ";C:\bin\ImageMagick"
    
    foreach ($strFileName in $input) {
    
    $strFNin = (Get-Item $strFileName).name
    $strFNout = [io.path]::ChangeExtension($strFNin,'png')
    $strFNoutrc = "RoundedCorners_$strFNout"
    $strFNoutsh = "Shadow_$strFNout"
    
      if (!$ShadowOnly) {
            roundCorner $strFNin $strFNoutrc
            shadow $strFNoutrc $strFNoutsh
                  if (Test-Path -Path .\$strFNoutrc) {Remove-Item $strFNoutrc}
        else {
            shadow $strFNin $strFNoutsh
        }
      }
    }
      
  # Give colorful output
    Write-Host "`nComplete... Have a nice day!`a`n" -ForegroundColor Yellow
}

export-modulemember -function photo2