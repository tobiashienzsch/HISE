cmake_minimum_required(VERSION 3.15)
project(hlac_tool VERSION ${CMAKE_PROJECT_VERSION})

juce_add_console_app(hlac_tool
    PRODUCT_NAME "HLAC Tool"
    BUNDLE_ID "com.HISE.hlac_tool"
    HARDENED_RUNTIME_ENABLED ON
)

juce_generate_juce_header(hlac_tool)
hise_generate_appconfig_stub(hlac_tool)

target_sources(hlac_tool
    PRIVATE
        Source/HlacTests.cpp
        Source/HlacTests.h
        Source/Main.cpp
)

target_compile_definitions(hlac_tool
    PRIVATE
        HLAC_MEASURE_DECODING_PERFORMANCE=1
        HLAC_DEBUG_LOG=0
        HLAC_INCLUDE_TEST_SUITE=1

        JUCE_WEB_BROWSER=0
        JUCE_USE_CURL=0
        JUCE_DISABLE_JUCE_VERSION_PRINTING=1
)

target_link_libraries(hlac_tool
    PRIVATE
        hise::hi_lac

    PUBLIC
        juce::juce_recommended_config_flags
        juce::juce_recommended_lto_flags
        # juce::juce_recommended_warning_flags

        hise::compiler_options
        hise::compiler_warnings
)

add_test(
    NAME
        hlac_tests
    COMMAND
        $<TARGET_FILE:hlac_tool> unit_test
    WORKING_DIRECTORY
        ${CMAKE_SOURCE_DIR}
)
