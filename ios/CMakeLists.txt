cmake_minimum_required(VERSION 3.1)

list(APPEND H3_COMPILE_FLAGS -Wall)

list(APPEND H3_COMPILE_FLAGS $<$<CONFIG:Debug>:-gdwarf-2 -g3 -O0 -fno-inline -fno-eliminate-unused-debug-types>)

include_directories(h3/src/h3lib/include)
include_directories(${CMAKE_CURRENT_BINARY_DIR})

set(LIB_SOURCE_FILES
        h3/src/h3lib/include/bbox.h
        h3/src/h3lib/include/polygon.h
        h3/src/h3lib/include/polygonAlgos.h
        h3/src/h3lib/include/h3Index.h
        h3/src/h3lib/include/h3UniEdge.h
        h3/src/h3lib/include/geoCoord.h
        h3/src/h3lib/include/vec2d.h
        h3/src/h3lib/include/vec3d.h
        h3/src/h3lib/include/linkedGeo.h
        h3/src/h3lib/include/localij.h
        h3/src/h3lib/include/baseCells.h
        h3/src/h3lib/include/faceijk.h
        h3/src/h3lib/include/vertexGraph.h
        h3/src/h3lib/include/mathExtensions.h
        h3/src/h3lib/include/constants.h
        h3/src/h3lib/include/coordijk.h
        h3/src/h3lib/include/algos.h
        h3/src/h3lib/lib/algos.c
        h3/src/h3lib/lib/coordijk.c
        h3/src/h3lib/lib/bbox.c
        h3/src/h3lib/lib/polygon.c
        h3/src/h3lib/lib/h3Index.c
        h3/src/h3lib/lib/vec2d.c
        h3/src/h3lib/lib/vec3d.c
        h3/src/h3lib/lib/linkedGeo.c
        h3/src/h3lib/lib/localij.c
        h3/src/h3lib/lib/geoCoord.c
        h3/src/h3lib/lib/h3UniEdge.c
        h3/src/h3lib/lib/mathExtensions.c
        h3/src/h3lib/lib/vertexGraph.c
        h3/src/h3lib/lib/faceijk.c
        h3/src/h3lib/lib/baseCells.c)


set(UNCONFIGURED_API_HEADER h3/src/h3lib/include/h3api.h.in)
set(CONFIGURED_API_HEADER ../h3/src/h3lib/include/h3api.h)
configure_file(${UNCONFIGURED_API_HEADER} ${CONFIGURED_API_HEADER})

add_library(h3 SHARED ${LIB_SOURCE_FILES} ${CONFIGURED_API_HEADER})

add_library(h3-static STATIC ${LIB_SOURCE_FILES} ${CONFIGURED_API_HEADER})
set_target_properties(h3-static PROPERTIES OUTPUT_NAME "h3")

