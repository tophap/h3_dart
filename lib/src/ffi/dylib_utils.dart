// File created by
// Lung Razvan <long1eu>
// on 22/08/2019

import 'dart:ffi' as ffi;
import 'dart:io' show Platform;

String _platformPath(String name) {
  if (Platform.isLinux || Platform.isAndroid) {
    return 'lib' + name + '.so';
  }
  if (Platform.isMacOS) {
    return 'ios/build/lib' + name + '.dylib';
  }
  if (Platform.isWindows) {
    return name + '.dll';
  }

  throw Exception('Platform not implemented');
}

ffi.DynamicLibrary dlopenPlatformSpecific(String name) {
  final String fullPath = _platformPath(name);
  return ffi.DynamicLibrary.open(fullPath);
}
