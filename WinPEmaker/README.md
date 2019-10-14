README
======
This is README file

Description
-----------

### Capture and apply a Windows image using a single .WIM file

`WIM` files only capture a single partition. You can usually capture just the Windows partition, and then use files from that image to set up the rest of the partitions on the drive. If you've created a custom partition configuration

* Capture the Windows partition. For example:
   `Dism /Capture-Image /ImageFile:"D:\Images\WinSystemYYYYMMDD.wim" /CaptureDir:C:\ /Name:WindowsDesktopYYYYMMDD`
   where D: is a USB flash drive or other file storage location.

* Wipe the hard drive and set up new hard disk partitions using a script.
   Use CreatePartitions-UEFI.txt (or CreatePartitions-BIOS.txt for older, legacy BIOS devices):
   `diskpart /s CreatePartitions-UEFI.txt`

* Apply the images using a manual method. For example:
   `Dism /Apply-Image /ImageFile:N:\Images\WinSystemYYYYMMDD.wim /Index:1 /ApplyDir:W:\`
   where W: is the Windows partition.

   Configure the system partition by using the `BCDBoot` tool.
   This tool copies and configures system partition files by using files from the Windows partition.
   For example:
   `W:\Windows\System32\bcdboot W:\Windows /s S:`

   Copy the Windows Recovery Environment (RE) tools into the recovery tools partition:
   `md R:\Recovery\WindowsRE`
   `copy W:\Windows\System32\Recovery\winre.wim R:\Recovery\WindowsRE\winre.wim`
   where R: is the recovery partition.

   Register the location of the recovery tools, and hide the recovery partition using Diskpart:
   `W:\Windows\System32\reagentc /setreimage /path R:\Recovery\WindowsRE /target W:\Windows`

   Diskpart steps for UEFI:
   `set id="de94bba4-06d1-4d40-a16a-bfd50179d6ac"`
   `gpt attributes=0x8000000000000001`

   Diskpart steps for BIOS:
   `set id=27`

   Reboot the device (reboot). Windows should boot after. ;)

* Apply the images using a apply_image.cmd script:
   `apply_image.cmd D:\Images\WinSystemYYYYMMDD.wim`
   ***Important:*** Before using script check out the drive letter by `diskpart`
   It should be W: If NOT use: `assign letter=W` command in `diskpart`.

* `For ALL`:
   **Note:** The additional applications located in `X:\Windows\Apps`. The scripts and additional `diskpart` files
   are located in `X:\Windows\Scripts`.
   ***Important:*** The partitions MUST BE assigned the letters: System=S, Windows=W, and Recovery=R.
   If NOT use `assign` inside `diskpart` program.

### Commands list:

   help                                        - call the README.md file
   reboot                                      - restart  computer
   poweroff                                    - shutdown computer
   ps                                          - run      PowerShell

   clonedrive D:\WinSystemYYYYMMDD.ffu 0       - clone the physical drive #0
   restoredrive D:\WinSystemYYYYMMDD.ffu 0     - restore the physical drive #0
   clonewim D:\WinSystemYYYYMMDD.wim W WIMname - clone WIM to disk D: from W: with name
   restorewim D:\WinSystemYYYYMMDD.wim W       - restore WIM from D: to disk W:

   **Note:** Before drive cloning check out the README and real volume letters by "diskpart" utility!!!


### License

This WinPE has been created by 2019 Dmitri G.
