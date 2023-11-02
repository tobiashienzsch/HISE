cmake_minimum_required(VERSION 3.15)
project(HISE VERSION 3.6.2)

find_program(CCACHE ccache)
if (CCACHE)
    set(CMAKE_C_COMPILER_LAUNCHER ${CCACHE})
    set(CMAKE_CXX_COMPILER_LAUNCHER ${CCACHE})
endif ()

set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_EXTENSIONS ON)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

set(CMAKE_EXPORT_COMPILE_COMMANDS ON)

enable_testing()
include(CTest)

include(tools/cmake/CompilerOptions.cmake)
include(tools/cmake/CompilerWarnings.cmake)
include(tools/cmake/GenerateAppConfigStub.cmake)

add_subdirectory(JUCE)
juce_disable_default_flags()

include(FetchContent)
FetchContent_Declare(clap-juce-extensions GIT_REPOSITORY "https://github.com/free-audio/clap-juce-extensions" GIT_TAG "main")
FetchContent_MakeAvailable(clap-juce-extensions)

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

juce_add_binary_data(HISE_BinaryData
    SOURCES
        "hi_core/hi_images/logo_new.png"
        "hi_core/hi_images/logo_mini.png"
        "hi_core/hi_images/infoError.png"
        "hi_core/hi_images/infoInfo.png"
        "hi_core/hi_images/infoQuestion.png"
        "hi_core/hi_images/infoWarning.png"
        "hi_core/hi_images/FrontendKnob_Bipolar.png"
        "hi_core/hi_images/FrontendKnob_Unipolar.png"
        "hi_core/hi_images/balanceKnob_200.png"
        "hi_core/hi_images/knobEmpty_200.png"
        "hi_core/hi_images/knobModulated_200.png"
        "hi_core/hi_images/knobUnmodulated_200.png"
        "hi_core/hi_images/toggle_200.png"
        "hi_core/hi_images/knob_without_arrow.png"
)

add_subdirectory(projects/plugin)
add_subdirectory(projects/standalone)

add_subdirectory(tools/hlac_tool)