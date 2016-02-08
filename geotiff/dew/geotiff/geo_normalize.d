/******************************************************************************
 * $Id: geo_normalize.h 2233 2012-10-09 01:33:11Z warmerdam $
 *
 * Project:  libgeotiff
 * Purpose:  Include file related to geo_normalize.c containing Code to
 *           normalize PCS and other composite codes in a GeoTIFF file.
 * Author:   Frank Warmerdam, warmerda@home.com
 *
 ******************************************************************************
 * Copyright (c) 1999, Frank Warmerdam
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
 *****************************************************************************/

module dew.geotiff.geo_normalize;

extern(C):
public:
nothrow:

import core.stdc.stdio;
import dew.geotiff.geotiff;
    
enum MAX_GTIF_PROJPARMS = 10;

// Holds a definition of a coordinate system in normalized form
struct GTIFDefn
{
    short	Model;							// From GTModelTypeGeoKey tag. Can have the values ModelTypeGeographic or ModelTypeProjected.
    short	PCS;							// From ProjectedCSTypeGeoKey tag. For example PCS_NAD27_UTM_zone_3N.
    short	GCS;	      					// From GeographicTypeGeoKey tag. For example GCS_WGS_84 or GCS_Voirol_1875_Paris. Includes datum and prime meridian value.
    short	UOMLength;						// From ProjLinearUnitsGeoKey. For example Linear_Meter.
    double	UOMLengthInMeters;				// One UOMLength = UOMLengthInMeters meters.
    short	UOMAngle;						// The angular units of the GCS.
    double	UOMAngleInDegrees;				// One UOMAngle = UOMLengthInDegrees degrees.
    short	Datum;							// Datum from GeogGeodeticDatumGeoKey tag. For example Datum_WGS84.
    short	PM;								// Prime meridian from GeogPrimeMeridianGeoKey. For example PM_Greenwich or PM_Paris.
    double	PMLongToGreenwich;				// Decimal degrees of longitude between this prime meridian and Greenwich. Prime meridians to the west of Greenwich are negative.
    short	Ellipsoid;						// Ellipsoid identifier from GeogELlipsoidGeoKey. For example Ellipse_Clarke_1866.
    double	SemiMajor;						// The length of the semi major ellipse axis in meters.
    double	SemiMinor;						// The length of the semi minor ellipse axis in meters.

	// maintain binary compatability with older versions of libgeotiff for MrSID binaries (for example)
	version(GEO_NORMALIZE_DISABLE_TOWGS84) else 
	{
		short		TOWGS84Count;			// TOWGS84 transformation values (0/3/7)
		double[7]	TOWGS84;				// TOWGS84 transformation values
	}
	
    short	ProjCode;						// Projection id from ProjectionGeoKey. For example Proj_UTM_11S.
    short	Projection;						// EPSG identifier for underlying projection method. From the EPSG TRF_METHOD table.
    short	CTProjection;					// GeoTIFF identifier for underlying projection method. While some of these values have corresponding vlaues in EPSG (Projection field), others do not. For example CT_TransverseMercator.
    int		nParms;							// Number of projection parameters in ProjParm and ProjParmId.
    double[MAX_GTIF_PROJPARMS]	ProjParm;	// Projection parameter value. The identify of this parameter is established from the corresponding entry in ProjParmId. The value will be measured in meters, or decimal degrees if it is a linear or angular measure.
	int[MAX_GTIF_PROJPARMS]		ProjParmId;	// Projection parameter identifier. For example ProjFalseEastingGeoKey. The value will be 0 for unused table entries.
    int		MapSys;							// Special zone map system code (MapSys_UTM_South, MapSys_UTM_North, MapSys_State_Plane or KvUserDefined if none apply.
    int		Zone;							// UTM, or State Plane Zone number, zero if not known.
    int		DefnSet;						// Do we have any definition at all? 0 if no geokeys found.
}

export int			GTIFGetPCSInfo(int nPCSCode, char** ppszEPSGName, short* pnProjOp, short* pnUOMLengthCode, short* pnGeogCS);
export int			GTIFGetProjTRFInfo(int nProjTRFCode, char** ppszProjTRFName, short* pnProjMethod, double* padfProjParms);
export int			GTIFGetGCSInfo(int nGCSCode, char** ppszName, short* pnDatum, short* pnPM, short* pnUOMAngle);
export int			GTIFGetDatumInfo(int nDatumCode, char** ppszName, short* pnEllipsoid);
export int			GTIFGetEllipsoidInfo(int nEllipsoid, char** ppszName, double* pdfSemiMajor, double* pdfSemiMinor);
export int			GTIFGetPMInfo(int nPM, char** ppszName, double* pdfLongToGreenwich);
export double		GTIFAngleStringToDD(const char* pszAngle, int nUOMAngle);
export int			GTIFGetUOMLengthInfo(int nUOMLengthCode, char** ppszUOMName, double* pdfInMeters);
export int			GTIFGetUOMAngleInfo(int nUOMAngleCode, char** ppszUOMName, double* pdfInDegrees);
export double		GTIFAngleToDD(double dfAngle, int nUOMAngle);
    
// this should be used to free strings returned by GTIFGet... funcs
export void			GTIFFreeMemory(char*);
export void			GTIFDeaccessCSV();
export int			GTIFGetDefn(GTIF* psGTIF, GTIFDefn* psDefn);
export void			GTIFPrintDefn(GTIFDefn*, FILE*);
export GTIFDefn*	GTIFAllocDefn(void);
export void			GTIFFreeDefn(GTIFDefn*);
export void 		SetCSVFilenameHook(const(char*) function(const char*) CSVFileOverride);
export const(char)*	GTIFDecToDMS(double, const char*, int);

// These are useful for recognising UTM and State Plane, with or without CSV files being found.
enum
{
	MapSys_UTM_North		= -9001,
	MapSys_UTM_South		= -9002,
	MapSys_State_Plane_27	= -9003,
	MapSys_State_Plane_83	= -9004
}

export int			GTIFMapSysToPCS(int MapSys, int Datum, int nZone);
export int			GTIFMapSysToProj(int MapSys, int nZone);
export int			GTIFPCSToMapSys(int PCSCode, int* pDatum, int* pZone);
export int			GTIFProjToMapSys(int ProjCode, int* pZone);

// These are only useful if using libgeotiff with libproj (PROJ.4+).
export char*		GTIFGetProj4Defn(GTIFDefn*);
export int			GTIFProj4ToLatLong(GTIFDefn*, int, double*, double*);
export int			GTIFProj4FromLatLong(GTIFDefn*, int, double*, double*);
export int			GTIFSetFromProj4(GTIF* gtif, const char* proj4);
