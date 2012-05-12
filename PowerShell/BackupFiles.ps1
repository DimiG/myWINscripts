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
  
  "Checking up $dataFolder...`nAnd copy if different name and length`n"

  $Fldr1 = Get-childitem -path $dataFldr -recurse
  $Fldr2 = Get-childitem -path $backUpPath -recurse

  Compare-Object $Fldr1 $Fldr2 -Property Name, Length | Where-Object {$_.SideIndicator -eq "<="} | ForEach-Object {
            Copy-Item -path "$dataFldr\$($_.name)" -destination $backUpPath -force
            }

  } 
    else {
    
   "Backing up $dataFolder...`nCheck $backUppath for your files`n"
   
    Get-Childitem -path $dataFldr -recurse |
    Foreach-Object {
            Copy-Item -path $_.FullName -destination $backUpPath -force
    }
  }
  
} #end New-BackUp

# *** entry point to script MAIN ***

# Set-Up Arrays
$dataFolder = @("\\remoteHost\remoteFolder1\Folder1","\\remoteHost\remoteFolder2\Folder2")
$destinationFolder = @("C:\Users\yourUserName\BackUPs\Folder1","C:\Users\yourUserName\BackUPs\Folder2")

# RUN main 
BackUpData
