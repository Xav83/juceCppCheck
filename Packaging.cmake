include(CPackComponent)

set(CPACK_PACKAGE_NAME "juceCppCheck")

function(installCppCheckResult cppcheckOutputsTarget)
    INSTALL(FILES ${CMAKE_BINARY_DIR}/${cppcheckOutputsTarget}_output.txt
        DESTINATION .
        COMPONENT ${cppcheckOutputsTarget}_Component
    )
    list(APPEND CPACK_COMPONENTS_ALL ${cppcheckOutputsTarget}_Component)
endfunction(installCppCheckResult)

if (APPLE)
    set(CPACK_SYSTEM_NAME "Darwin")
    set(CPACK_GENERATOR "ZIP")

    foreach(cppcheckOutputsTarget ${cppcheckOutputsTargets})
        installCppCheckResult(${cppcheckOutputsTarget})
    endforeach(cppcheckOutputsTarget)
endif(APPLE)

include(CPack)
