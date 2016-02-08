/*
** Copyright (c) 2007-2009 The Khronos Group Inc.
**
** Permission is hereby granted, free of charge, to any person obtaining a
** copy of this software and/or associated documentation files (the
** "Materials"), to deal in the Materials without restriction, including
** without limitation the rights to use, copy, modify, merge, publish,
** distribute, sublicense, and/or sell copies of the Materials, and to
** permit persons to whom the Materials are furnished to do so, subject to
** the following conditions:
**
** The above copyright notice and this permission notice shall be included
** in all copies or substantial portions of the Materials.
**
** THE MATERIALS ARE PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
** EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
** MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
** IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY
** CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,
** TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
** MATERIALS OR THE USE OR OTHER DEALINGS IN THE MATERIALS.
*/

module dew.EGL.eglplatform;

extern(C):
public:
nothrow:

import dew.KHR.khrplatform;

/* The types NativeDisplayType, NativeWindowType, and NativePixmapType
 * are aliases of window-system-dependent types, such as X Display * or
 * Windows Device Context. They must be defined in platform-specific
 * code below. The EGL-prefixed versions of Native*Type are the same
 * types, renamed in EGL 1.3 so all types in the API start with "EGL".
 *
 * Khronos STRONGLY RECOMMENDS that you use the default definitions
 * provided below, since these changes affect both binary and source
 * portability of applications using EGL running on different EGL
 * implementations.
 */

version(Windows)
{
    import std.c.windows.windows;

    alias EGLNativeDisplayType      = HDC;
    alias EGLNativePixmapType       = HBITMAP;
    alias EGLNativeWindowType       = HWND;
}
else version(Symbian)
{
    alias EGLNativeDisplayType      = int;
    alias EGLNativePixmapType       = void*;
    alias EGLNativeWindowType       = void*;
}
else version(WL_EGL_PLATFORM)
{
    struct wl_display;
    struct wl_egl_pixmap;
    struct wl_egl_window;

    alias EGLNativeDisplayType      = wl_display*;
    alias EGLNativePixmapType       = wl_egl_pixmap*;
    alias EGLNativeWindowType       = wl_egl_window*;
}
else version(__GBM__)
{
    struct gbm_device;
    struct gbm_bo;

    alias EGLNativeDisplayType      = gbm_device*;
    alias EGLNativePixmapType       = gbm_bo*;
    alias EGLNativeWindowType       = void*;
}
else version(Android)
{
    struct ANativeWindow;
    struct egl_native_pixmap_t;

    alias EGLNativeDisplayType      = ANativeWindow*;
    alias EGLNativePixmapType       = egl_native_pixmap_t*;
    alias EGLNativeWindowType       = void*;
}
else version(Posix)
{
    version(MESA_EGL_NO_X11_HEADERS)
    {
        alias EGLNativeDisplayType  = void*;
        alias EGLNativePixmapType   = khronos_uintptr_t;
        alias EGLNativeWindowType   = khronos_uintptr_t;
    }
    else
    {
        // X11 (tentative)
        import deimos.X11.Xlib;
        import deimos.X11.Xutil;

        alias EGLNativeDisplayType  = Display*;
        alias EGLNativePixmapType   = Pixmap;
        alias EGLNativeWindowType   = Window;
    }
}
else version(Haiku)
{
    import std.c.haiku.kernel.image;

    alias EGLNativeDisplayType      = void*;
    alias EGLNativePixmapType       = khronos_uintptr_t;
    alias EGLNativeWindowType       = khronos_uintptr_t;
}
else static assert(0, "Platform not recognized");

// EGL 1.2 types, renamed for consistency in EGL 1.3
alias NativeDisplayType = EGLNativeDisplayType;
alias NativePixmapType  = EGLNativePixmapType;
alias NativeWindowType  = EGLNativeWindowType;

/* Define EGLint. This must be a signed integral type large enough to contain
 * all legal attribute names and values passed into and out of EGL, whether
 * their type is boolean, bitmask, enumerant (symbolic constant), integer,
 * handle, or other.  While in general a 32-bit integer will suffice, if
 * handles are 64 bit types, then EGLint should be defined as a signed 64-bit
 * integer type.
 */

alias EGLint = khronos_int32_t;
