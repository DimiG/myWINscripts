@ECHO OFF

:: Convert MOV files to MP4

:: ########################################################################
:: # Created By: Dmitri G. (2017)
:: ########################################################################

:: This block for annotation
ECHO.
ECHO .......................................
ECHO .      Convert MOV files to MP4       .
ECHO .                                     .
ECHO .      Created By: DimiG (2017)       .
ECHO .......................................
ECHO.

:: Script Settings
:: No setting here

:: Check if you need help
IF [%1] EQU [/?] GOTO usage

:: The Code 1
for %%a in ("*.mov") do ffmpeg.exe -i "%%a" -vcodec copy -acodec copy "%%~na".mp4

:: Message
:message
ECHO.
ECHO Script COMPLETE! Have a GOOD DAY!!! :)
ECHO.

::PAUSE

GOTO :EOF

:usage
ECHO.
ECHO Usage: RUN mov2mp4.cmd inside the folder
ECHO with MOV video files you want to convert.
ECHO.

EXIT /B 1
