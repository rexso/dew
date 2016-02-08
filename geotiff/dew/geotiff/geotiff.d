/**********************************************************************
 *
 *  geotiff.h - Public interface for Geotiff tag parsing.
 *
 *   Written By: Niles D. Ritter
 *
 *  copyright (c) 1995   Niles D. Ritter
 *
 *  Permission granted to use this software, so long as this copyright
 *  notice accompanies any products derived therefrom.
 **********************************************************************/

module dew.geotiff.geotiff;

extern(C):
public:
nothrow:

enum GvCurrentVersion      = 1;     // This Version code should only change if a drastic alteration is made to the GeoTIFF key structure. Readers encountering a larger value should give up gracefully.
enum LIBGEOTIFF_VERSION    = 1410;

import dew.geotiff.geokeys;

/**********************************************************************
 *
 *                 Public Structures & Definitions
 *
 **********************************************************************/

struct GTIF;
struct TIFFMethod;

alias tifftag_t			= ushort;
alias geocode_t			= ushort;

alias GTIFPrintMethod	= int function(char* str, void* aux);
alias GTIFReadMethod	= int function(char* str, void* aux);  // string 1024+ in size

alias tagtype_t	= int;
enum
{
	TYPE_BYTE		= 1,
	TYPE_SHORT		= 2,
	TYPE_LONG		= 3,
	TYPE_RATIONAL	= 4,
	TYPE_ASCII		= 5,
	TYPE_FLOAT		= 6,
	TYPE_DOUBLE		= 7,
	TYPE_SBYTE		= 8,
	TYPE_SSHORT		= 9,
	TYPE_SLONG		= 10,
	TYPE_UNKNOWN	= 11
}

/**********************************************************************
 *
 *                 Public Function Declarations
 *
 **********************************************************************/

// TIFF-level interface
export GTIF*	GTIFNew(void* tif);
export GTIF*	GTIFNewSimpleTags(void* tif);
export GTIF*	GTIFNewWithMethods(void* tif, TIFFMethod*);
export void		GTIFFree(GTIF* gtif);
export int		GTIFWriteKeys(GTIF* gtif);
export void		GTIFDirectoryInfo(GTIF* gtif, int* versions, int* keycount);

// GeoKey Access
export int		GTIFKeyInfo(GTIF* gtif, geokey_t key, int* size, tagtype_t* type);
export int		GTIFKeyGet(GTIF* gtif, geokey_t key, void* val, int index, int count);
export int		GTIFKeySet(GTIF* gtif, geokey_t keyID, tagtype_t type, int count, ...);

// Metadata Import-Export utilities
export void		GTIFPrint(GTIF *gtif, GTIFPrintMethod print, void *aux);
export int		GTIFImport(GTIF *gtif, GTIFReadMethod scan, void *aux);
export char*	GTIFKeyName(geokey_t key);
export char*	GTIFValueName(geokey_t key, int value);
export char*	GTIFTypeName(tagtype_t type);
export char*	GTIFTagName(int tag);
export int		GTIFKeyCode(char* key);
export int		GTIFValueCode(geokey_t key, char* value);
export int		GTIFTypeCode(char* type);
export int		GTIFTagCode(char* tag);

// Translation between image/PCS space
export int		GTIFImageToPCS(GTIF* gtif, double* x, double* y);
export int		GTIFPCSToImage(GTIF* gtif, double* x, double* y);
