# -*- mode: python -*-
a = Analysis(['.\\AvidProjBackUP.py'],
             pathex=['C:\\PythonProj\\PyInstall'],
             hiddenimports=[],
             hookspath=None,
             runtime_hooks=None)
pyz = PYZ(a.pure)
exe = EXE(pyz,
          a.scripts,
          a.binaries,
          a.zipfiles,
          a.datas,
          exclude_binaries=False,
          name='AvidProjBackUP.exe',
          debug=False,
          strip=None,
          upx=False,
          console=True , version='file_version_info.txt', icon='BackupFolder_128x128.ico')