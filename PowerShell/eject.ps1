<#
 .Synopsis
   PowerShell Eject SCRIPT
   This script Eject the flash disk

   *Note: This script in infinite developing and may not work correctly ;)

 .Description
   File Name : eject.ps1
   Author : Dmitri G. - dimi615@pisem.net
   Requires :  PowerShell Version 4.0
   Important :

   This script posted to:
   http://github.com/dimig

 .Example
  eject.ps G:

  Description
  -----------
  Eject the disk G:

#>

########################################################################
# Created By: Dmitri G. (2016)
########################################################################

# Turn on/off DEBUG reporting

# DEBUG ON
# $DebugPreference = "Continue"
# DEBUG OFF
# $DebugPreference = "SilentlyContinue"

## PowerShell Script to store and use the same credentials for PSRemoting ##

param(
 [Parameter(Position=1,Mandatory=$false,
  HelpMessage="Chose the drive to eject!!!")]
 [string]$Drive = "G:"

) #end param

process {

########################################################################
# Functions
########################################################################

function thumbEject {

    Write-Host "`nTrying to eject the drive $Drive ...`n" -ForegroundColor Cyan

    $driveEject = New-Object -comObject Shell.Application
    $driveEject.Namespace(17).ParseName($Drive).InvokeVerb("Eject")
}


########################################################################
# Variables SET
########################################################################

# Nothing to Set UP ;)

########################################################################
# Program START HERE
########################################################################

#Invoke the Function `thumbEject'

try {

        thumbEject
        Write-Host "Done. Have a nice Day`n" -ForegroundColor Yellow

    }
catch {

    # Say something...
        Write-Host "Oops... Something wrong with disk eject! :(`a`n" -ForegroundColor Red

    }

}
