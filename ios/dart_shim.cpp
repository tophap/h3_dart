//
// Created by Razvan Lung on 26/08/2019.
//

#ifndef DART_SHIM_H_
#define DART_SHIM_H_

#import <iostream>
#import "h3/src/h3lib/include/h3api.h"

#define EXPORT extern "C" __attribute__((visibility("default"))) __attribute((used))

EXPORT int h3ToGeoBoundary_dart(H3Index h3, GeoCoord* g) {
  GeoBoundary p;
  h3ToGeoBoundary(h3, &p);

  for (size_t i = 0; i < p.numVerts; i++) {
    g[i] = p.verts[i];
  }

  return p.numVerts;
}

#endif //DART_SHIM_H_
