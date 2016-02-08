/******************************************************************************
 * Copyright (c) 1998, Frank Warmerdam
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
 ******************************************************************************/

module dew.geotiff.cpl_serv;

extern(C):
public:
nothrow:

import core.stdc.stdio;
import core.stdc.math;
import core.stdc.string;
import core.stdc.stdlib;
import dew.geotiff.geo_tiffp;

enum FALSE	= 0;
enum TRUE	= 1;
enum NULL	= 0;

// VSI Services (just map directly onto Standard C services
alias VSIFOpen		= fopen;
alias VSIFClose		= fclose;
alias VSIFEof		= feof;
alias VSIFPrintf	= fprintf;
alias VSIFPuts		= fputs;
alias VSIFPutc		= fputc;
alias VSIFGets		= fgets;
alias VSIRewind		= rewind;
alias VSIFSeek		= fseek;
alias VSIFTell		= ftell;
alias VSIFRead		= fread;
alias GTIFAtof		= atof;

auto VSICalloc(gsize_t x, gsize_t y)
{
	return _GTIFcalloc(x * y)
}

alias VSIMalloc		= _GTIFcalloc;
alias VSIFree		= _GTIFFree;
alias VSIRealloc	= _GTIFrealloc;

// Safe malloc() API.  Thin cover over VSI functions with fatal error reporting if memory allocation fails
export void*					CPLMalloc(int);
export void*					CPLCalloc(int, int);
export void*					CPLRealloc(void*, int);
export char*					CPLStrdup(const char*);

export void CPLFree(void* ptr)
{
	if(ptr != null)
	VSIFree(ptr);
}

// Locale insensitive string to float conversion
export double					GTIFStrtod(const char* nptr, char** endptr);

// Read a line from a text file, and strip of CR/LF
export const(char)*				CPLReadLine(FILE*);

// Error handling functions (cpl_error.c)
alias CPLErr = int;
enum
{
    CE_None						= 0,
    CE_Log						= 1,
    CE_Warning					= 2,
    CE_Failure					= 3,
    CE_Fatal					= 4
}

export void 					CPLError(CPLErr eErrClass, int err_no, const char* fmt, ...);
export void 					CPLErrorReset();
export int  					CPLGetLastErrorNo();
export const(char)*				CPLGetLastErrorMsg();
export void						CPLSetErrorHandler(void function(CPLErr, int, const char*) pfnErrorHandler);
export void						_CPLAssert(const char*, const char*, int);

export void CPLAssert(const char* expr)
{
	version(debug) if(expr != null)
	_CPLAssert(expr, __FILE__, __LINE__);
}

// Well known error codes
enum
{
	CPLE_AppDefined				= 1,
	CPLE_OutOfMemory			= 2,
	CPLE_FileIO					= 3,
	CPLE_OpenFailed				= 4,
	CPLE_IllegalArg				= 5,
	CPLE_NotSupported			= 6,
	CPLE_AssertionFailed		= 7,
	CPLE_NoWriteAccess			= 8
}

// Stringlist functions (strlist.c)
export char**					CSLAddString(char** papszStrList, const char* pszNewString);
export int						CSLCount(char** papszStrList);
export const(char)*				CSLGetField(char**, int);
export void						CSLDestroy(char** papszStrList);
export char**					CSLDuplicate(char** papszStrList);
export char**					CSLTokenizeString(const char* pszString);
export char**					CSLTokenizeStringComplex(const char* pszString, const char* pszDelimiter, int bHonourStrings, int bAllowEmptyTokens);

// .csv file related functions (cpl_csv.c)
enum CSVCompareCriteria
{
    CC_ExactString,
    CC_ApproxString,
    CC_Integer
}

alias CC_ExactString			= CSVCompareCriteria.CC_ExactString;
alias CC_ApproxString			= CSVCompareCriteria.CC_ApproxString;
alias CC_Integer				= CSVCompareCriteria.CC_Integer;

export const(char)*				CSVFilename( const char * );
export char**					CSVReadParseLine(FILE*);
export char**					CSVScanLines(FILE*, int, const char*, CSVCompareCriteria);
export char**					CSVScanFile(const char*, int, const char*, CSVCompareCriteria);
export char**					CSVScanFileByName(const char*, const char*, const char*, CSVCompareCriteria);
export int						CSVGetFieldId(FILE*, const char*);
export int						CSVGetFileFieldId(const char*, const char*);
export void						CSVDeaccess(const char*);
export const(char)*				CSVGetField(const char*, const char*, const char*, CSVCompareCriteria, const char*);
export void 					SetCSVFilenameHook(const char* function(const char*));
