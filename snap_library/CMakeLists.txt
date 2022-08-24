cmake_minimum_required(VERSION 3.7 FATAL_ERROR)
project(snap_library VERSION 1.0.0 LANGUAGES C)
add_library(snap_library SHARED snap.c snap.def)

find_library(CAIRO_LIB_RELEASE cairo)
find_library(CAIRO_GOBJECT_LIB_DEBUG cairo-gobjectd)
find_library(CAIRO_GOBJECT_LIB_RELEASE cairo-gobject)

target_link_libraries(snap_library cairo)

target_link_libraries(snap_library ${Cairo_LIBRARIES})

target_include_directories(snap_library
PUBLIC ${CAIRO_INCLUDE_DIR})

target_link_libraries(snap_library cairo)

set_target_properties(snap_library PROPERTIES
    PUBLIC_HEADER snap.h
    VERSION ${PROJECT_VERSION}
    SOVERSION 1
    OUTPUT_NAME "snap"
    XCODE_ATTRIBUTE_CODE_SIGN_IDENTITY "Hex_Identity_ID_Goes_Here"
)
