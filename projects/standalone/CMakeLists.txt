cmake_minimum_required(VERSION 3.15)
project(GUI_APP_EXAMPLE VERSION 0.0.1)

juce_add_binary_data(HISEStandalone_BinaryData
    SOURCES
        "../../hi_core/hi_images/logo_new.png"
        "../../hi_core/hi_images/logo_mini.png"
        "../../hi_core/hi_images/infoError.png"
        "../../hi_core/hi_images/infoInfo.png"
        "../../hi_core/hi_images/infoQuestion.png"
        "../../hi_core/hi_images/infoWarning.png"
        "../../hi_core/hi_images/FrontendKnob_Bipolar.png"
        "../../hi_core/hi_images/FrontendKnob_Unipolar.png"
        "../../hi_core/hi_images/balanceKnob_200.png"
        "../../hi_core/hi_images/knobEmpty_200.png"
        "../../hi_core/hi_images/knobModulated_200.png"
        "../../hi_core/hi_images/knobUnmodulated_200.png"
        "../../hi_core/hi_images/toggle_200.png"
        "../../hi_core/hi_images/knob_without_arrow.png"
)

juce_add_gui_app(HISEStandalone
    PRODUCT_NAME "HISE Standalone"
    NEEDS_WEB_BROWSER TRUE
    NEEDS_CURL TRUE
)

juce_generate_juce_header(HISEStandalone)

target_sources(HISEStandalone
    PRIVATE
        Source/Main.cpp
        Source/MainComponent.cpp
)

target_compile_definitions(HISEStandalone
    PRIVATE
        HI_EXPORT_DSP_LIBRARY=0
        HISE_INCLUDE_RLOTTiE=0
        HISE_INCLUDE_SNEX=1
        HISE_NO_GUI_TOOLS=0

        USE_IPP=0
        USE_BACKEND=1

        JUCE_APPLICATION_NAME_STRING="$<TARGET_PROPERTY:HISEStandalone,JUCE_PRODUCT_NAME>"
        JUCE_APPLICATION_VERSION_STRING="$<TARGET_PROPERTY:HISEStandalone,JUCE_VERSION>"
)

target_compile_options(HISEStandalone
    PRIVATE
        "-Wno-deprecated-declarations"
        "-Wno-implicit-const-int-float-conversion"
        "-Wno-inconsistent-missing-override"
        "-Wno-return-type"
        "-Wno-switch"
        "-Wno-unqualified-std-cast-call"
)

target_include_directories(HISEStandalone
    PRIVATE
        ${PROJECT_SOURCE_DIR}/Source/Config
)

target_link_libraries(HISEStandalone
    PRIVATE
        juce::juce_audio_utils
        juce::juce_dsp
        juce::juce_gui_extra
        juce::juce_opengl
        juce::juce_osc
        juce::juce_product_unlocking

        hise::hi_backend
        hise::hi_dsp_library
        hise::hi_faust_jit
        hise::hi_lac
        hise::hi_rlottie
        hise::hi_scripting
        hise::hi_snex
        hise::hi_streaming
        hise::hi_tools
        hise::hi_zstd

    PUBLIC
        HISEStandalone_BinaryData

        juce::juce_recommended_config_flags
        # juce::juce_recommended_lto_flags
        # juce::juce_recommended_warning_flags
)
