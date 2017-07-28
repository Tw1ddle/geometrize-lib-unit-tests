TEMPLATE = app
CONFIG += console c++11
CONFIG -= app_bundle
CONFIG -= qt

include($$PWD/catch/catch.pri)
include($$PWD/geometrize/geometrize/geometrize.pri)

SOURCES += unit/main.cpp \
           $$files(unit/tests/*.cpp, true)

# Run the unit tests after successful linking
isEmpty(TARGET_EXT) {
    win32 {
        TARGET_CUSTOM_EXT = .exe
    }
    macx {
        TARGET_CUSTOM_EXT = .app
    }
} else {
    TARGET_CUSTOM_EXT = $${TARGET_EXT}
}

CONFIG(debug, debug|release) {
    TARGET_DIR = $$shell_path($${OUT_PWD}/debug)
} else {
    TARGET_DIR = $$shell_path($${OUT_PWD}/release)
}

TARGET_FILE = $$shell_quote($$shell_path($${TARGET_DIR}/$${TARGET}$${TARGET_CUSTOM_EXT}))

win32 {
    RUN_UNIT_TESTS = $$shell_quote($$shell_path($${TARGET_DIR}/$${TARGET}$${TARGET_CUSTOM_EXT}))
}
unix {
    RUN_UNIT_TESTS = $$shell_quote($$shell_path($${TARGET_DIR}/./$${TARGET}$${TARGET_CUSTOM_EXT}))
}

exists($${TARGET_FILE}) {
    QMAKE_POST_LINK = $${RUN_UNIT_TESTS}
}
!exists($${TARGET_FILE}) {
    warning("Failed to run unit tests, maybe the binary was not generated")
}
