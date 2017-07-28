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

win32 {
    TARGET_PATH = $$shell_quote($$shell_path($${TARGET_DIR}/$${TARGET}$${TARGET_CUSTOM_EXT}))
}
unix {
    TARGET_PATH = $$shell_quote($$shell_path($${TARGET_DIR}/./$${TARGET}$${TARGET_CUSTOM_EXT}))
}

QMAKE_POST_LINK = $${TARGET_PATH}
