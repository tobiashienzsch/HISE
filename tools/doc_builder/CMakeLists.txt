cmake_minimum_required(VERSION 3.15)
project(doc_builder VERSION ${CMAKE_PROJECT_VERSION})

juce_add_console_app(doc_builder
    PRODUCT_NAME "doc_builder"
    BUNDLE_ID "com.HISE.doc_builder"
    HARDENED_RUNTIME_ENABLED ON
)

juce_generate_juce_header(doc_builder)
hise_generate_appconfig_stub(doc_builder)

target_sources(doc_builder
    PRIVATE
        Source/Main.cpp
)

target_compile_definitions(doc_builder
    PRIVATE
        USE_BACKEND=0
        USE_FRONTEND=0
        USE_RAW_FRONTEND=0
        USE_COPY_PROTECTION=0
        USE_IPP=0
        USE_VDSP_FFT=0

        IS_STANDALONE_APP=1
        FRONTEND_IS_PLUGIN=0

        HI_EXPORT_DSP_LIBRARY=0
        HISE_INCLUDE_RLOTTIE=0

        JUCE_WEB_BROWSER=0
        JUCE_USE_CURL=0
        JUCE_DISABLE_JUCE_VERSION_PRINTING=1
)

target_link_libraries(doc_builder
    PRIVATE
        hise::binary_data

        juce::juce_opengl
        hise::hi_dsp_library
        hise::hi_tools
        hise::hi_zstd

        juce::juce_recommended_config_flags
        juce::juce_recommended_lto_flags

        hise::compiler_options
        hise::compiler_warnings
)
