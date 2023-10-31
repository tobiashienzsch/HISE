add_library(hise_compiler_warnings INTERFACE)
add_library(hise::compiler_warnings ALIAS hise_compiler_warnings)

if(NOT ((CMAKE_CXX_COMPILER_ID STREQUAL "MSVC") OR (CMAKE_CXX_COMPILER_FRONTEND_VARIANT STREQUAL "MSVC")))
    target_compile_options(hise_compiler_warnings
        INTERFACE
            "-Wno-deprecated-declarations"
            "-Wno-implicit-const-int-float-conversion"
            "-Wno-inconsistent-missing-override"
            "-Wno-return-type"
            "-Wno-switch"
            "-Wno-unqualified-std-cast-call"
    )
endif()
