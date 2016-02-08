module dew.tiff.tiffconf;

extern(C):
public:
nothrow:

import std.stdint;

alias TIFF_INT8_T		= int8_t;
alias TIFF_INT16_T		= int16_t;
alias TIFF_INT32_T		= int32_t;
alias TIFF_INT64_T		= int64_t;
alias TIFF_UINT8_T		= uint8_t;
alias TIFF_UINT16_T		= uint16_t;
alias TIFF_UINT32_T		= uint32_t;
alias TIFF_UINT64_T		= uint64_t;
alias TIFF_SSIZE_T		= ptrdiff_t;
alias TIFF_PTRDIFF_T	= ptrdiff_t;

version = HAVE_INT8;
version = HAVE_INT16;
version = HAVE_INT32;
version = HAVE_IEEEFP;
version = CCITT_SUPPORT;				// Support CCITT Group 3 & 4 algorithms
version = JPEG_SUPPORT;					// Support JPEG compression (requires IJG JPEG library)
version = JBIG_SUPPORT;					// Support JBIG compression (requires JBIG-KIT library)
version = LOGLUV_SUPPORT;				// Support LogLuv high dynamic range encoding
version = LZW_SUPPORT;					// Support LZW algorithm
version = NEXT_SUPPORT;					// Support NeXT 2-bit RLE algorithm
version = OJPEG_SUPPORT;				// Support Old JPEG compresson (read contrib/ojpeg/README first! Compilation fails with unpatched IJG JPEG library)
version = PACKBITS_SUPPORT;				// Support Macintosh PackBits algorithm
version = PIXARLOG_SUPPORT;				// Support Pixar log-format algorithm (requires Zlib)
version = THUNDER_SUPPORT;				// Support ThunderScan 4-bit RLE algorithm
version = ZIP_SUPPORT;					// Support Deflate compression
version = SUBIFD_SUPPORT;				// Enable SubIFD tag (330) support
version = DEFAULT_EXTRASAMPLE_AS_ALPHA;	// Treat extra sample as alpha (default enabled). The RGBA interface will treat a fourth sample with no EXTRASAMPLE_ value as being ASSOCALPHA. Many packages produce RGBA files but don't mark the alpha properly.
version = CHECK_JPEG_YCBCR_SUBSAMPLING;	// Pick up YCbCr subsampling info from the JPEG data stream to support files lacking the tag (default enabled).
version = MDI_SUPPORT;					// Support MS MDI magic number files as TIFF
version = COLORIMETRY_SUPPORT;
version = YCBCR_SUPPORT;
version = CMYK_SUPPORT;
version = ICC_SUPPORT;
version = PHOTOSHOP_SUPPORT;
version = IPTC_SUPPORT;

version(BigEndian)
{
	version = HOST_BIGENDIAN;
}
