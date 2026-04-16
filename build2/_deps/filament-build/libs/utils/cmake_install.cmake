# Install script for directory: /home/matias/personal/mujoco/build2/_deps/filament-src/libs/utils

# Set the install prefix
if(NOT DEFINED CMAKE_INSTALL_PREFIX)
  set(CMAKE_INSTALL_PREFIX "/usr/local")
endif()
string(REGEX REPLACE "/$" "" CMAKE_INSTALL_PREFIX "${CMAKE_INSTALL_PREFIX}")

# Set the install configuration name.
if(NOT DEFINED CMAKE_INSTALL_CONFIG_NAME)
  if(BUILD_TYPE)
    string(REGEX REPLACE "^[^A-Za-z0-9_]+" ""
           CMAKE_INSTALL_CONFIG_NAME "${BUILD_TYPE}")
  else()
    set(CMAKE_INSTALL_CONFIG_NAME "Release")
  endif()
  message(STATUS "Install configuration: \"${CMAKE_INSTALL_CONFIG_NAME}\"")
endif()

# Set the component getting installed.
if(NOT CMAKE_INSTALL_COMPONENT)
  if(COMPONENT)
    message(STATUS "Install component: \"${COMPONENT}\"")
    set(CMAKE_INSTALL_COMPONENT "${COMPONENT}")
  else()
    set(CMAKE_INSTALL_COMPONENT)
  endif()
endif()

# Install shared libraries without execute permission?
if(NOT DEFINED CMAKE_INSTALL_SO_NO_EXE)
  set(CMAKE_INSTALL_SO_NO_EXE "1")
endif()

# Is this installation the result of a crosscompile?
if(NOT DEFINED CMAKE_CROSSCOMPILING)
  set(CMAKE_CROSSCOMPILING "FALSE")
endif()

# Set path to fallback-tool for dependency-resolution.
if(NOT DEFINED CMAKE_OBJDUMP)
  set(CMAKE_OBJDUMP "/usr/bin/objdump")
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "Unspecified" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/lib/x86_64" TYPE STATIC_LIBRARY FILES "/home/matias/personal/mujoco/build2/lib/libutils.a")
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "Unspecified" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/include/utils" TYPE FILE FILES
    "/home/matias/personal/mujoco/build2/_deps/filament-src/libs/utils/include/utils/algorithm.h"
    "/home/matias/personal/mujoco/build2/_deps/filament-src/libs/utils/include/utils/bitset.h"
    "/home/matias/personal/mujoco/build2/_deps/filament-src/libs/utils/include/utils/CallStack.h"
    "/home/matias/personal/mujoco/build2/_deps/filament-src/libs/utils/include/utils/debug.h"
    "/home/matias/personal/mujoco/build2/_deps/filament-src/libs/utils/include/utils/Allocator.h"
    "/home/matias/personal/mujoco/build2/_deps/filament-src/libs/utils/include/utils/BitmaskEnum.h"
    "/home/matias/personal/mujoco/build2/_deps/filament-src/libs/utils/include/utils/compiler.h"
    "/home/matias/personal/mujoco/build2/_deps/filament-src/libs/utils/include/utils/compressed_pair.h"
    "/home/matias/personal/mujoco/build2/_deps/filament-src/libs/utils/include/utils/CString.h"
    "/home/matias/personal/mujoco/build2/_deps/filament-src/libs/utils/include/utils/ImmutableCString.h"
    "/home/matias/personal/mujoco/build2/_deps/filament-src/libs/utils/include/utils/Entity.h"
    "/home/matias/personal/mujoco/build2/_deps/filament-src/libs/utils/include/utils/EntityInstance.h"
    "/home/matias/personal/mujoco/build2/_deps/filament-src/libs/utils/include/utils/EntityManager.h"
    "/home/matias/personal/mujoco/build2/_deps/filament-src/libs/utils/include/utils/FixedCapacityVector.h"
    "/home/matias/personal/mujoco/build2/_deps/filament-src/libs/utils/include/utils/Hash.h"
    "/home/matias/personal/mujoco/build2/_deps/filament-src/libs/utils/include/utils/InternPool.h"
    "/home/matias/personal/mujoco/build2/_deps/filament-src/libs/utils/include/utils/Invocable.h"
    "/home/matias/personal/mujoco/build2/_deps/filament-src/libs/utils/include/utils/Log.h"
    "/home/matias/personal/mujoco/build2/_deps/filament-src/libs/utils/include/utils/Logger.h"
    "/home/matias/personal/mujoco/build2/_deps/filament-src/libs/utils/include/utils/memalign.h"
    "/home/matias/personal/mujoco/build2/_deps/filament-src/libs/utils/include/utils/MonotonicRingMap.h"
    "/home/matias/personal/mujoco/build2/_deps/filament-src/libs/utils/include/utils/Mutex.h"
    "/home/matias/personal/mujoco/build2/_deps/filament-src/libs/utils/include/utils/NameComponentManager.h"
    "/home/matias/personal/mujoco/build2/_deps/filament-src/libs/utils/include/utils/ostream.h"
    "/home/matias/personal/mujoco/build2/_deps/filament-src/libs/utils/include/utils/Panic.h"
    "/home/matias/personal/mujoco/build2/_deps/filament-src/libs/utils/include/utils/Path.h"
    "/home/matias/personal/mujoco/build2/_deps/filament-src/libs/utils/include/utils/PrivateImplementation.h"
    "/home/matias/personal/mujoco/build2/_deps/filament-src/libs/utils/include/utils/PrivateImplementation-impl.h"
    "/home/matias/personal/mujoco/build2/_deps/filament-src/libs/utils/include/utils/RefCountedMap.h"
    "/home/matias/personal/mujoco/build2/_deps/filament-src/libs/utils/include/utils/SingleInstanceComponentManager.h"
    "/home/matias/personal/mujoco/build2/_deps/filament-src/libs/utils/include/utils/Slice.h"
    "/home/matias/personal/mujoco/build2/_deps/filament-src/libs/utils/include/utils/StaticString.h"
    "/home/matias/personal/mujoco/build2/_deps/filament-src/libs/utils/include/utils/Status.h"
    "/home/matias/personal/mujoco/build2/_deps/filament-src/libs/utils/include/utils/StructureOfArrays.h"
    "/home/matias/personal/mujoco/build2/_deps/filament-src/libs/utils/include/utils/Systrace.h"
    "/home/matias/personal/mujoco/build2/_deps/filament-src/libs/utils/include/utils/sstream.h"
    "/home/matias/personal/mujoco/build2/_deps/filament-src/libs/utils/include/utils/unwindows.h"
    )
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "Unspecified" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/include/utils/generic" TYPE FILE FILES "/home/matias/personal/mujoco/build2/_deps/filament-src/libs/utils/include/utils/generic/Mutex.h")
endif()

string(REPLACE ";" "\n" CMAKE_INSTALL_MANIFEST_CONTENT
       "${CMAKE_INSTALL_MANIFEST_FILES}")
if(CMAKE_INSTALL_LOCAL_ONLY)
  file(WRITE "/home/matias/personal/mujoco/build2/_deps/filament-build/libs/utils/install_local_manifest.txt"
     "${CMAKE_INSTALL_MANIFEST_CONTENT}")
endif()
