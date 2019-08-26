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

  final double lat;
  final double lon;

  double get latDeg => radToDeg(lat);

  double get lonDeg => radToDeg(lon);

  Pointer<GeoCoordNative> get _pointer => GeoCoordNative.allocate(lat, lon);

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

class GeoBoundary {
  const GeoBoundary(this.coordinates);

  final List<GeoCoord> coordinates;

  @override
  String toString() => 'GeoBoundary{coordinates: $coordinates}';

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is GeoBoundary &&
          runtimeType == other.runtimeType &&
          const ListEquality<GeoCoord>().equals(coordinates, other.coordinates);

  @override
  int get hashCode => const ListEquality<GeoCoord>().hash(coordinates);
}

num degToRad(num deg) => deg * (pi / 180.0);

num radToDeg(num rad) => rad * (180.0 / pi);
