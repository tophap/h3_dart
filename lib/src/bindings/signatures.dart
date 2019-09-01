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

typedef kRing_native_t = Void Function(Uint64 origin, Int32 k, Pointer<Uint64> out);

typedef kRingDistances_native_t = Void Function(Uint64 origin, Int32 k, Pointer<Uint64> out, Pointer<Int32> distances);

typedef hexRing_native_t = Int32 Function(Uint64 origin, Int32 k, Pointer<Uint64> out);

/*
typedef maxPolyfillSize_native_t = Int32 Function(Pointer<GeoPolygon> geoPolygon, Int32 res);
typedef polyfill_native_t = Void Function(Pointer<GeoPolygon> geoPolygon, Int32 res, Pointer<Uint64> out);
typedef h3SetToLinkedGeo_native_t = Void Function(Pointer<Uint64> h3Set, Int32 numHexes, Pointer<LinkedGeoPolygon> out);
typedef destroyLinkedPolygon_native_t = Void Function(Pointer<LinkedGeoPolygon> polygon);
typedef degsToRads_native_t = double Function(double degrees);
typedef radsToDegs_native_t = double Function(double radians);
typedef hexAreaKm2_native_t = double Function(Int32 res);
typedef hexAreaM2_native_t = double Function(Int32 res);
typedef edgeLengthKm_native_t = double Function(Int32 res);
typedef edgeLengthM_native_t = double Function(Int32 res);
typedef numHexagons_native_t = Uint64 Function(Int32 res);
typedef res0IndexCount_native_t = Int32 Function();
typedef getRes0Indexes_native_t = Void Function(Pointer<Uint64> out);
typedef pentagonIndexCount_native_t = Int32 Function();
typedef getPentagonIndexes_native_t = Void Function(Int32 res, Pointer<Uint64> out);
typedef h3GetResolution_native_t = Int32 Function(Uint64 h);
typedef h3GetBaseCell_native_t = Int32 Function(Uint64 h);
typedef stringToH3_native_t = Uint64 Function(char /***/ str);
typedef h3ToString_native_t = Void Function(Uint64 h, char /***/ str, size_t sz);
typedef h3IsValid_native_t = Int32 Function(Uint64 h);
typedef h3ToParent_native_t = Uint64 Function(Uint64 h, Int32 parentRes);
typedef maxH3ToChildrenSize_native_t = Int32 Function(Uint64 h, Int32 childRes);
typedef h3ToChildren_native_t = Void Function(Uint64 h, Int32 childRes, Pointer<Uint64> children);
typedef h3ToCenterChild_native_t = Uint64 Function(Uint64 h, Int32 childRes);
typedef compact_native_t = Int32 Function(Pointer<Uint64> h3Set, Pointer<Uint64> compactedSet, Int32 numHexes);
typedef maxUncompactSize_native_t = Int32 Function(Pointer<Uint64> compactedSet, Int32 numHexes, Int32 res);
typedef uncompact_native_t = Int32 Function(
    Pointer<Uint64> compactedSet, Int32 numHexes, Pointer<Uint64> h3Set, Int32 maxHexes, Int32 res);
typedef h3IsResClassIII_native_t = Int32 Function(Uint64 h);
typedef h3IsPentagon_native_t = Int32 Function(Uint64 h);
typedef maxFaceCount_native_t = Int32 Function(Uint64 h3);
typedef h3GetFaces_native_t = Void Function(Uint64 h3, Pointer<Int32> out);
typedef h3IndexesAreNeighbors_native_t = Int32 Function(Uint64 origin, Uint64 destination);
typedef getH3UnidirectionalEdge_native_t = Uint64 Function(Uint64 origin, Uint64 destination);
typedef h3UnidirectionalEdgeIsValid_native_t = Int32 Function(Uint64 edge);
typedef getOriginH3IndexFromUnidirectionalEdge_native_t = Uint64 Function(Uint64 edge);
typedef getDestinationH3IndexFromUnidirectionalEdge_native_t = Uint64 Function(Uint64 edge);
typedef getH3IndexesFromUnidirectionalEdge_native_t = Void Function(Uint64 edge, Pointer<Uint64> originDestination);
typedef getH3UnidirectionalEdgesFromHexagon_native_t = Void Function(Uint64 origin, Pointer<Uint64> edges);
typedef getH3UnidirectionalEdgeBoundary_native_t = Void Function(Uint64 edge, Pointer<GeoBoundary> gb);
typedef h3Distance_native_t = Int32 Function(Uint64 origin, Uint64 h3);
typedef h3LineSize_native_t = Int32 Function(Uint64 start, Uint64 end);
typedef h3Line_native_t = Int32 Function(Uint64 start, Uint64 end, Pointer<Uint64> out);
typedef experimentalH3ToLocalIj_native_t = Int32 Function(Uint64 origin, Uint64 h3, Pointer<CoordIJ> out);
typedef experimentalLocalIjToH3_native_t = Int32 Function(Uint64 origin, Pointer<CoordIJ> ij, Pointer<Uint64> out);
*/
