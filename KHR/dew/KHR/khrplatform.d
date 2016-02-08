/*
** Copyright (c) 2008-2009 The Khronos Group Inc.
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

module dew.KHR.khrplatform;

extern(C):
public:
nothrow:

import std.stdint;

version = KHRONOS_SUPPORT_INT64;
version = KHRONOS_SUPPORT_FLOAT;

alias khronos_int8_t        = int8_t;
alias khronos_uint8_t       = uint8_t;
alias khronos_int16_t       = int16_t;
alias khronos_uint16_t      = uint16_t;
alias khronos_int32_t       = int32_t;
alias khronos_uint32_t      = uint32_t;
alias khronos_int64_t       = int64_t;
alias khronos_uint64_t      = uint64_t;
alias khronos_intptr_t      = intptr_t;
alias khronos_uintptr_t     = uintptr_t;
alias khronos_ssize_t       = ptrdiff_t;
alias khronos_usize_t       = size_t;
alias khronos_float_t       = float;

/* Time types
 *
 * These types can be used to represent a time interval in nanoseconds or
 * an absolute Unadjusted System Time.  Unadjusted System Time is the number
 * of nanoseconds since some arbitrary system event (e.g. since the last
 * time the system booted).  The Unadjusted System Time is an unsigned
 * 64 bit value that wraps back to 0 every 584 years.  Time intervals
 * may be either signed or unsigned.
 */

alias khronos_utime_nanoseconds_t   = khronos_uint64_t;
alias khronos_stime_nanoseconds_t   = khronos_int64_t;

// Dummy value used to pad enum types to 32 bits.
enum KHRONOS_MAX_ENUM = 0x7FFFFFFF;

/*
 * Enumerated boolean type
 *
 * Values other than zero should be considered to be true.  Therefore
 * comparisons should not be made against KHRONOS_TRUE.
 */

alias khronos_boolean_enum_t = int;
enum
{
    KHRONOS_FALSE = 0,
    KHRONOS_TRUE  = 1,
    KHRONOS_BOOLEAN_ENUM_FORCE_SIZE = KHRONOS_MAX_ENUM
}
