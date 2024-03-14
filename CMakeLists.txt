cmake_minimum_required(VERSION 3.11)

project(${APP} VERSION 0.0.1 LANGUAGES C CXX)

file(GLOB C RELATIVE ${CMAKE_SOURCE_DIR} "src/*.c*" "tmp/*.c*")
file(GLOB H RELATIVE ${CMAKE_SOURCE_DIR} "inc/*.h*" "tmp/*.h*")

find_package(Qt6 REQUIRED COMPONENTS Core Widgets Gui)
qt_standard_project_setup()

file(GLOB R RELATIVE ${CMAKE_SOURCE_DIR} "inc/*.qrc")
set(CMAKE_AUTORCC ON)

# find_package(FLEX  REQUIRED)
# find_package(BISON REQUIRED)

# FLEX_TARGET(lexer
#     ${CMAKE_SOURCE_DIR}/src/${APP}.lex
#                  ${CMAKE_SOURCE_DIR}/tmp/${APP}.lexer.cpp
#     DEFINES_FILE ${CMAKE_SOURCE_DIR}/tmp/${APP}.lexer.hpp)

# BISON_TARGET(parser
#     ${CMAKE_SOURCE_DIR}/src/${APP}.yacc
#                  ${CMAKE_SOURCE_DIR}/tmp/${APP}.parser.cpp)

# add_flex_bison_dependency(lexer parser)

include_directories(
    "${CMAKE_SOURCE_DIR}/inc"
    "${CMAKE_SOURCE_DIR}/tmp"
)

set(CMAKE_ARCHIVE_OUTPUT_DIRECTORY ${CMAKE_SOURCE_DIR}/bin)
set(CMAKE_LIBRARY_OUTPUT_DIRECTORY ${CMAKE_SOURCE_DIR}/bin)
set(CMAKE_RUNTIME_OUTPUT_DIRECTORY ${CMAKE_SOURCE_DIR}/bin)

add_link_options("-Wl,-E") # dl

qt_add_executable(${APP}
    ${C} ${H} ${R}
    ${FLEX_lexer_OUTPUTS} ${BISON_parser_OUTPUTS}
)

target_link_libraries(${APP} PRIVATE Qt6::Core Qt6::Widgets)

target_precompile_headers(${APP} PRIVATE ${H} )
