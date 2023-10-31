cmake_minimum_required(VERSION 3.15)
project(plugin VERSION ${CMAKE_PROJECT_VERSION})

juce_add_plugin(HISE
    PRODUCT_NAME "HISE"
    BUNDLE_ID "com.hartinstruments.HISE"
    ICON_BIG "../../hi_core/hi_images/logo_new.png"
    PLUGIN_MANUFACTURER_CODE Hain               
    PLUGIN_CODE Hise                            
    FORMATS AU VST3
    IS_SYNTH ON                       
    NEEDS_MIDI_INPUT ON               
    NEEDS_MIDI_OUTPUT ON              
    IS_MIDI_EFFECT OFF                 
    EDITOR_WANTS_KEYBOARD_FOCUS ON
    HARDENED_RUNTIME_ENABLED ON
    NEEDS_WEB_BROWSER ON
    NEEDS_CURL ON
)

clap_juce_extensions_plugin(
    TARGET
        HISE
    CLAP_ID
        "com.hartinstruments.HISE"
    CLAP_FEATURES
        instrument 
        sampler
)

juce_generate_juce_header(HISE)

target_sources(HISE
    PRIVATE
        Source/PluginProcessor.h
        Source/PluginProcessor.cpp
)

target_compile_definitions(HISE
    PRIVATE
        HI_ENABLE_EXPANSION_EDITING=1
        HI_EXPORT_DSP_LIBRARY=0
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
        USE_COPY_PROTECTION=0

        JUCE_APPLICATION_NAME_STRING="$<TARGET_PROPERTY:HISE,JUCE_PRODUCT_NAME>"
        JUCE_APPLICATION_VERSION_STRING="$<TARGET_PROPERTY:HISE,JUCE_VERSION>"
        JUCE_DISABLE_JUCE_VERSION_PRINTING=1
        JUCE_DISPLAY_SPLASH_SCREEN=0
        JUCE_REPORT_APP_USAGE=0
        JUCE_VST3_CAN_REPLACE_VST2=0
)

target_include_directories(HISE
    PRIVATE
        ${PROJECT_SOURCE_DIR}/Source/Config
)

target_link_libraries(HISE
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

