myWINscripts
===========
This repository dedicated to myOWN Windows scripts I use for daily purposes.

Repositories divided between Windows and Linux/Mac/UNIX scripts due to an incompatibility
with special characters inside the text files and different encodings.

Scripts description
-------------------

### PowerShell folder
   
* `Convert2.ps1`: Transcode and Rip DVD to video format you wish. This script use
   ffmpeg and HandBrakeCLI for windows to encode. Provide FPS, video format
   and aspect ratio changes. MPEG video tested with SONY SMP-U10 USB player.<br>
   **Note :** Played much with functions in PowerShell. ;) This code is not well optimized.<br>
   ***Requires :*** PowerShell Version 2.0, ffmpeg and HandBrakeCLI for Windows<br>
   ***Important:*** ffmpeg and HandBrakeCLI MUST BE LOCATED in "C:\bin\"
   
* `BackupFiles.ps1`: Backup networked files locally.<br>
   **Note :** To run this script by Task Scheduler use this command line:<br>
   powershell.exe -noexit &'C:\bin\scripts\BackupFiles.ps1'<br>
   This code may contain bugs.<br>
   ***Requires :*** PowerShell Version 2.0<br>
   ***Important:*** Networked resources must be exist and open for current user. Check folder names below the script
   
* `WindowsPowerShell`: My implementation of PowerShell modules.<br>
   **Note :** Please kindly read instructions inside modules. ;) This code may contain bugs.<br>
   ***Requires :*** PowerShell Version 2.0<br>
   ***Important:*** WindowsPowerShell folder must be located inside your user Documents folder. Don't change the file names
   and folder structure.
   
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
