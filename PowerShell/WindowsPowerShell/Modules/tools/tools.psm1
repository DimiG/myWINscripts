<# 
 .Synopsis
  These functions are handy for me. Just automate your life.

 .Description
  myOWN handy functions:
  1. ll - force files list
  2. quit - short name for quit shell window
  3. touch - change last access time
  4. book - encode epub, html into Amazon e-book format
   ( Note: kindlegen.exe must be in C:\bin directory )

 .Example
  book yourHTMLfileName
  
  Description
  -----------
  To process only one file in time
  
 .Example
  touch
  
  Description
  -----------
  Change files date in current directory
   
#>

function ll {Get-ChildItem -Force}

function quit {exit}

function touch {
    gci | ? {$_.LastWriteTime = Get-Date }
}

function book {
  Param ([string]$strFileName)

    $strFNin = (Get-Item $strFileName).name
    $strFNout = [io.path]::ChangeExtension($strFNin,'mobi')
      & "C:\bin\kindlegen.exe" $strFNin -c2 -o $strFNout
  
  # Give colorful output
    Write-Host "`nComplete... Have a nice day!`a`n" -ForegroundColor Yellow
}

# --- LOAD FUNCTIONS AS MODULES ---
export-modulemember -function ll, quit, touch, book
