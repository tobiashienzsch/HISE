cmake_minimum_required(VERSION 3.23)
project(HISE VERSION 3.6.2)

find_program(CCACHE ccache)
if (CCACHE)
    set(CMAKE_C_COMPILER_LAUNCHER ${CCACHE})
    set(CMAKE_CXX_COMPILER_LAUNCHER ${CCACHE})
endif ()

set(CMAKE_C_STANDARD 11)
set(CMAKE_C_EXTENSIONS ON)
set(CMAKE_C_STANDARD_REQUIRED ON)

set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_EXTENSIONS ON)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

set(CMAKE_EXPORT_COMPILE_COMMANDS ON)

add_subdirectory(JUCE)

set_directory_properties(PROPERTIES
    JUCE_COMPANY_NAME       "Hart Instruments"
    JUCE_COMPANY_WEBSITE    "http://hise.audio"
    JUCE_COMPANY_COPYRIGHT  "Copyright (c) 2023 - Hart Instruments"
)

juce_add_modules(ALIAS_NAMESPACE hise
    hi_backend
    hi_core
    hi_dsp_library
    hi_faust
    hi_faust_jit
    hi_faust_lib
    hi_faust_types
    hi_frontend
    hi_lac
    hi_rlottie
    hi_scripting
    hi_snex
    hi_streaming
    hi_tools
    hi_zstd
)

add_subdirectory(projects/standalone)
