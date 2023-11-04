cmake_minimum_required(VERSION 3.15)
project(CppBuilder VERSION ${CMAKE_PROJECT_VERSION})

juce_add_console_app(CppBuilder
    PRODUCT_NAME "CppBuilder"
    BUNDLE_ID "com.HISE.CppBuilder"
    HARDENED_RUNTIME_ENABLED ON
)

juce_generate_juce_header(CppBuilder)

target_sources(CppBuilder
    PRIVATE
        Source/Main.cpp
)

target_compile_definitions(CppBuilder
    PRIVATE
        JUCE_WEB_BROWSER=0
        JUCE_USE_CURL=0
        JUCE_DISABLE_JUCE_VERSION_PRINTING=1
)

target_link_libraries(CppBuilder
    PRIVATE
        juce::juce_data_structures
        juce::juce_events
        juce::juce_recommended_config_flags

        hise::compiler_options
        hise::compiler_warnings
)
