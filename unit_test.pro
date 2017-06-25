TEMPLATE = app
CONFIG += console c++11
CONFIG -= app_bundle
CONFIG -= qt

# Add gcov for code coverage with Linux g++ Travis builds
linux-g++ {
    QMAKE_CXXFLAGS += -fprofile-arcs -ftest-coverage
    LIBS += -lgcov
}

include($$PWD/catch/catch.pri)
include($$PWD/geometrize/geometrize/geometrize.pri)

SOURCES += unit/main.cpp \
           $$files(unit/tests/*.cpp, true)
