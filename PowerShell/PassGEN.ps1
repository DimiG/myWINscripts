﻿<#
.SYNOPSIS

This script generate the passwords by PowerShell

Version: 1.0.2

.DESCRIPTION

Generate passwords by PowerShell

.NOTES

File Name : PassGEN.ps1
Author : Dmitri G. (2017)
Requires : PowerShell Version 5.0

.LINK

No any links. Internal use ;)

.EXAMPLE

PassGEN.ps1 PasswordLength

Description
-----------
Generate passwords by PowerShell

#>

########################################################################
# Created By: Dmitri G. (2017)
########################################################################

param(
[Parameter(Mandatory=$true)]
[string]$Length

) #end param

process {

########################################################################
# Functions
########################################################################

function infStart {
  # Prepare the screen
    Clear-Host
    $Time=Get-Date
    Write-Host "`n$Time Let's start..." -ForegroundColor Green
}

function infStop {
  # Stop here
    $Time=Get-Date
    Write-Host "`a`n$Time Have a good day, Thanks!`n" -ForegroundColor Green
    exit
}

function generate {

    Write-Host "`nGenerate Password...`n" -ForegroundColor Yellow

    ((65..90) + (97..122) + (48..57) | Get-Random -Count $Length | % {[char]$_}) -join""

}

########################################################################
# Variables SET
########################################################################

# The help message output
If ($Length.Equals("--help") -or $Length.Equals("/?")) {
  Write-Host "`nUsage: PassGEN.ps1 PasswordLength`n`a" -ForegroundColor Yellow
  Break
}

########################################################################
# Program START HERE
########################################################################

generate
infStop

}
