@echo off
setlocal
set MK_LOG=release\genbind.log
if not exist release md release
if not exist h md h
echo. > %MK_LOG%
set SMINCLUDE=.;idl;C:\os2tk45\idl;C:\os2tk45\som\include;C:\os2tk45\h
set SMEMIT=ih;h
set SMADDSTAR=1
echo Generating bindings for wpstack.idl... 2>&1 | tee -a %MK_LOG%
sc -s"ih;h" idl\wpstack.idl 2>&1 | tee -a %MK_LOG%
if exist idl\wpstack.ih move idl\wpstack.ih h\wpstack.ih
if exist idl\wpstack.h  move idl\wpstack.h  h\wpstack.h
echo genbind done. 2>&1 | tee -a %MK_LOG%
endlocal
