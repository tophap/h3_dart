part of h3_ffi;

/// Find the H3 index of the resolution [res] cell containing the lat/lon [g]
int geoToH3(GeoCoord g, int resolution) {
  final Pointer<GeoCoordNative> pointer = g._pointer;
  final int geoToH3 = bindings.geoToH3(pointer, resolution);
  pointer.free();
  return geoToH3;
}

/// Find the lat/lon center point g of the cell [h3]
GeoCoord h3ToGeo(int h3) {
  final Pointer<GeoCoordNative> g = Pointer<GeoCoordNative>.allocate();
  bindings.h3ToGeo(h3, g);

  final GeoCoordNative center = g.load();
  final GeoCoord result = GeoCoord(lat: center.lat, lon: center.lon);
  g.free();
  return result;
}

/// Give the cell boundary in lat/lon coordinates for the cell [h3]
GeoBoundary h3ToGeoBoundary(int h3) {
  final Pointer<GeoBoundaryNative> gp = Pointer<GeoBoundaryNative>.allocate(count: 100);
  bindings.h3ToGeoBoundary(h3, gp);

  final List<GeoCoord> coordinates = <GeoCoord>[];
  final GeoBoundaryNative boundary = gp.load();

  for (int i = 0; i < boundary.numVerts; i++) {
    final GeoCoordNative coord = boundary.verts.elementAt(i).load<GeoCoordNative>();
    coordinates.add(GeoCoord(lat: coord.lat, lon: coord.lon));
  }
  gp.free();

  return GeoBoundary(coordinates);
}
