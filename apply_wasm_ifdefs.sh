#!/bin/bash
# Apply __WXWASM__ ifdefs to prusa-wxWidgets 3.2.6
# These are all small surgical additions following existing platform ifdef patterns
set -e

DST="/Users/user/Documents/Work/ASI/Programs/misc/prusaslicer-web/prusa-wxWidgets"
cd "$DST"

# Helper: insert a line after a pattern
insert_after() {
    local file="$1" pattern="$2" newline="$3"
    if grep -q "$pattern" "$file"; then
        sed -i '' "/$pattern/a\\
$newline" "$file"
        echo "  OK: $file (after: $pattern)"
    else
        echo "  MISS: $file (pattern not found: $pattern)"
    fi
}

# Helper: insert a line before a pattern
insert_before() {
    local file="$1" pattern="$2" newline="$3"
    if grep -q "$pattern" "$file"; then
        sed -i '' "/$pattern/i\\
$newline" "$file"
        echo "  OK: $file (before: $pattern)"
    else
        echo "  MISS: $file (pattern not found: $pattern)"
    fi
}

# Helper: add to existing #if condition
add_to_condition() {
    local file="$1" pattern="$2" addition="$3"
    if grep -q "$pattern" "$file"; then
        sed -i '' "s|$pattern|$pattern $addition|" "$file"
        echo "  OK: $file (extended: $pattern)"
    else
        echo "  MISS: $file (pattern not found: $pattern)"
    fi
}

echo "=== Step 3: Core header __WXWASM__ additions ==="

# include/wx/app.h — add wasm include after qt
f="include/wx/app.h"
insert_after "$f" '#include "wx/qt/app.h"' '#elif defined(__WXWASM__)
    #include "wx/wasm/app.h"'

# include/wx/window.h — add wasm include after qt
f="include/wx/window.h"
insert_after "$f" '#include "wx/qt/window.h"' '#elif defined(__WXWASM__)
    #include "wx/wasm/window.h"'

# include/wx/bitmap.h — add wasm include after qt
f="include/wx/bitmap.h"
insert_after "$f" '#include "wx/qt/bitmap.h"' '#elif defined(__WXWASM__)
    #include "wx/wasm/bitmap.h"'

# include/wx/brush.h
f="include/wx/brush.h"
insert_after "$f" '#include "wx/qt/brush.h"' '#elif defined(__WXWASM__)
    #include "wx/wasm/brush.h"'

# include/wx/pen.h
f="include/wx/pen.h"
insert_after "$f" '#include "wx/qt/pen.h"' '#elif defined(__WXWASM__)
    #include "wx/wasm/pen.h"'

# include/wx/colour.h
f="include/wx/colour.h"
insert_after "$f" '#include "wx/qt/colour.h"' '#elif defined(__WXWASM__)
    #include "wx/wasm/colour.h"'

# include/wx/font.h
f="include/wx/font.h"
insert_after "$f" '#include "wx/qt/font.h"' '#elif defined(__WXWASM__)
    #include "wx/wasm/font.h"'

# include/wx/cursor.h
f="include/wx/cursor.h"
insert_after "$f" '#include "wx/qt/cursor.h"' '#elif defined(__WXWASM__)
    #include "wx/wasm/cursor.h"'

# include/wx/region.h
f="include/wx/region.h"
insert_after "$f" '#include "wx/qt/region.h"' '#elif defined(__WXWASM__)
    #include "wx/wasm/region.h"'

# include/wx/clipbrd.h
f="include/wx/clipbrd.h"
insert_after "$f" '#include "wx/qt/clipbrd.h"' '#elif defined(__WXWASM__)
    #include "wx/wasm/clipbrd.h"'

# include/wx/dnd.h
f="include/wx/dnd.h"
insert_after "$f" '#include "wx/qt/dnd.h"' '#elif defined(__WXWASM__)
    #include "wx/wasm/dnd.h"'

# include/wx/evtloop.h
f="include/wx/evtloop.h"
insert_after "$f" '#include "wx/qt/evtloop.h"' '#elif defined(__WXWASM__)
    #include "wx/wasm/evtloop.h"'

# include/wx/toplevel.h
f="include/wx/toplevel.h"
insert_after "$f" '#include "wx/qt/toplevel.h"' '#elif defined(__WXWASM__)
    #include "wx/wasm/toplevel.h"'

# include/wx/nonownedwnd.h
f="include/wx/nonownedwnd.h"
insert_after "$f" '#include "wx/qt/nonownedwnd.h"' '#elif defined(__WXWASM__)
    #include "wx/wasm/nonownedwnd.h"'

# include/wx/popupwin.h
f="include/wx/popupwin.h"
insert_after "$f" '#include "wx/qt/popupwin.h"' '#elif defined(__WXWASM__)
    #include "wx/wasm/popupwin.h"'

# include/wx/chkconf.h
f="include/wx/chkconf.h"
insert_after "$f" '#include "wx/android/chkconf.h"' '#elif defined(__WXWASM__)
    #include "wx/wasm/chkconf.h"'

# include/wx/dataobj.h — 3 additions
f="include/wx/dataobj.h"
# dataform
insert_after "$f" '#include "wx/qt/dataform.h"' '#elif defined(__WXWASM__)
    #include "wx/wasm/dataform.h"'
# dataobj
insert_after "$f" '#include "wx/qt/dataobj.h"' '#elif defined(__WXWASM__)
    #include "wx/wasm/dataobj.h"'
# dataobj2
insert_after "$f" '#include "wx/qt/dataobj2.h"' '#elif defined(__WXWASM__)
    #include "wx/wasm/dataobj2.h"'

# include/wx/config.h
f="include/wx/config.h"
insert_after "$f" '#include "wx/msw/regconf.h"' '#elif defined(__WXWASM__) \&\& wxUSE_CONFIG_NATIVE
    #include "wx/wasm/config.h"'

# include/wx/icon.h
f="include/wx/icon.h"
insert_after "$f" '#include "wx/qt/icon.h"' '#elif defined(__WXWASM__)
    #include "wx/generic/icon.h"'

# include/wx/accel.h
f="include/wx/accel.h"
insert_after "$f" '#include "wx/qt/accel.h"' '#elif defined(__WXWASM__)
    // wasm uses generic accel'

# include/wx/dragimag.h
f="include/wx/dragimag.h"
insert_after "$f" '#include "wx/qt/dragimag.h"' '#elif defined(__WXWASM__)
    #include "wx/generic/dragimgg.h"'

echo ""
echo "=== Step 3b: Condition extensions (adding __WXWASM__ to existing #if) ==="

# include/wx/defs.h — WXWidget typedef
f="include/wx/defs.h"
# Add WXWidget typedef for wasm (find the qt WXWidget block and add after)
grep -q "__WXWASM__" "$f" || {
    insert_after "$f" '#endif.*__WXQT__.*WXWidget' '#ifdef __WXWASM__
typedef const void *WXWidget;
#endif /* __WXWASM__ */'
    echo "  Note: defs.h may need manual review for WXWidget"
}

# include/wx/dcbuffer.h — add to no-buffering-needed platforms
f="include/wx/dcbuffer.h"
sed -i '' 's/defined(__WXQT__)/defined(__WXQT__) || defined(__WXWASM__)/' "$f" 2>/dev/null && echo "  OK: $f" || echo "  MISS: $f"

# include/wx/palette.h — use generic palette like gtk
f="include/wx/palette.h"
sed -i '' 's/defined(__WXGTK__)/defined(__WXGTK__) || defined(__WXWASM__)/' "$f" 2>/dev/null && echo "  OK: $f" || echo "  MISS: $f"

# include/wx/filefn.h — exclude wasm from flock
f="include/wx/filefn.h"
sed -i '' 's/#if defined(__UNIX__)$/#if defined(__UNIX__) \&\& !defined(__WXWASM__)/' "$f" 2>/dev/null && echo "  OK: $f (flock)" || echo "  MISS: $f"

# include/wx/kbdstate.h — add wasm alongside osx for Cmd/RawControl
f="include/wx/kbdstate.h"
sed -i '' 's/defined(__WXOSX__)/defined(__WXOSX__) || defined(__WXWASM__)/g' "$f" 2>/dev/null && echo "  OK: $f" || echo "  MISS: $f"

echo ""
echo "=== Step 4: wxUniversal theme support ==="

# include/wx/univ/theme.h
f="include/wx/univ/theme.h"
insert_after "$f" '#define wxUSE_THEME_METAL 1' '#undef wxUSE_THEME_WASM
#define wxUSE_THEME_WASM 1'
# Default theme for wasm
insert_after "$f" '#define wxUNIV_DEFAULT_THEME mono' '#elif defined(__WXWASM__) \&\& wxUSE_THEME_WASM
#define wxUNIV_DEFAULT_THEME wasm'

# include/wx/univ/window.h
f="include/wx/univ/window.h"
insert_after "$f" 'wxWindowMac' '#elif defined(__WXWASM__)
#define wxWindowNative wxWindowWasm'

# include/wx/univ/setup_inc.h
f="include/wx/univ/setup_inc.h"
insert_after "$f" 'wxUSE_THEME_WIN32' '#define wxUSE_THEME_WASM    0'

# include/wx/univ/chkconf.h — validation
f="include/wx/univ/chkconf.h"
insert_after "$f" '#endif.*wxUSE_THEME_MONO' '#if wxUSE_THEME_WASM \&\& !defined(__WXWASM__)
#   ifdef wxABORT_ON_CONFIG_ERROR
#       error "wxUSE_THEME_WASM strstrshould be 0 on non-wasm builds"
#   else
#       undef wxUSE_THEME_WASM
#       define wxUSE_THEME_WASM 0
#   endif
#endif'

echo ""
echo "=== Step 5: Platform setup.h defaults ==="

for f in include/wx/motif/setup.h include/wx/osx/setup.h include/wx/msw/setup.h include/wx/gtk/setup.h include/wx/android/setup.h include/wx/setup_inc.h; do
    if [ -f "$f" ]; then
        insert_after "$f" 'wxUSE_THEME_WIN32' '#define wxUSE_THEME_WASM    0'
    else
        echo "  SKIP: $f (not found)"
    fi
done

# include/wx/univ/setup.h (2 locations)
f="include/wx/univ/setup.h"
if [ -f "$f" ]; then
    sed -i '' '/wxUSE_THEME_WIN32/a\
#define wxUSE_THEME_WASM    0' "$f"
    echo "  OK: $f"
fi

echo ""
echo "=== Step 6: Source file __WXWASM__ ifdefs ==="

# src/common/dcbase.cpp — add wasm dc includes
f="src/common/dcbase.cpp"
if [ -f "$f" ]; then
    insert_after "$f" '#include "wx/qt/dcscreen.h"' '#ifdef __WXWASM__
    #include "wx/wasm/dcclient.h"
    #include "wx/wasm/dcmemory.h"
    #include "wx/wasm/dcscreen.h"
#endif'
    echo "  OK: $f"
fi

# src/common/platinfo.cpp — add wasm port
f="src/common/platinfo.cpp"
if [ -f "$f" ]; then
    insert_after "$f" 'wxPORT_QT' '
#ifdef __WXWASM__
    { wxPORT_WASM,   "wxWASM" },
#endif'
    echo "  OK: $f"
fi

# src/common/popupcmn.cpp
f="src/common/popupcmn.cpp"
if [ -f "$f" ]; then
    sed -i '' 's/defined(__WXMAC__)/defined(__WXMAC__) || defined(__WXWASM__)/g' "$f"
    echo "  OK: $f"
fi

# src/common/file.cpp
f="src/common/file.cpp"
if [ -f "$f" ]; then
    sed -i '' 's/#ifdef __UNIX__$/#if defined(__UNIX__) \&\& !defined(__WXWASM__)/' "$f" 2>/dev/null
    echo "  OK: $f"
fi

# src/common/filename.cpp
f="src/common/filename.cpp"
if [ -f "$f" ]; then
    sed -i '' 's/defined(__UNIX_LIKE__)/defined(__UNIX_LIKE__) \&\& !defined(__WXWASM__)/' "$f" 2>/dev/null
    echo "  OK: $f (may need manual check for multiple matches)"
fi

# src/univ/winuniv.cpp
f="src/univ/winuniv.cpp"
if [ -f "$f" ]; then
    insert_after "$f" 'wxWindowX11' ' #elif defined(__WXWASM__)
wxIMPLEMENT_DYNAMIC_CLASS(wxWindow, wxWindowWasm);'
    echo "  OK: $f"
fi

# src/unix/utilsunx.cpp
f="src/unix/utilsunx.cpp"
if [ -f "$f" ]; then
    sed -i '' 's/defined(HAVE_UNAME)/defined(HAVE_UNAME) \&\& !defined(__WXWASM__)/' "$f" 2>/dev/null
    echo "  OK: $f (HAVE_UNAME)"
fi

# src/common/config.cpp
f="src/common/config.cpp"
if [ -f "$f" ]; then
    insert_after "$f" '#include "wx/msw/regconf.h"' '#elif defined(__WXWASM__) \&\& wxUSE_CONFIG_NATIVE
    #include "wx/wasm/config.h"'
    echo "  OK: $f"
fi

# include/wx/unix/apptrait.h
f="include/wx/unix/apptrait.h"
if [ -f "$f" ]; then
    sed -i '' 's/defined(__WXGTK20__)/defined(__WXGTK20__) || defined(__WXWASM__)/' "$f" 2>/dev/null
    echo "  OK: $f"
fi

echo ""
echo "=== Done! ==="
echo "Next: Review misses above, then run Step 7 (API adaptation) and Step 8 (build test)"
