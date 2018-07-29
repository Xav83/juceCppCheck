
project(juceCppCheck)

list(APPEND JUCE_VERSION "5.3.2")
list(APPEND JUCE_VERSION "develop")

if(NOT CMAKE_BUILD_TYPE)
    set(CMAKE_BUILD_TYPE "Debug")
endif()

## CppCheck generation

set(CPPCHECK_BINARY ${PROJECT_SOURCE_DIR}/cppcheck-1.84/build/bin/cppcheck)

add_custom_command(
    COMMAND mkdir -p build && cd build && cmake .. && cmake --build .
    WORKING_DIRECTORY ${PROJECT_SOURCE_DIR}/cppcheck-1.84
    OUTPUT ${CPPCHECK_BINARY}
    COMMENT "Generating cppcheck ..."
)

include(ExternalProject)
ExternalProject_Add(JUCE_Develop
  GIT_REPOSITORY "https://github.com/WeAreROLI/JUCE.git"
  GIT_TAG "origin/develop"
  SOURCE_DIR "${PROJECT_SOURCE_DIR}/JUCEs/JUCE-develop"

  CONFIGURE_COMMAND ""
  BUILD_COMMAND ""
  INSTALL_COMMAND ""
)

## Run cpp check

set(CPPCHECK_CLANG_DEBUG -DDEBUG -D__clang__ -D__clang_major__=4 -D__APPLE_CPP__ -DMAC_OS_X_VERSION_10_6)

function(createCppCheckCustomCommand juceVersion)
    set(JUCE_ROOT ${PROJECT_SOURCE_DIR}/JUCEs/JUCE-${juceVersion})

    add_custom_command(
        COMMAND ${CPPCHECK_BINARY} --language=c++ --suppress=missingIncludeSystem ${CPPCHECK_CLANG_DEBUG} --enable=all -I ${JUCE_ROOT}/modules ${JUCE_ROOT}/extras/AudioPerformanceTest/Source
        WORKING_DIRECTORY .
        OUTPUT juce${juceVersion}_output
        COMMENT "Generating Run CppCheck ..."
        DEPENDS ${CPPCHECK_BINARY}
    )

    add_custom_target(
        juce${juceVersion} ALL
        DEPENDS juce${juceVersion}_output
    )
endfunction(createCppCheckCustomCommand)

foreach(juceVersion ${JUCE_VERSION})
    createCppCheckCustomCommand(${juceVersion})
endforeach(juceVersion)

add_dependencies(jucedevelop JUCE_Develop)

add_custom_target(
    RunCppCheck ALL
    DEPENDS juce5.3.2 jucedevelop
)
