<#
.SYNOPSIS

This script for video files creating in ProRes codec

Version: 1.0.1

.DESCRIPTION

ProRes Video Making

Russian localisation

.NOTES

File Name : ProResCreator.ps1
Author : Dmitri G. (2017) - dimi615@pisem.net
Requires : PowerShell Version 4.0

.LINK

No any links. Internal use ;)

.EXAMPLE

ProResCreator.ps1

Description
-----------
Convert video files in folder to ProRes422

.EXAMPLE

ProResCreator.ps1 -Cores 12

Description
-----------
Convert video files with processor core numbers

.EXAMPLE

ProResCreator.ps1 /?

Description
-----------
Get short HELP...

#>

########################################################################
# Created By: Dmitri G. (2017)
########################################################################

param(
[Parameter(Mandatory=$false)]
[string]$Cores = "4"

) #end param

process {

# DEBUG ON
# $DebugPreference = "Continue"

########################################################################
# Variables SET
########################################################################

# The help message output
If ($Cores.Equals("--help") -or $Cores.Equals("/?")) {
  Write-Host "`n*** Создание ProRes видео файла из исходника ***`n" -ForegroundColor Yellow
  Write-Host "  Варианты:" -ForegroundColor Yellow
  Write-Host "  ---------" -ForegroundColor Yellow
  Write-Host -NoNewline "> ProResCreator.ps1" -ForegroundColor Yellow
  Write-Host "  # Кодирует все MOV файлы в текущей папке в ProRes" -ForegroundColor Cyan
  Write-Host -NoNewline "> ProResCreator.ps1 -Cores 12"  -ForegroundColor Yellow
  Write-Host "  # Кодирует все MOV файлы на 12 ядрах процессора" -ForegroundColor Cyan
  Write-Host "`n`a"
  Break
}

[string[]]$vFiles=@("*.mov")

[string]$strMessage1 = "Write-Host -NoNewline '`nКодирование файлов ProRes 422, ждите... ' -ForegroundColor Magenta"
[string]$strMessage2 = "Write-Host '`nКодирование выполнено, Спасибо!`n`a' -ForegroundColor Green"
[string]$folderName = "ProRes422"

########################################################################
# Functions
########################################################################

function exception {

  Write-Host "`nOops!!! Something go wrong...!!!`n`a" -ForegroundColor Red

}

function Convert2ProRes {

    Invoke-Expression -Command:$strMessage1

  # Collect the files
    [Environment]::CurrentDirectory=(Get-Location -PSProvider FileSystem).ProviderPath
    $files = Get-ChildItem -Recurse -Include $vFiles -File | Where-Object {$_.PSParentPath -notmatch $folderName}

    If(!(test-path $folderName))
    {
      New-Item -ItemType Directory -Path $folderName | Out-Null
    }

    # Collect the FILES
    foreach ($file in $files) {
      $destname = $folderName + "\" + $file.BaseName + "_ProRes1080p.mov"

      if (!(test-path $destname)) {
        Write-Host "Обрабатываю: $($file.BaseName)" -ForegroundColor Magenta

        $strCommand1 = "ffmbc -i '$file' -vcodec prores -pix_fmt yuv422p10 -acodec copy -threads $Cores -timecode 00:10:00:00 '$destname'"

        Write-Debug $strCommand1

        Invoke-Expression -Command:$strCommand1

        }
      }

    Invoke-Expression -Command:$strMessage2
}

########################################################################
# Program START HERE
########################################################################
try {

  Convert2ProRes

  } catch { exception }

}
