# Copyright 2025 DeepMind Technologies Limited
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     https://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

add_library(dear_imgui STATIC)
target_include_directories(dear_imgui
  PUBLIC
    ${dear_imgui_SOURCE_DIR}
)
target_sources(dear_imgui
  PUBLIC
    ${dear_imgui_SOURCE_DIR}/imgui.h
    ${dear_imgui_SOURCE_DIR}/imgui.cpp
    ${dear_imgui_SOURCE_DIR}/imgui_internal.h
    ${dear_imgui_SOURCE_DIR}/imgui_draw.cpp
    ${dear_imgui_SOURCE_DIR}/imgui_tables.cpp
    ${dear_imgui_SOURCE_DIR}/imgui_widgets.cpp
    ${dear_imgui_SOURCE_DIR}/imgui_demo.cpp
)

# SDL2 backend
# Prefer to use SDL2 if it is available, but skip the SDL2 backend when it
# is not present to avoid build failures in contexts without SDL2 support.
if(TARGET SDL2::SDL2-static OR TARGET SDL2-static OR TARGET SDL2::SDL2 OR TARGET SDL2)
  if(NOT TARGET SDL2::SDL2-static)
    if(TARGET SDL2-static)
      add_library(SDL2::SDL2-static ALIAS SDL2-static)
    elseif(TARGET SDL2::SDL2)
      add_library(SDL2::SDL2-static ALIAS SDL2::SDL2)
    elseif(TARGET SDL2)
      add_library(SDL2::SDL2-static ALIAS SDL2)
    endif()
  endif()

  add_library(dear_imgui_SDL2 STATIC)
  target_include_directories(dear_imgui_SDL2
    PUBLIC
      ${dear_imgui_SOURCE_DIR}
  )
  target_sources(dear_imgui_SDL2
    PUBLIC
      ${dear_imgui_SOURCE_DIR}/backends/imgui_impl_sdl2.cpp
  )
  target_link_libraries(dear_imgui_SDL2
    SDL2::SDL2-static
  )
endif()

# OpenGL3 backend
add_library(dear_imgui_OpenGL3 STATIC)
target_include_directories(dear_imgui_OpenGL3
  PUBLIC
    ${dear_imgui_SOURCE_DIR}
)
target_sources(dear_imgui_OpenGL3
  PUBLIC
    ${dear_imgui_SOURCE_DIR}/backends/imgui_impl_opengl3.h
    ${dear_imgui_SOURCE_DIR}/backends/imgui_impl_opengl3.cpp
)

# stdlib
add_library(dear_imgui_stdlib STATIC)
target_include_directories(dear_imgui_stdlib
  PUBLIC
    ${dear_imgui_SOURCE_DIR}
)
target_sources(dear_imgui_stdlib
  PUBLIC
    ${dear_imgui_SOURCE_DIR}/misc/cpp/imgui_stdlib.h
    ${dear_imgui_SOURCE_DIR}/misc/cpp/imgui_stdlib.cpp
)
