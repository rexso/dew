/*
 * Copyright (c) 1988-1997 Sam Leffler
 * Copyright (c) 1991-1997 Silicon Graphics, Inc.
 *
 * Permission to use, copy, modify, distribute, and sell this software and
 * its documentation for any purpose is hereby granted without fee, provided
 * that (i) the above copyright notices and this permission notice appear in
 * all copies of the software and related documentation, and (ii) the names of
 * Sam Leffler and Silicon Graphics may not be used in any advertising or
 * publicity relating to the software without the specific, prior written
 * permission of Sam Leffler and Silicon Graphics.
 *
 * THE SOFTWARE IS PROVIDED "AS-IS" AND WITHOUT WARRANTY OF ANY KIND,
 * EXPRESS, IMPLIED OR OTHERWISE, INCLUDING WITHOUT LIMITATION, ANY
 * WARRANTY OF MERCHANTABILITY OR FITNESS FOR A PARTICULAR PURPOSE.
 *
 * IN NO EVENT SHALL SAM LEFFLER OR SILICON GRAPHICS BE LIABLE FOR
 * ANY SPECIAL, INCIDENTAL, INDIRECT OR CONSEQUENTIAL DAMAGES OF ANY KIND,
 * OR ANY DAMAGES WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS,
 * WHETHER OR NOT ADVISED OF THE POSSIBILITY OF DAMAGE, AND ON ANY THEORY OF
 * LIABILITY, ARISING OUT OF OR IN CONNECTION WITH THE USE OR PERFORMANCE
 * OF THIS SOFTWARE.
 */

module dew.tiff.tiffio;

extern(C):
public:
nothrow:

import dew.tiff.tiff;
import dew.tiff.tiffvers;

/*
 * TIFF is defined as an incomplete type to hide the
 * library's internal data structures from clients.
 */

struct TIFF;

/*
 * The following typedefs define the intrinsic size of
 * data types used in the *exported* interfaces.  These
 * definitions depend on the proper definition of types
 * in tiff.h.  Note also that the varargs interface used
 * to pass tag types and values uses the types defined in
 * tiff.h directly.
 *
 * NB: ttag_t is unsigned int and not unsigned short because
 *     ANSI C requires that the type before the ellipsis be a
 *     promoted type (i.e. one of int, unsigned int, pointer,
 *     or double) and because we defined pseudo-tags that are
 *     outside the range of legal Aldus-assigned tags.
 * NB: tsize_t is int32 and not uint32 because some functions
 *     return -1.
 * NB: toff_t is not off_t for many reasons; TIFFs max out at
 *     32-bit file offsets, and BigTIFF maxes out at 64-bit
 *     offsets being the most important, and to ensure use of
 *     a consistently unsigned type across architectures.
 *     Prior to libtiff 4.0, this was an unsigned 32 bit type.
 */

alias tmsize_t	= TIFF_SSIZE_T;
alias toff_t	= ulong;

// the following are deprecated and should be replaced by their defining counterparts
alias ttag_t	= uint;			// directory tag
alias tdir_t	= ushort;		// directory index
alias tsample_t	= ushort;		// sample number
alias tstrile_t	= uint;			// strip or tile number
alias tstrip_t	= tstrile_t;	// strip number
alias ttile_t	= tstrile_t;	// tile number
alias tsize_t	= tmsize_t;		// i/o size in bytes
alias tdata_t	= void*;		// image data ref
alias thandle_t	= void*;		// client data handle

/*
 * Flags to pass to TIFFPrintDirectory to control
 * printing of data structures that are potentially
 * very large.   Bit-or these flags to enable printing
 * multiple items.
 */

enum
{
	TIFFPRINT_NONE			= 0x0,		// no extra info
	TIFFPRINT_STRIPS		= 0x1,		// strips/tiles info
	TIFFPRINT_CURVES		= 0x2,		// color/gray response curves
	TIFFPRINT_COLORMAP		= 0x4,		// colormap
	TIFFPRINT_JPEGQTABLES	= 0x100,	// JPEG Q matrices
	TIFFPRINT_JPEGACTABLES	= 0x200,	// JPEG AC tables
	TIFFPRINT_JPEGDCTABLES	= 0x200		// JPEG DC tables
}

// Colour conversion stuff (reference white)
enum : float
{
	D65_X0	= 95.0470,
	D65_Y0	= 100.0,
	D65_Z0	= 108.8827
}

alias TIFFRGBValue = ubyte;	// 8-bit samples

// Structure for holding information about a display device.
struct TIFFDisplay
{
	// XYZ -> luminance matrix
	float[3][3] d_mat;
	
	// Light o/p for reference white
	float d_YCR;
	float d_YCG;
	float d_YCB;
	
	// Pixel values for ref. white
	uint d_Vrwr;
	uint d_Vrwg;
	uint d_Vrwb;
	
	// Residual light for black pixel
	float d_Y0R;
	float d_Y0G;
	float d_Y0B;
	
	// Gamma values for the three guns
	float d_gammaR;
	float d_gammaG;
	float d_gammaB;
}

// YCbCr->RGB support
struct TIFFYCbCrToRGB
{
	TIFFRGBValue* clamptab;	// range clamping table
	int* Cr_r_tab;
	int* Cb_b_tab;
	int* Cr_g_tab;
	int* Cb_g_tab;
	int* Y_tab;
}

// CIE Lab 1976->RGB support
struct TIFFCIELabToRGB
{
	int range;									// Size of conversion table
	float rstep, gstep, bstep;
	float X0, Y0, Z0;							// Reference white point
	TIFFDisplay display;
	
	enum CIELABTORGB_TABLE_RANGE = 1500;
	float Yr2r[CIELABTORGB_TABLE_RANGE + 1];	// Conversion of Yr to r
	float Yg2g[CIELABTORGB_TABLE_RANGE + 1];	// Conversion of Yg to g
	float Yb2b[CIELABTORGB_TABLE_RANGE + 1];	// Conversion of Yb to b
}

// RGBA-style image support.
alias TIFFRGBAImage = _TIFFRGBAImage;

/*
 * The image reading and conversion routines invoke
 * ``put routines'' to copy/image/whatever tiles of
 * raw image data.  A default set of routines are 
 * provided to convert/copy raw image data to 8-bit
 * packed ABGR format rasters.  Applications can supply
 * alternate routines that unpack the data into a
 * different format or, for example, unpack the data
 * and draw the unpacked raster on the display.
 */

alias tileContigRoutine		= void function(TIFFRGBAImage*, uint*, uint, uint, uint, uint, int, int, ubyte*);
alias tileSeparateRoutine	= void function(TIFFRGBAImage*, uint*, uint, uint, uint, uint, int, int, ubyte*, ubyte*, ubyte*, ubyte*);

// RGBA-reader state
struct _TIFFRGBAImage
{
	TIFF* tif;					// image handle
	int stoponerr;				// stop on read error
	int isContig;				// data is packed/separate
	int alpha;					// type of alpha data present
	uint width;					// image width
	uint height;				// image height
	ushort bitspersample;		// image bits/sample
	ushort samplesperpixel;		// image samples/pixel
	ushort orientation;			// image orientation
	ushort req_orientation;		// requested orientation
	ushort photometric;			// image photometric interp
	ushort*	redcmap;			// colormap pallete
	ushort*	greencmap;
	ushort*	bluecmap;
	
	// get image data routine
	int function(TIFFRGBAImage*, uint*, uint, uint)	get;
	
	// put decoded strip/tile
	union _putUnion
	{
		void function(TIFFRGBAImage*) any;
		tileContigRoutine contig;
		tileSeparateRoutine separate;
	}
	_putUnion put;
	
	TIFFRGBValue* Map;			// sample mapping array
	uint** BWmap;				// black&white map
	uint** PALmap;				// palette image map
	TIFFYCbCrToRGB* ycbcr;		// YCbCr conversion state
	TIFFCIELabToRGB* cielab;	// CIE L*a*b conversion state
	
	ubyte* UaToAa;				// Unassociated alpha to associated alpha convertion LUT
	ubyte* Bitdepth16To8;		// LUT for conversion from 16bit to 8bit values
	
	int row_offset;
	int col_offset;
}

auto TIFFGetR(T)(T abgr) { return ((abgr) & 0xff); }
auto TIFFGetG(T)(T abgr) { return (((abgr) >> 8) & 0xff); }
auto TIFFGetB(T)(T abgr) { return (((abgr) >> 16) & 0xff); }
auto TIFFGetA(T)(T abgr) { return (((abgr) >> 24) & 0xff); }

/*
 * A CODEC is a software package that implements decoding,
 * encoding, or decoding+encoding of a compression algorithm.
 * The library provides a collection of builtin codecs.
 * More codecs may be registered through calls to the library
 * and/or the builtin implementations may be overridden.
 */

alias TIFFInitMethod = int function(TIFF*, int);

struct TIFFCodec
{
	char* name;
	ushort scheme;
	TIFFInitMethod init;
}

import core.stdc.stdio;
import core.stdc.stdarg;

alias TIFFErrorHandler		= void function(const char*, const char*, va_list);
alias TIFFErrorHandlerExt	= void function(thandle_t, const char*, const char*, va_list);
alias TIFFReadWriteProc		= tmsize_t function(thandle_t, void*, tmsize_t);
alias TIFFSeekProc			= toff_t function(thandle_t, toff_t, int);
alias TIFFCloseProc			= int function(thandle_t);
alias TIFFSizeProc			= toff_t function(thandle_t);
alias TIFFMapFileProc		= int function(thandle_t, void** base, toff_t* size);
alias TIFFUnmapFileProc		= void function(thandle_t, void* base, toff_t size);
alias TIFFExtendProc		= void function(TIFF*);

export const(char)*			TIFFGetVersion();
export const(TIFFCodec*)	TIFFFindCODEC(ushort);
export TIFFCodec*			TIFFRegisterCODEC(ushort, const char*, TIFFInitMethod);
export void					TIFFUnRegisterCODEC(TIFFCodec*);
export int					TIFFIsCODECConfigured(ushort);
export TIFFCodec*			TIFFGetConfiguredCODECs();

//Auxiliary functions.
export void*				_TIFFmalloc(tmsize_t s);
export void*				_TIFFrealloc(void* p, tmsize_t s);
export void					_TIFFmemset(void* p, int v, tmsize_t c);
export void					_TIFFmemcpy(void* d, const void* s, tmsize_t c);
export int					_TIFFmemcmp(const void* p1, const void* p2, tmsize_t c);
export void					_TIFFfree(void* p);

// Stuff, related to tag handling and creating custom tags.
export int 					TIFFGetTagListCount(TIFF*);
export uint					TIFFGetTagListEntry(TIFF*, int tag_index);

enum
{
	TIFF_ANY		= TIFF_NOTYPE,	// for field descriptor searching
	TIFF_VARIABLE	= -1,			// marker for variable length tags
	TIFF_SPP		= -2,			// marker for SamplesPerPixel tags
	TIFF_VARIABLE2	= -3,			// marker for uint32 var-length tags
	FIELD_CUSTOM 	= 65
}

struct TIFFField;
struct TIFFFieldArray;

export const(TIFFField)*	TIFFFindField(TIFF*, uint, TIFFDataType);
export const(TIFFField)*	TIFFFieldWithTag(TIFF*, uint);
export const(TIFFField)*	TIFFFieldWithName(TIFF*, const char*);

export uint 				TIFFFieldTag(const TIFFField*);
export const(char)*			TIFFFieldName(const TIFFField*);
export TIFFDataType			TIFFFieldDataType(const TIFFField*);
export int					TIFFFieldPassCount(const TIFFField*);
export int					TIFFFieldReadCount(const TIFFField*);
export int					TIFFFieldWriteCount(const TIFFField*);

alias TIFFVSetMethod		= int function(TIFF*, uint, va_list);
alias TIFFVGetMethod		= int function(TIFF*, uint, va_list);
alias TIFFPrintMethod		= void function(TIFF*, FILE*, long);

struct TIFFTagMethods
{
	TIFFVSetMethod vsetfield;	// tag set routine
	TIFFVGetMethod vgetfield;	// tag get routine
	TIFFPrintMethod printdir;	// directory print routine
}

export TIFFTagMethods*		TIFFAccessTagMethods(TIFF*);
export void*				TIFFGetClientInfo(TIFF*, const char*);
export void					TIFFSetClientInfo(TIFF*, void*, const char*);

export void					TIFFCleanup(TIFF* tif);
export void					TIFFClose(TIFF* tif);
export int					TIFFFlush(TIFF* tif);
export int					TIFFFlushData(TIFF* tif);
export int					TIFFGetField(TIFF* tif, uint tag, ...);
export int					TIFFVGetField(TIFF* tif, uint tag, va_list ap);
export int					TIFFGetFieldDefaulted(TIFF* tif, uint tag, ...);
export int					TIFFVGetFieldDefaulted(TIFF* tif, uint tag, va_list ap);
export int					TIFFReadDirectory(TIFF* tif);
export int					TIFFReadCustomDirectory(TIFF* tif, toff_t diroff, const TIFFFieldArray* infoarray);
export int					TIFFReadEXIFDirectory(TIFF* tif, toff_t diroff);
export ulong				TIFFScanlineSize64(TIFF* tif);
export tmsize_t				TIFFScanlineSize(TIFF* tif);
export ulong				TIFFRasterScanlineSize64(TIFF* tif);
export tmsize_t				TIFFRasterScanlineSize(TIFF* tif);
export ulong				TIFFStripSize64(TIFF* tif);
export tmsize_t				TIFFStripSize(TIFF* tif);
export ulong				TIFFRawStripSize64(TIFF* tif, uint strip);
export tmsize_t				TIFFRawStripSize(TIFF* tif, uint strip);
export ulong				TIFFVStripSize64(TIFF* tif, uint nrows);
export tmsize_t				TIFFVStripSize(TIFF* tif, uint nrows);
export ulong				TIFFTileRowSize64(TIFF* tif);
export tmsize_t				TIFFTileRowSize(TIFF* tif);
export ulong				TIFFTileSize64(TIFF* tif);
export tmsize_t				TIFFTileSize(TIFF* tif);
export ulong				TIFFVTileSize64(TIFF* tif, uint nrows);
export tmsize_t				TIFFVTileSize(TIFF* tif, uint nrows);
export uint					TIFFDefaultStripSize(TIFF* tif, uint request);
export void					TIFFDefaultTileSize(TIFF*, uint*, uint*);
export int					TIFFFileno(TIFF*);
export int					TIFFSetFileno(TIFF*, int);
export thandle_t			TIFFClientdata(TIFF*);
export thandle_t			TIFFSetClientdata(TIFF*, thandle_t);
export int					TIFFGetMode(TIFF*);
export int					TIFFSetMode(TIFF*, int);
export int					TIFFIsTiled(TIFF*);
export int					TIFFIsByteSwapped(TIFF*);
export int					TIFFIsUpSampled(TIFF*);
export int					TIFFIsMSB2LSB(TIFF*);
export int					TIFFIsBigEndian(TIFF*);
export TIFFReadWriteProc	TIFFGetReadProc(TIFF*);
export TIFFReadWriteProc	TIFFGetWriteProc(TIFF*);
export TIFFSeekProc			TIFFGetSeekProc(TIFF*);
export TIFFCloseProc		TIFFGetCloseProc(TIFF*);
export TIFFSizeProc			TIFFGetSizeProc(TIFF*);
export TIFFMapFileProc		TIFFGetMapFileProc(TIFF*);
export TIFFUnmapFileProc	TIFFGetUnmapFileProc(TIFF*);
export uint					TIFFCurrentRow(TIFF*);
export ushort				TIFFCurrentDirectory(TIFF*);
export ushort				TIFFNumberOfDirectories(TIFF*);
export ulong				TIFFCurrentDirOffset(TIFF*);
export uint					TIFFCurrentStrip(TIFF*);
export uint					TIFFCurrentTile(TIFF* tif);
export int					TIFFReadBufferSetup(TIFF* tif, void* bp, tmsize_t size);
export int					TIFFWriteBufferSetup(TIFF* tif, void* bp, tmsize_t size);  
export int					TIFFSetupStrips(TIFF*);
export int					TIFFWriteCheck(TIFF*, int, const char*);
export void					TIFFFreeDirectory(TIFF*);
export int					TIFFCreateDirectory(TIFF*);
export int					TIFFCreateCustomDirectory(TIFF*, const TIFFFieldArray*);
export int					TIFFCreateEXIFDirectory(TIFF*);
export int					TIFFLastDirectory(TIFF*);
export int					TIFFSetDirectory(TIFF*, ushort);
export int					TIFFSetSubDirectory(TIFF*, ulong);
export int					TIFFUnlinkDirectory(TIFF*, ushort);
export int					TIFFSetField(TIFF*, uint, ...);
export int					TIFFVSetField(TIFF*, uint, va_list);
export int					TIFFUnsetField(TIFF*, uint);
export int					TIFFWriteDirectory(TIFF*);
export int					TIFFWriteCustomDirectory(TIFF*, ulong*);
export int					TIFFCheckpointDirectory(TIFF*);
export int					TIFFRewriteDirectory(TIFF*);
export void					TIFFPrintDirectory(TIFF*, FILE*, long = 0);
export int					TIFFReadScanline(TIFF* tif, void* buf, uint row, ushort sample = 0);
export int					TIFFWriteScanline(TIFF* tif, void* buf, uint row, ushort sample = 0);
export int					TIFFReadRGBAImage(TIFF*, uint, uint, uint*, int = 0);
export int					TIFFReadRGBAImageOriented(TIFF*, uint, uint, uint*, int = ORIENTATION_BOTLEFT, int = 0);
export int					TIFFReadRGBAStrip(TIFF*, uint, uint*);
export int					TIFFReadRGBATile(TIFF*, uint, uint, uint*);
export int					TIFFRGBAImageOK(TIFF*, char[1024]);
export int					TIFFRGBAImageBegin(TIFFRGBAImage*, TIFF*, int, char[1024]);
export int					TIFFRGBAImageGet(TIFFRGBAImage*, uint*, uint, uint);
export void					TIFFRGBAImageEnd(TIFFRGBAImage*);
export TIFF*				TIFFOpen(const char*, const char*);
export TIFF*				TIFFOpenW(const wchar*, const char*);
export TIFF*				TIFFFdOpen(int, const char*, const char*);
export TIFF*				TIFFClientOpen(const char*, const char*, thandle_t, TIFFReadWriteProc, TIFFReadWriteProc, TIFFSeekProc, TIFFCloseProc, TIFFSizeProc, TIFFMapFileProc, TIFFUnmapFileProc);
export const(char)*			TIFFFileName(TIFF*);
export const(char)*			TIFFSetFileName(TIFF*, const char*);
export void					TIFFError(const char*, const char*, ...);
export void					TIFFErrorExt(thandle_t, const char*, const char*, ...);
export void					TIFFWarning(const char*, const char*, ...);
export void					TIFFWarningExt(thandle_t, const char*, const char*, ...);
export TIFFErrorHandler		TIFFSetErrorHandler(TIFFErrorHandler);
export TIFFErrorHandlerExt	TIFFSetErrorHandlerExt(TIFFErrorHandlerExt);
export TIFFErrorHandler		TIFFSetWarningHandler(TIFFErrorHandler);
export TIFFErrorHandlerExt	TIFFSetWarningHandlerExt(TIFFErrorHandlerExt);
export TIFFExtendProc		TIFFSetTagExtender(TIFFExtendProc);
export uint					TIFFComputeTile(TIFF* tif, uint x, uint y, uint z, ushort s);
export int					TIFFCheckTile(TIFF* tif, uint x, uint y, uint z, ushort s);
export uint					TIFFNumberOfTiles(TIFF*);
export tmsize_t				TIFFReadTile(TIFF* tif, void* buf, uint x, uint y, uint z, ushort s);  
export tmsize_t				TIFFWriteTile(TIFF* tif, void* buf, uint x, uint y, uint z, ushort s);
export uint					TIFFComputeStrip(TIFF*, uint, ushort);
export uint					TIFFNumberOfStrips(TIFF*);
export tmsize_t				TIFFReadEncodedStrip(TIFF* tif, uint strip, void* buf, tmsize_t size);
export tmsize_t				TIFFReadRawStrip(TIFF* tif, uint strip, void* buf, tmsize_t size);  
export tmsize_t				TIFFReadEncodedTile(TIFF* tif, uint tile, void* buf, tmsize_t size);  
export tmsize_t				TIFFReadRawTile(TIFF* tif, uint tile, void* buf, tmsize_t size);  
export tmsize_t				TIFFWriteEncodedStrip(TIFF* tif, uint strip, void* data, tmsize_t cc);
export tmsize_t				TIFFWriteRawStrip(TIFF* tif, uint strip, void* data, tmsize_t cc);  
export tmsize_t				TIFFWriteEncodedTile(TIFF* tif, uint tile, void* data, tmsize_t cc);  
export tmsize_t				TIFFWriteRawTile(TIFF* tif, uint tile, void* data, tmsize_t cc);  
export int					TIFFDataWidth(TIFFDataType);	// table of tag datatype widths
export void					TIFFSetWriteOffset(TIFF* tif, toff_t off);
export void					TIFFSwabShort(ushort*);
export void					TIFFSwabLong(uint*);
export void					TIFFSwabLong8(ulong*);
export void					TIFFSwabFloat(float*);
export void					TIFFSwabDouble(double*);
export void					TIFFSwabArrayOfShort(ushort* wp, tmsize_t n);
export void					TIFFSwabArrayOfTriples(ubyte* tp, tmsize_t n);
export void					TIFFSwabArrayOfLong(uint* lp, tmsize_t n);
export void					TIFFSwabArrayOfLong8(ulong* lp, tmsize_t n);
export void					TIFFSwabArrayOfFloat(float* fp, tmsize_t n);
export void					TIFFSwabArrayOfDouble(double* dp, tmsize_t n);
export void					TIFFReverseBits(ubyte* cp, tmsize_t n);
export const(ubyte)*		TIFFGetBitRevTable(int);

enum U_NEU					= 0.210526316;
enum V_NEU					= 0.473684211;
enum UVSCALE				= 410.0;

version = LOGLUV_PUBLIC;

export double				LogL16toY(int);
export double				LogL10toY(int);
export void					XYZtoRGB24(float*, ubyte*);
export int					uv_decode(double*, double*, int);
export void					LogLuv24toXYZ(uint, float*);
export void					LogLuv32toXYZ(uint, float*);
export int					LogL16fromY(double, int = SGILOGENCODE_NODITHER);
export int					LogL10fromY(double, int = SGILOGENCODE_NODITHER);
export int					uv_encode(double, double, int = SGILOGENCODE_NODITHER);
export uint					LogLuv24fromXYZ(float*, int = SGILOGENCODE_NODITHER);
export uint					LogLuv32fromXYZ(float*, int = SGILOGENCODE_NODITHER);

export int					TIFFCIELabToRGBInit(TIFFCIELabToRGB*, const TIFFDisplay*, float*);
export void					TIFFCIELabToXYZ(TIFFCIELabToRGB*, uint, int, int, float*, float*, float*);
export void					TIFFXYZToRGB(TIFFCIELabToRGB*, float, float, float, uint*, uint*, uint*);
export int					TIFFYCbCrToRGBInit(TIFFYCbCrToRGB*, float*, float*);
export void					TIFFYCbCrtoRGB(TIFFYCbCrToRGB*, uint, int, int, uint*, uint*, uint*);

/****************************************************************************
*               O B S O L E T E D    I N T E R F A C E S
*
* Don't use this stuff in your applications, it may be removed in the future
* libtiff versions.
****************************************************************************/

struct TIFFFieldInfo
{
	ttag_t	field_tag;			// field's tag
	short	field_readcount;	// read count/TIFF_VARIABLE/TIFF_SPP
	short	field_writecount;	// write count/TIFF_VARIABLE
	TIFFDataType field_type;	// type of associated data
	ushort field_bit;			// bit in fieldsset bit vector
	ubyte field_oktochange;		// if true, can change while writing
	ubyte field_passcount;		// if true, pass dir count on set
	char* field_name;			// ASCII name
}

export int TIFFMergeFieldInfo(TIFF*, const TIFFFieldInfo[], uint);
