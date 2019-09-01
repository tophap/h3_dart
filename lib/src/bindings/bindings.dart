// File created by
// Lung Razvan <long1eu>
// on 22/08/2019

import 'dart:ffi';

import 'package:h3_ffi/src/bindings/types.dart';
import 'package:h3_ffi/src/ffi/dylib_utils.dart';

import 'signatures.dart';

typedef LibraryLoader = DynamicLibrary Function(String name);

class _H3Bindings {
  DynamicLibrary h3;

  void initialize(LibraryLoader loader) {
    h3 = loader?.call('h3') ?? dlopenPlatformSpecific('h3');

    geoToH3 = h3.lookup<NativeFunction<geoToH3_native_t>>('geoToH3').asFunction();
    h3ToGeo = h3.lookup<NativeFunction<h3ToGeo_native_t>>('h3ToGeo').asFunction();
    h3ToGeoBoundary = h3.lookup<NativeFunction<h3ToGeoBoundary_native_t>>('h3ToGeoBoundary_dart').asFunction();
    maxKringSize = h3.lookup<NativeFunction<maxKringSize_native_t>>('maxKringSize').asFunction();
    hexRange = h3.lookup<NativeFunction<hexRange_native_t>>('hexRange').asFunction();
    hexRangeDistances = h3.lookup<NativeFunction<hexRangeDistances_native_t>>('hexRangeDistances').asFunction();
    hexRanges = h3.lookup<NativeFunction<hexRanges_native_t>>('hexRanges').asFunction();
    kRing = h3.lookup<NativeFunction<kRing_native_t>>('kRing').asFunction();
    kRingDistances = h3.lookup<NativeFunction<kRingDistances_native_t>>('kRingDistances').asFunction();
  }

  /// Find the H3 index of the resolution [res] cell containing the lat/lon [g]
  int Function(Pointer<GeoCoordNative> g, int res) geoToH3;

  /// Find the lat/lon center point g of the cell h3
  void Function(int h3, Pointer<GeoCoordNative> g) h3ToGeo;

  /// Give the cell boundary in lat/lon coordinates for the cell h3
  int Function(int h3, Pointer<GeoCoordNative> g) h3ToGeoBoundary;

  /// Maximum number of hexagons in k-ring
  int Function(int k) maxKringSize;

  /// Hexagons neighbors in all directions, assuming no pentagons
  int Function(int origin, int k, Pointer<Uint64> out) hexRange;

  /// Hexagon neighbors in all directions, reporting distance from origin
  int Function(int origin, int k, Pointer<Uint64> out, Pointer<Int32> distances) hexRangeDistances;

  /// Collection of hex rings sorted by ring for all given hexagons
  int Function(Pointer<Uint64> h3Set, int length, int k, Pointer<Uint64> out) hexRanges;

  /// Hexagon neighbors in all directions
  void Function(int origin, int k, Pointer<Uint64> out) kRing;

  /// Hexagon neighbors in all directions, reporting distance from origin
  void Function(int origin, int k, Pointer<Uint64> out, Pointer<Int32> distances) kRingDistances;
}

_H3Bindings _cachedBindings;

_H3Bindings get bindings => _cachedBindings ??= _H3Bindings();
