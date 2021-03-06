@ECHO OFF

:: ########################################################################
:: File: WinPEmaker.cmd
:: Created by: Dmitri G.
:: Date: 2019-10-08
:: Description: This Command File Run WinPE compilation processes
:: ########################################################################

:: ########################################################################
:: # Note: Install the Windows Assessment and Deployment Kit (ADK),       #
:: # adding the Deployment Tools and Windows Preinstallation Environment  #
:: # features. If you're using installing the ADK for Windows 10, version #
:: # 1809, Windows PE is a separate add-on that you'll need to download   #
:: # and install after you install the ADK.                               #
:: # To make WinPE with PXE boot follow official instruction (README.md): #
:: # https://docs.microsoft.com/en-us/windows/deployment/                 #
:: # configure-a-pxe-server-to-load-windows-pe                            #
:: # Your TFTP server MUST accept back slash                              #
:: ########################################################################


:: This Block for Annotation
ECHO.
ECHO .......................................
ECHO .    Run WinPE compilation processes  .
ECHO .                                     .
ECHO .         ( PowerShell added )        .
ECHO .                v1.0.1               .
ECHO .     Created By: Dmitri G. (2019)    .
ECHO .......................................
ECHO.

:: Set LOCALs
SETLOCAL
set WINPE_PREP=copype amd64 C:\WinPE_amd64_PS
set WINPE_MOUNT=Dism /Mount-Wim /WimFile:"C:\WinPE_amd64_PS\media\sources\boot.wim" /Index:1 /MountDir:"C:\WinPE_amd64_PS\mount"
set WINPE_UNMOUNT=Dism /Unmount-Wim /MountDir:C:\WinPE_amd64_PS\mount /Commit
set WINPE_VHDX_CREATE=diskpart /s C:\bin\scripts\Create-VHDX.txt
set WINPE_VHDX_MAKE=MakeWinPEMedia /UFD C:\WinPE_amd64_PS Z:
set WINPE_ISO=MakeWinPEMedia /ISO C:\WinPE_amd64_PS C:\VHD\WinPE_amd64_PS.iso

:: Script Settings
IF [%1] EQU []   GOTO usage
IF [%1] EQU [/?] GOTO usage

:: Script Logic
IF [%1] EQU [prep]    GOTO winpe_prep
IF [%1] EQU [mount]   GOTO winpe_mount
IF [%1] EQU [ps]      GOTO winpe_powershell
IF [%1] EQU [unmount] GOTO winpe_unmount
IF [%1] EQU [create]  GOTO winpe_vhdx_create
IF [%1] EQU [make]    GOTO winpe_vhdx_make
IF [%1] EQU [iso]     GOTO winpe_iso
IF [%1] EQU [pxe]     GOTO winpe_pxe

:: Run HELP
GOTO usage

:: Run The Code WinPE Prep
:winpe_prep
ECHO.
ECHO WinPE preparation procedure...
ECHO.

%WINPE_PREP%

GOTO :EOF

:: Run The Code WinPE Mount
:winpe_mount
ECHO.
ECHO WinPE mounting...
ECHO.

%WINPE_MOUNT%

GOTO :EOF

:: Run The Code WinPE Unmount
:winpe_unmount
ECHO.
ECHO WinPE unmounting...
ECHO.

%WINPE_UNMOUNT%

GOTO :EOF

:: Run The Code WinPE CREATE
:winpe_vhdx_create
ECHO.
ECHO Creating the virtual hard drive (.vhdx)
ECHO Please CHECK the mounted drive after complete!!!
ECHO.

%WINPE_VHDX_CREATE%

GOTO :EOF

:: Run The Code WinPE MAKE
:winpe_vhdx_make
ECHO.
ECHO Copy WinPE to VHD MEDIA...
ECHO Disk MUST be MOUNTED before this process
ECHO Please CHECK the mounted drive after complete!!!
ECHO.

%WINPE_VHDX_MAKE%

GOTO :EOF

:: Run The Code WinPE ISO
:winpe_iso
ECHO.
ECHO Copy WinPE to ISO MEDIA...
ECHO.

%WINPE_ISO%

GOTO :EOF

:: Run The Code WinPE PowerShell
:winpe_powershell
ECHO.
ECHO Adding the PowerShell to WindowsPE...
ECHO.

Dism /Add-Package /Image:"C:\WinPE_amd64_PS\mount" /PackagePath:"C:\Program Files (x86)\Windows Kits\10\Assessment and Deployment Kit\Windows Preinstallation Environment\amd64\WinPE_OCs\WinPE-WMI.cab"
Dism /Add-Package /Image:"C:\WinPE_amd64_PS\mount" /PackagePath:"C:\Program Files (x86)\Windows Kits\10\Assessment and Deployment Kit\Windows Preinstallation Environment\amd64\WinPE_OCs\en-us\WinPE-WMI_en-us.cab"
Dism /Add-Package /Image:"C:\WinPE_amd64_PS\mount" /PackagePath:"C:\Program Files (x86)\Windows Kits\10\Assessment and Deployment Kit\Windows Preinstallation Environment\amd64\WinPE_OCs\WinPE-NetFX.cab"
Dism /Add-Package /Image:"C:\WinPE_amd64_PS\mount" /PackagePath:"C:\Program Files (x86)\Windows Kits\10\Assessment and Deployment Kit\Windows Preinstallation Environment\amd64\WinPE_OCs\en-us\WinPE-NetFX_en-us.cab"
Dism /Add-Package /Image:"C:\WinPE_amd64_PS\mount" /PackagePath:"C:\Program Files (x86)\Windows Kits\10\Assessment and Deployment Kit\Windows Preinstallation Environment\amd64\WinPE_OCs\WinPE-Scripting.cab"
Dism /Add-Package /Image:"C:\WinPE_amd64_PS\mount" /PackagePath:"C:\Program Files (x86)\Windows Kits\10\Assessment and Deployment Kit\Windows Preinstallation Environment\amd64\WinPE_OCs\en-us\WinPE-Scripting_en-us.cab"
Dism /Add-Package /Image:"C:\WinPE_amd64_PS\mount" /PackagePath:"C:\Program Files (x86)\Windows Kits\10\Assessment and Deployment Kit\Windows Preinstallation Environment\amd64\WinPE_OCs\WinPE-PowerShell.cab"
Dism /Add-Package /Image:"C:\WinPE_amd64_PS\mount" /PackagePath:"C:\Program Files (x86)\Windows Kits\10\Assessment and Deployment Kit\Windows Preinstallation Environment\amd64\WinPE_OCs\en-us\WinPE-PowerShell_en-us.cab"
Dism /Add-Package /Image:"C:\WinPE_amd64_PS\mount" /PackagePath:"C:\Program Files (x86)\Windows Kits\10\Assessment and Deployment Kit\Windows Preinstallation Environment\amd64\WinPE_OCs\WinPE-StorageWMI.cab"
Dism /Add-Package /Image:"C:\WinPE_amd64_PS\mount" /PackagePath:"C:\Program Files (x86)\Windows Kits\10\Assessment and Deployment Kit\Windows Preinstallation Environment\amd64\WinPE_OCs\en-us\WinPE-StorageWMI_en-us.cab"
Dism /Add-Package /Image:"C:\WinPE_amd64_PS\mount" /PackagePath:"C:\Program Files (x86)\Windows Kits\10\Assessment and Deployment Kit\Windows Preinstallation Environment\amd64\WinPE_OCs\WinPE-DismCmdlets.cab"
Dism /Add-Package /Image:"C:\WinPE_amd64_PS\mount" /PackagePath:"C:\Program Files (x86)\Windows Kits\10\Assessment and Deployment Kit\Windows Preinstallation Environment\amd64\WinPE_OCs\en-us\WinPE-DismCmdlets_en-us.cab"

GOTO :EOF

:: Run The Code WinPE PXE
:winpe_pxe
ECHO.
ECHO Configure boot settings for PXE boot...
ECHO.

bcdedit /store c:\BCD /create {ramdiskoptions} /d "Ramdisk options"
bcdedit /createstore c:\BCD
bcdedit /store c:\BCD /set {ramdiskoptions} ramdisksdidevice boot
bcdedit /store c:\BCD /set {ramdiskoptions} ramdisksdipath \boot\boot.sdi
bcdedit /store c:\BCD /create /d "winpe boot image" /application osloader

ECHO.
ECHO Your GUID number will be used in next commands. Copy and Paste it below.
SET /p guid="Enter GUID: "
ECHO You have entered this GUID: %guid%
ECHO.

bcdedit /store c:\BCD /set {%guid%} path \windows\system32\winload.exe
bcdedit /store c:\BCD /set {%guid%} device ramdisk=[boot]\boot\boot.wim,{ramdiskoptions}
bcdedit /store c:\BCD /set {%guid%} osdevice ramdisk=[boot]\boot\boot.wim,{ramdiskoptions}
bcdedit /store c:\BCD /set {%guid%} systemroot \windows
bcdedit /store c:\BCD /set {%guid%} detecthal Yes
bcdedit /store c:\BCD /set {%guid%} winpe Yes

ECHO.
ECHO Copy your new created BCD file "c:\BCD" to your "boot" folder of your TFTP server...
ECHO.

bcdedit /store C:\BCD /enum all

GOTO :EOF

:usage
ECHO.
ECHO You MUST run this script as Admin!
ECHO.
ECHO Usage: %0 prep    - Prepare the Windows PE for development
ECHO Usage: %0 mount   - WinPE mount for development
ECHO Usage: %0 ps      - Add PowerShell to Windows PE
ECHO Usage: %0 unmount - WinPE unmount
ECHO Usage: %0 create  - Create a virtual hard drive (.vhdx)
ECHO Usage: %0 make    - Make Windows PE VHD media
ECHO Usage: %0 iso     - Make Windows PE ISO media
ECHO Usage: %0 pxe     - Make Windows PE PXE media
ECHO.

:EOF
