@ECHO OFF

:: Convert MOV files to MP4

:: ########################################################################
:: # Created By: Dmitri G. (2019)
:: ########################################################################

:: This block for annotation
ECHO.
ECHO .......................................
ECHO .      Convert MOV files to MP4       .
ECHO .                720p                 .
ECHO .      Created By: DimiG (2019)       .
ECHO .               v0.0.2                .
ECHO .......................................
ECHO.

:: Script Settings
:: No setting here

:: Check if you need help
IF [%1] EQU [/?] GOTO usage

:: The Code 1

for %%a in ("*.mov") do handbrakecli.exe -i "%%a" -o "%%~na".mp4 -e x264 -q 20 -B 160 -l 720 --crop 0:0:0:0

:: Message
:message
ECHO.
ECHO Script COMPLETE! Have a GOOD DAY!!! :)
ECHO.

::PAUSE

GOTO :EOF

:usage
ECHO.
ECHO Usage: RUN mov2mp4-hb.cmd inside the folder
ECHO where  MOV video files you want to convert
ECHO.

EXIT /B 1
