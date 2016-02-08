/*
** Copyright (c) 2013 The Khronos Group Inc.
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

module dew.EGL.eglext;

extern(C):
public:
nothrow:

import dew.EGL.eglplatform;

enum EGL_EGLEXT_VERSION = 20131218;

version = EGL_KHR_cl_event;
version = EGL_KHR_cl_event2;
version = EGL_KHR_client_get_all_proc_addresses;
version = EGL_KHR_config_attribs;
version = EGL_KHR_create_context;
version = EGL_KHR_fence_sync;
version = EGL_KHR_get_all_proc_addresses;
version = EGL_KHR_gl_colorspace;
version = EGL_KHR_gl_renderbuffer_image;
version = EGL_KHR_gl_texture_2D_image;
version = EGL_KHR_gl_texture_3D_image;
version = EGL_KHR_gl_texture_cubemap_image;
version = EGL_KHR_image;
version = EGL_KHR_image_base;
version = EGL_KHR_image_pixmap;
version = EGL_KHR_lock_surface;
version = EGL_KHR_lock_surface2;
version = EGL_KHR_lock_surface3;
version = EGL_KHR_reusable_sync;
version = EGL_KHR_stream;
version = EGL_KHR_stream_consumer_gltexture;
version = EGL_KHR_stream_cross_process_fd;
version = EGL_KHR_stream_fifo;
version = EGL_KHR_stream_producer_aldatalocator;
version = EGL_KHR_stream_producer_eglsurface;
version = EGL_KHR_surfaceless_context;
version = EGL_KHR_vg_parent_image;
version = EGL_KHR_wait_sync;
version = EGL_ANDROID_blob_cache;
version = EGL_ANDROID_framebuffer_target;
version = EGL_ANDROID_image_native_buffer;
version = EGL_ANDROID_native_fence_sync;
version = EGL_ANDROID_recordable;
version = EGL_ANGLE_d3d_share_handle_client_buffer;
version = EGL_ANGLE_query_surface_pointer;
version = EGL_ANGLE_surface_d3d_texture_2d_share_handle;
version = EGL_ARM_pixmap_multisample_discard;
version = EGL_EXT_buffer_age;
version = EGL_EXT_client_extensions;
version = EGL_EXT_create_context_robustness;
version = EGL_EXT_image_dma_buf_import;
version = EGL_EXT_multiview_window;
version = EGL_EXT_platform_base;
version = EGL_EXT_platform_wayland;
version = EGL_EXT_platform_x11;
version = EGL_EXT_swap_buffers_with_damage;
version = EGL_HI_clientpixmap;
version = EGL_HI_colorformats;
version = EGL_IMG_context_priority;
version = EGL_MESA_drm_image;
version = EGL_MESA_platform_gbm;
version = EGL_NV_3dvision_surface;
version = EGL_NV_coverage_sample;
version = EGL_NV_coverage_sample_resolve;
version = EGL_NV_depth_nonlinear;
version = EGL_NV_native_query;
version = EGL_NV_post_convert_rounding;
version = EGL_NV_post_sub_buffer;
version = EGL_NV_stream_sync;
version = EGL_NV_sync;
version = EGL_NV_system_time;

enum
{
    EGL_CL_EVENT_HANDLE_KHR                             = 0x309C,
    EGL_SYNC_CL_EVENT_KHR                               = 0x30FE,
    EGL_SYNC_CL_EVENT_COMPLETE_KHR                      = 0x30FF,
    EGL_CONFORMANT_KHR                                  = 0x3042,
    EGL_VG_COLORSPACE_LINEAR_BIT_KHR                    = 0x0020,
    EGL_VG_ALPHA_FORMAT_PRE_BIT_KHR                     = 0x0040,
    EGL_CONTEXT_MAJOR_VERSION_KHR                       = 0x3098,
    EGL_CONTEXT_MINOR_VERSION_KHR                       = 0x30FB,
    EGL_CONTEXT_FLAGS_KHR                               = 0x30FC,
    EGL_CONTEXT_OPENGL_PROFILE_MASK_KHR                 = 0x30FD,
    EGL_CONTEXT_OPENGL_RESET_NOTIFICATION_STRATEGY_KHR  = 0x31BD,
    EGL_NO_RESET_NOTIFICATION_KHR                       = 0x31BE,
    EGL_LOSE_CONTEXT_ON_RESET_KHR                       = 0x31BF,
    EGL_CONTEXT_OPENGL_DEBUG_BIT_KHR                    = 0x00000001,
    EGL_CONTEXT_OPENGL_FORWARD_COMPATIBLE_BIT_KHR       = 0x00000002,
    EGL_CONTEXT_OPENGL_ROBUST_ACCESS_BIT_KHR            = 0x00000004,
    EGL_CONTEXT_OPENGL_CORE_PROFILE_BIT_KHR             = 0x00000001,
    EGL_CONTEXT_OPENGL_COMPATIBILITY_PROFILE_BIT_KHR    = 0x00000002,
    EGL_OPENGL_ES3_BIT_KHR                              = 0x00000040,
    EGL_SYNC_PRIOR_COMMANDS_COMPLETE_KHR                = 0x30F0,
    EGL_SYNC_CONDITION_KHR                              = 0x30F8,
    EGL_SYNC_FENCE_KHR                                  = 0x30F9,
    EGL_GL_COLORSPACE_KHR                               = 0x309D,
    EGL_GL_COLORSPACE_SRGB_KHR                          = 0x3089,
    EGL_GL_COLORSPACE_LINEAR_KHR                        = 0x308A,
    EGL_GL_RENDERBUFFER_KHR                             = 0x30B9,
    EGL_GL_TEXTURE_2D_KHR                               = 0x30B1,
    EGL_GL_TEXTURE_LEVEL_KHR                            = 0x30BC,
    EGL_GL_TEXTURE_3D_KHR                               = 0x30B2,
    EGL_GL_TEXTURE_ZOFFSET_KHR                          = 0x30BD,
    EGL_GL_TEXTURE_CUBE_MAP_POSITIVE_X_KHR              = 0x30B3,
    EGL_GL_TEXTURE_CUBE_MAP_NEGATIVE_X_KHR              = 0x30B4,
    EGL_GL_TEXTURE_CUBE_MAP_POSITIVE_Y_KHR              = 0x30B5,
    EGL_GL_TEXTURE_CUBE_MAP_NEGATIVE_Y_KHR              = 0x30B6,
    EGL_GL_TEXTURE_CUBE_MAP_POSITIVE_Z_KHR              = 0x30B7,
    EGL_GL_TEXTURE_CUBE_MAP_NEGATIVE_Z_KHR              = 0x30B8,
    EGL_NATIVE_PIXMAP_KHR                               = 0x30B0,
    EGL_IMAGE_PRESERVED_KHR                             = 0x30D2,
    EGL_READ_SURFACE_BIT_KHR                            = 0x0001,
    EGL_WRITE_SURFACE_BIT_KHR                           = 0x0002,
    EGL_LOCK_SURFACE_BIT_KHR                            = 0x0080,
    EGL_OPTIMAL_FORMAT_BIT_KHR                          = 0x0100,
    EGL_MATCH_FORMAT_KHR                                = 0x3043,
    EGL_FORMAT_RGB_565_EXACT_KHR                        = 0x30C0,
    EGL_FORMAT_RGB_565_KHR                              = 0x30C1,
    EGL_FORMAT_RGBA_8888_EXACT_KHR                      = 0x30C2,
    EGL_FORMAT_RGBA_8888_KHR                            = 0x30C3,
    EGL_MAP_PRESERVE_PIXELS_KHR                         = 0x30C4,
    EGL_LOCK_USAGE_HINT_KHR                             = 0x30C5,
    EGL_BITMAP_POINTER_KHR                              = 0x30C6,
    EGL_BITMAP_PITCH_KHR                                = 0x30C7,
    EGL_BITMAP_ORIGIN_KHR                               = 0x30C8,
    EGL_BITMAP_PIXEL_RED_OFFSET_KHR                     = 0x30C9,
    EGL_BITMAP_PIXEL_GREEN_OFFSET_KHR                   = 0x30CA,
    EGL_BITMAP_PIXEL_BLUE_OFFSET_KHR                    = 0x30CB,
    EGL_BITMAP_PIXEL_ALPHA_OFFSET_KHR                   = 0x30CC,
    EGL_BITMAP_PIXEL_LUMINANCE_OFFSET_KHR               = 0x30CD,
    EGL_LOWER_LEFT_KHR                                  = 0x30CE,
    EGL_UPPER_LEFT_KHR                                  = 0x30CF,
    EGL_BITMAP_PIXEL_SIZE_KHR                           = 0x3110,
    EGL_SYNC_STATUS_KHR                                 = 0x30F1,
    EGL_SIGNALED_KHR                                    = 0x30F2,
    EGL_UNSIGNALED_KHR                                  = 0x30F3,
    EGL_TIMEOUT_EXPIRED_KHR                             = 0x30F5,
    EGL_CONDITION_SATISFIED_KHR                         = 0x30F6,
    EGL_SYNC_TYPE_KHR                                   = 0x30F7,
    EGL_SYNC_REUSABLE_KHR                               = 0x30FA,
    EGL_SYNC_FLUSH_COMMANDS_BIT_KHR                     = 0x0001,
    EGL_CONSUMER_LATENCY_USEC_KHR                       = 0x3210,
    EGL_PRODUCER_FRAME_KHR                              = 0x3212,
    EGL_CONSUMER_FRAME_KHR                              = 0x3213,
    EGL_STREAM_STATE_KHR                                = 0x3214,
    EGL_STREAM_STATE_CREATED_KHR                        = 0x3215,
    EGL_STREAM_STATE_CONNECTING_KHR                     = 0x3216,
    EGL_STREAM_STATE_EMPTY_KHR                          = 0x3217,
    EGL_STREAM_STATE_NEW_FRAME_AVAILABLE_KHR            = 0x3218,
    EGL_STREAM_STATE_OLD_FRAME_AVAILABLE_KHR            = 0x3219,
    EGL_STREAM_STATE_DISCONNECTED_KHR                   = 0x321A,
    EGL_BAD_STREAM_KHR                                  = 0x321B,
    EGL_BAD_STATE_KHR                                   = 0x321C,
    EGL_CONSUMER_ACQUIRE_TIMEOUT_USEC_KHR               = 0x321E,
    EGL_STREAM_FIFO_LENGTH_KHR                          = 0x31FC,
    EGL_STREAM_TIME_NOW_KHR                             = 0x31FD,
    EGL_STREAM_TIME_CONSUMER_KHR                        = 0x31FE,
    EGL_STREAM_TIME_PRODUCER_KHR                        = 0x31FF,
    EGL_STREAM_BIT_KHR                                  = 0x0800,
    EGL_VG_PARENT_IMAGE_KHR                             = 0x30BA,
    EGL_FRAMEBUFFER_TARGET_ANDROID                      = 0x3147,
    EGL_NATIVE_BUFFER_ANDROID                           = 0x3140,
    EGL_SYNC_NATIVE_FENCE_ANDROID                       = 0x3144,
    EGL_SYNC_NATIVE_FENCE_FD_ANDROID                    = 0x3145,
    EGL_SYNC_NATIVE_FENCE_SIGNALED_ANDROID              = 0x3146,
    EGL_RECORDABLE_ANDROID                              = 0x3142,
    EGL_D3D_TEXTURE_2D_SHARE_HANDLE_ANGLE               = 0x3200,
    EGL_DISCARD_SAMPLES_ARM                             = 0x3286,
    EGL_BUFFER_AGE_EXT                                  = 0x313D,
    EGL_CONTEXT_OPENGL_ROBUST_ACCESS_EXT                = 0x30BF,
    EGL_CONTEXT_OPENGL_RESET_NOTIFICATION_STRATEGY_EXT  = 0x3138,
    EGL_NO_RESET_NOTIFICATION_EXT                       = 0x31BE,
    EGL_LOSE_CONTEXT_ON_RESET_EXT                       = 0x31BF,
    EGL_LINUX_DMA_BUF_EXT                               = 0x3270,
    EGL_LINUX_DRM_FOURCC_EXT                            = 0x3271,
    EGL_DMA_BUF_PLANE0_FD_EXT                           = 0x3272,
    EGL_DMA_BUF_PLANE0_OFFSET_EXT                       = 0x3273,
    EGL_DMA_BUF_PLANE0_PITCH_EXT                        = 0x3274,
    EGL_DMA_BUF_PLANE1_FD_EXT                           = 0x3275,
    EGL_DMA_BUF_PLANE1_OFFSET_EXT                       = 0x3276,
    EGL_DMA_BUF_PLANE1_PITCH_EXT                        = 0x3277,
    EGL_DMA_BUF_PLANE2_FD_EXT                           = 0x3278,
    EGL_DMA_BUF_PLANE2_OFFSET_EXT                       = 0x3279,
    EGL_DMA_BUF_PLANE2_PITCH_EXT                        = 0x327A,
    EGL_YUV_COLOR_SPACE_HINT_EXT                        = 0x327B,
    EGL_SAMPLE_RANGE_HINT_EXT                           = 0x327C,
    EGL_YUV_CHROMA_HORIZONTAL_SITING_HINT_EXT           = 0x327D,
    EGL_YUV_CHROMA_VERTICAL_SITING_HINT_EXT             = 0x327E,
    EGL_ITU_REC601_EXT                                  = 0x327F,
    EGL_ITU_REC709_EXT                                  = 0x3280,
    EGL_ITU_REC2020_EXT                                 = 0x3281,
    EGL_YUV_FULL_RANGE_EXT                              = 0x3282,
    EGL_YUV_NARROW_RANGE_EXT                            = 0x3283,
    EGL_YUV_CHROMA_SITING_0_EXT                         = 0x3284,
    EGL_YUV_CHROMA_SITING_0_5_EXT                       = 0x3285,
    EGL_MULTIVIEW_VIEW_COUNT_EXT                        = 0x3134,
    EGL_PLATFORM_WAYLAND_EXT                            = 0x31D8,
    EGL_PLATFORM_X11_EXT                                = 0x31D5,
    EGL_PLATFORM_X11_SCREEN_EXT                         = 0x31D6,
    EGL_CLIENT_PIXMAP_POINTER_HI                        = 0x8F74,
    EGL_COLOR_FORMAT_HI                                 = 0x8F70,
    EGL_COLOR_RGB_HI                                    = 0x8F71,
    EGL_COLOR_RGBA_HI                                   = 0x8F72,
    EGL_COLOR_ARGB_HI                                   = 0x8F73,
    EGL_CONTEXT_PRIORITY_LEVEL_IMG                      = 0x3100,
    EGL_CONTEXT_PRIORITY_HIGH_IMG                       = 0x3101,
    EGL_CONTEXT_PRIORITY_MEDIUM_IMG                     = 0x3102,
    EGL_CONTEXT_PRIORITY_LOW_IMG                        = 0x3103,
    EGL_DRM_BUFFER_FORMAT_MESA                          = 0x31D0,
    EGL_DRM_BUFFER_USE_MESA                             = 0x31D1,
    EGL_DRM_BUFFER_FORMAT_ARGB32_MESA                   = 0x31D2,
    EGL_DRM_BUFFER_MESA                                 = 0x31D3,
    EGL_DRM_BUFFER_STRIDE_MESA                          = 0x31D4,
    EGL_DRM_BUFFER_USE_SCANOUT_MESA                     = 0x00000001,
    EGL_DRM_BUFFER_USE_SHARE_MESA                       = 0x00000002,
    EGL_PLATFORM_GBM_MESA                               = 0x31D7,
    EGL_AUTO_STEREO_NV                                  = 0x3136,
    EGL_COVERAGE_BUFFERS_NV                             = 0x30E0,
    EGL_COVERAGE_SAMPLES_NV                             = 0x30E1,
    EGL_COVERAGE_SAMPLE_RESOLVE_NV                      = 0x3131,
    EGL_COVERAGE_SAMPLE_RESOLVE_DEFAULT_NV              = 0x3132,
    EGL_COVERAGE_SAMPLE_RESOLVE_NONE_NV                 = 0x3133,
    EGL_DEPTH_ENCODING_NV                               = 0x30E2,
    EGL_DEPTH_ENCODING_NONE_NV                          = 0,
    EGL_DEPTH_ENCODING_NONLINEAR_NV                     = 0x30E3,
    EGL_POST_SUB_BUFFER_SUPPORTED_NV                    = 0x30BE,
    EGL_SYNC_NEW_FRAME_NV                               = 0x321F,
    EGL_SYNC_PRIOR_COMMANDS_COMPLETE_NV                 = 0x30E6,
    EGL_SYNC_STATUS_NV                                  = 0x30E7,
    EGL_SIGNALED_NV                                     = 0x30E8,
    EGL_UNSIGNALED_NV                                   = 0x30E9,
    EGL_SYNC_FLUSH_COMMANDS_BIT_NV                      = 0x0001,
    EGL_ALREADY_SIGNALED_NV                             = 0x30EA,
    EGL_TIMEOUT_EXPIRED_NV                              = 0x30EB,
    EGL_CONDITION_SATISFIED_NV                          = 0x30EC,
    EGL_SYNC_TYPE_NV                                    = 0x30ED,
    EGL_SYNC_CONDITION_NV                               = 0x30EE,
    EGL_SYNC_FENCE_NV                                   = 0x30EF
}

struct EGLClientPixmapHI
{
    void  *pData;
    EGLint iWidth;
    EGLint iHeight;
    EGLint iStride;
}

alias EGLSyncKHR                    = void*;
alias EGLAttribKHR                  = intptr_t;
alias EGLImageKHR                   = void*;
alias EGLTimeKHR                    = khronos_utime_nanoseconds_t;
alias EGLStreamKHR                  = void*;
alias EGLuint64KHR                  = khronos_uint64_t;
alias EGLNativeFileDescriptorKHR    = int;
alias EGLsizeiANDROID               = khronos_ssize_t;
alias EGLSyncNV                     = void*;
alias EGLTimeNV                     = khronos_utime_nanoseconds_t;
alias EGLuint64NV                   = khronos_utime_nanoseconds_t;
alias EGLSetBlobFuncANDROID         = void function(const void *key, EGLsizeiANDROID keySize, const void *value, EGLsizeiANDROID valueSize);
alias EGLGetBlobFuncANDROID         = EGLsizeiANDROID function(const void *key, EGLsizeiANDROID keySize, void *value, EGLsizeiANDROID valueSize);

enum EGL_NO_IMAGE_KHR               = null;
enum EGL_NO_SYNC_KHR                = null;
enum EGL_NO_STREAM_KHR              = null;
enum EGL_NO_FILE_DESCRIPTOR_KHR     = -1;
enum EGL_NO_NATIVE_FENCE_FD_ANDROID = -1;
enum EGL_FOREVER_KHR                = 0xFFFFFFFFFFFFFFFFu;
enum EGL_NO_SYNC_NV                 = null;
enum EGL_FOREVER_NV                 = 0xFFFFFFFFFFFFFFFFu;

alias PFNEGLCREATESYNC64KHRPROC                     = EGLSyncKHR function(EGLDisplay dpy, EGLenum type, const EGLAttribKHR *attrib_list);
alias PFNEGLCREATEIMAGEKHRPROC                      = EGLImageKHR function(EGLDisplay dpy, EGLContext ctx, EGLenum target, EGLClientBuffer buffer, const EGLint *attrib_list);
alias PFNEGLDESTROYIMAGEKHRPROC                     = EGLBoolean function(EGLDisplay dpy, EGLImageKHR image);
alias PFNEGLLOCKSURFACEKHRPROC                      = EGLBoolean function(EGLDisplay dpy, EGLSurface surface, const EGLint *attrib_list);
alias PFNEGLUNLOCKSURFACEKHRPROC                    = EGLBoolean function(EGLDisplay dpy, EGLSurface surface);
alias PFNEGLQUERYSURFACE64KHRPROC                   = EGLBoolean function(EGLDisplay dpy, EGLSurface surface, EGLint attribute, EGLAttribKHR *value);
alias PFNEGLCREATESYNCKHRPROC                       = EGLSyncKHR function(EGLDisplay dpy, EGLenum type, const EGLint *attrib_list);
alias PFNEGLDESTROYSYNCKHRPROC                      = EGLBoolean function(EGLDisplay dpy, EGLSyncKHR sync);
alias PFNEGLCLIENTWAITSYNCKHRPROC                   = EGLint function(EGLDisplay dpy, EGLSyncKHR sync, EGLint flags, EGLTimeKHR timeout);
alias PFNEGLSIGNALSYNCKHRPROC                       = EGLBoolean function(EGLDisplay dpy, EGLSyncKHR sync, EGLenum mode);
alias PFNEGLGETSYNCATTRIBKHRPROC                    = EGLBoolean function(EGLDisplay dpy, EGLSyncKHR sync, EGLint attribute, EGLint *value);
alias PFNEGLCREATESTREAMKHRPROC                     = EGLStreamKHR function(EGLDisplay dpy, const EGLint *attrib_list);
alias PFNEGLDESTROYSTREAMKHRPROC                    = EGLBoolean function(EGLDisplay dpy, EGLStreamKHR stream);
alias PFNEGLSTREAMATTRIBKHRPROC                     = EGLBoolean function(EGLDisplay dpy, EGLStreamKHR stream, EGLenum attribute, EGLint value);
alias PFNEGLQUERYSTREAMKHRPROC                      = EGLBoolean function(EGLDisplay dpy, EGLStreamKHR stream, EGLenum attribute, EGLint *value);
alias PFNEGLQUERYSTREAMU64KHRPROC                   = EGLBoolean function(EGLDisplay dpy, EGLStreamKHR stream, EGLenum attribute, EGLuint64KHR *value);
alias PFNEGLSTREAMCONSUMERGLTEXTUREEXTERNALKHRPROC  = EGLBoolean function(EGLDisplay dpy, EGLStreamKHR stream);
alias PFNEGLSTREAMCONSUMERACQUIREKHRPROC            = EGLBoolean function(EGLDisplay dpy, EGLStreamKHR stream);
alias PFNEGLSTREAMCONSUMERRELEASEKHRPROC            = EGLBoolean function(EGLDisplay dpy, EGLStreamKHR stream);
alias PFNEGLGETSTREAMFILEDESCRIPTORKHRPROC          = EGLNativeFileDescriptorKHR function(EGLDisplay dpy, EGLStreamKHR stream);
alias PFNEGLCREATESTREAMFROMFILEDESCRIPTORKHRPROC   = EGLStreamKHR function(EGLDisplay dpy, EGLNativeFileDescriptorKHR file_descriptor);
alias PFNEGLQUERYSTREAMTIMEKHRPROC                  = EGLBoolean function(EGLDisplay dpy, EGLStreamKHR stream, EGLenum attribute, EGLTimeKHR *value);
alias PFNEGLCREATESTREAMPRODUCERSURFACEKHRPROC      = EGLSurface function(EGLDisplay dpy, EGLConfig config, EGLStreamKHR stream, const EGLint *attrib_list);
alias PFNEGLWAITSYNCKHRPROC                         = EGLint function(EGLDisplay dpy, EGLSyncKHR sync, EGLint flags);
alias PFNEGLSETBLOBCACHEFUNCSANDROIDPROC            = void function(EGLDisplay dpy, EGLSetBlobFuncANDROID set, EGLGetBlobFuncANDROID get);
alias PFNEGLDUPNATIVEFENCEFDANDROIDPROC             = EGLint function(EGLDisplay dpy, EGLSyncKHR sync);
alias PFNEGLQUERYSURFACEPOINTERANGLEPROC            = EGLBoolean function(EGLDisplay dpy, EGLSurface surface, EGLint attribute, void **value);
alias PFNEGLGETPLATFORMDISPLAYEXTPROC               = EGLDisplay function(EGLenum platform, void *native_display, const EGLint *attrib_list);
alias PFNEGLCREATEPLATFORMWINDOWSURFACEEXTPROC      = EGLSurface function(EGLDisplay dpy, EGLConfig config, void *native_window, const EGLint *attrib_list);
alias PFNEGLCREATEPLATFORMPIXMAPSURFACEEXTPROC      = EGLSurface function(EGLDisplay dpy, EGLConfig config, void *native_pixmap, const EGLint *attrib_list);
alias PFNEGLSWAPBUFFERSWITHDAMAGEEXTPROC            = EGLBoolean function(EGLDisplay dpy, EGLSurface surface, EGLint *rects, EGLint n_rects);
alias PFNEGLCREATEPIXMAPSURFACEHIPROC               = EGLSurface function(EGLDisplay dpy, EGLConfig config, struct EGLClientPixmapHI *pixmap);
alias PFNEGLCREATEDRMIMAGEMESAPROC                  = EGLImageKHR function(EGLDisplay dpy, const EGLint *attrib_list);
alias PFNEGLEXPORTDRMIMAGEMESAPROC                  = EGLBoolean function(EGLDisplay dpy, EGLImageKHR image, EGLint *name, EGLint *handle, EGLint *stride);
alias PFNEGLQUERYNATIVEDISPLAYNVPROC                = EGLBoolean function(EGLDisplay dpy, EGLNativeDisplayType *display_id);
alias PFNEGLQUERYNATIVEWINDOWNVPROC                 = EGLBoolean function(EGLDisplay dpy, EGLSurface surf, EGLNativeWindowType *window);
alias PFNEGLQUERYNATIVEPIXMAPNVPROC                 = EGLBoolean function(EGLDisplay dpy, EGLSurface surf, EGLNativePixmapType *pixmap);
alias PFNEGLPOSTSUBBUFFERNVPROC                     = EGLBoolean function(EGLDisplay dpy, EGLSurface surface, EGLint x, EGLint y, EGLint width, EGLint height);
alias PFNEGLCREATESTREAMSYNCNVPROC                  = EGLSyncKHR function(EGLDisplay dpy, EGLStreamKHR stream, EGLenum type, const EGLint *attrib_list);
alias PFNEGLCREATEFENCESYNCNVPROC                   = EGLSyncNV function(EGLDisplay dpy, EGLenum condition, const EGLint *attrib_list);
alias PFNEGLDESTROYSYNCNVPROC                       = EGLBoolean function(EGLSyncNV sync);
alias PFNEGLFENCENVPROC                             = EGLBoolean function(EGLSyncNV sync);
alias PFNEGLCLIENTWAITSYNCNVPROC                    = EGLint function(EGLSyncNV sync, EGLint flags, EGLTimeNV timeout);
alias PFNEGLSIGNALSYNCNVPROC                        = EGLBoolean function(EGLSyncNV sync, EGLenum mode);
alias PFNEGLGETSYNCATTRIBNVPROC                     = EGLBoolean function(EGLSyncNV sync, EGLint attribute, EGLint *value);
alias PFNEGLGETSYSTEMTIMEFREQUENCYNVPROC            = EGLuint64NV function(void);
alias PFNEGLGETSYSTEMTIMENVPROC                     = EGLuint64NV function(void);

export EGLSyncKHR                   eglCreateSync64KHR(EGLDisplay dpy, EGLenum type, const EGLAttribKHR *attrib_list);
export EGLImageKHR                  eglCreateImageKHR(EGLDisplay dpy, EGLContext ctx, EGLenum target, EGLClientBuffer buffer, const EGLint *attrib_list);
export EGLBoolean                   eglDestroyImageKHR(EGLDisplay dpy, EGLImageKHR image);
export EGLBoolean                   eglLockSurfaceKHR(EGLDisplay dpy, EGLSurface surface, const EGLint *attrib_list);
export EGLBoolean                   eglUnlockSurfaceKHR(EGLDisplay dpy, EGLSurface surface);
export EGLBoolean                   eglQuerySurface64KHR(EGLDisplay dpy, EGLSurface surface, EGLint attribute, EGLAttribKHR *value);
export EGLSyncKHR                   eglCreateSyncKHR(EGLDisplay dpy, EGLenum type, const EGLint *attrib_list);
export EGLBoolean                   eglDestroySyncKHR(EGLDisplay dpy, EGLSyncKHR sync);
export EGLint                       eglClientWaitSyncKHR(EGLDisplay dpy, EGLSyncKHR sync, EGLint flags, EGLTimeKHR timeout);
export EGLBoolean                   eglSignalSyncKHR(EGLDisplay dpy, EGLSyncKHR sync, EGLenum mode);
export EGLBoolean                   eglGetSyncAttribKHR(EGLDisplay dpy, EGLSyncKHR sync, EGLint attribute, EGLint *value);
export EGLStreamKHR                 eglCreateStreamKHR(EGLDisplay dpy, const EGLint *attrib_list);
export EGLBoolean                   eglDestroyStreamKHR(EGLDisplay dpy, EGLStreamKHR stream);
export EGLBoolean                   eglStreamAttribKHR(EGLDisplay dpy, EGLStreamKHR stream, EGLenum attribute, EGLint value);
export EGLBoolean                   eglQueryStreamKHR(EGLDisplay dpy, EGLStreamKHR stream, EGLenum attribute, EGLint *value);
export EGLBoolean                   eglQueryStreamu64KHR(EGLDisplay dpy, EGLStreamKHR stream, EGLenum attribute, EGLuint64KHR *value);
export EGLBoolean                   eglStreamConsumerGLTextureExternalKHR(EGLDisplay dpy, EGLStreamKHR stream);
export EGLBoolean                   eglStreamConsumerAcquireKHR(EGLDisplay dpy, EGLStreamKHR stream);
export EGLBoolean                   eglStreamConsumerReleaseKHR(EGLDisplay dpy, EGLStreamKHR stream);
export EGLNativeFileDescriptorKHR   eglGetStreamFileDescriptorKHR(EGLDisplay dpy, EGLStreamKHR stream);
export EGLStreamKHR                 eglCreateStreamFromFileDescriptorKHR(EGLDisplay dpy, EGLNativeFileDescriptorKHR file_descriptor);
export EGLBoolean                   eglQueryStreamTimeKHR(EGLDisplay dpy, EGLStreamKHR stream, EGLenum attribute, EGLTimeKHR *value);
export EGLSurface                   eglCreateStreamProducerSurfaceKHR(EGLDisplay dpy, EGLConfig config, EGLStreamKHR stream, const EGLint *attrib_list);
export EGLint                       eglWaitSyncKHR(EGLDisplay dpy, EGLSyncKHR sync, EGLint flags);
export void                         eglSetBlobCacheFuncsANDROID(EGLDisplay dpy, EGLSetBlobFuncANDROID set, EGLGetBlobFuncANDROID get);
export EGLint                       eglDupNativeFenceFDANDROID(EGLDisplay dpy, EGLSyncKHR sync);
export EGLBoolean                   eglQuerySurfacePointerANGLE(EGLDisplay dpy, EGLSurface surface, EGLint attribute, void **value);
export EGLDisplay                   eglGetPlatformDisplayEXT(EGLenum platform, void *native_display, const EGLint *attrib_list);
export EGLSurface                   eglCreatePlatformWindowSurfaceEXT(EGLDisplay dpy, EGLConfig config, void *native_window, const EGLint *attrib_list);
export EGLSurface                   eglCreatePlatformPixmapSurfaceEXT(EGLDisplay dpy, EGLConfig config, void *native_pixmap, const EGLint *attrib_list);
export EGLBoolean                   eglSwapBuffersWithDamageEXT(EGLDisplay dpy, EGLSurface surface, EGLint *rects, EGLint n_rects);
export EGLSurface                   eglCreatePixmapSurfaceHI(EGLDisplay dpy, EGLConfig config, struct EGLClientPixmapHI *pixmap);
export EGLImageKHR                  eglCreateDRMImageMESA(EGLDisplay dpy, const EGLint *attrib_list);
export EGLBoolean                   eglExportDRMImageMESA(EGLDisplay dpy, EGLImageKHR image, EGLint *name, EGLint *handle, EGLint *stride);
export EGLBoolean                   eglQueryNativeDisplayNV(EGLDisplay dpy, EGLNativeDisplayType *display_id);
export EGLBoolean                   eglQueryNativeWindowNV(EGLDisplay dpy, EGLSurface surf, EGLNativeWindowType *window);
export EGLBoolean                   eglQueryNativePixmapNV(EGLDisplay dpy, EGLSurface surf, EGLNativePixmapType *pixmap);
export EGLBoolean                   eglPostSubBufferNV(EGLDisplay dpy, EGLSurface surface, EGLint x, EGLint y, EGLint width, EGLint height);
export EGLSyncKHR                   eglCreateStreamSyncNV(EGLDisplay dpy, EGLStreamKHR stream, EGLenum type, const EGLint *attrib_list);
export EGLSyncNV                    eglCreateFenceSyncNV(EGLDisplay dpy, EGLenum condition, const EGLint *attrib_list);
export EGLBoolean                   eglDestroySyncNV(EGLSyncNV sync);
export EGLBoolean                   eglFenceNV(EGLSyncNV sync);
export EGLint                       eglClientWaitSyncNV(EGLSyncNV sync, EGLint flags, EGLTimeNV timeout);
export EGLBoolean                   eglSignalSyncNV(EGLSyncNV sync, EGLenum mode);
export EGLBoolean                   eglGetSyncAttribNV(EGLSyncNV sync, EGLint attribute, EGLint *value);
export EGLuint64NV                  eglGetSystemTimeFrequencyNV();
export EGLuint64NV                  eglGetSystemTimeNV();
