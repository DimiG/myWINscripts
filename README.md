myWINscripts
===========
This repository dedicated to myOWN Windows scripts I use for daily purposes.

Repositories divided between Windows and Linux/Mac/UNIX scripts due to an incompatibility
with special characters inside the text files and different encoding.

Scripts description
-------------------

### PowerShell folder

* `BackupFiles.ps1`: Backup networked files locally.<br>
   **Note :** To run this script by Task Scheduler use this command line:<br>
   powershell.exe -noexit &'C:\bin\scripts\BackupFiles.ps1'<br>
   This code may contain bugs.<br>
   ***Requires :*** PowerShell Version 2.0<br>
   ***Important:*** Networked resources must be exist and open for current user. Check folder names below the script

* `Convert2.ps1`: Transcode and Rip DVD to video format you wish. This script use
   ffmpeg and HandBrakeCLI for windows to encode. Provide FPS, video format
   and aspect ratio changes. MPEG video tested with SONY SMP-U10 USB player.<br>
   **Note :** Played much with functions in PowerShell. ;) This code is not well optimized.<br>
   ***Requires :*** PowerShell Version 2.0, ffmpeg and HandBrakeCLI for Windows<br>
   ***Important:*** ffmpeg and HandBrakeCLI MUST BE LOCATED in "C:\bin\"

* `ripDVD.ps1`: Transcode and Rip DVD to video MP4 format. This script use
   HandBrakeCLI and dd for Windows. Provide ISO file creation from DVD media.<br>
   ***Requires :*** PowerShell Version 4.0 and [HandBrakeCLI][handbrake] MinGW x86_64 for Windows.<br>
                    [dd][dd] for Windows.<br>
   ***Important:*** HandBrakeCLI and dd MUST BE LOCATED in "C:\bin\"

* `authorDVD.ps1`: Author DVD-VIDEO format by this simple script. This script use
   FFmpeg, dvdauthor, mkisofs and ISOWriter for Windows. Provide ISO file creation and ISO file burn.<br>
   ***Requires :*** PowerShell Version 4.0, [FFmpeg][ffmpeg], [dvdauthor][dvdauthor], [mkisofs][mkisofs]<br>
                    and [ISOWriter][isowriter] for Windows.<br>
   ***Important:*** All CLI utilities MUST BE LOCATED in "C:\bin\" (PATH specified also)<br>
                    The dvd.xml example file located in authorDVD.ps1 folder. Drop it to your working folder.

* `MKVripper.ps1`: MKV to MP4 lossless converter. This script use mkvmerge, mkvextract and MP4Box for Windows.<br>
   ***Requires :*** PowerShell Version 4.0, [mkvmerge][mkvmerge], [mkvextract][mkvextract] and [MP4Box][mp4box] for Windows<br>
   ***Important:*** All CLI utilities MUST BE LOCATED in "C:\bin\" (PATH specified also)<br>
                    MP4 doesn't officially support AC3 audio so the audio track should be converted into<br>
                    a supported format (eg. AAC, MP3), if U WANT the file to be PLAYABLE with something else than VLC. ;)

* `SynBackUP.ps1`: Backup the [Synology NAS][synology] WEB site by rsync on Windows platform via SSH. This script use
   [Rsync][cwrsync] for Windows and [PowerShell][powershell].<br>
   ***Requires :*** PowerShell Version 4.0 and [Rsync][rsync] for [Windows][cwrsync].<br>
                    [dd][dd] for Windows.<br>
   ***Important:*** rsync.exe MUST BE ACCESSIBLE in Path environment set

* `FileRenamerGUI.ps1`: This script rename the bunch of files by adding numbers. Created in a GUI form.<br>
                    Maybe useful for music album renaming. No additional modules required.<br>
   ***Requires :*** PowerShell Version 4.0<br>
   ***Important:*** The icon file rename128x128.ico MUST be located same directory as FileRenamerGUI.ps1<br>
                    To start the script CREATE the link to script and ADD the code there<br>
                    `powershell.exe -sta -WindowStyle hidden -noprofile -nologo -command "C:\FileRenamerGUI.ps1"`

* `RoboSync.ps1`: This script backup the huge amount of data from Avid Media server by Windows internal `Robocopy.exe` utility.<br>
                    You can use it with any other server also. The current script help with complex settings.<br>
   **Note :**       Available via [scoop][scoop] and [dgbucket][dgbucket]<br>
   ***Requires :*** PowerShell Version 4.0 or newer.<br>
   ***Important:*** BE CAREFUL WITH DIRECTION OF SYNCING!!! You may LOSS data if incorrect Source/Destination path!<br>
                    Get-Help for additional info.

* `ProResMaker_2016.ps1`: This script converts the video file to ProRes422 codec. It is useful in professional video facilities.<br>
                    Run `Get-Help ProResMaker_2016.ps1` for MORE information.<br>
   **Note :**       Available via [scoop][scoop] and [dgbucket][dgbucket]<br>
   ***Requires :*** PowerShell Version 4.0 or newer, [FFmpeg][ffmpeg].<br>
   ***Important:*** [FFmpeg][ffmpeg] MUST be accessible for program to work!.

* `ProResCreator.ps1`: One more script implementation for ProRes422 video files encoding. It is useful in professional video facilities.<br>
                    Run `Get-Help ProResCreator.ps1` or `ProResCreator.ps1 /?` for MORE information.<br>
   **Note :**       Available via [scoop][scoop] and [dgbucket][dgbucket]<br>
   ***Requires :*** PowerShell Version 4.0 or newer, [ffmbc][ffmbc].<br>
   ***Important:*** [ffmbc][ffmbc] can be installed via [scoop][scoop] and [dgbucket][dgbucket].

* `Eject.ps1`: This simple script Ejects the flash disk from Windows system.<br>
                    Run `Get-Help eject.ps1` for MORE information.<br>
   ***Requires :*** PowerShell Version 4.0 or newer.<br>
   ***Important:*** Just read the Help before start.

* `EncAvidMXF_2016.ps1`: This script converts the video file to [Avid DNxHD][DNxHD] codec and add it into video [MXF][MXF] file format. It is useful in professional video facilities.<br>
                    This script has been tested with [Avid Media Composer 7.0.4][avid_mc] (PC version).<br>
                    Run `Get-Help EncAvidMXF_2016.ps1` for MORE information.<br>
   ***Requires :*** PowerShell Version 4.0 or newer, [FFmpeg][ffmpeg] and [bmx-win32-exe-snapshot][bmx] for [MXF][MXF] writing.<br>
   ***Important:*** [FFmpeg][ffmpeg] and [BMX][bmx] MUST be accessible for program to work!.

* `ConvertDVD_2016.ps1`: This script converts DVD-VIDEO structure to MP4 video file or ISO image. It is useful for DVD-VIDEO discs grubbing.<br>
                    Run `Get-Help ConvertDVD_2016.ps1` for MORE information.<br>
   ***Requires :*** PowerShell Version 4.0 or newer, [FFmpeg][ffmpeg] and [HandBrake][handbrake]<br>
   ***Important:*** [FFmpeg][ffmpeg] and [HandBrake][handbrake] MUST be accessible for program to work!.

* `EncMKV_2016.ps1`: Current script converts video file with multi-channel (5.1) audio to MKV (Matroska) format with multi-channel and stereo track.<br>
                    In production facilities we use [ProRes][prores] with multi-channel audio.<br>
                    Run `Get-Help EncMKV_2016.ps1` for MORE information.<br>
   ***Requires :*** PowerShell Version 4.0 or newer, [FFmpeg][ffmpeg], [MKVmerge][mkvmerge] and [aften][aften] (A/52 audio encoder)<br>
   ***Important:*** [FFmpeg][ffmpeg], [MKVmerge][mkvmerge] and [aften][aften] MUST be accessible in system PATH for program to work!.

* `PassGEN.ps1`: This script generates the passwords by [PowerShell][powershell].<br>
                    Run `Get-Help PassGEN.ps1` for MORE information.<br>
   **Note :**       Available via [scoop][scoop] and [dgbucket][dgbucket]<br>
   ***Requires :*** [PowerShell][powershell] Version 5.0 or newer.

* `PSWinUpdate.ps1`: This script helps to install updates on Windows platform from [PowerShell][powershell].<br>
                    Run `Get-Help PSWinUpdate.ps1` or `PSWinUpdate.ps1 /?` for MORE information.<br>
   **Note :**       Available via [scoop][scoop] and [dgbucket][dgbucket]<br>
   ***Requires :*** [PowerShell][powershell] Version 4.0 or newer, [Windows Update PowerShell Module][pswinupd].<br>
   ***Important:*** Windows Update [PowerShell][powershell] Module CAN be located in:<br>
                    `C:\Windows\System32\WindowsPowerShell\v1.0\Modules`<br>
                    Importing the module by: `PS > Import-Module PSWindowsUpdate`

* `WinSYSbackUp.ps1`: Current script helps to create the Windows System Backup for emergency purposes.<br>
                    Run `Get-Help WinSYSbackUp.ps1` or `WinSYSbackUp.ps1 /?` for MORE information.<br>
   **Note :**       Available via [scoop][scoop] and [dgbucket][dgbucket]<br>
   ***Requires :*** [PowerShell][powershell] Version 4.0 or newer.<br>
   ***Important:*** Assumes that computer uses disk C: as system drive by default.

* `WindowsPowerShell`: My implementation of PowerShell modules.<br>
   **Note :** Please kindly read instructions inside modules. ;) This code may contain bugs.<br>
   ***Requires :*** PowerShell Version 2.0<br>
   ***Important:*** WindowsPowerShell folder must be located inside your user Documents folder. Don't change the file names
   and folder structure.

* `All Scripts`:
   **Note :** Some scripts MAY HAVE the Russian localization in messages.

### Python folder

* `sendMail.py`: (SendMail folder) This script is example how to send e-mails by Python script. The CLASS uses just for fun.<br>
   **Note :** No special rules to use it. Just read the comments and change the variables in this code to your needs.<br>
   ***Requires :*** [Python][python] 2.7.7 MSC v.1500 64 bit (AMD64) on win32, Microsoft Windows 7 and above.

* `AvidProjBackUP.py`: (AvidProjBAK2 folder) This script backup (ZIP) the [Avid][avid] projects located in Avid shared folder
                    on local hardrive to Avid video server which is located on virtual Z: disk.<br>
   **Note :** This is a Windows platform specific script and MUST be changed for other platforms. The additional AvidProjBackUP.spec,
                    file_version_info.txt and BackupFolder_128x128.ico needed for executable creating by [pyinstaller][pyinstaller].<br>
   ***Requires :*** [Python][python] 2.7.7 MSC v.1500 64 bit (AMD64) on win32, Microsoft Windows 7 and above, Cross-platform colored terminal
                    text Python package ([colorama][colorama]).<br>
   ***Important:*** The local Avid Projects usually located in "C:\Users\Public\Documents\Shared Avid Projects" by default.
                    The BackUP inside the ZIP archive pushing to "Z:\BackUP" folder on video server.
                    Read comments inside the script file for further information.

* `pingTEST.py`: (SubProcess folder) This script just an example how to invoke the subprocess with CLI program
                    from Python code.<br>
   **Note :** This script tested by Python 2.7.8 on [Synology][synology] platform.<br>
   ***Requires :*** Python 2.7.8

* `projectBackUP.py`: (AvidProjBAK1 folder) This script backup (mirror) the [Avid][avid] projects located in shared folder
                    by Windows internal Robocopy (Robust File Copy for Windows) program. No additional modules required.<br>
   **Note :** Two mirrors created in separate folders by current ODD or EVEN date.<br>
   ***Requires :*** Python 2.7.7, Microsoft Windows 7 and above<br>
   ***Important:*** JOBtask folder MUST be located as "C:\JOBtask" with two job task configuration files inside
                    ProjectBackup1.rcj and ProjectBackup2.rcj. They MUST be corrected for your purposes.<br>
                    Read comments inside job task files.

* `say.py`: (Say folder) This script demonstrate how to use COM components of Microsoft Speech API by Python.
                    This script says the words from CSV file by voice of Microsoft Anna. The format for CSV file line by line is:<br>
                    1. Sentence to say<br>
                    2. Delay in seconds between next sentence<br>
   **Note :** Microsoft Speech API need to be installed and function<br>
   ***Requires :*** Python 2.7.7, Microsoft Windows 7 and above<br>
   ***Important:*** The message.scv file MUST be located in the same folder as a script itself<br>

* `example.spec`: (PyInstallCFG) This is an example of spec file for [PyInstaller][pyinstaller] (Windows executable file creator)
                    The "Tree('data', prefix='data')" line allow to implement the data folder with files inside the executable<br>
   **Note :** file_version_info.txt help to create the metadata inside the executable file<br>
   ***Requires :*** Python 2.7.7, Microsoft Windows 7 and above, PyInstaller<br>
   ***Important:*** Data folder (data) MUST be located in the same folder as spec file<br>

* `All Scripts`:
   **Note :** Some scripts MAY HAVE the Russian localization in messages.

### CMD folder

* `mov2mp4-hb.cmd`: This Windows [CMD][cmd] script convert the video file from MOV to H264 MP4 720p format.<br>
   **Note :** Run this script where your MOV files located. It will automatically convert one by one to MP4.<br>
   ***Requires :*** [Handbrake-cli][handbrake] MUST be accessible in your system for program to work!<br>

* `All Scripts`:
   **Note :** Some scripts MAY HAVE the Russian localization in messages.

### WinPE folder

* `WinPEmaker`: This Windows [CMD][cmd] script helps to create the [Windows PE][winpe] image. `Windows Preinstallation Environment` (also known as Windows PE and WinPE) is a lightweight version of Windows used for the deployment of PCs, workstations, and servers, or troubleshooting an operating system while it is offline. It is intended to replace `MS-DOS` boot disks and can be booted via USB flash drive, PXE, iPXE, CD-ROM or hard disk. Traditionally used by large corporations and OEMs (to preinstall Windows client operating systems on PCs during manufacturing).<br>
   **Note :** Install the `Windows Assessment and Deployment Kit` (ADK) and adding the `Deployment Tools and Windows Preinstallation Environment` features according to [official Microsoft documentation][adk]. If you're using installing the `ADK` for `Windows 10`, `version 1809`, `Windows PE` is a separate add-on that you'll need to download and install after you install the `ADK`.<br>
   ***Important :*** The file `README.md` from `WinPEmaker` folder should be located inside the [WIM][wim] image here: `X:\Windows\Apps`. The [Microsoft original scripts][winpedocs] from `mscripts` folder should be located here: `X:\Windows\Scripts`. The custom made `startnet.cmd` inside the [WIM][wim] image here: `X:\Windows\System32`. The `Create-VHDX.txt` and `WinPEmaker.cmd` stay located on host engineer machine. According to [official Microsoft documentation][winpedocs] the pre-build `WinPE` is located in `C:\WinPE_amd64_PS`. The prepared final images in `C:\VHD`. The current variant contain [PowerShell][powershell] also.<br>

* `All Scripts`:
   **Note :** Files contain `CRLF` in the end of lines (EOL) cause it is Windows scripts. Otherwise, performance is NOT GUARANTEED!

### Qemu folder

* `vm.cmd`: [QEMU][qemu] is a hosted virtual machine monitor. It emulates the machine's processor through dynamic binary translation and provides a set of different hardware and device models for the machine, enabling it to run a variety of guest operating systems. It also can be used with `KVM` to run virtual machines at near-native speed (by taking advantage of hardware extensions such as Intel VT-x). [QEMU][qemu] can also do emulation for user-level processes, allowing applications compiled for one architecture to run on another.<br>
   This `CMD` script helps to run the `Qemu` Virtual Machine `VM` on `Windows` platform.<br>
   ***Requires :*** [Qemu][qemu] MUST BE pre installed on your system.<br>

* `All Scripts`:
   **Note :** Files contain `CRLF` in the end of lines (EOL) cause it is Windows scripts. Otherwise, performance is NOT GUARANTEED!

* `To be continued...`

### License

These code may be COPYRIGHT PROTECTED by ©2019 DimiG

[homepage]:http://dimig.blogspot.com
[dimig]:http://dimig.blogspot.com
[handbrake]:http://handbrake.fr
[dd]:http://www.chrysocome.net/dd
[rsync]:http://rsync.samba.org
[cwrsync]:https://www.itefix.no/i2/cwrsync
[synology]:http://www.synology.com
[powershell]:http://www.microsoft.com/powershell
[ffmpeg]:http://ffmpeg.zeranoe.com/builds/
[dvdauthor]:http://download.videohelp.com/gfd/edcounter.php?file=download/dvdauthor_winbin.zip
[mkisofs]:http://smithii.com/cdrtools
[isowriter]:http://isorecorder.alexfeinman.com/ISOWriter.htm
[mkvmerge]:http://www.bunkus.org/videotools/mkvtoolnix/downloads.html
[mkvextract]:http://www.bunkus.org/videotools/mkvtoolnix/downloads.html
[mp4box]:http://gpac.sourceforge.net
[avid]:http://www.avid.com
[pyinstaller]:https://github.com/pyinstaller/pyinstaller/wiki
[colorama]:http://pypi.python.org/pypi/colorama
[python]:https://www.python.org
[MXF]:https://en.wikipedia.org/wiki/Material_Exchange_Format
[DNxHD]:https://en.wikipedia.org/wiki/DNxHD_codec
[avid_mc]:https://en.wikipedia.org/wiki/Media_Composer
[bmx]:https://sourceforge.net/projects/bmxlib/
[aften]:http://aften.sourceforge.net/
[prores]:https://en.wikipedia.org/wiki/Apple_ProRes
[scoop]:http://scoop.sh
[dgbucket]:https://github.com/DimiG/dgBucket
[pswinupd]:https://gallery.technet.microsoft.com/scriptcenter/2d191bcd-3308-4edd-9de2-88dff796b0bc
[ffmbc]:https://www.videohelp.com/software/ffmbc
[cmd]:https://en.wikipedia.org/wiki/Cmd.exe
[winpe]:https://en.wikipedia.org/wiki/Windows_Preinstallation_Environment
[wim]:https://en.wikipedia.org/wiki/Windows_Imaging_Format
[winpedocs]:https://docs.microsoft.com/en-us/windows-hardware/manufacture/desktop/index
[adk]:https://docs.microsoft.com/en-us/windows-hardware/get-started/adk-install?ocid=tia-235208000
[qemu]:https://www.qemu.org
