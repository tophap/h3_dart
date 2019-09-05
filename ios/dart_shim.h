//
// Created by Razvan Lung on 26/08/2019.
//

#ifndef DART_SHIM_H_
#define DART_SHIM_H_

#import <iostream>
#import <memory>
#import "h3/src/h3lib/include/h3api.h"

#define EXPORT extern "C" __attribute__((visibility("default"))) __attribute((used))

EXPORT int h3ToGeoBoundary_shim(H3Index h3, GeoCoord* g);

EXPORT int maxPolyfillSize_shim(const GeoCoord* geofence,
                                int geofenceNum,
                                GeoCoord** holes,
                                const int* holesSizes,
                                int holesNum,
                                int res);

EXPORT void polyfill_shim(const GeoCoord* geofence,
                          int geofenceNum,
                          GeoCoord** holes,
                          const int* holesSizes,
                          int holesNum,
                          int res,
                          H3Index* out);
#endif //DART_SHIM_H_
