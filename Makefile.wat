# Makefile.wat - WPSTACK Open Watcom build
# Builds wpstack.dll (Stack : WPAbstract) and wpstack.hlp

CC    = wcc386
LINK  = wlink
RC    = wrc
WIPFC = wipfc

INCL   = -I. -Ih -Isrc -IC:\os2tk45\h -IC:\os2tk45\som\include
CFLAGS = -bd -bt=os2 -zq -wx -wcd=202 -wcd=726 -d1 $(INCL)

b = wpstack

all : release\$(b).dll release\$(b).hlp .SYMBOLIC

release\$(b).dll : src\$(b).obj release\$(b).res src\$(b).def
	$(LINK) SYSTEM OS2V2_DLL &
		NAME release\$(b).dll &
		FILE src\$(b).obj &
		OPTION QUIET &
		OPTION MAP=release\$(b).map &
		LIBPATH C:\os2tk45\lib &
		LIBPATH C:\os2tk45\som\lib &
		LIB somtk &
		EXP StackNewClass &
		EXP M_StackNewClass &
		EXP StackClassData &
		EXP StackCClassData &
		EXP M_StackClassData &
		EXP M_StackCClassData &
		@src\$(b).def
	$(RC) release\$(b).res release\$(b).dll

src\$(b).obj : src\$(b).c h\$(b).ih h\$(b).h
	$(CC) $(CFLAGS) -fo=src\$(b).obj src\$(b).c

release\$(b).res : src\$(b).rc src\$(b)_res.h
	$(RC) -r -fo=release\$(b).res -Isrc -IC:\os2tk45\h src\$(b).rc

release\$(b).hlp : doc\$(b).ipf
	$(WIPFC) doc\$(b).ipf
	@if exist doc\$(b).hlp move doc\$(b).hlp release\$(b).hlp
	@if exist $(b).hlp move $(b).hlp release\$(b).hlp

clean : .SYMBOLIC
	-rm -f src\$(b).obj
	-rm -f release\$(b).dll release\$(b).res release\$(b).hlp
	-rm -f release\$(b).map
	-rm -f h\$(b).ih h\$(b).h
