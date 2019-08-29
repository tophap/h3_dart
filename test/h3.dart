// File created by
// Lung Razvan <long1eu>
// on 26/08/2019

import 'dart:convert';
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

  test('hexRange', () {
    final List<int> result = hexRange(0x845ad1bffffffff, 2);

    expect(
      result,
      <int>[
        0x845ad1bffffffff,
        0x845ad19ffffffff,
        0x845ad11ffffffff,
        0x845ad13ffffffff,
        0x845adcdffffffff,
        0x845ac27ffffffff,
        0x845ac25ffffffff,
        0x845ad53ffffffff,
        0x845ad57ffffffff,
        0x845ad1dffffffff,
        0x845ad15ffffffff,
        0x845ad17ffffffff,
        0x845ade9ffffffff,
        0x845adc5ffffffff,
        0x845adc1ffffffff,
        0x845adc9ffffffff,
        0x845ac23ffffffff,
        0x845ac21ffffffff,
        0x845ac2dffffffff
      ],
    );
  });

  test('hexRangeDistances', () {
    final Map<int, int> result = hexRangeDistances(0x845ad1bffffffff, 2);

    expect(
      result,
      <int, int>{
        0x845ad1bffffffff: 0,
        0x845ad19ffffffff: 1,
        0x845ad11ffffffff: 1,
        0x845ad13ffffffff: 1,
        0x845adcdffffffff: 1,
        0x845ac27ffffffff: 1,
        0x845ac25ffffffff: 1,
        0x845ad53ffffffff: 2,
        0x845ad57ffffffff: 2,
        0x845ad1dffffffff: 2,
        0x845ad15ffffffff: 2,
        0x845ad17ffffffff: 2,
        0x845ade9ffffffff: 2,
        0x845adc5ffffffff: 2,
        0x845adc1ffffffff: 2,
        0x845adc9ffffffff: 2,
        0x845ac23ffffffff: 2,
        0x845ac21ffffffff: 2,
        0x845ac2dffffffff: 2
      },
    );
  });

  test('hexRanges', () {
    final List<int> result = hexRanges(<int>{
      0x89283080ddbffff,
      0x89283080c37ffff,
      0x89283080c27ffff,
      0x89283080d53ffff,
      0x89283080dcfffff,
      0x89283080dc3ffff,
    }, 1);

    expect(result, <int>[
      0x89283080ddbffff,
      0x89283080cafffff,
      0x89283080c37ffff,
      0x89283080dcbffff,
      0x89283080dc3ffff,
      0x89283080dd3ffff,
      0x89283080ca7ffff,
      0x89283080c37ffff,
      0x89283080c33ffff,
      0x89283080c23ffff,
      0x89283080c27ffff,
      0x89283080dcbffff,
      0x89283080ddbffff,
      0x89283080cafffff,
      0x89283080c27ffff,
      0x89283080c23ffff,
      0x89283080c2fffff,
      0x89283080d5bffff,
      0x89283080d53ffff,
      0x89283080dcbffff,
      0x89283080c37ffff,
      0x89283080d53ffff,
      0x89283080c27ffff,
      0x89283080d5bffff,
      0x89283080d43ffff,
      0x89283080d57ffff,
      0x89283080dcfffff,
      0x89283080dcbffff,
      0x89283080dcfffff,
      0x89283080dcbffff,
      0x89283080d53ffff,
      0x89283080d57ffff,
      0x89283080d1bffff,
      0x89283080dc7ffff,
      0x89283080dc3ffff,
      0x89283080dc3ffff,
      0x89283080ddbffff,
      0x89283080dcbffff,
      0x89283080dcfffff,
      0x89283080dc7ffff,
      0x89283080dd7ffff,
      0x89283080dd3ffff
    ]);
  });
}

// ignore: unused_element
void _printGeoJson(List<int> data) {
  print(jsonEncode(<String, dynamic>{
    'type': 'FeatureCollection',
    'features': data.map(_h3ToGeoJson).toList(),
  }));
}

Map<String, dynamic> _h3ToGeoJson(int h3) {
  final List<List<double>> coordinates =
      h3ToGeoBoundary(h3).map((GeoCoord it) => <double>[it.lonDeg, it.latDeg]).toList();

  return <String, dynamic>{
    'type': 'Feature',
    'properties': <String, dynamic>{},
    'geometry': <String, dynamic>{
      'type': 'Polygon',
      'coordinates': <List<List<double>>>[
        <List<double>>[
          ...coordinates,
          coordinates[0],
        ]
      ]
    }
  };
}
