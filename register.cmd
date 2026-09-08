/* register.cmd - Register Stack WPS class */
call RxFuncAdd 'SysLoadFuncs', 'RexxUtil', 'SysLoadFuncs'
call SysLoadFuncs
'copy release\wpstack.dll C:\OS2\DLL\wpstack.dll'
rc1 = SysRegisterObjectClass('Stack', 'wpstack')
say 'SysRegisterObjectClass Stack =' rc1
rc2 = SysCreateObject('Stack', 'MyStack', '<WP_DESKTOP>', 'OBJECTID=<WPSTACK001>', 'U')
say 'SysCreateObject Stack =' rc2
say 'Done. A "MyStack" object appears on the desktop.'
