part of h3_ffi;

bool _initialized = false;

void initializeH3([LibraryLoader loader]) {
  bindings.initialize(loader);
  _initialized = true;
}

/// Find the H3 index of the resolution [res] cell containing the lat/lon [g]
int geoToH3(GeoCoord g, int resolution) {
  assert(_initialized);

  final Pointer<GeoCoordNative> pointer = g._pointer;
  final int geoToH3 = bindings.geoToH3(pointer, resolution);
  pointer.free();
  return geoToH3;
}

/// Find the lat/lon center point g of the cell [h3]
GeoCoord h3ToGeo(int h3) {
  assert(_initialized);

  final Pointer<GeoCoordNative> g = Pointer<GeoCoordNative>.allocate();
  bindings.h3ToGeo(h3, g);

  final GeoCoordNative center = g.load();
  final GeoCoord result = GeoCoord(lat: center.lat, lon: center.lon);
  g.free();
  return result;
}

/// Give the cell boundary in lat/lon coordinates for the cell [h3]
GeoBoundary h3ToGeoBoundary(int h3) {
  assert(_initialized);

  final Pointer<GeoBoundaryNative> gp = Pointer<GeoBoundaryNative>.allocate(count: 10 * GeoCoordNative.size);
  bindings.h3ToGeoBoundary(h3, gp);

  final List<GeoCoord> coordinates = <GeoCoord>[];
  final GeoBoundaryNative boundary = gp.load();

  print(boundary.numVerts);

  for (GeoCoordNative vert in boundary.verts) {
    coordinates.add(GeoCoord(lat: vert.lat, lon: vert.lon));
  }
  gp.free();

  return GeoBoundary(coordinates);
}
