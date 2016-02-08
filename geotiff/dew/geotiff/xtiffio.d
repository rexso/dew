module dew.geotiff.xtiffio;

extern(C):
public:
nothrow:

import dew.tiff.tiffio;

enum
{
	TIFFTAG_GEOPIXELSCALE		= 33550,	// private tag registered to SoftDesk, Inc
	TIFFTAG_INTERGRAPH_MATRIX	= 33920,	// private tag registered to Intergraph, Inc. $use TIFFTAG_GEOTRANSMATRIX
	TIFFTAG_GEOTIEPOINTS		= 33922,
	TIFFTAG_JPL_CARTO_IFD		= 34263,	// private tag registered to NASA-JPL Carto Group. $use GeoProjectionInfo
	TIFFTAG_GEOTRANSMATRIX		= 34264,	// New Matrix Tag replaces 33920

	// Tags 34735-34738 are private tags registered to SPOT Image, Inc
	TIFFTAG_GEOKEYDIRECTORY		= 34735,
	TIFFTAG_GEODOUBLEPARAMS		= 34736,
	TIFFTAG_GEOASCIIPARAMS		= 34737
}

// Define Printing method flags. These flags may be passed in to TIFFPrintDirectory() to indicate that those particular field values should be printed out in full, rather than just an indicator of whether they are present or not.
enum TIFFPRINT_GEOKEYDIRECTORY	= 0x80000000;
enum TIFFPRINT_GEOKEYPARAMS		= 0x40000000;

export void		XTIFFInitialize();
export TIFF*	XTIFFOpen(const char* name, const char* mode);
export TIFF*	XTIFFFdOpen(int fd, const char* name, const char* mode);
export void		XTIFFClose(TIFF* tif);
export TIFF*	XTIFFClientOpen(const char* name, const char* mode, thandle_t thehandle, TIFFReadWriteProc, TIFFReadWriteProc, TIFFSeekProc, TIFFCloseProc, TIFFSizeProc, TIFFMapFileProc, TIFFUnmapFileProc);
