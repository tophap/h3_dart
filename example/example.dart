// File created by
// Lung Razvan <long1eu>
// on 22/08/2019

import 'dart:ffi';

import 'package:h3_ffi/h3_ffi.dart';

Future<void> main() async {
  initializeH3((_) => DynamicLibrary.open('ios/cmake-build-debug/libh3.dylib'));
  const List<GeoCoord> geofence = <GeoCoord>[
    GeoCoord(lat: 0.8, lon: 0.3),
    GeoCoord(lat: 0.7, lon: 0.6),
    GeoCoord(lat: 1.1, lon: 0.7),
    GeoCoord(lat: 1.0, lon: 0.2),
  ];

  const List<List<GeoCoord>> holes = <List<GeoCoord>>[
    <GeoCoord>[
      GeoCoord(lat: 0.9, lon: 0.3),
      GeoCoord(lat: 0.9, lon: 0.5),
      GeoCoord(lat: 1.0, lon: 0.7),
      GeoCoord(lat: 0.9, lon: 0.3),
    ],
  ];

  for (int i = 0; i < 10000000; i++) {
    print(maxPolyfillSize(GeoPolygon(geofence, holes), 2));
  }
}
