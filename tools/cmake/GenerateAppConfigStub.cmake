function(hise_generate_appconfig_stub _target)
    add_custom_command(
        OUTPUT  AppConfig.h 
        COMMAND ${CMAKE_COMMAND} -E echo "#pragma once" > ${CMAKE_CURRENT_BINARY_DIR}/AppConfig.h
        VERBATIM
    )

    target_sources(${_target} PUBLIC ${CMAKE_CURRENT_BINARY_DIR}/AppConfig.h)
    target_include_directories(${_target} PUBLIC ${CMAKE_CURRENT_BINARY_DIR})    
endfunction(hise_generate_appconfig_stub)


