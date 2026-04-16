# Distributed under the OSI-approved BSD 3-Clause License.  See accompanying
# file Copyright.txt or https://cmake.org/licensing for details.

cmake_minimum_required(VERSION ${CMAKE_VERSION}) # this file comes with cmake

# If CMAKE_DISABLE_SOURCE_CHANGES is set to true and the source directory is an
# existing directory in our source tree, calling file(MAKE_DIRECTORY) on it
# would cause a fatal error, even though it would be a no-op.
if(NOT EXISTS "/home/matias/personal/mujoco/build2/_deps/dear_imgui-src")
  file(MAKE_DIRECTORY "/home/matias/personal/mujoco/build2/_deps/dear_imgui-src")
endif()
file(MAKE_DIRECTORY
  "/home/matias/personal/mujoco/build2/_deps/dear_imgui-build"
  "/home/matias/personal/mujoco/build2/_deps/dear_imgui-subbuild/dear_imgui-populate-prefix"
  "/home/matias/personal/mujoco/build2/_deps/dear_imgui-subbuild/dear_imgui-populate-prefix/tmp"
  "/home/matias/personal/mujoco/build2/_deps/dear_imgui-subbuild/dear_imgui-populate-prefix/src/dear_imgui-populate-stamp"
  "/home/matias/personal/mujoco/build2/_deps/dear_imgui-subbuild/dear_imgui-populate-prefix/src"
  "/home/matias/personal/mujoco/build2/_deps/dear_imgui-subbuild/dear_imgui-populate-prefix/src/dear_imgui-populate-stamp"
)

set(configSubDirs )
foreach(subDir IN LISTS configSubDirs)
    file(MAKE_DIRECTORY "/home/matias/personal/mujoco/build2/_deps/dear_imgui-subbuild/dear_imgui-populate-prefix/src/dear_imgui-populate-stamp/${subDir}")
endforeach()
if(cfgdir)
  file(MAKE_DIRECTORY "/home/matias/personal/mujoco/build2/_deps/dear_imgui-subbuild/dear_imgui-populate-prefix/src/dear_imgui-populate-stamp${cfgdir}") # cfgdir has leading slash
endif()
