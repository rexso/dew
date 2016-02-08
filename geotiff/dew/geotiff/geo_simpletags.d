/******************************************************************************
 * Copyright (c) 2008, Frank Warmerdam
 *
 * Permission is hereby granted, free of charge, to any person obtaining a
 * copy of this software and associated documentation files (the "Software"),
 * to deal in the Software without restriction, including without limitation
 * the rights to use, copy, modify, merge, publish, distribute, sublicense,
 * and/or sell copies of the Software, and to permit persons to whom the
 * Software is furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included
 * in all copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS
 * OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
 * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
 * FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
 * DEALINGS IN THE SOFTWARE.
 ****************************************************************************/

module dew.geotiff.geo_simpletags;

extern(C):
public:
nothrow:

import dew.geotiff.geotiff;

enum
{
    STT_SHORT   = 1,
    STT_DOUBLE  = 2,
    STT_ASCII   = 3
}

struct ST_KEY
{
    int     tag;
    int     count;
    int     type;
    void*   data;
}

struct ST_TIFF
{
    int     key_count;
    ST_KEY* key_list;
}

alias STIFF = void*;

export void     GTIFSetSimpleTagsMethods(TIFFMethod* method);
export int      ST_SetKey(ST_TIFF*, int tag, int count, int st_type, void* data);
export int      ST_GetKey(ST_TIFF*, int tag, int* count, int* st_type, void** data_ptr);
export ST_TIFF* ST_Create();
export void     ST_Destroy(ST_TIFF*);
export int      ST_TagType(int tag);
