<#
.SYNOPSIS

This script for ProRes making

Version: 1.0.2

.DESCRIPTION

ProRes Video Making. Choose ProRes format from table below:
0 : ProRes422 (Proxy)
1 : ProRes422 (LT)
2 : ProRes422 (Normal)
3 : ProRes422 (HQ)

Russian localisation

.NOTES

File Name : ProResMaker.ps1
Author : Dmitri G. (2017) - dimi615@pisem.net
Requires : PowerShell Version 5.0

.LINK

No any links. Internal use ;)

.EXAMPLE

ProResMaker.ps1 FileName -Mode LT -Deinterlace

Description
-----------
Convert video file to ProRes422 LT with deinterlace

.EXAMPLE

ProResMaker.ps1 FileName -Mode Proxy -Force

Description
-----------
Convert video file to ProRes422 Proxy PCM audio into MOV container

#>

########################################################################
# Created By: Dmitri G. (2017)
########################################################################

param(
[Parameter(Mandatory=$true)]
[string]$SourceFile,
[ValidateSet("Proxy","LT","Normal","HQ")]
[string]$Mode="Normal",
[switch]$Deinterlace,
[switch]$Force

) #end param

process {

# DEBUG ON
# $DebugPreference = "Continue"

########################################################################
# Variables SET
########################################################################

# The help message output
If ($SourceFile.Equals("--help") -or $SourceFile.Equals("/?")) {
  Write-Host "`n*** Создание ProRes422 видео файла из исходника ***`n" -ForegroundColor Yellow
  Write-Host "  Варианты:" -ForegroundColor Yellow
  Write-Host "  ---------" -ForegroundColor Yellow
  Write-Host -NoNewline "> ProResMaker.ps1 FileName -Mode Proxy -Deinterlace" -ForegroundColor Yellow
  Write-Host "  # Кодирует файл в ProRes422 Proxy c устранением чересстрочности" -ForegroundColor Cyan
  Write-Host -NoNewline "> ProResMaker.ps1 FileName -Mode LT -Deinterlace" -ForegroundColor Yellow
  Write-Host "  # Кодирует файл в ProRes422 LT c устранением чересстрочности" -ForegroundColor Cyan
  Write-Host -NoNewline "> ProResMaker.ps1 FileName -Mode Normal -Deinterlace" -ForegroundColor Yellow
  Write-Host "  # Кодирует файл в ProRes422 c устранением чересстрочности" -ForegroundColor Cyan
  Write-Host -NoNewline "> ProResMaker.ps1 FileName -Mode HQ -Deinterlace" -ForegroundColor Yellow
  Write-Host "  # Кодирует файл в ProRes422 HQ c устранением чересстрочности" -ForegroundColor Cyan
  Write-Host -NoNewline "> ProResMaker.ps1 FileName -Mode Proxy -Force" -ForegroundColor Yellow
  Write-Host "  # Кодирует файл в ProRes422 Proxy c PCM звуком в контейнер MOV" -ForegroundColor Cyan
  Write-Host "`n`a"
  Break
}

[string]$Prefix = ""
[string]$NumMode = ""

# Prefix and Mode creation
# 0 : ProRes422 (Proxy)
# 1 : ProRes422 (LT)
# 2 : ProRes422 (Normal)
# 3 : ProRes422 (HQ)

switch ($Mode)
{
    "Proxy"
    {
        $Prefix = "_ProRes422.PROXY"
        $NumMode = "0"
    }

    "LT"
    {
        $Prefix = "_ProRes422.LT"
        $NumMode = "1"
    }

    "Normal"
    {
        $Prefix = "_ProRes422"
        $NumMode = "2"
    }

    "HQ"
    {
        $Prefix = "_ProRes422.HQ"
        $NumMode = "3"
    }

    default
    {
        Write-Host "`nОшибочка вышла...`n" -ForegroundColor Red
    }
}

# New File Name creation

[string]$directory = [System.IO.Path]::GetDirectoryName($SourceFile)
[string]$strippedFileName = [System.IO.Path]::GetFileNameWithoutExtension($SourceFile)

if ($Force) {
  [string]$extension = ".mov"
  [string]$AudioCodec = "pcm_s16le"
} else {
  [string]$extension = [System.IO.Path]::GetExtension($SourceFile)
  [string]$AudioCodec = "copy"
}

[string]$newFileName = $strippedFileName + $Prefix + [DateTime]::Now.ToString(".yyMMdd") + $extension
[string]$newFilePath = [System.IO.Path]::Combine($directory, $newFileName)


########################################################################
# Functions
########################################################################

function exception {

  Write-Host "`nOops!!! Something go wrong...!!!`n`a" -ForegroundColor Red

}

########################################################################
# Program START HERE
########################################################################

Clear-Host

switch ($Deinterlace)
{
    true
    {
        Write-Host "`nКодирование файла ProRes 422 + Deinterlace, ждите...`n" -ForegroundColor Magenta
        $strSwitches = ("-c:v","prores","-vf","`"yadif`"","-c:a",$AudioCodec,"-profile:v",$NumMode)
    }

    default
    {
        Write-Host "`nКодирование файла ProRes 422, ждите...`n" -ForegroundColor Magenta
        $strSwitches = ("-c:v","prores","-c:a",$AudioCodec,"-profile:v",$NumMode)
    }
}

Write-Debug "Your switchers are: $strSwitches"
Write-Debug "Your output name is: $newFilePath"

try {
  & ffmpeg -i $SourceFile $strSwitches $newFilePath
  } catch { exception }

Write-Host "`nКодирование выполнено, Спасибо!`n`a" -ForegroundColor Green

}
