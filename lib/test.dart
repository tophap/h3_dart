// File created by
// Lung Razvan <long1eu>
// on 22/08/2019

import 'package:h3_ffi/h3_ffi.dart';

Future<void> main() async {
  final GeoCoord coord = GeoCoord.degrees(lat: 40.68942184369929, lon: -74.04443139990863);
  final int h3 = geoToH3(coord, 10);
  final GeoCoord result = h3ToGeo(h3);
  assert(coord == result);

  print(h3ToGeoBoundary(h3));
}
