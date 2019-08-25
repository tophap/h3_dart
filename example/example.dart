// File created by
// Lung Razvan <long1eu>
// on 22/08/2019

import 'package:h3_ffi/h3_ffi.dart';

Future<void> main() async {
  initializeH3();

  final GeoCoord coord = GeoCoord.degrees(lat: 40.68942184369929, lon: -74.04443139990863);
  final int h3 = geoToH3(coord, 10);
  print('h3: 0x${h3.toRadixString(16).toUpperCase()}');

  final GeoCoord result = h3ToGeo(h3);
  print('coord: $result');

  final GeoBoundary boundary = h3ToGeoBoundary(0x8b0a00000000fff);

  print('boundary: ${boundary.coordinates}');
}
