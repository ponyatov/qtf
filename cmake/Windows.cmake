if(CMAKE_SYSTEM_NAME STREQUAL "Windows")
    add_executable(${APP}.exe WIN32 ${ALL_SOURCES})
    target_compile_definitions(${APP}.exe PUBLIC "Linux")
endif()
