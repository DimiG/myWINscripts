<#
.SYNOPSIS

This script for video files creating in ProRes codec

Version: 1.0.0

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
[string]$SourceFile

) #end param

process {

# DEBUG ON
# $DebugPreference = "Continue"

########################################################################
# Variables SET
########################################################################

# The help message output
If ($SourceFile.Equals("--help") -or $SourceFile.Equals("/?")) {
  Write-Host "`n*** Создание ProRes видео файла из исходника ***`n" -ForegroundColor Yellow
  Write-Host "  Варианты:" -ForegroundColor Yellow
  Write-Host "  ---------" -ForegroundColor Yellow
  Write-Host -NoNewline "> ProResCreator.ps1" -ForegroundColor Yellow
  Write-Host "  # Кодирует все MOV файлы в текущей папке в ProRes" -ForegroundColor Cyan
  Write-Host "`n`a"
  Break
}

[string[]]$vFiles=@("*.mov")

$strMessage1 = "Write-Host -NoNewline '`nКодирование файлов ProRes 422, ждите... ' -ForegroundColor Magenta"
$strMessage2 = "Write-Host '`nКодирование выполнено, Спасибо!`n`a' -ForegroundColor Green"
$folderName = "ProRes422"

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

        $strCommand1 = "ffmbc -i '$file' -vcodec prores -pix_fmt yuv422p10 -acodec copy -timecode 00:10:00:00 '$destname'"

        Write-Debug $destname

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
