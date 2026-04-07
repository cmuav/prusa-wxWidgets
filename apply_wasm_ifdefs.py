#!/usr/bin/env python3
"""Apply __WXWASM__ ifdefs to prusa-wxWidgets 3.2.6"""
import os
import re
import sys

DST = "/Users/user/Documents/Work/ASI/Programs/misc/prusaslicer-web/prusa-wxWidgets"
os.chdir(DST)

ok = 0
miss = 0

def read(path):
    with open(path, 'r') as f:
        return f.read()

def write(path, content):
    with open(path, 'w') as f:
        f.write(content)

def insert_after_line(path, pattern, insertion):
    """Insert text after the first line matching pattern."""
    global ok, miss
    lines = read(path).split('\n')
    for i, line in enumerate(lines):
        if pattern in line:
            lines.insert(i + 1, insertion)
            write(path, '\n'.join(lines))
            print(f"  OK: {path}")
            ok += 1
            return True
    print(f"  MISS: {path} (pattern: {pattern!r})")
    miss += 1
    return False

def replace_first(path, old, new):
    """Replace the first occurrence of old with new."""
    global ok, miss
    content = read(path)
    if old in content:
        content = content.replace(old, new, 1)
        write(path, content)
        print(f"  OK: {path}")
        ok += 1
        return True
    print(f"  MISS: {path} (old: {old[:60]!r})")
    miss += 1
    return False

def replace_all(path, old, new):
    """Replace all occurrences of old with new."""
    global ok, miss
    content = read(path)
    if old in content:
        content = content.replace(old, new)
        write(path, content)
        print(f"  OK: {path}")
        ok += 1
        return True
    print(f"  MISS: {path} (old: {old[:60]!r})")
    miss += 1
    return False

print("=== Step 3: Core header __WXWASM__ additions ===")

# include/wx/app.h
insert_after_line("include/wx/app.h",
    '#include "wx/qt/app.h"',
    '#elif defined(__WXWASM__)\n    #include "wx/wasm/app.h"')

# include/wx/window.h
insert_after_line("include/wx/window.h",
    '#include "wx/qt/window.h"',
    '#elif defined(__WXWASM__)\n    #include "wx/wasm/window.h"')

# include/wx/bitmap.h — include
insert_after_line("include/wx/bitmap.h",
    '#include "wx/qt/bitmap.h"',
    '#elif defined(__WXWASM__)\n    #include "wx/wasm/bitmap.h"')

# include/wx/brush.h
insert_after_line("include/wx/brush.h",
    '#include "wx/qt/brush.h"',
    '#elif defined(__WXWASM__)\n    #include "wx/wasm/brush.h"')

# include/wx/pen.h
insert_after_line("include/wx/pen.h",
    '#include "wx/qt/pen.h"',
    '#elif defined(__WXWASM__)\n    #include "wx/wasm/pen.h"')

# include/wx/colour.h
insert_after_line("include/wx/colour.h",
    '#include "wx/qt/colour.h"',
    '#elif defined(__WXWASM__)\n    #include "wx/wasm/colour.h"')

# include/wx/font.h
insert_after_line("include/wx/font.h",
    '#include "wx/qt/font.h"',
    '#elif defined(__WXWASM__)\n    #include "wx/wasm/font.h"')

# include/wx/cursor.h
insert_after_line("include/wx/cursor.h",
    '#include "wx/qt/cursor.h"',
    '#elif defined(__WXWASM__)\n    #include "wx/wasm/cursor.h"')

# include/wx/region.h
insert_after_line("include/wx/region.h",
    '#include "wx/qt/region.h"',
    '#elif defined(__WXWASM__)\n    #include "wx/wasm/region.h"')

# include/wx/clipbrd.h
insert_after_line("include/wx/clipbrd.h",
    '#include "wx/qt/clipbrd.h"',
    '#elif defined(__WXWASM__)\n    #include "wx/wasm/clipbrd.h"')

# include/wx/dnd.h
insert_after_line("include/wx/dnd.h",
    '#include "wx/qt/dnd.h"',
    '#elif defined(__WXWASM__)\n    #include "wx/wasm/dnd.h"')

# include/wx/evtloop.h
insert_after_line("include/wx/evtloop.h",
    '#include "wx/qt/evtloop.h"',
    '#elif defined(__WXWASM__)\n    #include "wx/wasm/evtloop.h"')

# include/wx/toplevel.h
insert_after_line("include/wx/toplevel.h",
    '#include "wx/qt/toplevel.h"',
    '#elif defined(__WXWASM__)\n    #include "wx/wasm/toplevel.h"')

# include/wx/nonownedwnd.h
insert_after_line("include/wx/nonownedwnd.h",
    '#include "wx/qt/nonownedwnd.h"',
    '#elif defined(__WXWASM__)\n    #include "wx/wasm/nonownedwnd.h"')

# include/wx/popupwin.h
insert_after_line("include/wx/popupwin.h",
    '#include "wx/qt/popupwin.h"',
    '#elif defined(__WXWASM__)\n    #include "wx/wasm/popupwin.h"')

# include/wx/chkconf.h
insert_after_line("include/wx/chkconf.h",
    '#include "wx/android/chkconf.h"',
    '#elif defined(__WXWASM__)\n    #include "wx/wasm/chkconf.h"')

# include/wx/dataobj.h — 3 spots
insert_after_line("include/wx/dataobj.h",
    '#include "wx/qt/dataform.h"',
    '#elif defined(__WXWASM__)\n    #include "wx/wasm/dataform.h"')
insert_after_line("include/wx/dataobj.h",
    '#include "wx/qt/dataobj.h"',
    '#elif defined(__WXWASM__)\n    #include "wx/wasm/dataobj.h"')
insert_after_line("include/wx/dataobj.h",
    '#include "wx/qt/dataobj2.h"',
    '#elif defined(__WXWASM__)\n    #include "wx/wasm/dataobj2.h"')

# include/wx/config.h
insert_after_line("include/wx/config.h",
    '#include "wx/msw/regconf.h"',
    '#elif defined(__WXWASM__) && wxUSE_CONFIG_NATIVE\n    #include "wx/wasm/config.h"')

# include/wx/icon.h
insert_after_line("include/wx/icon.h",
    '#include "wx/qt/icon.h"',
    '#elif defined(__WXWASM__)\n    #include "wx/generic/icon.h"')

# include/wx/accel.h
insert_after_line("include/wx/accel.h",
    '#include "wx/qt/accel.h"',
    '#elif defined(__WXWASM__)\n    // wasm uses generic accel')

# include/wx/dragimag.h
insert_after_line("include/wx/dragimag.h",
    '#include "wx/qt/dragimag.h"',
    '#elif defined(__WXWASM__)\n    #include "wx/generic/dragimgg.h"')

print("\n=== Step 3b: Condition extensions ===")

# include/wx/defs.h — WXWidget typedef
insert_after_line("include/wx/defs.h",
    '#endif /* __WXQT__ */',
    '#ifdef __WXWASM__\ntypedef const void *WXWidget;\n#endif /* __WXWASM__ */')

# include/wx/defs.h — wxMOD_RAW_CONTROL
replace_first("include/wx/defs.h",
    '#if defined(__WXMAC__)',
    '#if defined(__WXMAC__) || defined(__WXWASM__)')

# include/wx/dcbuffer.h
replace_first("include/wx/dcbuffer.h",
    'defined(__WXQT__)',
    'defined(__WXQT__) || defined(__WXWASM__)')

# include/wx/palette.h — use generic
replace_first("include/wx/palette.h",
    'defined(__WXGTK__)',
    'defined(__WXGTK__) || defined(__WXWASM__)')

# include/wx/kbdstate.h — add wasm alongside osx
replace_all("include/wx/kbdstate.h",
    'defined(__WXOSX__)',
    'defined(__WXOSX__) || defined(__WXWASM__)')

# include/wx/filefn.h — exclude wasm from flock
replace_first("include/wx/filefn.h",
    '#if defined(__UNIX__)\n',
    '#if defined(__UNIX__) && !defined(__WXWASM__)\n')

# include/wx/features.h
replace_first("include/wx/features.h",
    'defined(__WXQT__)',
    'defined(__WXQT__) || defined(__WXWASM__)')

# include/wx/gdicmn.h — multiple spots
replace_all("include/wx/gdicmn.h",
    'defined(__WXMAC__)',
    'defined(__WXMAC__) || defined(__WXWASM__)')

# include/wx/fontutil.h
insert_after_line("include/wx/fontutil.h",
    '#elif defined(__WXQT__)',
    '    // qt fontutil')  # placeholder, will handle separately

# include/wx/encinfo.h
replace_first("include/wx/encinfo.h",
    'defined(__WXQT__)',
    'defined(__WXQT__) || defined(__WXWASM__)')

# include/wx/rawbmp.h
replace_first("include/wx/rawbmp.h",
    'defined(__WXQT__)',
    'defined(__WXQT__) || defined(__WXWASM__)')

# include/wx/utils.h — add wxBrowserOpen
# This is a more complex addition, skip for now and handle in API adaptation

# include/wx/unix/apptrait.h
replace_first("include/wx/unix/apptrait.h",
    'defined(__WXGTK20__)',
    'defined(__WXGTK20__) || defined(__WXWASM__)')

print("\n=== Step 4: wxUniversal theme support ===")

# include/wx/univ/theme.h
insert_after_line("include/wx/univ/theme.h",
    '#define wxUSE_THEME_METAL 1',
    '#undef wxUSE_THEME_WASM\n#define wxUSE_THEME_WASM 1')

# Default theme for wasm — find the DFB mono fallback
insert_after_line("include/wx/univ/theme.h",
    '#define wxUNIV_DEFAULT_THEME mono',
    '#elif defined(__WXWASM__) && wxUSE_THEME_WASM\n#define wxUNIV_DEFAULT_THEME wasm')

# include/wx/univ/window.h
insert_after_line("include/wx/univ/window.h",
    'wxWindowMac',
    '#elif defined(__WXWASM__)\n#define wxWindowNative wxWindowWasm')

# include/wx/univ/setup_inc.h
insert_after_line("include/wx/univ/setup_inc.h",
    'wxUSE_THEME_WIN32',
    '#define wxUSE_THEME_WASM    0')

# include/wx/univ/chkconf.h
insert_after_line("include/wx/univ/chkconf.h",
    '#endif /* wxUSE_THEME_MONO */',
    '\n#if wxUSE_THEME_WASM && !defined(__WXWASM__)\n#   ifdef wxABORT_ON_CONFIG_ERROR\n#       error "wxUSE_THEME_WASM should be 0 on non-wasm builds"\n#   else\n#       undef wxUSE_THEME_WASM\n#       define wxUSE_THEME_WASM 0\n#   endif\n#endif /* wxUSE_THEME_WASM */')

print("\n=== Step 5: Platform setup.h defaults ===")

for f in ["include/wx/motif/setup.h", "include/wx/osx/setup.h",
          "include/wx/msw/setup.h", "include/wx/gtk/setup.h",
          "include/wx/android/setup.h", "include/wx/setup_inc.h",
          "include/wx/univ/setup.h"]:
    if os.path.exists(f):
        insert_after_line(f, 'wxUSE_THEME_WIN32', '#define wxUSE_THEME_WASM    0')
    else:
        print(f"  SKIP: {f}")

print("\n=== Step 6: Source file __WXWASM__ ifdefs ===")

# src/common/dcbase.cpp
insert_after_line("src/common/dcbase.cpp",
    '#include "wx/qt/dcscreen.h"',
    '#endif\n#ifdef __WXWASM__\n    #include "wx/wasm/dcclient.h"\n    #include "wx/wasm/dcmemory.h"\n    #include "wx/wasm/dcscreen.h"')

# src/common/popupcmn.cpp
replace_all("src/common/popupcmn.cpp",
    'defined(__WXMAC__)',
    'defined(__WXMAC__) || defined(__WXWASM__)')

# src/common/config.cpp
insert_after_line("src/common/config.cpp",
    '#include "wx/msw/regconf.h"',
    '#elif defined(__WXWASM__) && wxUSE_CONFIG_NATIVE\n    #include "wx/wasm/config.h"')

# src/common/file.cpp — exclude wasm from chmod/flock
replace_first("src/common/file.cpp",
    '#ifdef __UNIX__',
    '#if defined(__UNIX__) && !defined(__WXWASM__)')

# src/univ/winuniv.cpp
insert_after_line("src/univ/winuniv.cpp",
    'wxWindowX11',
    ' #elif defined(__WXWASM__)\nwxIMPLEMENT_DYNAMIC_CLASS(wxWindow, wxWindowWasm);')

# src/unix/utilsunx.cpp — HAVE_UNAME guard
replace_first("src/unix/utilsunx.cpp",
    'defined(HAVE_UNAME)',
    'defined(HAVE_UNAME) && !defined(__WXWASM__)')

# src/common/platinfo.cpp — add wasm port name
insert_after_line("src/common/platinfo.cpp",
    'wxPORT_QT',
    '#ifdef __WXWASM__\n    { wxPORT_WASM,   "wxWASM"  },\n#endif')

# src/common/combocmn.cpp — wasm popup handling
replace_first("src/common/combocmn.cpp",
    '#if (!defined(__WXMSW__)',
    '#if (!defined(__WXMSW__) && !defined(__WXWASM__)')

print(f"\n=== Summary: {ok} OK, {miss} MISS ===")
if miss > 0:
    print("Review MISS entries above — some may need manual edits due to 3.2.6 differences")
