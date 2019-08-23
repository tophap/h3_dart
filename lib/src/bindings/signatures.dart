// File created by
// Lung Razvan <long1eu>
// on 22/08/2019

import 'dart:ffi';

import 'types.dart';

typedef geoToH3_native_t = Uint64 Function(Pointer<GeoCoordNative> g, Int32 res);

typedef h3ToGeo_native_t = Void Function(Uint64 h3, Pointer<GeoCoordNative> g);

typedef h3ToGeoBoundary_native_t = Void Function(Uint64 h3, Pointer<GeoBoundaryNative> gp);
