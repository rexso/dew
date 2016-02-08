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

module dew.tiff.tiff;

extern(C):
public:
nothrow:

import dew.tiff.tiffconf;
alias uint16_vap = int;

enum
{
	TIFF_VERSION_CLASSIC	= 42,
	TIFF_VERSION_BIG		= 43,
	TIFF_BIGENDIAN			= 0x4d4d,
	TIFF_LITTLEENDIAN		= 0x4949,
	MDI_LITTLEENDIAN		= 0x5045,
	MDI_BIGENDIAN			= 0x4550,
}

// TIFF header
struct TIFFHeaderCommon
{
	ushort	tiff_magic;			// magic number (defines byte order)
	ushort	tiff_version;		// TIFF version number
}

struct TIFFHeaderClassic
{
	ushort	tiff_magic;			// magic number (defines byte order)
	ushort	tiff_version;		// TIFF version number
	uint	tiff_diroff;		// byte offset to first directory
}

struct TIFFHeaderBig
{
	ushort	tiff_magic;			// magic number (defines byte order)
	ushort	tiff_version;		// TIFF version number
	ushort	tiff_offsetsize;	// size of offsets, should be 8
	ushort	tiff_unused;		// unused word, should be 0
	ulong	tiff_diroff;		// byte offset to first directory
}

alias TIFFDataType = int;
enum
{
	TIFF_NOTYPE		= 0,		// placeholder
	TIFF_BYTE		= 1,		// 8-bit unsigned integer
	TIFF_ASCII		= 2,		// 8-bit bytes w/ last byte null
	TIFF_SHORT		= 3,		// 16-bit unsigned integer
	TIFF_LONG		= 4,		// 32-bit unsigned integer
	TIFF_RATIONAL	= 5,		// 64-bit unsigned fraction
	TIFF_SBYTE		= 6,		// !8-bit signed integer
	TIFF_UNDEFINED	= 7,		// !8-bit untyped data
	TIFF_SSHORT		= 8,		// !16-bit signed integer
	TIFF_SLONG		= 9,		// !32-bit signed integer
	TIFF_SRATIONAL	= 10,		// !64-bit signed fraction
	TIFF_FLOAT		= 11,		// !32-bit IEEE floating point
	TIFF_DOUBLE		= 12,		// !64-bit IEEE floating point
	TIFF_IFD		= 13,		// %32-bit unsigned integer (offset)
	TIFF_LONG8		= 16,		// BigTIFF 64-bit unsigned integer
	TIFF_SLONG8		= 17,		// BigTIFF 64-bit signed integer
	TIFF_IFD8		= 18		// BigTIFF 64-bit unsigned integer (offset)
}

// TIFF Tag Definitions
enum
{
	TIFFTAG_SUBFILETYPE					= 254,		// subfile data descriptor
		FILETYPE_REDUCEDIMAGE			= 0x1,		// reduced resolution version
		FILETYPE_PAGE					= 0x2,		// one page of many
		FILETYPE_MASK					= 0x4,		// transparency mask
	TIFFTAG_OSUBFILETYPE				= 255,		// +kind of data in subfile
		OFILETYPE_IMAGE					= 1,		// full resolution image data
		OFILETYPE_REDUCEDIMAGE			= 2,		// reduced size image data
		OFILETYPE_PAGE					= 3,		// one page of many
	TIFFTAG_IMAGEWIDTH					= 256,		// image width in pixels
	TIFFTAG_IMAGELENGTH					= 257,		// image height in pixels
	TIFFTAG_BITSPERSAMPLE				= 258,		// bits per channel (sample)
	TIFFTAG_COMPRESSION					= 259,		// data compression technique
		COMPRESSION_NONE				= 1,		// dump mode
		COMPRESSION_CCITTRLE			= 2,		// CCITT modified Huffman RLE
		COMPRESSION_CCITTFAX3			= 3,		// CCITT Group 3 fax encoding
		COMPRESSION_CCITT_T4			= 3,		// CCITT T.4 (TIFF 6 name)
		COMPRESSION_CCITTFAX4			= 4,		// CCITT Group 4 fax encoding
		COMPRESSION_CCITT_T6			= 4,		// CCITT T.6 (TIFF 6 name)
		COMPRESSION_LZW					= 5,		// Lempel-Ziv  & Welch
		COMPRESSION_OJPEG				= 6,		// !6.0 JPEG
		COMPRESSION_JPEG				= 7,		// %JPEG DCT compression
		COMPRESSION_T85					= 9,		// !TIFF/FX T.85 JBIG compression
		COMPRESSION_T43					= 10,		// !TIFF/FX T.43 colour by layered JBIG compression
		COMPRESSION_NEXT				= 32766,	// NeXT 2-bit RLE
		COMPRESSION_CCITTRLEW			= 32771,	// #1 w/ word alignment
		COMPRESSION_PACKBITS			= 32773,	// Macintosh RLE
		COMPRESSION_THUNDERSCAN			= 32809,	// ThunderScan RLE
		// codes 32895-32898 are reserved for ANSI IT8 TIFF/IT <dkelly@apago.com)
		COMPRESSION_IT8CTPAD			= 32895,	// IT8 CT w/padding
		COMPRESSION_IT8LW				= 32896,	// IT8 Linework RLE
		COMPRESSION_IT8MP				= 32897,	// IT8 Monochrome picture
		COMPRESSION_IT8BL				= 32898,	// IT8 Binary line art
		// compression codes 32908-32911 are reserved for Pixar
		COMPRESSION_PIXARFILM			= 32908,	// Pixar companded 10bit LZW
		COMPRESSION_PIXARLOG			= 32909,	// Pixar companded 11bit ZIP
		COMPRESSION_DEFLATE				= 32946,	// Deflate compression
		COMPRESSION_ADOBE_DEFLATE		= 8,		// Deflate compression as recognized by Adobe
		// compression code 32947 is reserved for Oceana Matrix <dev@oceana.com>
		COMPRESSION_DCS					= 32947,	// Kodak DCS encoding
		COMPRESSION_JBIG				= 34661,	// ISO JBIG
		COMPRESSION_SGILOG				= 34676,	// SGI Log Luminance RLE
		COMPRESSION_SGILOG24			= 34677,	// SGI Log 24-bit packed
		COMPRESSION_JP2000				= 34712,	// Leadtools JPEG2000
		COMPRESSION_LZMA				= 34925,	// LZMA2
	TIFFTAG_PHOTOMETRIC					= 262,		// photometric interpretation
		PHOTOMETRIC_MINISWHITE			= 0,		// min value is white
		PHOTOMETRIC_MINISBLACK			= 1,		// min value is black
		PHOTOMETRIC_RGB					= 2,		// RGB color model
		PHOTOMETRIC_PALETTE				= 3,		// color map indexed
		PHOTOMETRIC_MASK				= 4,		// $holdout mask
		PHOTOMETRIC_SEPARATED			= 5,		// !color separations
		PHOTOMETRIC_YCBCR				= 6,		// !CCIR 601
		PHOTOMETRIC_CIELAB				= 8,		// !1976 CIE L*a*b*
		PHOTOMETRIC_ICCLAB				= 9,		// ICC L*a*b* [Adobe TIFF Technote 4]
		PHOTOMETRIC_ITULAB				= 10,		// ITU L*a*b*
		PHOTOMETRIC_CFA					= 32803,	// color filter array
		PHOTOMETRIC_LOGL				= 32844,	// CIE Log2(L)
		PHOTOMETRIC_LOGLUV				= 32845,	// CIE Log2(L) (u',v')
	TIFFTAG_THRESHHOLDING				= 263,		// +thresholding used on data
		THRESHHOLD_BILEVEL				= 1,		// b&w art scan
		THRESHHOLD_HALFTONE				= 2,		// or dithered scan
		THRESHHOLD_ERRORDIFFUSE			= 3,		// usually floyd-steinberg
	TIFFTAG_CELLWIDTH					= 264,		// +dithering matrix width
	TIFFTAG_CELLLENGTH					= 265,		// +dithering matrix height
	TIFFTAG_FILLORDER					= 266,		// data order within a byte
		FILLORDER_MSB2LSB				= 1,		// most significant -> least
		FILLORDER_LSB2MSB				= 2,		// least significant -> most
	TIFFTAG_DOCUMENTNAME				= 269,		// name of doc. image is from
	TIFFTAG_IMAGEDESCRIPTION			= 270,		// info about image
	TIFFTAG_MAKE						= 271,		// scanner manufacturer name
	TIFFTAG_MODEL						= 272,		// scanner model name/number
	TIFFTAG_STRIPOFFSETS				= 273,		// offsets to data strips
	TIFFTAG_ORIENTATION					= 274,		// +image orientation
		ORIENTATION_TOPLEFT				= 1,		// row 0 top, col 0 lhs
		ORIENTATION_TOPRIGHT			= 2,		// row 0 top, col 0 rhs
		ORIENTATION_BOTRIGHT			= 3,		// row 0 bottom, col 0 rhs
		ORIENTATION_BOTLEFT				= 4,		// row 0 bottom, col 0 lhs
		ORIENTATION_LEFTTOP				= 5,		// row 0 lhs, col 0 top
		ORIENTATION_RIGHTTOP			= 6,		// row 0 rhs, col 0 top
		ORIENTATION_RIGHTBOT			= 7,		// row 0 rhs, col 0 bottom
		ORIENTATION_LEFTBOT				= 8,		// row 0 lhs, col 0 bottom
	TIFFTAG_SAMPLESPERPIXEL				= 277,		// samples per pixel
	TIFFTAG_ROWSPERSTRIP				= 278,		// rows per strip of data
	TIFFTAG_STRIPBYTECOUNTS				= 279,		// bytes counts for strips
	TIFFTAG_MINSAMPLEVALUE				= 280,		// +minimum sample value
	TIFFTAG_MAXSAMPLEVALUE				= 281,		// +maximum sample value
	TIFFTAG_XRESOLUTION					= 282,		// pixels/resolution in x
	TIFFTAG_YRESOLUTION					= 283,		// pixels/resolution in y
	TIFFTAG_PLANARCONFIG				= 284,		// storage organization
		PLANARCONFIG_CONTIG				= 1,		// single image plane
		PLANARCONFIG_SEPARATE			= 2,		// separate planes of data
	TIFFTAG_PAGENAME					= 285,		// page name image is from
	TIFFTAG_XPOSITION					= 286,		// x page offset of image lhs
	TIFFTAG_YPOSITION					= 287,		// y page offset of image lhs
	TIFFTAG_FREEOFFSETS					= 288,		// +byte offset to free block
	TIFFTAG_FREEBYTECOUNTS				= 289,		// +sizes of free blocks
	TIFFTAG_GRAYRESPONSEUNIT			= 290,		// $gray scale curve accuracy
		GRAYRESPONSEUNIT_10S			= 1,		// tenths of a unit
		GRAYRESPONSEUNIT_100S			= 2,		// hundredths of a unit
		GRAYRESPONSEUNIT_1000S			= 3,		// thousandths of a unit
		GRAYRESPONSEUNIT_10000S			= 4,		// ten-thousandths of a unit
		GRAYRESPONSEUNIT_100000S		= 5,		// hundred-thousandths
	TIFFTAG_GRAYRESPONSECURVE			= 291,		// $gray scale response curve
	TIFFTAG_GROUP3OPTIONS				= 292,		// 32 flag bits
	TIFFTAG_T4OPTIONS					= 292,		// TIFF 6.0 proper name alias
		GROUP3OPT_2DENCODING			= 0x1,		// 2-dimensional coding
		GROUP3OPT_UNCOMPRESSED			= 0x2,		// data not compressed
		GROUP3OPT_FILLBITS				= 0x4,		// fill to byte boundary
	TIFFTAG_GROUP4OPTIONS				= 293,		// 32 flag bits
	TIFFTAG_T6OPTIONS					= 293,		// TIFF 6.0 proper name
		GROUP4OPT_UNCOMPRESSED			= 0x2,		// data not compressed
	TIFFTAG_RESOLUTIONUNIT				= 296,		// units of resolutions
		RESUNIT_NONE					= 1,		// no meaningful units
		RESUNIT_INCH					= 2,		// english
		RESUNIT_CENTIMETER				= 3,		// metric
	TIFFTAG_PAGENUMBER					= 297,		// page numbers of multi-page
	TIFFTAG_COLORRESPONSEUNIT			= 300,		// $color curve accuracy
		COLORRESPONSEUNIT_10S			= 1,		// tenths of a unit
		COLORRESPONSEUNIT_100S			= 2,		// hundredths of a unit
		COLORRESPONSEUNIT_1000S			= 3,		// thousandths of a unit
		COLORRESPONSEUNIT_10000S		= 4,		// ten-thousandths of a unit
		COLORRESPONSEUNIT_100000S		= 5,		// hundred-thousandths
	TIFFTAG_TRANSFERFUNCTION			= 301,		// !colorimetry info
	TIFFTAG_SOFTWARE					= 305,		// name & release
	TIFFTAG_DATETIME					= 306,		// creation date and time
	TIFFTAG_ARTIST						= 315,		// creator of image
	TIFFTAG_HOSTCOMPUTER				= 316,		// machine where created
	TIFFTAG_PREDICTOR					= 317,		// prediction scheme w/ LZW
		PREDICTOR_NONE					= 1,		// no prediction scheme used
		PREDICTOR_HORIZONTAL			= 2,		// horizontal differencing
		PREDICTOR_FLOATINGPOINT			= 3,		// floating point predictor
	TIFFTAG_WHITEPOINT					= 318,		// image white point
	TIFFTAG_PRIMARYCHROMATICITIES		= 319,		// !primary chromaticities
	TIFFTAG_COLORMAP					= 320,		// RGB map for pallette image
	TIFFTAG_HALFTONEHINTS				= 321,		// !highlight+shadow info
	TIFFTAG_TILEWIDTH					= 322,		// !tile width in pixels
	TIFFTAG_TILELENGTH					= 323,		// !tile height in pixels
	TIFFTAG_TILEOFFSETS					= 324,		// !offsets to data tiles
	TIFFTAG_TILEBYTECOUNTS				= 325,		// !byte counts for tiles
	TIFFTAG_BADFAXLINES					= 326,		// lines w/ wrong pixel count
	TIFFTAG_CLEANFAXDATA				= 327,		// regenerated line info
		CLEANFAXDATA_CLEAN				= 0,		// no errors detected
		CLEANFAXDATA_REGENERATED		= 1,		// receiver regenerated lines
		CLEANFAXDATA_UNCLEAN			= 2,		// uncorrected errors exist
	TIFFTAG_CONSECUTIVEBADFAXLINES		= 328,		// max consecutive bad lines
	TIFFTAG_SUBIFD						= 330,		// subimage descriptors
	TIFFTAG_INKSET						= 332,		// !inks in separated image
		INKSET_CMYK						= 1,		// !cyan-magenta-yellow-black color
		INKSET_MULTIINK					= 2,		// !multi-ink or hi-fi color
	TIFFTAG_INKNAMES					= 333,		// !ascii names of inks
	TIFFTAG_NUMBEROFINKS				= 334,		// !number of inks
	TIFFTAG_DOTRANGE					= 336,		// !0% and 100% dot codes
	TIFFTAG_TARGETPRINTER				= 337,		// !separation target
	TIFFTAG_EXTRASAMPLES				= 338,		// !info about extra samples
		EXTRASAMPLE_UNSPECIFIED			= 0,		// !unspecified data
		EXTRASAMPLE_ASSOCALPHA			= 1,		// !associated alpha data
		EXTRASAMPLE_UNASSALPHA			= 2,		// !unassociated alpha data
	TIFFTAG_SAMPLEFORMAT				= 339,		// !data sample format
		SAMPLEFORMAT_UINT				= 1,		// !unsigned integer data
		SAMPLEFORMAT_INT				= 2,		// !signed integer data
		SAMPLEFORMAT_IEEEFP				= 3,		// !IEEE floating point data
		SAMPLEFORMAT_VOID				= 4,		// !untyped data
		SAMPLEFORMAT_COMPLEXINT			= 5,		// !complex signed int
		SAMPLEFORMAT_COMPLEXIEEEFP		= 6,		// !complex ieee floating
	TIFFTAG_SMINSAMPLEVALUE				= 340,		// !variable MinSampleValue
	TIFFTAG_SMAXSAMPLEVALUE				= 341,		// !variable MaxSampleValue
	TIFFTAG_CLIPPATH					= 343,		// %ClipPath [Adobe TIFF technote 2]
	TIFFTAG_XCLIPPATHUNITS				= 344,		// %XClipPathUnits [Adobe TIFF technote 2]
	TIFFTAG_YCLIPPATHUNITS				= 345,		// %YClipPathUnits [Adobe TIFF technote 2]
	TIFFTAG_INDEXED						= 346,		// %Indexed [Adobe TIFF Technote 3]
	TIFFTAG_JPEGTABLES					= 347,		// %JPEG table stream
	TIFFTAG_OPIPROXY					= 351,		// %OPI Proxy [Adobe TIFF technote]
	// Tags 400-435 are from the TIFF/FX spec
	TIFFTAG_GLOBALPARAMETERSIFD			= 400,		// !
	TIFFTAG_PROFILETYPE					= 401,		// !
		PROFILETYPE_UNSPECIFIED			= 0,		// !
		PROFILETYPE_G3_FAX				= 1,		// !
	TIFFTAG_FAXPROFILE					= 402,		// !
		FAXPROFILE_S					= 1,		// !TIFF/FX FAX profile S
		FAXPROFILE_F					= 2,		// !TIFF/FX FAX profile F
		FAXPROFILE_J					= 3,		// !TIFF/FX FAX profile J
		FAXPROFILE_C					= 4,		// !TIFF/FX FAX profile C
		FAXPROFILE_L					= 5,		// !TIFF/FX FAX profile L
		FAXPROFILE_M					= 6,		// !TIFF/FX FAX profile LM
	TIFFTAG_CODINGMETHODS				= 403,		// !TIFF/FX coding methods
		CODINGMETHODS_T4_1D				= (1 << 1),	// !T.4 1D
		CODINGMETHODS_T4_2D				= (1 << 2),	// !T.4 2D
		CODINGMETHODS_T6				= (1 << 3),	// !T.6
		CODINGMETHODS_T85 				= (1 << 4),	// !T.85 JBIG
		CODINGMETHODS_T42 				= (1 << 5),	// !T.42 JPEG
		CODINGMETHODS_T43				= (1 << 6),	// !T.43 colour by layered JBIG
	TIFFTAG_VERSIONYEAR					= 404,		// !TIFF/FX version year
	TIFFTAG_MODENUMBER					= 405,		// !TIFF/FX mode number
	TIFFTAG_DECODE						= 433,		// !TIFF/FX decode
	TIFFTAG_IMAGEBASECOLOR				= 434,		// !TIFF/FX image base colour
	TIFFTAG_T82OPTIONS					= 435,		// !TIFF/FX T.82 options
	// Tags 512-521 are obsoleted by Technical Note #2 which specifies a revised JPEG-in-TIFF scheme
	TIFFTAG_JPEGPROC					= 512,		// !JPEG processing algorithm
		JPEGPROC_BASELINE				= 1,		// !baseline sequential
		JPEGPROC_LOSSLESS				= 14,		// !Huffman coded lossless
	TIFFTAG_JPEGIFOFFSET				= 513,		// !pointer to SOI marker
	TIFFTAG_JPEGIFBYTECOUNT				= 514,		// !JFIF stream length
	TIFFTAG_JPEGRESTARTINTERVAL			= 515,		// !restart interval length
	TIFFTAG_JPEGLOSSLESSPREDICTORS		= 517,		// !lossless proc predictor
	TIFFTAG_JPEGPOINTTRANSFORM			= 518,		// !lossless point transform
	TIFFTAG_JPEGQTABLES					= 519,		// !Q matrice offsets
	TIFFTAG_JPEGDCTABLES				= 520,		// !DCT table offsets
	TIFFTAG_JPEGACTABLES				= 521,		// !AC coefficient offsets
	TIFFTAG_YCBCRCOEFFICIENTS			= 529,		// !RGB -> YCbCr transform
	TIFFTAG_YCBCRSUBSAMPLING			= 530,		// !YCbCr subsampling factors
	TIFFTAG_YCBCRPOSITIONING			= 531,		// !subsample positioning
		YCBCRPOSITION_CENTERED			= 1,		// !as in PostScript Level 2
		YCBCRPOSITION_COSITED			= 2,		// !as in CCIR 601-1
	TIFFTAG_REFERENCEBLACKWHITE			= 532,		// !colorimetry info
	TIFFTAG_STRIPROWCOUNTS				= 559,		// !TIFF/FX strip row counts
	TIFFTAG_XMLPACKET					= 700,		// %XML packet [Adobe XMP Specification, January 2004]
	TIFFTAG_OPIIMAGEID					= 32781,	// %OPI ImageID [Adobe TIFF technote]
	// Tags 32952-32956 are private tags registered to Island Graphics
	TIFFTAG_REFPTS						= 32953,	// image reference points
	TIFFTAG_REGIONTACKPOINT				= 32954,	// region-xform tack point
	TIFFTAG_REGIONWARPCORNERS			= 32955,	// warp quadrilateral
	TIFFTAG_REGIONAFFINE				= 32956,	// affine transformation mat
	// Tags 32995-32999 are private tags registered to SGI
	TIFFTAG_MATTEING					= 32995,	// $use ExtraSamples
	TIFFTAG_DATATYPE					= 32996,	// $use SampleFormat
	TIFFTAG_IMAGEDEPTH					= 32997,	// z depth of image
	TIFFTAG_TILEDEPTH					= 32998,	// z depth/data tile
	// Tags 33300-33309 are private tags registered to Pixar
	
	/*
	 * TIFFTAG_PIXAR_IMAGEFULLWIDTH and TIFFTAG_PIXAR_IMAGEFULLLENGTH
	 * are set when an image has been cropped out of a larger image.  
	 * They reflect the size of the original uncropped image.
	 * The TIFFTAG_XPOSITION and TIFFTAG_YPOSITION can be used
	 * to determine the position of the smaller image in the larger one.
	 */
	
	TIFFTAG_PIXAR_IMAGEFULLWIDTH    	= 33300,	// full image size in x
	TIFFTAG_PIXAR_IMAGEFULLLENGTH   	= 33301,	// full image size in y
	
	// Tags 33302-33306 are used to identify special image modes and data used by Pixar's texture formats.
	TIFFTAG_PIXAR_TEXTUREFORMAT			= 33302,	// texture map format
	TIFFTAG_PIXAR_WRAPMODES				= 33303,	// s & t wrap modes
	TIFFTAG_PIXAR_FOVCOT				= 33304,	// cotan(fov) for env. maps
	TIFFTAG_PIXAR_MATRIX_WORLDTOSCREEN	= 33305,
	TIFFTAG_PIXAR_MATRIX_WORLDTOCAMERA	= 33306,
	TIFFTAG_WRITERSERIALNUMBER      	= 33405,	// device serial number, private tag registered to Eastman Kodak
	TIFFTAG_CFAREPEATPATTERNDIM			= 33421,	// dimensions of CFA pattern
	TIFFTAG_CFAPATTERN					= 33422,	// color filter array pattern
	TIFFTAG_COPYRIGHT					= 33432,	// copyright string, listed in the 6.0 spec w/ unknown ownership
	TIFFTAG_RICHTIFFIPTC				= 33723,	// IPTC TAG from RichTIFF specifications
	// Tags 34016-34029 are reserved for ANSI IT8 TIFF/IT <dkelly@apago.com>
	TIFFTAG_IT8SITE						= 34016,	// site name
	TIFFTAG_IT8COLORSEQUENCE			= 34017,	// color seq. [RGB,CMYK,etc]
	TIFFTAG_IT8HEADER					= 34018,	// DDES Header
	TIFFTAG_IT8RASTERPADDING			= 34019,	// raster scanline padding
	TIFFTAG_IT8BITSPERRUNLENGTH			= 34020,	// # of bits in short run
	TIFFTAG_IT8BITSPEREXTENDEDRUNLENGTH = 34021,	// # of bits in long run
	TIFFTAG_IT8COLORTABLE				= 34022,	// LW colortable
	TIFFTAG_IT8IMAGECOLORINDICATOR		= 34023,	// BP/BL image color switch
	TIFFTAG_IT8BKGCOLORINDICATOR		= 34024,	// BP/BL bg color switch
	TIFFTAG_IT8IMAGECOLORVALUE			= 34025,	// BP/BL image color value
	TIFFTAG_IT8BKGCOLORVALUE			= 34026,	// BP/BL bg color value
	TIFFTAG_IT8PIXELINTENSITYRANGE		= 34027,	// MP pixel intensity value
	TIFFTAG_IT8TRANSPARENCYINDICATOR 	= 34028,	// HC transparency switch
	TIFFTAG_IT8COLORCHARACTERIZATION 	= 34029,	// color character. table
	TIFFTAG_IT8HCUSAGE					= 34030,	// HC usage indicator
	TIFFTAG_IT8TRAPINDICATOR			= 34031,	// Trapping indicator (untrapped=0, trapped=1)
	TIFFTAG_IT8CMYKEQUIVALENT			= 34032,	// CMYK color equivalents
	// Tags 34232-34236 are private tags registered to Texas Instruments
	TIFFTAG_FRAMECOUNT					= 34232,	// Sequence Frame Count
	TIFFTAG_PHOTOSHOP					= 34377,	// private tag registered to Adobe for PhotoShop
	// Tags 34665, 34853 and 40965 are documented in EXIF specification
	TIFFTAG_EXIFIFD						= 34665,	// Pointer to EXIF private directory
	TIFFTAG_ICCPROFILE					= 34675,	// ICC profile data
	TIFFTAG_IMAGELAYER					= 34732,	// !TIFF/FX image layer information
	TIFFTAG_JBIGOPTIONS					= 34750,	// JBIG options, private tag registered to Pixel Magic
	TIFFTAG_GPSIFD						= 34853,	// Pointer to GPS private directory
	// Tags 34908-34914 are private tags registered to SGI
	TIFFTAG_FAXRECVPARAMS				= 34908,	// encoded Class 2 ses. parms
	TIFFTAG_FAXSUBADDRESS				= 34909,	// received SubAddr string
	TIFFTAG_FAXRECVTIME					= 34910,	// receive time (secs)
	TIFFTAG_FAXDCS						= 34911,	// encoded fax ses. params, Table 2/T.30
	// Tags 37439-37443 are registered to SGI <gregl@sgi.com>
	TIFFTAG_STONITS						= 37439,	// Sample value to Nits
	TIFFTAG_FEDEX_EDR					= 34929,	// unknown use, private tag registered to FedEx
	TIFFTAG_INTEROPERABILITYIFD			= 40965,	// Pointer to Interoperability private directory
	// Adobe Digital Negative (DNG) format tags
	TIFFTAG_DNGVERSION					= 50706,	// &DNG version number
	TIFFTAG_DNGBACKWARDVERSION			= 50707,	// &DNG compatibility version
	TIFFTAG_UNIQUECAMERAMODEL			= 50708,	// &name for the camera model
	TIFFTAG_LOCALIZEDCAMERAMODEL		= 50709,	// &localized camera model name
	TIFFTAG_CFAPLANECOLOR				= 50710,	// &CFAPattern->LinearRaw space mapping
	TIFFTAG_CFALAYOUT					= 50711,	// &spatial layout of the CFA
	TIFFTAG_LINEARIZATIONTABLE			= 50712,	// &lookup table description
	TIFFTAG_BLACKLEVELREPEATDIM			= 50713,	// &repeat pattern size for the BlackLevel tag
	TIFFTAG_BLACKLEVEL					= 50714,	// &zero light encoding level
	TIFFTAG_BLACKLEVELDELTAH			= 50715,	// &zero light encoding level differences (columns)
	TIFFTAG_BLACKLEVELDELTAV			= 50716,	// &zero light encoding level differences (rows)
	TIFFTAG_WHITELEVEL					= 50717,	// &fully saturated encoding level
	TIFFTAG_DEFAULTSCALE				= 50718,	// &default scale factors
	TIFFTAG_DEFAULTCROPORIGIN			= 50719,	// &origin of the final image area
	TIFFTAG_DEFAULTCROPSIZE				= 50720,	// &size of the final image  area
	TIFFTAG_COLORMATRIX1				= 50721,	// &XYZ->reference color space transformation matrix 1
	TIFFTAG_COLORMATRIX2				= 50722,	// &XYZ->reference color space transformation matrix 2
	TIFFTAG_CAMERACALIBRATION1			= 50723,	// &calibration matrix 1
	TIFFTAG_CAMERACALIBRATION2			= 50724,	// &calibration matrix 2
	TIFFTAG_REDUCTIONMATRIX1			= 50725,	// &dimensionality reduction matrix 1
	TIFFTAG_REDUCTIONMATRIX2			= 50726,	// &dimensionality reduction matrix 2
	TIFFTAG_ANALOGBALANCE				= 50727,	// &gain applied the stored raw values
	TIFFTAG_ASSHOTNEUTRAL				= 50728,	// &selected white balance in linear reference space
	TIFFTAG_ASSHOTWHITEXY				= 50729,	// &selected white balance in x-y chromaticity coordinates
	TIFFTAG_BASELINEEXPOSURE			= 50730,	// &how much to move the zero point
	TIFFTAG_BASELINENOISE				= 50731,	// &relative noise level
	TIFFTAG_BASELINESHARPNESS			= 50732,	// &relative amount of sharpening
	TIFFTAG_BAYERGREENSPLIT				= 50733,	// &how closely the values of the green pixels in the blue/green rows track the values of the green pixels in the red/green rows
	TIFFTAG_LINEARRESPONSELIMIT			= 50734,	// &non-linear encoding range
	TIFFTAG_CAMERASERIALNUMBER			= 50735,	// &camera's serial number
	TIFFTAG_LENSINFO					= 50736,	// info about the lens
	TIFFTAG_CHROMABLURRADIUS			= 50737,	// &chroma blur radius
	TIFFTAG_ANTIALIASSTRENGTH			= 50738,	// &relative strength of the camera's anti-alias filter
	TIFFTAG_SHADOWSCALE					= 50739,	// &used by Adobe Camera Raw
	TIFFTAG_DNGPRIVATEDATA				= 50740,	// &manufacturer's private data
	TIFFTAG_MAKERNOTESAFETY				= 50741,	// &whether the EXIF MakerNote tag is safe to preserve along with the rest of the EXIF data
	TIFFTAG_CALIBRATIONILLUMINANT1		= 50778,	// &illuminant 1
	TIFFTAG_CALIBRATIONILLUMINANT2		= 50779,	// &illuminant 2
	TIFFTAG_BESTQUALITYSCALE			= 50780,	// &best quality multiplier
	TIFFTAG_RAWDATAUNIQUEID				= 50781,	// &unique identifier for the raw image data
	TIFFTAG_ORIGINALRAWFILENAME			= 50827,	// &file name of the original raw file
	TIFFTAG_ORIGINALRAWFILEDATA			= 50828,	// &contents of the original raw file
	TIFFTAG_ACTIVEAREA					= 50829,	// &active (non-masked) pixels of the sensor
	TIFFTAG_MASKEDAREAS					= 50830,	// &list of coordinates of fully masked pixels
	TIFFTAG_ASSHOTICCPROFILE			= 50831,	// &these two tags used to
	TIFFTAG_ASSHOTPREPROFILEMATRIX		= 50832,	// map cameras's color space into ICC profile space
	TIFFTAG_CURRENTICCPROFILE			= 50833,	// &
	TIFFTAG_CURRENTPREPROFILEMATRIX		= 50834,	// &
	TIFFTAG_DCSHUESHIFTVALUES			= 65535,	// hue shift correction data, used by Eastman Kodak
	
	/*
	 * The following are ``pseudo tags'' that can be used to control
	 * codec-specific functionality.  These tags are not written to file.
	 * Note that these values start at 0xffff+1 so that they'll never
	 * collide with Aldus-assigned tags.
	 *
	 * If you want your private pseudo tags ``registered'' (i.e. added to
	 * this file), please post a bug report via the tracking system at
	 * http://www.remotesensing.org/libtiff/bugs.html with the appropriate
	 * C definitions to add.
	 */
	
	TIFFTAG_FAXMODE						= 65536,	// Group 3/4 format control
		FAXMODE_CLASSIC					= 0x0000,	// default, include RTC
		FAXMODE_NORTC					= 0x0001,	// no RTC at end of data
		FAXMODE_NOEOL					= 0x0002,	// no EOL code at end of row
		FAXMODE_BYTEALIGN				= 0x0004,	// byte align row
		FAXMODE_WORDALIGN				= 0x0008,	// word align row
		FAXMODE_CLASSF					= FAXMODE_NORTC, // TIFF Class F
	TIFFTAG_JPEGQUALITY					= 65537,	// Compression quality level, on the IJG 0-100 scale. Default value is 75
	TIFFTAG_JPEGCOLORMODE				= 65538,	// Auto RGB<=>YCbCr convert?
		JPEGCOLORMODE_RAW				= 0x0000,	// no conversion (default)
		JPEGCOLORMODE_RGB				= 0x0001,	// do auto conversion
	TIFFTAG_JPEGTABLESMODE				= 65539,	// What to put in JPEGTables. Default value is JPEGTABLESMODE_QUANT | JPEGTABLESMODE_HUFF
		JPEGTABLESMODE_QUANT			= 0x0001,	// include quantization tbls
		JPEGTABLESMODE_HUFF				= 0x0002,	// include Huffman tbls
	TIFFTAG_FAXFILLFUNC					= 65540,	// G3/G4 fill function
	TIFFTAG_PIXARLOGDATAFMT				= 65549,	// PixarLogCodec I/O data sz
		PIXARLOGDATAFMT_8BIT			= 0,		// regular u_char samples
		PIXARLOGDATAFMT_8BITABGR		= 1,		// ABGR-order u_chars
		PIXARLOGDATAFMT_11BITLOG		= 2,		// 11-bit log-encoded (raw)
		PIXARLOGDATAFMT_12BITPICIO		= 3,		// as per PICIO (1.0==2048)
		PIXARLOGDATAFMT_16BIT			= 4,		// signed short samples
		PIXARLOGDATAFMT_FLOAT			= 5,		// IEEE float samples
	// 65550-65556 are allocated to Oceana Matrix <dev@oceana.com>
	TIFFTAG_DCSIMAGERTYPE				= 65550,	// imager model & filter
		DCSIMAGERMODEL_M3				= 0,		// M3 chip (1280 x 1024)
		DCSIMAGERMODEL_M5				= 1,		// M5 chip (1536 x 1024)
		DCSIMAGERMODEL_M6				= 2,		// M6 chip (3072 x 2048)
		DCSIMAGERFILTER_IR				= 0,		// infrared filter
		DCSIMAGERFILTER_MONO			= 1,		// monochrome filter
		DCSIMAGERFILTER_CFA				= 2,		// color filter array
		DCSIMAGERFILTER_OTHER			= 3,		// other filter
	TIFFTAG_DCSINTERPMODE				= 65551,	// interpolation mode
		DCSINTERPMODE_NORMAL			= 0x0,		// whole image, default
		DCSINTERPMODE_PREVIEW			= 0x1,		// preview of image (384x256)
	TIFFTAG_DCSBALANCEARRAY				= 65552,	// color balance values
	TIFFTAG_DCSCORRECTMATRIX			= 65553,	// color correction values
	TIFFTAG_DCSGAMMA					= 65554,	// gamma value
	TIFFTAG_DCSTOESHOULDERPTS			= 65555,	// toe & shoulder points
	TIFFTAG_DCSCALIBRATIONFD			= 65556,	// calibration file desc
	TIFFTAG_ZIPQUALITY					= 65557,	// compression quality level on the ZLIB 1-9 scale. Default value is -1
	TIFFTAG_PIXARLOGQUALITY				= 65558,	// PixarLog uses same scale
	TIFFTAG_DCSCLIPRECTANGLE			= 65559,	// area of image to acquire, allocated to Oceana Matrix <dev@oceana.com>
	TIFFTAG_SGILOGDATAFMT				= 65560,	// SGILog user data format
		SGILOGDATAFMT_FLOAT				= 0,		// IEEE float samples
		SGILOGDATAFMT_16BIT				= 1,		// 16-bit samples
		SGILOGDATAFMT_RAW				= 2,		// uninterpreted data
		SGILOGDATAFMT_8BIT				= 3,		// 8-bit RGB monitor values
	TIFFTAG_SGILOGENCODE				= 65561,	// SGILog data encoding control
		SGILOGENCODE_NODITHER			= 0,		// do not dither encoded values
		SGILOGENCODE_RANDITHER			= 1,		// randomly dither encd values
	TIFFTAG_LZMAPRESET					= 65562,	// LZMA2 preset (compression level)
	TIFFTAG_PERSAMPLE					= 65563,	// interface for per sample tags
		PERSAMPLE_MERGED        		= 0,		// present as a single value
		PERSAMPLE_MULTI         		= 1,		// present as multiple values
		
	// EXIF tags
	EXIFTAG_EXPOSURETIME				= 33434,	// Exposure time
	EXIFTAG_FNUMBER						= 33437,	// F number
	EXIFTAG_EXPOSUREPROGRAM				= 34850,	// Exposure program
	EXIFTAG_SPECTRALSENSITIVITY			= 34852,	// Spectral sensitivity
	EXIFTAG_ISOSPEEDRATINGS				= 34855,	// ISO speed rating
	EXIFTAG_OECF						= 34856,	// Optoelectric conversion factor
	EXIFTAG_EXIFVERSION					= 36864,	// Exif version
	EXIFTAG_DATETIMEORIGINAL			= 36867,	// Date and time of original data generation
	EXIFTAG_DATETIMEDIGITIZED			= 36868,	// Date and time of digital data generation
	EXIFTAG_COMPONENTSCONFIGURATION		= 37121,	// Meaning of each component
	EXIFTAG_COMPRESSEDBITSPERPIXEL		= 37122,	// Image compression mode
	EXIFTAG_SHUTTERSPEEDVALUE			= 37377,	// Shutter speed
	EXIFTAG_APERTUREVALUE				= 37378,	// Aperture
	EXIFTAG_BRIGHTNESSVALUE				= 37379,	// Brightness
	EXIFTAG_EXPOSUREBIASVALUE			= 37380,	// Exposure bias
	EXIFTAG_MAXAPERTUREVALUE			= 37381,	// Maximum lens aperture
	EXIFTAG_SUBJECTDISTANCE				= 37382,	// Subject distance
	EXIFTAG_METERINGMODE				= 37383,	// Metering mode
	EXIFTAG_LIGHTSOURCE					= 37384,	// Light source
	EXIFTAG_FLASH						= 37385,	// Flash
	EXIFTAG_FOCALLENGTH					= 37386,	// Lens focal length
	EXIFTAG_SUBJECTAREA					= 37396,	// Subject area
	EXIFTAG_MAKERNOTE					= 37500,	// Manufacturer notes
	EXIFTAG_USERCOMMENT					= 37510,	// User comments
	EXIFTAG_SUBSECTIME					= 37520,	// DateTime subseconds
	EXIFTAG_SUBSECTIMEORIGINAL			= 37521,	// DateTimeOriginal subseconds
	EXIFTAG_SUBSECTIMEDIGITIZED			= 37522,	// DateTimeDigitized subseconds
	EXIFTAG_FLASHPIXVERSION				= 40960,	// Supported Flashpix version
	EXIFTAG_COLORSPACE					= 40961,	// Color space information
	EXIFTAG_PIXELXDIMENSION				= 40962,	// Valid image width
	EXIFTAG_PIXELYDIMENSION				= 40963,	// Valid image height
	EXIFTAG_RELATEDSOUNDFILE			= 40964,	// Related audio file
	EXIFTAG_FLASHENERGY					= 41483,	// Flash energy
	EXIFTAG_SPATIALFREQUENCYRESPONSE	= 41484,	// Spatial frequency response
	EXIFTAG_FOCALPLANEXRESOLUTION		= 41486,	// Focal plane X resolution
	EXIFTAG_FOCALPLANEYRESOLUTION		= 41487,	// Focal plane Y resolution
	EXIFTAG_FOCALPLANERESOLUTIONUNIT	= 41488,	// Focal plane resolution unit
	EXIFTAG_SUBJECTLOCATION				= 41492,	// Subject location
	EXIFTAG_EXPOSUREINDEX				= 41493,	// Exposure index
	EXIFTAG_SENSINGMETHOD				= 41495,	// Sensing method
	EXIFTAG_FILESOURCE					= 41728,	// File source
	EXIFTAG_SCENETYPE					= 41729,	// Scene type
	EXIFTAG_CFAPATTERN					= 41730,	// CFA pattern
	EXIFTAG_CUSTOMRENDERED				= 41985,	// Custom image processing
	EXIFTAG_EXPOSUREMODE				= 41986,	// Exposure mode
	EXIFTAG_WHITEBALANCE				= 41987,	// White balance
	EXIFTAG_DIGITALZOOMRATIO			= 41988,	// Digital zoom ratio
	EXIFTAG_FOCALLENGTHIN35MMFILM		= 41989,	// Focal length in 35 mm film
	EXIFTAG_SCENECAPTURETYPE			= 41990,	// Scene capture type
	EXIFTAG_GAINCONTROL					= 41991,	// Gain control
	EXIFTAG_CONTRAST					= 41992,	// Contrast
	EXIFTAG_SATURATION					= 41993,	// Saturation
	EXIFTAG_SHARPNESS					= 41994,	// Sharpness
	EXIFTAG_DEVICESETTINGDESCRIPTION	= 41995,	// Device settings description
	EXIFTAG_SUBJECTDISTANCERANGE		= 41996,	// Subject distance range
	EXIFTAG_IMAGEUNIQUEID				= 42016		// Unique image ID
}
