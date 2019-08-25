// File created by
// Lung Razvan <long1eu>
// on 22/08/2019

import 'dart:ffi';

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

  static int get size => 2 * 8; // two doubles

  @override
  String toString() => 'GeoCoordNative{lat: $lat, lon: $lon}';
}

class GeoBoundaryNative extends Struct<GeoBoundaryNative> {
  /// number of vertices
  @Int32()
  int numVerts;

  /// vertices in ccw order
  Iterable<GeoCoordNative> get verts sync* {
    final int sizeOfVerts = GeoCoordNative.size * numVerts;

    int offset = 8; // one int + padding
    while (offset < sizeOfVerts) {
      yield addressOf.offsetBy(offset).cast<GeoCoordNative>().load();
      offset += GeoCoordNative.size;
    }
  }

  @override
  String toString() => 'GeoBoundaryNative{numVerts: $numVerts, verts: $verts}';
}
