<#
.SYNOPSIS

This script for ProRes making

Version: 1.0.1

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

#>

########################################################################
# Created By: Dmitri G. (2017)
########################################################################

# Turn on/off DEBUG reporting

# DEBUG ON
# $DebugPreference = "Continue"
# DEBUG OFF
# $DebugPreference = "SilentlyContinue"

# Deinterlace by: -vf "yadif"

param(
[Parameter(Mandatory=$true)]
[string]$SourceFile,
[ValidateSet("Proxy","LT","Normal","HQ")]
[string]$Mode="Normal",
[switch]$Deinterlace

) #end param

########################################################################
# Variables SET
########################################################################

# The help message output
If (($SourceFile -Match "help") -or ($SourceFile -Match "--help") -or ($SourceFile -Match "/?")) {
  Write-Host "`n*** Создание ProRes видео файла из исходника ***`n" -ForegroundColor Yellow
  Write-Host "Варианты:" -ForegroundColor Yellow
  Write-Host "---------" -ForegroundColor Yellow
  Write-Host "> ProResMaker.ps1 FileName -Mode Proxy -Deinterlace" -ForegroundColor Yellow
  Write-Host "> ProResMaker.ps1 FileName -Mode LT -Deinterlace" -ForegroundColor Yellow
  Write-Host "> ProResMaker.ps1 FileName -Mode Normal -Deinterlace" -ForegroundColor Yellow
  Write-Host "> ProResMaker.ps1 FileName -Mode HQ -Deinterlace`n`a" -ForegroundColor Yellow
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
[string]$extension = [System.IO.Path]::GetExtension($SourceFile)
[string]$newFileName = $strippedFileName + $Prefix + [DateTime]::Now.ToString(".yyMMdd") + $extension
[string]$newFilePath = [System.IO.Path]::Combine($directory, $newFileName)

Clear-Host

########################################################################
# Program START HERE
########################################################################

switch ($Deinterlace)
{
    true
    {
        Write-Host "`nКодирование файлов ProRes 422 + Deinterlace, ждите...`n" -ForegroundColor Magenta
        $strSwitches = ("-c:v","prores","-vf","`"yadif`"","-c:a","copy","-profile:v",$NumMode)
    }

    default
    {
        Write-Host "`nКодирование файлов ProRes 422, ждите...`n" -ForegroundColor Magenta
        $strSwitches = ("-c:v","prores","-c:a","copy","-profile:v",$NumMode)
    }
}

# Debug
# Write-Host "`nYour switchers are: $strSwitches`n" -ForegroundColor Yellow
# Write-Host "`nYour output name is: $newFilePath`n" -ForegroundColor Yellow

& ffmpeg -i $SourceFile $strSwitches $newFilePath

Write-Host "`nКодирование выполнено, Спасибо!`n`a" -ForegroundColor Green

