/**************************************************************************
 *
 * Copyright 2008 VMware, Inc.
 * All Rights Reserved.
 *
 * Permission is hereby granted, free of charge, to any person obtaining a
 * copy of this software and associated documentation files (the
 * "Software"), to deal in the Software without restriction, including
 * without limitation the rights to use, copy, modify, merge, publish,
 * distribute, sub license, and/or sell copies of the Software, and to
 * permit persons to whom the Software is furnished to do so, subject to
 * the following conditions:
 *
 * The above copyright notice and this permission notice (including the
 * next paragraph) shall be included in all copies or substantial portions
 * of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
 * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
 * FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
 * DEALINGS IN THE SOFTWARE.
 *
 **************************************************************************/

module dew.EGL.eglmesaext;

extern(C):
public:
nothrow:

import dew.EGL.eglplatform;

version = EGL_MESA_drm_display;
version = EGL_WL_bind_wayland_display;
version = EGL_WL_create_wayland_buffer_from_image;
version = EGL_NOK_swap_region;
version = EGL_NOK_texture_from_pixmap;
version = EGL_ANDROID_image_native_buffer;
version = EGL_MESA_configless_context;
version = EGL_MESA_image_dma_buf_export;

enum
{
    EGL_DRM_BUFFER_USE_CURSOR_MESA      = 0x0004,
    EGL_WAYLAND_BUFFER_WL               = 0x31D5, // eglCreateImageKHR target
    EGL_WAYLAND_PLANE_WL                = 0x31D6, // eglCreateImageKHR target
    EGL_WAYLAND_Y_INVERTED_WL           = 0x31DB, // eglQueryWaylandBufferWL attribute
    EGL_TEXTURE_Y_U_V_WL                = 0x31D7,
    EGL_TEXTURE_Y_UV_WL                 = 0x31D8,
    EGL_TEXTURE_Y_XUXV_WL               = 0x31D9,
    EGL_Y_INVERTED_NOK                  = 0x307F,
    EGL_NATIVE_BUFFER_ANDROID           = 0x3140  // eglCreateImageKHR target
}

struct wl_display;
struct wl_resource;

enum EGL_NO_CONFIG_MESA = null;

export EGLDisplay eglGetDRMDisplayMESA(int fd);
export EGLBoolean eglBindWaylandDisplayWL(EGLDisplay dpy, wl_display *display);
export EGLBoolean eglUnbindWaylandDisplayWL(EGLDisplay dpy, wl_display *display);
export EGLBoolean eglQueryWaylandBufferWL(EGLDisplay dpy, wl_resource *buffer, EGLint attribute, EGLint *value);
export wl_buffer* eglCreateWaylandBufferFromImageWL(EGLDisplay dpy, EGLImageKHR image);
export EGLBoolean eglSwapBuffersRegionNOK(EGLDisplay dpy, EGLSurface surface, EGLint numRects, const EGLint* rects);
export EGLBoolean eglExportDMABUFImageQueryMESA(EGLDisplay dpy, EGLImageKHR image, EGLint *fourcc, EGLint *nplanes, EGLuint64KHR *modifiers);
export EGLBoolean eglExportDMABUFImageMESA(EGLDisplay dpy, EGLImageKHR image, int *fds, EGLint *strides, EGLint *offsets);

alias PFNEGLGETDRMDISPLAYMESA               = EGLDisplay function(int fd);
alias PFNEGLBINDWAYLANDDISPLAYWL            = EGLBoolean function(EGLDisplay dpy, wl_display *display);
alias PFNEGLUNBINDWAYLANDDISPLAYWL          = EGLBoolean function(EGLDisplay dpy, wl_display *display);
alias PFNEGLQUERYWAYLANDBUFFERWL            = EGLBoolean function(EGLDisplay dpy, wl_resource *buffer, EGLint attribute, EGLint *value);
alias PFNEGLCREATEWAYLANDBUFFERFROMIMAGEWL  = wl_buffer* function(EGLDisplay dpy, EGLImageKHR image);
alias PFNEGLSWAPBUFFERSREGIONNOK            = EGLBoolean function(EGLDisplay dpy, EGLSurface surface, EGLint numRects, const EGLint* rects);
alias PFNEGLEXPORTDMABUFIMAGEQUERYMESA      = EGLBoolean function(EGLDisplay dpy, EGLImageKHR image, EGLint *fourcc, EGLint *nplanes, EGLuint64KHR *modifiers);
alias PFNEGLEXPORTDMABUFIMAGEMESA           = EGLBoolean function(EGLDisplay dpy, EGLImageKHR image, int *fds, EGLint *strides, EGLint *offsets);
