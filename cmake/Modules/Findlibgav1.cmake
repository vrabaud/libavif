# - Try to find libgav1
# Once done this will define
#
#  LIBGAV1_FOUND - system has libgav1
#  LIBGAV1_INCLUDE_DIR - the libgav1 include directory
#  LIBGAV1_LIBRARIES - Link these to use libgav1
#
#=============================================================================
#  Copyright (c) 2020 Google LLC
#
#  Distributed under the OSI-approved BSD License (the "License");
#  see accompanying file Copyright.txt for details.
#
#  This software is distributed WITHOUT ANY WARRANTY; without even the
#  implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
#  See the License for more information.
#=============================================================================
#

find_package(PkgConfig QUIET)
if(PKG_CONFIG_FOUND)
    pkg_check_modules(_LIBGAV1 libgav1)
endif(PKG_CONFIG_FOUND)

find_path(LIBGAV1_INCLUDE_DIR NAMES gav1/decoder.h PATHS ${_LIBGAV1_INCLUDEDIR})

find_library(LIBGAV1_LIBRARY NAMES gav1 PATHS ${_LIBGAV1_LIBDIR})

if(LIBGAV1_LIBRARY)
    set(LIBGAV1_LIBRARIES ${LIBGAV1_LIBRARIES} ${LIBGAV1_LIBRARY})
endif(LIBGAV1_LIBRARY)

include(FindPackageHandleStandardArgs)
find_package_handle_standard_args(
    libgav1 REQUIRED_VARS LIBGAV1_LIBRARY LIBGAV1_LIBRARIES LIBGAV1_INCLUDE_DIR VERSION_VAR _LIBGAV1_VERSION
)

# show the LIBGAV1_INCLUDE_DIR, LIBGAV1_LIBRARY and LIBGAV1_LIBRARIES variables
# only in the advanced view
mark_as_advanced(LIBGAV1_INCLUDE_DIR LIBGAV1_LIBRARY LIBGAV1_LIBRARIES)

if(LIBGAV1_LIBRARY)
    add_library(libgav1::libgav1 STATIC IMPORTED GLOBAL)
    set_target_properties(
        libgav1::libgav1 PROPERTIES IMPORTED_LOCATION "${LIBGAV1_LIBRARY}" IMPORTED_IMPLIB "${LIBGAV1_LIBRARY}" IMPORTED_SONAME
                                                                                                                gav1
    )
    target_include_directories(libgav1::libgav1 INTERFACE ${LIBGAV1_INCLUDE_DIR})
endif()
