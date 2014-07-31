# -*- mode: python -*-
a = Analysis(['.\\example.py'],
             pathex=['C:\\PythonProj\\PyInstall'],
             hiddenimports=[],
             hookspath=None,
             runtime_hooks=None)
pyz = PYZ(a.pure)
exe = EXE(pyz,
          Tree('data', prefix='data'),
          a.scripts,
          a.binaries,
          a.zipfiles,
          a.datas,
          name='example.exe',
          debug=False,
          strip=None,
          upx=False,
          console=True , version='file_version_info.txt', icon='Example_128x128.ico')
