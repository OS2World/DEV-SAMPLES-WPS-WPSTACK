@echo off
set MK_LOG=release\mk.log
if not exist release md release
echo. > %MK_LOG%
if "%1"=="nobind" goto skipbind
echo --- genbind --- 2>&1 | tee -a %MK_LOG%
call genbind.cmd
:skipbind
echo --- wmake --- 2>&1 | tee -a %MK_LOG%
wmake -f Makefile.wat 2>&1 | tee -a %MK_LOG%
echo --- done --- 2>&1 | tee -a %MK_LOG%
