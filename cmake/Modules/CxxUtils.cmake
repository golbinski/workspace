# =========================================================================== 
# Provides build system utilities for CXX projects.
#
# =========================================================================== 
# 
#  ADD_COMPILE_OPTIONS: Adds comiler option to the compilation of the source
#                       files.
#
#    ADD_COMPILE_OPTIONS(opt1 [opt2...]
#      [BUILD_TYPE type])
#
#    BUILD_TYPE = Variable to define the build type to extend the
#                 CMAKE_CXX_FLAGS_${BUILD_TYPE} compile options.
#
# =========================================================================== 
#  REMOVE_COMPILE_OPTIONS: Removes compiler options from the compilation of
#                          the source files.
#
#    REMOVE_COMPILE_OPTIONS(opt1 [opt2...]
#      [BUILD_TYPE type])
#
#    BUILD_TYPE = Variable to define the build type to reduce the
#                 CMAKE_CXX_FLAGS_${BUILD_TYPE} compile options.
#    
# =========================================================================== 
#  ENABLE_CXX11: Enables new C++11 standard.
#
#   ENABLE_CXX11()
#
# =========================================================================== 

include(CMakeParseArguments)

function(ADD_COMPILE_OPTIONS)
    cmake_parse_arguments(ADD_COMPILE_OPTIONS "" "BUILD_TYPE" "" ${ARGN})
    if(NOT ADD_COMPILE_OPTIONS_UNPARSED_ARGUMENTS)
        message(SEND_ERROR "Error: ADD_COMPILE_OPTIONS() called without any options")
        return()
    endif()

    if(NOT ADD_COMPILE_OPTIONS_BUILD_TYPE)
        set(OUTPUT CMAKE_CXX_FLAGS)
    else()
        string(TOUPPER ${ADD_COMPILE_OPTIONS_BUILD_TYPE} ADD_COMPILE_OPTIONS_BUILD_TYPE)
        set(OUTPUT CMAKE_CXX_FLAGS_${ADD_COMPILE_OPTIONS_BUILD_TYPE})
    endif()
    
    foreach(OPT ${ADD_COMPILE_OPTIONS_UNPARSED_ARGUMENTS})
        set(${OUTPUT} "${${OUTPUT}} ${OPT}")
    endforeach()
    set(${OUTPUT} ${${OUTPUT}} PARENT_SCOPE)
endfunction()

function(REMOVE_COMPILE_OPTIONS)
    cmake_parse_arguments(REMOVE_COMPILE_OPTIONS "" "BUILD_TYPE" "" ${ARGN})
    if(NOT REMOVE_COMPILE_OPTIONS_UNPARSED_ARGUMENTS)
        message(SEND_ERROR "Error: REMOVE_COMPILE_OPTIONS() called without any options")
        return()
    endif()

    if(NOT REMOVE_COMPILE_OPTIONS_BUILD_TYPE)
        set(OUTPUT CMAKE_CXX_FLAGS)
    else()
        string(TOUPPER ${REMOVE_COMPILE_OPTIONS_BUILD_TYPE} REMOVE_COMPILE_OPTIONS_BUILD_TYPE)
        set(OUTPUT CMAKE_CXX_FLAGS_${REMOVE_COMPILE_OPTIONS_BUILD_TYPE})
    endif()

    foreach(OPT ${REMOVE_COMPILE_OPTIONS_UNPARSED_ARGUMENTS})
        string(REPLACE "${OPT} " "" ${OUTPUT} ${${OUTPUT}})
    endforeach()
    set(${OUTPUT} ${${OUTPUT}} PARENT_SCOPE)
endfunction()

function(ENABLE_CXX11)
    set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -std=c++11")
    set(CMAKE_CXX_FLAGS ${CMAKE_CXX_FLAGS} PARENT_SCOPE)
endfunction()

function(ENABLE_CXX14)
    set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -std=c++1y")
    set(CMAKE_CXX_FLAGS ${CMAKE_CXX_FLAGS} PARENT_SCOPE)
endfunction()

