# Copyright 2025 DeepMind Technologies Limited
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

set(CMAKE_RUNTIME_OUTPUT_DIRECTORY "${CMAKE_SOURCE_DIR}/wasm/dist")
set(CMAKE_INSTALL_PREFIX ${PROJECT_SOURCE_DIR}/wasm)

include_directories(${PROJECT_SOURCE_DIR}/include)
include_directories(${PROJECT_SOURCE_DIR}/src)
include_directories(${PROJECT_SOURCE_DIR})

link_directories(${CMAKE_BINARY_DIR}/lib)

option(MUJOCO_BUILD_WASM_FILAMENT "Build MuJoCo WASM with Filament support" ON)

# Filament support requires a host build of Filament for tools like matc and resgen.
set(FILAMENT_IMPORT_EXECUTABLES "" CACHE FILEPATH "Path to Filament's ImportExecutables-Release.cmake")
include(${FILAMENT_IMPORT_EXECUTABLES})


set(FILAMENT_ASSETS_DIR "${PROJECT_SOURCE_DIR}/src/experimental/filament/assets")
set(GEN_DIR "${CMAKE_CURRENT_BINARY_DIR}/codegen/generated")
file(MAKE_DIRECTORY ${GEN_DIR})

set(MATC_EXECUTABLE matc)
set(MATERIAL_FILES
    pbr.mat pbr_packed.mat phong_2d_fade.mat phong_2d.mat phong_2d_reflect.mat
    phong_2d_uv_fade.mat phong_2d_uv.mat phong_2d_uv_reflect.mat phong_color_fade.mat
    phong_color.mat phong_color_reflect.mat phong_cube_fade.mat phong_cube.mat
    phong_cube_reflect.mat unlit_decor.mat unlit_depth.mat unlit_line.mat
    unlit_segmentation.mat unlit_ui.mat
)

set(FILAMAT_FILES "")
foreach(MAT_FILE ${MATERIAL_FILES})
    get_filename_component(MAT_NAME ${MAT_FILE} NAME_WE)
    set(OUTPUT_FILE "${GEN_DIR}/${MAT_NAME}.filamat")
    add_custom_command(
        OUTPUT ${OUTPUT_FILE}
        COMMAND ${MATC_EXECUTABLE} --platform=all --api=opengl --api=vulkan --variant-filter skinning --optimize-size --output ${OUTPUT_FILE} ${FILAMENT_ASSETS_DIR}/${MAT_FILE}
        DEPENDS ${FILAMENT_ASSETS_DIR}/${MAT_FILE} matc
        COMMENT "Compiling material ${MAT_FILE}"
    )
    list(APPEND FILAMAT_FILES ${OUTPUT_FILE})
endforeach()

set(EMBED_H "${GEN_DIR}/filament_assets_embed.h")
set(EMBED_CC "${GEN_DIR}/filament_assets_embed.cc")
set(IBL_FILE "${FILAMENT_ASSETS_DIR}/ibl.ktx")

add_custom_command(
    OUTPUT ${EMBED_H} ${EMBED_CC}
    COMMAND python3 ${CMAKE_CURRENT_SOURCE_DIR}/codegen/embed_assets.py
            --output_h ${EMBED_H}
            --output_cc ${EMBED_CC}
            --namespace mujoco
            --strip ${GEN_DIR}
            ${FILAMAT_FILES}
            ${IBL_FILE}
    DEPENDS ${FILAMAT_FILES} ${IBL_FILE} ${CMAKE_CURRENT_SOURCE_DIR}/codegen/embed_assets.py
    COMMENT "Embedding filament assets"
)
list(APPEND MUJOCO_WASM_EXTRA_SOURCES ${EMBED_CC})
include_directories(${GEN_DIR})

file(GLOB MUJOCO_WASM_FILES
    "codegen/generated/*.cc"
    "unpack.cc"
)
list(APPEND MUJOCO_WASM_FILES ${MUJOCO_WASM_EXTRA_SOURCES})

if(MUJOCO_BUILD_WASM_FILAMENT)
    set(PLATFORM_DIR "../src/experimental/platform")
    set(FILAMENT_DIR "../src/experimental/filament")
    list(APPEND MUJOCO_WASM_FILES
        ${PLATFORM_DIR}/hal/graphics_mode.cc
        ${PLATFORM_DIR}/hal/renderer.cc
        ${PLATFORM_DIR}/hal/window.cc
        ${PLATFORM_DIR}/sim/step_control.cc

        ${FILAMENT_DIR}/render_context_filament.cc
        ${FILAMENT_DIR}/mjr_compat.cc
        ${FILAMENT_DIR}/filament/builtins.cc
        ${FILAMENT_DIR}/filament/color_grading_options.cc
        ${FILAMENT_DIR}/filament/filament_context.cc
        ${FILAMENT_DIR}/filament/filament_platform_factory.cc
        ${FILAMENT_DIR}/filament/imgui_bridge.cc
        ${FILAMENT_DIR}/filament/imgui_editor.cc
        ${FILAMENT_DIR}/filament/light.cc
        ${FILAMENT_DIR}/filament/material.cc
        ${FILAMENT_DIR}/filament/math_util.cc
        ${FILAMENT_DIR}/filament/mesh.cc
        ${FILAMENT_DIR}/filament/model_objects.cc
        ${FILAMENT_DIR}/filament/object_manager.cc
        ${FILAMENT_DIR}/filament/render_target.cc
        ${FILAMENT_DIR}/filament/renderable.cc
        ${FILAMENT_DIR}/filament/scene_bridge.cc
        ${FILAMENT_DIR}/filament/scene_geom_util.cc
        ${FILAMENT_DIR}/filament/scene_view.cc
        ${FILAMENT_DIR}/filament/texture.cc
    )
    # Add necessary internal deps for experimental modules
    list(APPEND MUJOCO_WASM_FILES ${PLATFORM_DIR}/helpers.cc)
endif()

if(NOT MUJOCO_WASM_FILES)
    message(FATAL_ERROR "No source files found")
endif()

# Set Emscripten linker flags
set(EMCC_LINKER_FLAGS
    "--bind"
    "-s ASSERTIONS=1"
    "-s ALLOW_MEMORY_GROWTH=1"
    "-s EXPORT_ES6=1"
    "-s MODULARIZE=1"
    "-s FORCE_FILESYSTEM=1"
    "-s EXPORTED_RUNTIME_METHODS=['ccall','cwrap','FS','MEMFS']"
    "-s EXPORT_NAME=loadMujoco"
    "-s DISABLE_EXCEPTION_CATCHING=0"
    "-gsource-map"
    "-g"
    "--emit-tsd mujoco.d.ts"
)

if(MUJOCO_BUILD_WASM_FILAMENT)
    list(APPEND EMCC_LINKER_FLAGS
        "-s USE_WEBGL2=1"
        "-s FULL_ES3=1"
        "-s USE_SDL=2"
    )
endif()

if(MUJOCO_WASM_THREADS)
    list(APPEND EMCC_LINKER_FLAGS
        "-pthread"
        "-s PTHREAD_POOL_SIZE=navigator.hardwareConcurrency"
    )
    add_definitions(-DMUJOCO_WASM_THREADS)
endif()

string (REPLACE ";" " " EMCC_LINKER_FLAGS_STR "${EMCC_LINKER_FLAGS}")

add_executable(mujoco_wasm ${MUJOCO_WASM_FILES})

set_target_properties(mujoco_wasm PROPERTIES
    LINK_FLAGS "${EMCC_LINKER_FLAGS_STR}"
    OUTPUT_NAME "mujoco"
)

# Link dependencies
target_link_libraries(mujoco_wasm PRIVATE
    -Wl,--whole-archive mujoco -Wl,--no-whole-archive
    ccd lodepng tinyxml2 qhullstatic_r
)

if(MUJOCO_BUILD_WASM_FILAMENT)
    include(third_party_deps/filament)
    include(third_party_deps/sdl2)
    include(third_party_deps/dear_imgui)
    target_link_libraries(mujoco_wasm PRIVATE
        filament
        dear_imgui
    )
endif()

install(TARGETS mujoco_wasm DESTINATION ${DIVISIBLE_INSTALL_BIN_DIR})



