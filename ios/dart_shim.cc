//
// Created by Razvan Lung on 26/08/2019.
//

#import "dart_shim.h"

Geofence* buildGeofenceFromGeoCoord(const GeoCoord* geo_coord, int geofenceNum);
Geofence** buildGeoPolygonHolesFromGeofence(GeoCoord** holes,
                                            const int* holesSize,
                                            int holesNum);

EXPORT int h3ToGeoBoundary_shim(H3Index h3, GeoCoord* g) {
  GeoBoundary p;
  h3ToGeoBoundary(h3, &p);

  for (size_t i = 0; i < p.numVerts; i++) {
    g[i] = p.verts[i];
  }

  return p.numVerts;
}

EXPORT int maxPolyfillSize_shim(const GeoCoord* geofence,
                                int geofenceNum,
                                GeoCoord** holes,
                                const int* holesSizes,
                                int holesNum,
                                int res) {
  Geofence* geofencePtr = buildGeofenceFromGeoCoord(geofence, geofenceNum);
  Geofence** holesPtr = buildGeoPolygonHolesFromGeofence(holes, holesSizes, holesNum);

  GeoPolygon polygon;
  polygon.geofence = *geofencePtr;
  polygon.numHoles = holesNum;
  polygon.holes = *holesPtr;

  int result = maxPolyfillSize(&polygon, res);

  delete geofencePtr->verts;
  delete geofencePtr;
  for (size_t i = 0; i < holesNum; i++) {
    delete holesPtr[i]->verts;
    delete holesPtr[i];
  }
  delete holesPtr;

  return result;
}

EXPORT void polyfill_shim(const GeoCoord* geofence,
                          int geofenceNum,
                          GeoCoord** holes,
                          const int* holesSizes,
                          int holesNum,
                          int res,
                          H3Index* out) {
  Geofence* geofencePtr = buildGeofenceFromGeoCoord(geofence, geofenceNum);
  Geofence** holesPtr = buildGeoPolygonHolesFromGeofence(holes, holesSizes, holesNum);

  GeoPolygon polygon;
  polygon.geofence = *geofencePtr;
  polygon.numHoles = holesNum;
  polygon.holes = *holesPtr;

  polyfill(&polygon, res, out);

  delete geofencePtr->verts;
  delete geofencePtr;
  for (size_t i = 0; i < holesNum; i++) {
    delete holesPtr[i]->verts;
    delete holesPtr[i];
  }
  delete holesPtr;
}

Geofence** buildGeoPolygonHolesFromGeofence(GeoCoord** holes,
                                            const int* holesSize,
                                            int holesNum) {
  auto** holesPtr = new Geofence* [holesNum];
  for (size_t i = 0; i < holesNum; i++) {
    holesPtr[i] = buildGeofenceFromGeoCoord(holes[i], holesSize[i]);
  }

  return holesPtr;
}

Geofence* buildGeofenceFromGeoCoord(const GeoCoord* geo_coord, int geofenceNum) {
  auto g = new Geofence();
  g->numVerts = geofenceNum;
  g->verts = new GeoCoord[geofenceNum];
  for (size_t i = 0; i < geofenceNum; i++) {
    GeoCoord item = geo_coord[i];
    g->verts[i] = item;
  }

  return g;
}
