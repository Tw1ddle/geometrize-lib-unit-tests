TEMPLATE = app
CONFIG += console c++11
CONFIG -= app_bundle
CONFIG -= qt

include($$PWD/catch/catch.pri)
include($$PWD/geometrize-lib/geometrize/geometrize.pri)

SOURCES += unit/main.cpp \
           $$files(unit/tests/*.cpp, true)

# Run the unit tests after successful linking
isEmpty(TARGET_EXT) {
    win32 {
        TARGET_CUSTOM_EXT = .exe
    }
    macx {
        #TARGET_CUSTOM_EXT = .app # Seems like no file extension is added
    }
} else {
    TARGET_CUSTOM_EXT = $${TARGET_EXT}
}

# For some reason the executables are placed in debug/release folders on Windows (MSVC)
# but in one directory up on Linux (gcc)
win32 {
    CONFIG(debug, debug|release) {
        TARGET_DIR = $$shell_path($${OUT_PWD}/debug)
    } else {
        TARGET_DIR = $$shell_path($${OUT_PWD}/release)
    }
}
unix {
    TARGET_DIR = $$shell_path($${OUT_PWD}/)
}

win32 {
    RUN_UNIT_TESTS = $$shell_quote($$shell_path($${TARGET_DIR}/$${TARGET}$${TARGET_CUSTOM_EXT}))
}
unix {
    RUN_UNIT_TESTS = $$shell_quote($$shell_path($${TARGET_DIR}/./$${TARGET}$${TARGET_CUSTOM_EXT}))
}

QMAKE_POST_LINK = $${RUN_UNIT_TESTS}
