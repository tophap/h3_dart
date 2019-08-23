// File created by
// Lung Razvan <long1eu>
// on 22/08/2019

import 'dart:ffi';

import 'package:h3_ffi/h3_ffi.dart';

class GeoCoordNative extends Struct<GeoCoordNative> {
  /// latitude in radians
  @Double()
  double lat;

  /// longitude in radians
  @Double()
  double lon;

  // Please ensure to [free] the memory manually!
  static Pointer<GeoCoordNative> allocate(double lat, double lon) {
    return Pointer<GeoCoordNative>.allocate()
      ..load<GeoCoordNative>().lat = lat
      ..load<GeoCoordNative>().lon = lon;
  }

  @override
  String toString() => 'GeoCoordNative{lat: $lat, lon: $lon}';
}

class GeoBoundaryNative extends Struct<GeoBoundaryNative> {
  /// number of vertices
  @Int32()
  int numVerts;

  /// vertices in ccw order
  Pointer<GeoCoordNative> verts;

  // Please ensure to [free] the memory manually!
  static Pointer<GeoBoundaryNative> allocate(List<GeoCoord> coordinates) {
    final Pointer<GeoCoordNative> verts = Pointer<GeoCoordNative>.allocate(count: coordinates.length);
    for (int i = 0; i < coordinates.length; i++) {
      verts.elementAt(i).load<GeoCoordNative>().lat = coordinates[i].lat;
      verts.elementAt(i).load<GeoCoordNative>().lon = coordinates[i].lon;
    }

    return Pointer<GeoBoundaryNative>.allocate()
      ..load<GeoBoundaryNative>().numVerts = coordinates.length
      ..load<GeoBoundaryNative>().verts = verts;
  }

  @override
  String toString() => 'GeoBoundaryNative{numVerts: $numVerts, verts: $verts}';
}
