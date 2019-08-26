// File created by
// Lung Razvan <long1eu>
// on 26/08/2019

import 'dart:ffi';

import 'package:h3_ffi/h3_ffi.dart';
import 'package:test/test.dart';

const double precisionErrorTolerance = 1e-10;

void main() {
  setUpAll(() => initializeH3((_) => DynamicLibrary.open('ios/cmake-build-debug/libh3.dylib')));

  test('geoToH3', () {
    expect(geoToH3(GeoCoord.degrees(lat: 79.2423985098, lon: 38.0234070080), 0), 0x8001fffffffffff);
    expect(geoToH3(GeoCoord.degrees(lat: 79.2209863563, lon: -107.4292022430), 0), 0x8003fffffffffff);
    expect(geoToH3(GeoCoord.degrees(lat: 74.9284343892, lon: 145.3562419228), 0), 0x8005fffffffffff);
  });

  test('h3ToGeo', () {
    expect(h3ToGeo(0x8001fffffffffff), GeoCoord.degrees(lat: 79.2423985098, lon: 38.0234070080));
    expect(h3ToGeo(0x8003fffffffffff), GeoCoord.degrees(lat: 79.2209863563, lon: -107.4292022430));
    expect(h3ToGeo(0x8005fffffffffff), GeoCoord.degrees(lat: 74.9284343892, lon: 145.3562419228));
  });

  test('h3ToGeoBoundary', () {
    expect(h3ToGeoBoundary(0x8a8f5a980387fff), <GeoCoord>[
      GeoCoord.degrees(lat: -9.361697060, lon: -78.582037761),
      GeoCoord.degrees(lat: -9.362128022, lon: -78.582655266),
      GeoCoord.degrees(lat: -9.362873639, lon: -78.582586800),
      GeoCoord.degrees(lat: -9.363188292, lon: -78.581900827),
      GeoCoord.degrees(lat: -9.362757328, lon: -78.581283323),
      GeoCoord.degrees(lat: -9.362011713, lon: -78.581351792),
    ]);
    expect(h3ToGeoBoundary(0x8a2769da3587fff), <GeoCoord>[
      GeoCoord.degrees(lat: 44.641731384, lon: -82.135842406),
      GeoCoord.degrees(lat: 44.641506337, lon: -82.136798146),
      GeoCoord.degrees(lat: 44.640824436, lon: -82.136981488),
      GeoCoord.degrees(lat: 44.640367585, lon: -82.136209116),
      GeoCoord.degrees(lat: 44.640592624, lon: -82.135253397),
      GeoCoord.degrees(lat: 44.641274521, lon: -82.135070029),
    ]);
    expect(h3ToGeoBoundary(0x8a3d6628221ffff), <GeoCoord>[
      GeoCoord.degrees(lat: 38.026712729, lon: 85.707804486),
      GeoCoord.degrees(lat: 38.025989433, lon: 85.707767610),
      GeoCoord.degrees(lat: 38.025619227, lon: 85.708541471),
      GeoCoord.degrees(lat: 38.025972308, lon: 85.709352214),
      GeoCoord.degrees(lat: 38.026695600, lon: 85.709389108),
      GeoCoord.degrees(lat: 38.027065815, lon: 85.708615242),
    ]);
  });

  test('maxKringSize', () {
    for (int i = 0; i < 5; i++) {
      expect(maxKringSize(i), 3 * i * (i + 1) + 1);
    }
  });
}
