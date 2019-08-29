// File created by
// Lung Razvan <long1eu>
// on 22/08/2019

import 'dart:ffi';

import 'types.dart';

typedef geoToH3_native_t = Uint64 Function(Pointer<GeoCoordNative> g, Int32 res);

typedef h3ToGeo_native_t = Void Function(Uint64 h3, Pointer<GeoCoordNative> g);

typedef h3ToGeoBoundary_native_t = Int32 Function(Uint64 h3, Pointer<GeoCoordNative> gp);

typedef maxKringSize_native_t = Int32 Function(Int32 h3);

typedef hexRange_native_t = Int32 Function(Uint64 origin, Int32 k, Pointer<Uint64> out);

typedef hexRangeDistances_native_t = Int32 Function(
    Uint64 origin, Int32 k, Pointer<Uint64> out, Pointer<Int32> distances);

typedef hexRanges_native_t = Int32 Function(Pointer<Uint64> h3Set, Int32 length, Int32 k, Pointer<Uint64> out);
