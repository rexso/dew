/*
 * This file is included by the CSV ".c" files in the csv directory.
 *
 * copyright (c) 1995   Niles D. Ritter
 *
 * Permission granted to use this software, so long as this copyright
 * notice accompanies any products derived therefrom.
 */

module dew.geotiff.geo_incode_defs;

extern(C):
public:
nothrow:

import core.stdc.stdio;

alias datafile_rows_t = const(char)*;

struct datafile_s
{
  const char* name;
  const(datafile_rows_t)** rows; 
}

datafile_s datafile_t;
