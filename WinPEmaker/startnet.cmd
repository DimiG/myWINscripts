@ECHO OFF

:: ###################################################
:: File: startnet.cmd
:: Created by: Dmitri G.
:: Date: 2019-07-26
:: Description: This Command File initialize WinPE
:: ###################################################

:: This Block for Annotation
ECHO.
ECHO .......................................
ECHO .    WinPE with PowerShell support    .
ECHO .                 v1.0                .
ECHO .     Created By: Dmitri G. (2019)    .
ECHO .......................................
ECHO.
ECHO.
ECHO Commands list:
ECHO help                                        - call the README.md file
ECHO reboot                                      - restart  computer
ECHO poweroff                                    - shutdown computer
ECHO ps                                          - run      PowerShell
ECHO.
ECHO clonedrive D:\WinSystemYYYYMMDD.ffu 0       - clone the physical drive #0
ECHO restoredrive D:\WinSystemYYYYMMDD.ffu 0     - restore the physical drive #0
ECHO clonewim D:\WinSystemYYYYMMDD.wim W WIMname - clone WIM to disk D: from W: with name
ECHO restorewim D:\WinSystemYYYYMMDD.wim W       - restore WIM from D: to disk W:
ECHO.
ECHO Note: Before drive cloning check out the README and real volume letters by "diskpart" utility!!!

wpeinit

powercfg /s 8c5e7fda-e8bf-4a96-9a85-a6e23a8c635c

set PATH=%PATH%;X:\Windows\Apps;X:\Windows\Scripts

doskey help=type X:\Windows\Apps\README.md
doskey ps=powershell -executionpolicy bypass
doskey ls=dir
doskey reboot=wpeutil reboot
doskey poweroff=wpeutil shutdown
doskey clonedrive=DISM /capture-ffu /imagefile=$1 /capturedrive=\\.\PhysicalDrive$2 /name:DesktopSystem /description:"Windows System Disk clone"
doskey restoredrive=DISM /apply-ffu /ImageFile=$1 /ApplyDrive:\\.\PhysicalDrive$2
doskey clonewim=DISM /Capture-Image /ImageFile:$1 /CaptureDir:$2:\ /Name:$3
doskey restorewim=DISM /Apply-Image /ImageFile:$1 /Index:1 /ApplyDir:$2:\

ver
