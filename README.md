myWINscripts
===========
This repository dedicated to myOWN Windows scripts I use for daily purposes.

Repositories divided between Windows and Linux/Mac/UNIX scripts due to an incompatibility
with special characters inside the text files and different encodings.

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

* `WindowsPowerShell`: My implementation of PowerShell modules.<br>
   **Note :** Please kindly read instructions inside modules. ;) This code may contain bugs.<br>
   ***Requires :*** PowerShell Version 2.0<br>
   ***Important:*** WindowsPowerShell folder must be located inside your user Documents folder. Don't change the file names
   and folder structure.

### Python folder

* `pingTEST.py`: (SubProcess folder) This script just an example how to invoke the subprocess with CLI program 
                    from Python code.<br>
   **Note :** This scrip tested by Python 2.7.8 on [Synology][synology] platform.<br>
   ***Requires :*** Python 2.7.8

* `projectBackUP.py`: (AvidProjBackUP folder) This script backup (mirror) the [Avid][avid] projects located in shared folder
                    by Windows internal Robocopy (Robust File Copy for Windows) program. No additional modules required.<br>
   **Note :** Two mirrors created in separate folders by current ODD or EVEN date.<br>
   ***Requires :*** Python 2.7.7, Microsoft Windows 7 and above<br>
   ***Important:*** JOBtask folder MUST be located as "C:\JOBtask" with two job task configuration files inside<br>
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

* `To be continued...`

Your Questions - my Answers
---------------------------

### Why is it public?

Exist some reasons for it:

* I don't like to make one job many times and want to save it in the cloud.

* If someone have same automation needs he can contribute and improve this code
  for personal use.

* I want to use the `Git` for personal study and project collaboration

### When do you finish?

Just fill it one by one.

### Is it safe to use?

These code is not fully tested, and may not work correctly. For me it works very well.

### Who Are You?

My name is [Dmitri][dimig] and I'm a splendid chap.

### Where can I find more info?

Additional tips and tricks are on [myOWN blog][homepage].

Contributing
------------

Fork the [DimiG repository on GitHub](https://github.com/dimig) and
send a Pull Request.


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
[pyinstaller]:http://www.pyinstaller.org
