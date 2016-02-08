/**********************************************************************
 *
 *  geo_tiffp.h - Private interface for TIFF tag parsing.
 *
 *   Written by: Niles D. Ritter
 *
 *   This interface file encapsulates the interface to external TIFF
 *   file-io routines and definitions. The current configuration
 *   assumes that the "libtiff" module is used, but if you have your
 *   own TIFF reader, you may replace the definitions with your own
 *   here, and replace the implementations in geo_tiffp.c. No other
 *   modules have any explicit dependence on external TIFF modules.
 *
 *  copyright (c) 1995   Niles D. Ritter
 *
 *  Permission granted to use this software, so long as this copyright
 *  notice accompanies any products derived therefrom.
 **********************************************************************/

module dew.geotiff.geo_tiffp;

extern(C):
public:
nothrow:

import dew.geotiff.geotiff;
import dew.geotiff.xtiffio;
import dew.geotiff.cpl_serv;

alias dblparam_t	= double;
alias pinfo_t		= ushort;	// SHORT ProjectionInfo tag type
alias tiff_t		= TIFF;		// TIFF file descriptor
alias gdata_t		= tdata_t;	// pointer to data
alias gsize_t		= tsize_t;	// data allocation size

enum
{
	GTIFF_GEOKEYDIRECTORY	= TIFFTAG_GEOKEYDIRECTORY,
	GTIFF_DOUBLEPARAMS		= TIFFTAG_GEODOUBLEPARAMS,
	GTIFF_ASCIIPARAMS		= TIFFTAG_GEOASCIIPARAMS,
	GTIFF_PIXELSCALE		= TIFFTAG_GEOPIXELSCALE,
	GTIFF_TRANSMATRIX		= TIFFTAG_GEOTRANSMATRIX,
	GTIFF_INTERGRAPH_MATRIX	= TIFFTAG_INTERGRAPH_MATRIX,
	GTIFF_TIEPOINTS			= TIFFTAG_GEOTIEPOINTS,
	GTIFF_LOCAL				= 0
}

alias GTGetFunction			= int function(tiff_t* tif, pinfo_t tag, int* count, void* value);
alias GTSetFunction			= int function(tiff_t* tif, pinfo_t tag, int  count, void* value);
alias GTTypeFunction		= tagtype_t function(tiff_t* tif, pinfo_t tag);

struct _TIFFMethod
{
	GTGetFunction get;
	GTSetFunction set;
	GTTypeFunction type;
}

_TIFFMethod TIFFMethod_t;

extern gsize_t[]	_gtiff_size;	// TIFF data sizes

export void			_GTIFSetDefaultTIFF(TIFFMethod* method);
export gdata_t		_GTIFcalloc(gsize_t);
export gdata_t		_GTIFrealloc(gdata_t, gsize_t);
export void			_GTIFFree(gdata_t data);
export void			_GTIFmemcpy(gdata_t output, gdata_t input, gsize_t size);
