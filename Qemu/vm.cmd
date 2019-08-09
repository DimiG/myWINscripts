@ECHO OFF

:: ########################################################################
:: File: vm.cmd
:: Created by: Dmitri G.
:: Date: 2019-08-09
:: Description: This Command File Run Qemu Virtual Machine
:: ########################################################################

:: This Block for Annotation
:: USB device connection examples
:: -usb -device usb-host,vendorid=0x1234,productid=0x1234^
:: -usb -device usb-host,hostbus=0,hostaddr=3^
CLS
ECHO.
ECHO .......................................
ECHO .    Run the Qemu Virtual Machine     .
ECHO .                                     .
ECHO .      Created By: DimiG (2019)       .
ECHO .......................................
ECHO.

SETLOCAL
set QEMU_QCOW2=qemu-img create -f qcow2 %1 %2
set QEMU_NETWORK=qemu-system-x86_64.exe -m 1536 -smp 4 -hda %1 -accel hax -vga std^
 -netdev user,id=n0,hostfwd=tcp::2222-:22 -device rtl8139,netdev=n0
set QEMU_NOWINDOW=qemu-system-x86_64.exe -m 1536 -smp 4 -hda %1 -nographic -accel hax^
 -netdev user,id=n0,hostfwd=tcp::2222-:22 -device rtl8139,netdev=n0
set QEMU_ISO=qemu-system-x86_64.exe -boot d -cdrom %1 -m 1536 -smp 4 -hda %2 -vga std -accel hax
set QEMU_IMG=qemu-system-x86_64.exe -m 1536 -smp 4 -hda %1 -drive file=%2,format=raw -accel hax -vga std^
 -netdev user,id=n0,hostfwd=tcp::2222-:22 -device rtl8139,netdev=n0

:: Script Settings
IF [%1] EQU []   GOTO usage
IF [%2] EQU []   GOTO usage
IF [%1] EQU [/?] GOTO usage

:: Script Logic
IF [%2] EQU [-run]   GOTO qemu_network
IF [%2] EQU [-nw]    GOTO qemu_nowindow
IF [%3] EQU [-iso]   GOTO qemu_iso
IF [%3] EQU [-qcow2] GOTO qemu_qcow2
IF [%3] EQU [-img]   GOTO qemu_img

:: Run HELP
GOTO usage

:: Run The Code Qemu Network
:qemu_network
ECHO.
ECHO RUN the Qemu Virtual Machine with network...
ECHO.

%QEMU_NETWORK%

GOTO :EOF

:: Run The Code Qemu NoWindow
:qemu_nowindow
ECHO.
ECHO RUN the Qemu Virtual Machine with NO WINDOW...
ECHO.

%QEMU_NOWINDOW%

GOTO :EOF

:: Run The Code Qemu CDROM
:qemu_iso
ECHO.
ECHO RUN the Qemu Virtual Machine with ISO image...
ECHO.

%QEMU_ISO%

GOTO :EOF

:: Run The Code Qemu QCOW2
:qemu_qcow2
ECHO.
ECHO Creating the Qemu Virtual Machine image file...
ECHO.

%QEMU_QCOW2%

GOTO :EOF

:: Run The Code Qemu IMG
:qemu_img
ECHO.
ECHO Working with Qemu Virtual Machine IMG file...
ECHO.

%QEMU_IMG%

GOTO :EOF

:usage
ECHO.
ECHO Usage: %0 COW2_IMAGE.qcow2 -nw
ECHO Usage: %0 COW2_IMAGE.qcow2 -run
ECHO Usage: %0 COW2_IMAGE.qcow2 30G -qcow2
ECHO Usage: %0 ISO_IMAGE.iso COW2_IMAGE.qcow2 -iso
ECHO Usage: %0 COW2_IMAGE.qcow2 IMAGE_FILE.img -img
ECHO.

:EOF
