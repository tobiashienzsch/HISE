add_library(hise_compiler_options INTERFACE)
add_library(hise::compiler_options ALIAS hise_compiler_options)

if(${CMAKE_SYSTEM_NAME} MATCHES "Darwin")
    if(${CMAKE_CXX_COMPILER_VERSION} VERSION_GREATER_EQUAL 15)
        target_link_options(hise_compiler_options INTERFACE -Wl,-weak_reference_mismatches,weak)
    endif()
endif()
