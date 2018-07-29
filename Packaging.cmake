include(CPackComponent)

set(CPACK_PACKAGE_NAME "juceCppCheck")

function(installCppCheckResult juceVersion)
    INSTALL(FILES ${CMAKE_BINARY_DIR}/juce${juceVersion}_output.txt
        DESTINATION .
        COMPONENT juce${juceVersion}_Component
    )
    list(APPEND CPACK_COMPONENTS_ALL juce${juceVersion}_Component)
endfunction(installCppCheckResult)

if (APPLE)
    set(CPACK_SYSTEM_NAME "Darwin")
    set(CPACK_GENERATOR "ZIP")

    foreach(juceVersion ${JUCE_VERSION})
        installCppCheckResult(${juceVersion})
    endforeach(juceVersion)
endif(APPLE)

include(CPack)
