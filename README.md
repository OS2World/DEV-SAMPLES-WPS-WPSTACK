# wpstack — WPS Stack Sample (C SOM), Open Watcom Port

OS/2 WorkPlace Shell sample demonstrating WPS setup and cleanup methods.
Provides a new object class **Stack** (a `WPAbstract` subclass) whose instances
implement a persistent push-down stack backed by `OS2.INI` via WPAbstract
inheritance. A Settings notebook page lets the user view stack contents, push
new items, and pop existing items. The class also tracks awake and persistent
object instance counts.

---

## Class Hierarchy

```
SOMObject
  └── WPObject
        └── WPAbstract
              └── Stack          (metaclass: M_Stack)
```

Instance methods introduced on `Stack`: `InsertStackPage`, `Lock`, `Pop`,
`Push`, `Unlock`.

Class methods introduced on `M_Stack`: `clsDecObjectCount`,
`clsIncObjectCount`, `clsQueryModuleHandle`, `clsQueryObjectCount`.

---

## Directory Layout

```
wpstack/
├── idl/          wpstack.idl          — SOM 2.x IDL source
├── h/            wpstack.ih, wpstack.h — sc-generated (by genbind.cmd)
├── src/          wpstack.c            — C SOM implementation
│                 wpstack.rc           — dialog and icon resources
│                 wpstack_res.h        — resource ID constants
│                 wpstack.def          — wlink options + BLDLEVEL
│                 wpstack.ico          — object icon (provide separately)
├── doc/          wpstack.ipf          — help source
├── release/      build output (dll, res, hlp, map, log)
├── Makefile.wat  Open Watcom makefile
├── mk.cmd        one-shot clean build
├── genbind.cmd   runs sc to generate h\*.ih and h\*.h
├── register.cmd  REXX: copies DLL to C:\OS2\DLL, registers class,
│                 creates a Stack object on the desktop
└── deregister.cmd REXX: deregisters the Stack WPS class
```

---

## Prerequisites

| Item | Path |
|---|---|
| Open Watcom 2.0 | `PATH` must include Watcom bin |
| OS/2 Toolkit 4.5 | `C:\os2tk45` |
| SOM runtime | `C:\OS2\DLL\som.dll` |
| PMWP (WPS shell) | `C:\OS2\DLL\pmwp.dll` |
| SOM compiler `sc` | on `PATH` (Toolkit) |
| Object icon | `src\wpstack.ico` — not in repo, provide manually |

---

## Build

```
cd D:\projects\wps\wpstack
genbind.cmd
wmake -f Makefile.wat
```

Or use the convenience wrapper:

```
mk.cmd
```

To rebuild without regenerating bindings:

```
mk.cmd nobind
```

Output: `release\wpstack.dll`, `release\wpstack.hlp`

---

## Register / Test

```
register.cmd
```

Copies `release\wpstack.dll` to `C:\OS2\DLL`, registers the `Stack` class,
and creates a `MyStack` object on the desktop. Open its Settings notebook to
view the stack contents and push/pop items.

```
deregister.cmd
```

---

## Porting Notes (IBM C/C++ → Open Watcom)

| Item | Status |
|---|---|
| `wcc386` replaces IBM `icc` | Done — C project, single DLL |
| `sc -s"ih;h"` generates C bindings | `wpstack.ih` and `wpstack.h` moved to `h\` by `genbind.cmd` |
| SMINCLUDE: both `C:\os2tk45\idl` (WPS IDL) and `C:\os2tk45\som\include` (base SOM IDL) required | Set in `genbind.cmd` |
| `WPSTACK.RCH` renamed | → `src\wpstack_res.h`; `#include "wpstack.rch"` updated in `wpstack.c` and `wpstack.rc` |
| `OPTION CASEEXACT` in `.def` | Required for correct C symbol matching |
| Data symbol exports | Bare form — wcc386 32-bit flat model does not add `_` prefix |
| Bug fix: `\}` typo in `DialogProc` closing brace | Fixed to `}` (original had stray backslash causing compile error) |
| `#pragma info(nouse)` removed | IBM C extension not supported by OW; use `-wcd=202` in CFLAGS |
| `register.cmd` / `deregister.cmd` | Self-contained REXX scripts (start with `/* */`); no separate `.rex` file |
| Object icon | `wpstack.ico` referenced in RC but not included in original repo — provide manually in `src\`; ICON line commented out until icon is supplied |
| `#Endif` → `#endif` in IDL | sc is case-sensitive; capital-E form caused `#ifdef __SOMIDL__` blocks to go unclosed (W124/W191/W193 warnings) |
| `.SUFFIXES` removed from Makefile | OW wmake E25 "extension declared more than once" — built-in suffixes already cover all types used |
| `wrc -fo=` output flag | wrc writes `.res` next to the input file by default; `-fo=release\wpstack.res` redirects output to `release\` |
| `mk.cmd`: removed `/i` from `if` | OS/2 CMD.EXE does not support the `/i` (case-insensitive) flag; `goto :label` → `goto label` |

---

## Changelog

### 1.0 — 2026-09-07
- Open Watcom port: `Makefile.wat`, `mk.cmd`, `genbind.cmd`
- Files reorganized into `idl/`, `h/`, `src/`, `doc/`, `release/`
- `src/wpstack_res.h` created from `WPSTACK.RCH` (renamed)
- `src/wpstack.def` created (wlink-format with BLDLEVEL)
- `src/wpstack.rc`: `#include "wpstack.rch"` → `#include "wpstack_res.h"`; ICON line commented out (icon not in repo)
- `src/wpstack.c`: `#include "wpstack.rch"` → `#include "wpstack_res.h"`; system headers use angle brackets
- Bug fix: stray `\}` in `DialogProc` closing brace → `}`
- Removed `#pragma info(nouse)` (IBM-specific); added `-wcd=202` to CFLAGS
- `idl/wpstack.idl`: `#Endif` → `#endif` (sc is case-sensitive)
- `register.cmd` / `deregister.cmd`: self-contained REXX (no separate `.rex` wrapper)
- `genbind.cmd`: `setlocal`/`endlocal`; SMINCLUDE includes both `C:\os2tk45\idl` and `C:\os2tk45\som\include`
- `mk.cmd`: removed Windows-only `/i` flag from `if`; fixed `goto` label syntax for OS/2
- `Makefile.wat`: removed `.SUFFIXES` (OW E25); `wrc -fo=` for correct `.res` output path
- Added `.gitattributes`
- Build verified clean: `release\wpstack.dll` and `release\wpstack.hlp` produced with no errors
