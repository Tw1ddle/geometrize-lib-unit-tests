TEMPLATE = app
CONFIG += console c++11
CONFIG -= app_bundle
CONFIG -= qt

include($$PWD/catch/catch.pri)
include($$PWD/geometrize/geometrize/geometrize.pri)

SOURCES += unit/main.cpp \
           $$files(unit/tests/*.cpp, true)
