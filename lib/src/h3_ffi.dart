part of h3_ffi;

bool _initialized = false;

void initializeH3([LibraryLoader loader]) {
  assert(!_initialized);
  bindings.initialize(loader);
  _initialized = true;
}

/// Encodes [g] (coordinate on the sphere) to the H3 index of the containing cell at
/// the specified [resolution].
///
/// Returns the encoded H3Index (or 0 on failure).
int geoToH3(GeoCoord g, int resolution) {
  assert(_initialized);

  final Pointer<GeoCoordNative> pointer = g._pointer;
  final int geoToH3 = bindings.geoToH3(pointer, resolution);
  pointer.free();
  return geoToH3;
}

/// Determines the spherical coordinates of the center point of an [h3] index.
GeoCoord h3ToGeo(int h3) {
  assert(_initialized);

  final Pointer<GeoCoordNative> g = Pointer<GeoCoordNative>.allocate();
  bindings.h3ToGeo(h3, g);

  final GeoCoordNative center = g.load();
  final GeoCoord result = GeoCoord(lat: center.lat, lon: center.lon);
  g.free();
  return result;
}

/// Determines the cell boundary in spherical coordinates for an [h3] index.
List<GeoCoord> h3ToGeoBoundary(int h3) {
  assert(_initialized);

  final Pointer<GeoCoordNative> gp = Pointer<GeoCoordNative>.allocate(count: 100);
  final int verts = bindings.h3ToGeoBoundary(h3, gp);

  final List<GeoCoord> coordinates = <GeoCoord>[];
  for (int i = 0; i < verts; i++) {
    final GeoCoordNative vert = gp.elementAt(i).load();
    coordinates.add(GeoCoord(lat: vert.lat, lon: vert.lon));
  }
  gp.free();

  return coordinates;
}

/// Maximum number of indices that result from the kRing algorithm with the given
/// k. Formula source and proof: https://oeis.org/A003215
int maxKringSize(int k) {
  assert(_initialized);
  return bindings.maxKringSize(k);
}

/// Produces indexes within [k] distance of the origin index.
///
/// Throws [PentagonH3Error] when one of the indexes returned by this
/// function is a pentagon or [PentagonDistortionH3Error] when it is
/// in the pentagon distortion area.
///
/// k-ring 0 is defined as the origin index, k-ring 1 is defined as k-ring 0 and
/// all neighboring indexes, and so on.
///
/// Return a list of indexes in order of increasing distance from the origin.
List<int> hexRange(int origin, int k) {
  assert(k >= 0);

  final int size = maxKringSize(k);
  final Pointer<Uint64> out = Pointer<Uint64>.allocate(count: size);
  final int result = bindings.hexRange(origin, k, out);

  if (result == 0) {
    final List<int> list = out.asExternalTypedData(count: size).buffer.asUint64List().toList();
    out.free();
    return list;
  } else {
    if (result == 1) {
      throw PentagonH3Error();
    } else {
      assert(result == 2);
      throw PentagonDistortionH3Error();
    }
  }
}

/// Produces indexes within [k] distance of the origin index.
///
/// Throws [PentagonH3Error] when one of the indexes returned by this
/// function is a pentagon or [PentagonDistortionH3Error] when it is
/// in the pentagon distortion area.
///
/// k-ring 0 is defined as the origin index, k-ring 1 is defined as k-ring 0 and
/// all neighboring indexes, and so on.
///
/// Return the indexes in order of increasing distance from the origin, mapped to
/// their respective distances.
Map<int, int> hexRangeDistances(int origin, int k) {
  assert(k >= 0);

  final int size = maxKringSize(k);
  final Pointer<Uint64> out = Pointer<Uint64>.allocate(count: size);
  final Pointer<Int32> distances = Pointer<Int32>.allocate(count: size);
  final int result = bindings.hexRangeDistances(origin, k, out, distances);

  if (result == 0) {
    final Map<int, int> map = Map<int, int>.fromIterables(out.asExternalTypedData(count: size).buffer.asUint64List(),
        distances.asExternalTypedData(count: size).buffer.asInt32List());

    out.free();
    distances.free();

    return map;
  } else {
    if (result == 1) {
      throw PentagonH3Error();
    } else {
      assert(result == 2);
      throw PentagonDistortionH3Error();
    }
  }
}

/// Takes an set of input hex IDs and a max [k]-ring and returns an
/// list of hexagon IDs sorted first by the original hex IDs and then by the
/// k-ring (0 to max), with no guaranteed sorting within each k-ring group.
///
/// Throws [PentagonH3Error] when one of the indexes returned by this
/// function is a pentagon or [PentagonDistortionH3Error] when it is
/// in the pentagon distortion area.
List<int> hexRanges(Set<int> h3Set, int k) {
  final int size = maxKringSize(k) * h3Set.length;
  final Pointer<Uint64> out = Pointer<Uint64>.allocate(count: size);
  final Pointer<Uint64> h3SetPtr = Pointer<Uint64>.allocate(count: h3Set.length);
  for (int i = 0; i < h3Set.length; i++) {
    h3SetPtr.elementAt(i).store(h3Set.elementAt(i));
  }

  final int result = bindings.hexRanges(h3SetPtr, h3Set.length, k, out);

  if (result == 0) {
    final List<int> list = out.asExternalTypedData(count: size).buffer.asUint64List().toList();
    out.free();
    return list;
  } else {
    if (result == 1) {
      throw PentagonH3Error();
    } else {
      assert(result == 2);
      throw PentagonDistortionH3Error();
    }
  }
}

/// k-rings produces indices within [k] distance of the [origin] index.
///
/// k-ring 0 is defined as the origin index, k-ring 1 is defined as k-ring 0 and
/// all neighboring indices, and so on.
///
/// Elements of the return list may be left zero, as can happen when crossing a
/// pentagon.
List<int> kRing(int origin, int k) {
  assert(k >= 0);

  final int size = maxKringSize(k);
  final Pointer<Uint64> out = Pointer<Uint64>.allocate(count: size);

  bindings.kRing(origin, k, out);

  final List<int> list = out.asExternalTypedData(count: size).buffer.asUint64List().toList();
  out.free();
  return list;
}

/// k-rings produces indices within [k] distance of the [origin] index.
///
/// k-ring 0 is defined as the origin index, k-ring 1 is defined as k-ring 0 and
/// all neighboring indices, and so on.
///
/// Elements of the return list may be left zero, as can happen when crossing a
/// pentagon.
Map<int, int> kRingDistances(int origin, int k) {
  assert(k >= 0);

  final int size = maxKringSize(k);
  final Pointer<Uint64> out = Pointer<Uint64>.allocate(count: size);
  final Pointer<Int32> distances = Pointer<Int32>.allocate(count: size);
  bindings.kRingDistances(origin, k, out, distances);

  final Map<int, int> map = Map<int, int>.fromIterables(out.asExternalTypedData(count: size).buffer.asUint64List(),
      distances.asExternalTypedData(count: size).buffer.asInt32List());

  out.free();
  distances.free();

  return map;
}

/// Returns the "hollow" ring of hexagons at exactly grid distance [k] from
/// the [origin] hexagon. In particular, k=0 returns just the origin hexagon.
///
/// A nonzero failure code may be returned in some cases, for example,
/// if a pentagon is encountered.
/// Failure cases may be fixed in future versions.
///
/// Throws [PentagonH3Error] when one of the indexes returned by this
/// function is a pentagon or [PentagonDistortionH3Error] when it is
/// in the pentagon distortion area.
List<int> hexRing(int origin, int k) {
  assert(k >= 0);

  final int size = k == 0 ? 1 : 6 * k;
  final Pointer<Uint64> out = Pointer<Uint64>.allocate(count: size);

  final int result = bindings.hexRing(origin, k, out);

  if (result == 0) {
    final List<int> list = out.asExternalTypedData(count: size).buffer.asUint64List().toList();
    out.free();
    return list;
  } else {
    if (result == 1) {
      throw PentagonH3Error();
    } else {
      assert(result == 2);
      throw PentagonDistortionH3Error();
    }
  }
}

/// The number of hexagons to allocate space for when performing a polyfill on
/// the [geoPolygon], a GeoJSON-like data structure at a give [resolution].
int maxPolyfillSize(GeoPolygon geoPolygon, int resolution) {
  assert(resolution >= 0 && resolution <= 15);

  final GeoPolygonNative native = GeoPolygonNative.allocate(geoPolygon);
  final int result = bindings.maxPolyfillSize(
      native.geofence, native.geofenceNum, native.holes, native.holesSizes, native.holesNum, resolution);
  // native.free();

  return result;
}
