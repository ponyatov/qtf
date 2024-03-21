# Search for the path containing library's headers
find_path(READLINE_ROOT_DIR
    NAMES include/readline/readline.h
)

# Search for include directory
find_path(READLINE_INCLUDE_DIR
    NAMES readline/readline.h
    HINTS ${READLINE_ROOT_DIR}/include
)

# Search for library
find_library(READLINE_LIBRARY
    NAMES readline
    HINTS ${READLINE_ROOT_DIR}/lib
)

# Conditionally set READLINE_FOUND value
if(READLINE_INCLUDE_DIR AND READLINE_LIBRARY AND Ncurses_LIBRARY)
    set(READLINE_FOUND TRUE)
else(READLINE_INCLUDE_DIR AND READLINE_LIBRARY AND Ncurses_LIBRARY)
    FIND_LIBRARY(READLINE_LIBRARY NAMES readline)
        include(FindPackageHandleStandardArgs)
    FIND_PACKAGE_HANDLE_STANDARD_ARGS(READLINE DEFAULT_MSG
        READLINE_INCLUDE_DIR READLINE_LIBRARY )
    MARK_AS_ADVANCED(READLINE_INCLUDE_DIR READLINE_LIBRARY)
endif(READLINE_INCLUDE_DIR AND READLINE_LIBRARY AND Ncurses_LIBRARY)

# Hide these variables in cmake GUIs
mark_as_advanced(
    READLINE_ROOT_DIR
    READLINE_INCLUDE_DIR
    READLINE_LIBRARY
)
