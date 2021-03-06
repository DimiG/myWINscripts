<#
.SYNOPSIS
    This script is backup utility for networked files by PowerShell    
.DESCRIPTION
    This script look into SMB networked file and copy it locally if changed
    *Note: This script is not fully tested, and may not work correctly
.NOTES
    File Name : BackupFiles.ps1
    Author : Dmitri Guslinsky - dimi615@pisem.net
    Requires : PowerShell Version 2.0
    Important : Networked path must be exist (check your folders before run and change inside script!!!)
.LINK
    This script posted to:
    http://github.com/dimig
.EXAMPLE
    Just run it! ;)
#>

# PowerShell Script for backup routine

# ... Functions ...

Function BackUpData
{
  for ($i=0; $i -le 1; $i++) {
  $backUpPath = $destinationFolder[$i]
  if (!(Test-Path -path $backUpPath)) {
    $null = New-Item -path $backUpPath -itemType directory
    }
  New-Backup $dataFolder[$i] $backUpPath
  }
      
} #end BackUpData

Function New-Backup($dataFldr,$backUpPath)
{
  
  if (Test-Path -path "$backUpPath\*") {
  
        Write-Host "Checking up $dataFldr...`nAnd copy if different name and length`n" -ForegroundColor Green
            try {
            
                $Fldr1 = Get-childitem -path $dataFldr -recurse -ErrorAction SilentlyContinue
                $Fldr2 = Get-childitem -path $backUpPath -recurse -ErrorAction SilentlyContinue

                Compare-Object $Fldr1 $Fldr2 -Property Name, Length | Where-Object {$_.SideIndicator -eq "<="} | ForEach-Object {
                Copy-Item -path "$dataFldr\$($_.name)" -destination $backUpPath -force }
            }
            catch {
              # Say something...
                Write-Host "`nOops... Something wrong with network! :(`n..Check Out network connection PLEASE...`a`n" -ForegroundColor Red
                    break
            }
   
  } 
    else {
    
        Write-Host "Backing up $dataFldr...`nChecking $backUpPath for your files`n" -ForegroundColor Green
            try {

                Get-Childitem -path $dataFldr -recurse -ErrorAction SilentlyContinue |
                Foreach-Object {
                    Copy-Item -path $_.FullName -destination $backUpPath -force
                }
            }
            catch {
              # Say something...
                Write-Host "`nOops... Something wrong with network! :(`n..Check Out network connection PLEASE...`a`n" -ForegroundColor Red
                    break
            }
    }
  
} #end New-BackUp

# *** entry point to script MAIN ***

# Set-Up Arrays
$dataFolder = @("\\remoteHost\remoteFolder1\Folder1","\\remoteHost\remoteFolder2\Folder2")
$destinationFolder = @("C:\Users\yourUserName\BackUPs\Folder1","C:\Users\yourUserName\BackUPs\Folder2")

# RUN main 
BackUpData