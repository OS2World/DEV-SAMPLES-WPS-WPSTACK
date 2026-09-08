/* deregister.cmd - Deregister Stack WPS class */
call RxFuncAdd 'SysLoadFuncs', 'RexxUtil', 'SysLoadFuncs'
call SysLoadFuncs
rc1 = SysDestroyObject('<WPSTACK001>')
say 'SysDestroyObject  WPSTACK001  =' rc1
rc2 = SysDeregisterObjectClass('Stack')
say 'SysDeregisterObjectClass Stack =' rc2
say 'Done. Refresh the desktop.'
