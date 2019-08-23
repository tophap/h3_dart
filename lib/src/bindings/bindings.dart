// File created by
// Lung Razvan <long1eu>
// on 22/08/2019

import 'dart:ffi';

import 'package:h3_ffi/src/bindings/types.dart';
import 'package:h3_ffi/src/ffi/dylib_utils.dart';

import 'signatures.dart';

class _H3Bindings {
  _H3Bindings() {
    h3 = dlopenPlatformSpecific('h3');
    geoToH3 = h3.lookup<NativeFunction<geoToH3_native_t>>('geoToH3').asFunction();
    h3ToGeo = h3.lookup<NativeFunction<h3ToGeo_native_t>>('h3ToGeo').asFunction();
    h3ToGeoBoundary = h3.lookup<NativeFunction<h3ToGeoBoundary_native_t>>('h3ToGeoBoundary').asFunction();
  }

  DynamicLibrary h3;

  /// Find the H3 index of the resolution [res] cell containing the lat/lon [g]
  int Function(Pointer<GeoCoordNative> g, int res) geoToH3;

  /// Find the lat/lon center point g of the cell h3
  void Function(int h3, Pointer<GeoCoordNative> g) h3ToGeo;

  /// Give the cell boundary in lat/lon coordinates for the cell h3
  void Function(int h3, Pointer<GeoBoundaryNative> gp) h3ToGeoBoundary;
}

_H3Bindings _cachedBindings;

_H3Bindings get bindings => _cachedBindings ??= _H3Bindings();