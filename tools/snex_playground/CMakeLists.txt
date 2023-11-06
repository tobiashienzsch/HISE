cmake_minimum_required(VERSION 3.15)
project(snex_playground VERSION ${CMAKE_PROJECT_VERSION})

juce_add_gui_app(snex_playground
    PRODUCT_NAME "snex_playground"
    BUNDLE_ID "com.hise.snex_playground"
    HARDENED_RUNTIME_ENABLED ON
    NEEDS_WEB_BROWSER ON
    NEEDS_CURL ON
)

juce_generate_juce_header(snex_playground)
hise_generate_appconfig_stub(snex_playground)

target_sources(snex_playground
    PRIVATE
        Source/Main.cpp
        Source/MainComponent.cpp
)

target_compile_definitions(snex_playground
    PRIVATE
        SNEX_STANDALONE_PLAYGROUND=1

        HI_EXPORT_DSP_LIBRARY=0

        HISE_INCLUDE_RLOTTIE=0
        HISE_INCLUDE_SNEX=1

        JUCE_APPLICATION_NAME_STRING="$<TARGET_PROPERTY:snex_playground,JUCE_PRODUCT_NAME>"
        JUCE_APPLICATION_VERSION_STRING="$<TARGET_PROPERTY:snex_playground,JUCE_VERSION>"
        JUCE_DISABLE_JUCE_VERSION_PRINTING=1
        JUCE_DISPLAY_SPLASH_SCREEN=0
        JUCE_REPORT_APP_USAGE=0
        JUCE_ASIO=1
)

target_include_directories(snex_playground
    PRIVATE
        ${CMAKE_SOURCE_DIR}/tools/SDK/ASIOSDK2.3/common
)

target_link_libraries(snex_playground
    PRIVATE
        juce::juce_audio_utils
        juce::juce_cryptography
        juce::juce_dsp
        juce::juce_gui_extra
        juce::juce_opengl
        juce::juce_osc
        juce::juce_product_unlocking

        hise::hi_dsp_library
        hise::hi_lac
        hise::hi_rlottie
        hise::hi_snex
        hise::hi_tools
        hise::hi_zstd

        hise::binary_data

        juce::juce_recommended_config_flags
        juce::juce_recommended_lto_flags
        # juce::juce_recommended_warning_flags

        hise::compiler_options
        hise::compiler_warnings
)
