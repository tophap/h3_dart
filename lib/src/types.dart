// File created by
// Lung Razvan <long1eu>
// on 22/08/2019

part of h3_ffi;

const double _epsilon = 1e-9;

class GeoCoord {
  const GeoCoord({this.lat = 0.0, this.lon = 0.0});

  factory GeoCoord.degrees({double lat = 0.0, double lon = 0.0}) {
    return GeoCoord(lat: degToRad(lat), lon: degToRad(lon));
  }

  /// latitude in radians
  final double lat;

  /// longitude in radians
  final double lon;

  double get latDeg => radToDeg(lat);

  double get lonDeg => radToDeg(lon);

  Pointer<GeoCoordNative> get _pointer => GeoCoordNative.allocates(lat, lon);

  @override
  String toString() => 'GeoCoord{lat: $latDeg, lon: $lonDeg}';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! GeoCoord || runtimeType != other.runtimeType) {
      return false;
    }

    if (other is GeoCoord) {
      if ((latDeg - other.latDeg).abs() >= _epsilon) {
        return false;
      }

      return (lon - other.lon).abs() <= _epsilon;
    }
    return false;
  }

  @override
  int get hashCode => lat.hashCode ^ lon.hashCode;
}

/// cell boundary in latitude/longitude
class GeoBoundary {
  const GeoBoundary(this.vertices);

  /// vertices in ccw order
  final List<GeoCoord> vertices;

  @override
  String toString() => 'GeoBoundary{vertices: $vertices}';

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is GeoBoundary &&
          runtimeType == other.runtimeType &&
          const ListEquality<GeoCoord>().equals(vertices, other.vertices);

  @override
  int get hashCode => const ListEquality<GeoCoord>().hash(vertices);
}

/// Simplified core of GeoJSON Polygon coordinates definition
class GeoPolygon {
  GeoPolygon(this.geofence, this.holes);

  /// exterior boundary of the polygon
  final List<GeoCoord> geofence;

  /// interior boundaries (holes) in the polygon
  final List<List<GeoCoord>> holes;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is GeoPolygon &&
          runtimeType == other.runtimeType &&
          const DeepCollectionEquality().equals(geofence, other.geofence) &&
          const DeepCollectionEquality().equals(holes, other.holes);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(geofence) ^ //
      const DeepCollectionEquality().hash(holes);
}

num degToRad(num deg) => deg * (pi / 180.0);

num radToDeg(num rad) => rad * (180.0 / pi);
