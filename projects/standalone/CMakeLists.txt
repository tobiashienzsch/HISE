cmake_minimum_required(VERSION 3.15)
project(standalone VERSION ${CMAKE_PROJECT_VERSION})

juce_add_gui_app(HISE_Standalone
    PRODUCT_NAME "HISE Standalone"
    BUNDLE_ID "com.hartinstruments.HISEStandalone"
    ICON_BIG "../../hi_core/hi_images/logo_new.png"
    HARDENED_RUNTIME_ENABLED ON
    NEEDS_WEB_BROWSER ON
    NEEDS_CURL ON
)

juce_generate_juce_header(HISE_Standalone)
hise_generate_appconfig_stub(HISE_Standalone)

target_sources(HISE_Standalone
    PRIVATE
        Source/Main.cpp
        Source/MainComponent.cpp
)

target_compile_definitions(HISE_Standalone
    PRIVATE
        HI_ENABLE_EXPANSION_EDITING=1
        HI_EXPORT_DSP_LIBRARY=0
        HI_RUN_UNIT_TESTS=1
        HI_SUPPORT_FULL_DYNAMICS_HLAC=1
        
        HISE_ENABLE_EXPANSIONS=1
        HISE_ENABLE_MIDI_INPUT_FOR_FX=1 
        HISE_INCLUDE_RLOTTIE=1
        HISE_INCLUDE_SNEX=1
        HISE_NO_GUI_TOOLS=0
        HISE_SCRIPT_SERVER_TIMEOUT=20000

        ENABLE_PLOTTER=1
        ENABLE_SCRIPTING_SAFE_CHECKS=1
        ENABLE_SCRIPTING_BREAKPOINTS=1
        ENABLE_ALL_PEAK_METERS=1

        USE_IPP=0
        USE_BACKEND=1
        USE_FRONTEND=0 
        USE_RAW_FRONTEND=0
        IS_STANDALONE_APP=1 
        IS_STANDALONE_FRONTEND=0
        USE_COPY_PROTECTION=0

        JUCE_APPLICATION_NAME_STRING="$<TARGET_PROPERTY:HISE_Standalone,JUCE_PRODUCT_NAME>"
        JUCE_APPLICATION_VERSION_STRING="$<TARGET_PROPERTY:HISE_Standalone,JUCE_VERSION>"
        JUCE_DISABLE_JUCE_VERSION_PRINTING=1
        JUCE_DISPLAY_SPLASH_SCREEN=0
        JUCE_REPORT_APP_USAGE=0
        JUCE_ASIO=1
)

target_include_directories(HISE_Standalone
    PRIVATE
        ${CMAKE_SOURCE_DIR}/tools/SDK/ASIOSDK2.3/common
)

target_link_libraries(HISE_Standalone
    PRIVATE
        juce::juce_audio_utils
        juce::juce_cryptography
        juce::juce_dsp
        juce::juce_gui_extra
        juce::juce_opengl
        juce::juce_osc
        juce::juce_product_unlocking

        hise::hi_backend
        hise::hi_core
        hise::hi_dsp_library
        hise::hi_faust
        hise::hi_faust_jit
        hise::hi_faust_lib
        hise::hi_faust_types
        hise::hi_lac
        hise::hi_rlottie
        hise::hi_scripting
        hise::hi_snex
        hise::hi_streaming
        hise::hi_tools
        hise::hi_zstd

    PUBLIC
        HISE_BinaryData

        juce::juce_recommended_config_flags
        juce::juce_recommended_lto_flags
        # juce::juce_recommended_warning_flags

        hise::compiler_options
        hise::compiler_warnings
)

add_test(
    NAME
        HISE_Tests
    COMMAND
        $<TARGET_FILE:HISE_Standalone> run_unit_tests
    WORKING_DIRECTORY
        ${CMAKE_SOURCE_DIR}
)

set_property(
    TEST 
        HISE_Tests
    PROPERTY ENVIRONMENT 
        "HISE_SNEX_TEST_FILES=${CMAKE_SOURCE_DIR}/tools/snex_playground/test_files"
)