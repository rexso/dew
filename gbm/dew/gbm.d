/*
 * Copyright © 2011 Intel Corporation
 *
 * Permission is hereby granted, free of charge, to any person obtaining a
 * copy of this software and associated documentation files (the "Software"),
 * to deal in the Software without restriction, including without limitation
 * the rights to use, copy, modify, merge, publish, distribute, sublicense,
 * and/or sell copies of the Software, and to permit persons to whom the
 * Software is furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice (including the next
 * paragraph) shall be included in all copies or substantial portions of the
 * Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
 * EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
 * MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
 * NONINFRINGEMENT.  IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
 * HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
 * WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
 * DEALINGS IN THE SOFTWARE.
 *
 * Authors:
 *    Benjamin Franzke <benjaminfranzke@googlemail.com>
 */

module dew.gbm;

extern(C):
public:
nothrow:

import std.stdint;

version = __GBM__;

struct gbm_device;
struct gbm_bo;
struct gbm_surface;

struct gbm_import_fd_data
{
   int fd;
   uint32_t width;
   uint32_t height;
   uint32_t stride;
   uint32_t format;
}

// Abstraction representing the handle to a buffer allocated by the manager
union gbm_bo_handle
{
   void *ptr;
   int32_t s32;
   uint32_t u32;
   int64_t s64;
   uint64_t u64;
}

// Format of the allocated buffer
enum
{
   GBM_BO_FORMAT_XRGB8888,  // RGB with 8 bits per channel in a 32 bit value
   GBM_BO_FORMAT_ARGB8888   // ARGB with 8 bits per channel in a 32 bit value
}

auto __gbm_fourcc_code(T)(T a, T b, T c, T d) { return (cast(uint32_t)(a) | (cast(uint32_t)(b) << 8) | (cast(uint32_t)(c) << 16) | (cast(uint32_t)(d) << 24)); }

enum GBM_FORMAT_BIG_ENDIAN      = (1<<31); // format is big endian instead of little endian

// color index
enum GBM_FORMAT_C8              = __gbm_fourcc_code('C', '8', ' ', ' ');    // [7:0] C

// 8 bpp RGB
enum GBM_FORMAT_RGB332          = __gbm_fourcc_code('R', 'G', 'B', '8');    // [7:0] R:G:B 3:3:2
enum GBM_FORMAT_BGR233          = __gbm_fourcc_code('B', 'G', 'R', '8');    // [7:0] B:G:R 2:3:3

// 16 bpp RGB
enum GBM_FORMAT_XRGB4444        = __gbm_fourcc_code('X', 'R', '1', '2');    // [15:0] x:R:G:B 4:4:4:4 little endian
enum GBM_FORMAT_XBGR4444        = __gbm_fourcc_code('X', 'B', '1', '2');    // [15:0] x:B:G:R 4:4:4:4 little endian
enum GBM_FORMAT_RGBX4444        = __gbm_fourcc_code('R', 'X', '1', '2');    // [15:0] R:G:B:x 4:4:4:4 little endian
enum GBM_FORMAT_BGRX4444        = __gbm_fourcc_code('B', 'X', '1', '2');    // [15:0] B:G:R:x 4:4:4:4 little endian
enum GBM_FORMAT_ARGB4444        = __gbm_fourcc_code('A', 'R', '1', '2');    // [15:0] A:R:G:B 4:4:4:4 little endian
enum GBM_FORMAT_ABGR4444        = __gbm_fourcc_code('A', 'B', '1', '2');    // [15:0] A:B:G:R 4:4:4:4 little endian
enum GBM_FORMAT_RGBA4444        = __gbm_fourcc_code('R', 'A', '1', '2');    // [15:0] R:G:B:A 4:4:4:4 little endian
enum GBM_FORMAT_BGRA4444        = __gbm_fourcc_code('B', 'A', '1', '2');    // [15:0] B:G:R:A 4:4:4:4 little endian
enum GBM_FORMAT_XRGB1555        = __gbm_fourcc_code('X', 'R', '1', '5');    // [15:0] x:R:G:B 1:5:5:5 little endian
enum GBM_FORMAT_XBGR1555        = __gbm_fourcc_code('X', 'B', '1', '5');    // [15:0] x:B:G:R 1:5:5:5 little endian
enum GBM_FORMAT_RGBX5551        = __gbm_fourcc_code('R', 'X', '1', '5');    // [15:0] R:G:B:x 5:5:5:1 little endian
enum GBM_FORMAT_BGRX5551        = __gbm_fourcc_code('B', 'X', '1', '5');    // [15:0] B:G:R:x 5:5:5:1 little endian
enum GBM_FORMAT_ARGB1555        = __gbm_fourcc_code('A', 'R', '1', '5');    // [15:0] A:R:G:B 1:5:5:5 little endian
enum GBM_FORMAT_ABGR1555        = __gbm_fourcc_code('A', 'B', '1', '5');    // [15:0] A:B:G:R 1:5:5:5 little endian
enum GBM_FORMAT_RGBA5551        = __gbm_fourcc_code('R', 'A', '1', '5');    // [15:0] R:G:B:A 5:5:5:1 little endian
enum GBM_FORMAT_BGRA5551        = __gbm_fourcc_code('B', 'A', '1', '5');    // [15:0] B:G:R:A 5:5:5:1 little endian
enum GBM_FORMAT_RGB565          = __gbm_fourcc_code('R', 'G', '1', '6');    // [15:0] R:G:B 5:6:5 little endian
enum GBM_FORMAT_BGR565          = __gbm_fourcc_code('B', 'G', '1', '6');    // [15:0] B:G:R 5:6:5 little endian

// 24 bpp RGB
enum GBM_FORMAT_RGB888          = __gbm_fourcc_code('R', 'G', '2', '4');    // [23:0] R:G:B little endian
enum GBM_FORMAT_BGR888          = __gbm_fourcc_code('B', 'G', '2', '4');    // [23:0] B:G:R little endian

// 32 bpp RGB
enum GBM_FORMAT_XRGB8888        = __gbm_fourcc_code('X', 'R', '2', '4');    // [31:0] x:R:G:B 8:8:8:8 little endian
enum GBM_FORMAT_XBGR8888        = __gbm_fourcc_code('X', 'B', '2', '4');    // [31:0] x:B:G:R 8:8:8:8 little endian
enum GBM_FORMAT_RGBX8888        = __gbm_fourcc_code('R', 'X', '2', '4');    // [31:0] R:G:B:x 8:8:8:8 little endian
enum GBM_FORMAT_BGRX8888        = __gbm_fourcc_code('B', 'X', '2', '4');    // [31:0] B:G:R:x 8:8:8:8 little endian
enum GBM_FORMAT_ARGB8888        = __gbm_fourcc_code('A', 'R', '2', '4');    // [31:0] A:R:G:B 8:8:8:8 little endian
enum GBM_FORMAT_ABGR8888        = __gbm_fourcc_code('A', 'B', '2', '4');    // [31:0] A:B:G:R 8:8:8:8 little endian
enum GBM_FORMAT_RGBA8888        = __gbm_fourcc_code('R', 'A', '2', '4');    // [31:0] R:G:B:A 8:8:8:8 little endian
enum GBM_FORMAT_BGRA8888        = __gbm_fourcc_code('B', 'A', '2', '4');    // [31:0] B:G:R:A 8:8:8:8 little endian
enum GBM_FORMAT_XRGB2101010	    = __gbm_fourcc_code('X', 'R', '3', '0');    // [31:0] x:R:G:B 2:10:10:10 little endian
enum GBM_FORMAT_XBGR2101010	    = __gbm_fourcc_code('X', 'B', '3', '0');    // [31:0] x:B:G:R 2:10:10:10 little endian
enum GBM_FORMAT_RGBX1010102	    = __gbm_fourcc_code('R', 'X', '3', '0');    // [31:0] R:G:B:x 10:10:10:2 little endian
enum GBM_FORMAT_BGRX1010102	    = __gbm_fourcc_code('B', 'X', '3', '0');    // [31:0] B:G:R:x 10:10:10:2 little endian
enum GBM_FORMAT_ARGB2101010	    = __gbm_fourcc_code('A', 'R', '3', '0');    // [31:0] A:R:G:B 2:10:10:10 little endian
enum GBM_FORMAT_ABGR2101010	    = __gbm_fourcc_code('A', 'B', '3', '0');    // [31:0] A:B:G:R 2:10:10:10 little endian
enum GBM_FORMAT_RGBA1010102	    = __gbm_fourcc_code('R', 'A', '3', '0');    // [31:0] R:G:B:A 10:10:10:2 little endian
enum GBM_FORMAT_BGRA1010102	    = __gbm_fourcc_code('B', 'A', '3', '0');    // [31:0] B:G:R:A 10:10:10:2 little endian

// packed YCbCr
enum GBM_FORMAT_YUYV		    = __gbm_fourcc_code('Y', 'U', 'Y', 'V');    // [31:0] Cr0:Y1:Cb0:Y0 8:8:8:8 little endian
enum GBM_FORMAT_YVYU		    = __gbm_fourcc_code('Y', 'V', 'Y', 'U');    // [31:0] Cb0:Y1:Cr0:Y0 8:8:8:8 little endian
enum GBM_FORMAT_UYVY		    = __gbm_fourcc_code('U', 'Y', 'V', 'Y');    // [31:0] Y1:Cr0:Y0:Cb0 8:8:8:8 little endian
enum GBM_FORMAT_VYUY		    = __gbm_fourcc_code('V', 'Y', 'U', 'Y');    // [31:0] Y1:Cb0:Y0:Cr0 8:8:8:8 little endian
enum GBM_FORMAT_AYUV		    = __gbm_fourcc_code('A', 'Y', 'U', 'V');    // [31:0] A:Y:Cb:Cr 8:8:8:8 little endian

/*
 * 2 plane YCbCr
 * index 0 = Y plane, [7:0] Y
 * index 1 = Cr:Cb plane, [15:0] Cr:Cb little endian
 * or
 * index 1 = Cb:Cr plane, [15:0] Cb:Cr little endian
 */
enum GBM_FORMAT_NV12		    = __gbm_fourcc_code('N', 'V', '1', '2');    // 2x2 subsampled Cr:Cb plane
enum GBM_FORMAT_NV21		    = __gbm_fourcc_code('N', 'V', '2', '1');    // 2x2 subsampled Cb:Cr plane
enum GBM_FORMAT_NV16		    = __gbm_fourcc_code('N', 'V', '1', '6');    // 2x1 subsampled Cr:Cb plane
enum GBM_FORMAT_NV61		    = __gbm_fourcc_code('N', 'V', '6', '1');    // 2x1 subsampled Cb:Cr plane

/*
 * 3 plane YCbCr
 * index 0: Y plane, [7:0] Y
 * index 1: Cb plane, [7:0] Cb
 * index 2: Cr plane, [7:0] Cr
 * or
 * index 1: Cr plane, [7:0] Cr
 * index 2: Cb plane, [7:0] Cb
 */
enum GBM_FORMAT_YUV410	        = __gbm_fourcc_code('Y', 'U', 'V', '9');    // 4x4 subsampled Cb (1) and Cr (2) planes
enum GBM_FORMAT_YVU410	        = __gbm_fourcc_code('Y', 'V', 'U', '9');    // 4x4 subsampled Cr (1) and Cb (2) planes
enum GBM_FORMAT_YUV411	        = __gbm_fourcc_code('Y', 'U', '1', '1');    // 4x1 subsampled Cb (1) and Cr (2) planes
enum GBM_FORMAT_YVU411	        = __gbm_fourcc_code('Y', 'V', '1', '1');    // 4x1 subsampled Cr (1) and Cb (2) planes
enum GBM_FORMAT_YUV420	        = __gbm_fourcc_code('Y', 'U', '1', '2');    // 2x2 subsampled Cb (1) and Cr (2) planes
enum GBM_FORMAT_YVU420	        = __gbm_fourcc_code('Y', 'V', '1', '2');    // 2x2 subsampled Cr (1) and Cb (2) planes
enum GBM_FORMAT_YUV422	        = __gbm_fourcc_code('Y', 'U', '1', '6');    // 2x1 subsampled Cb (1) and Cr (2) planes
enum GBM_FORMAT_YVU422	        = __gbm_fourcc_code('Y', 'V', '1', '6');    // 2x1 subsampled Cr (1) and Cb (2) planes
enum GBM_FORMAT_YUV444	        = __gbm_fourcc_code('Y', 'U', '2', '4');    // non-subsampled Cb (1) and Cr (2) planes
enum GBM_FORMAT_YVU444	        = __gbm_fourcc_code('Y', 'V', '2', '4');    // non-subsampled Cr (1) and Cb (2) planes

enum
{
   GBM_BO_USE_SCANOUT           = (1 << 0),                                 // Buffer is going to be presented to the screen using an API such as KMS
   GBM_BO_USE_CURSOR            = (1 << 1),                                 // Buffer is going to be used as cursor
   GBM_BO_USE_CURSOR_64X64      = GBM_BO_USE_CURSOR,                        // Deprecated
   GBM_BO_USE_RENDERING         = (1 << 2),                                 // Buffer is to be used for rendering - for example it is going to be used as the storage for a color buffer
   GBM_BO_USE_WRITE             = (1 << 3),                                 // Buffer can be used for gbm_bo_write.  This is guaranteed to work with GBM_BO_USE_CURSOR. but may not work for other combinations.
   GBM_BO_USE_LINEAR            = (1 << 4),                                 // Buffer is linear, i.e. not tiled.

   GBM_BO_IMPORT_WL_BUFFER      = 0x5501,
   GBM_BO_IMPORT_EGL_IMAGE      = 0x5502,
   GBM_BO_IMPORT_FD             = 0x5503
}

export int                      gbm_device_get_fd(gbm_device *gbm);
export const(char)*             gbm_device_get_backend_name(gbm_device *gbm);
export int                      gbm_device_is_format_supported(gbm_device *gbm, uint32_t format, uint32_t usage);
export void                     gbm_device_destroy(gbm_device *gbm);
export gbm_device*              gbm_create_device(int fd);
export gbm_bo*                  gbm_bo_create(gbm_device *gbm, uint32_t width, uint32_t height, uint32_t format, uint32_t flags);
export gbm_bo*                  gbm_bo_import(gbm_device *gbm, uint32_t type, void *buffer, uint32_t usage);
export uint32_t                 gbm_bo_get_width(gbm_bo *bo);
export uint32_t                 gbm_bo_get_height(gbm_bo *bo);
export uint32_t                 gbm_bo_get_stride(gbm_bo *bo);
export uint32_t                 gbm_bo_get_format(gbm_bo *bo);
export gbm_device*              gbm_bo_get_device(gbm_bo *bo);
export gbm_bo_handle            gbm_bo_get_handle(gbm_bo *bo);
export int                      gbm_bo_get_fd(gbm_bo *bo);
export int                      gbm_bo_write(gbm_bo *bo, const void *buf, size_t count);
export void                     gbm_bo_set_user_data(gbm_bo *bo, void *data, void function(gbm_bo*, void*) destroy_user_data);
export void*                    gbm_bo_get_user_data(gbm_bo *bo);
export void                     gbm_bo_destroy(gbm_bo *bo);
export gbm_surface*             gbm_surface_create(gbm_device *gbm, uint32_t width, uint32_t height, uint32_t format, uint32_t flags);
export int                      gbm_surface_needs_lock_front_buffer(gbm_surface *surface);
export gbm_bo*                  gbm_surface_lock_front_buffer(gbm_surface *surface);
export void                     gbm_surface_release_buffer(gbm_surface *surface, gbm_bo *bo);
export int                      gbm_surface_has_free_buffers(gbm_surface *surface);
export void                     gbm_surface_destroy(gbm_surface *surface);
