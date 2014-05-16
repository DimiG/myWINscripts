<#
.SYNOPSIS
This script is for Synology NAS backup by rsync on Windows platform via SSH

.DESCRIPTION
Backup the web site

.NOTES
File Name : SynBackUP.ps1
Author : Dmitri G. - dimi615@pisem.net
Requires : PowerShell Version 4.0 and rsync for Windows - http://rsync.samba.org

.LINK
This script is not posted yet ;)

.EXAMPLE
SynBackUP.ps

Description
-----------
Process with Dry RUN (Nothig to Do)

.Example
ripDVD.ps -Force

Description
-----------
Process the syncing

#>

########################################################################
# Created By: Dmitri G. (2014)
########################################################################

param(

[switch]$Force

)

switch ($Force)
{ 
    true
    {
        Write-Host "`nCOPY FILES, waiting...`n`a" -ForegroundColor Red
        rsync --progress -vhru --exclude 'mediafiles' root@192.168.0.1:/volume1/web/MyWEBPage/* /cygdrive/c/Users/username/myWEBPage
    }

    default 
    {
        Write-Host "`nNOTHING do, Just showing...`n" -ForegroundColor Magenta
        rsync --progress -vhrun --exclude 'mediafiles' root@192.168.0.1:/volume1/web/MyWEBPage/* /cygdrive/c/Users/username/myWEBPage
    }
}

Write-Host "`nCommand COMPLETE, Thank U!`n" -ForegroundColor Green

