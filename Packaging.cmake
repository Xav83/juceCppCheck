include(CPackComponent)

set(CPACK_PACKAGE_NAME "juceCppCheck")

if (APPLE)
    set(CPACK_SYSTEM_NAME "Darwin")
    set(CPACK_GENERATOR "ZIP")

    INSTALL(FILES ${CMAKE_BINARY_DIR}/juce5.3.2_output.txt
            DESTINATION .
            COMPONENT juce5.3.2_Component
    )
    INSTALL(FILES ${CMAKE_BINARY_DIR}/jucedevelop_output.txt
            DESTINATION .
            COMPONENT jucedevelop_Component
    )

    set(CPACK_COMPONENTS_ALL juce5.3.2_Component jucedevelop_Component)
endif(APPLE)

include(CPack)
