cmake_minimum_required(VERSION 3.19)
project(my-shell LANGUAGES CXX)

set(CMAKE_CXX_STANDARD 20)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_CXX_EXTENSIONS OFF)
set(CMAKE_EXPORT_COMPILE_COMMANDS ON)
set(CMAKE_RUNTIME_OUTPUT_DIRECTORY "${CMAKE_BINARY_DIR}/lib")

# Install in /usr/local/lib/qt-6/qml
set(CMAKE_INSTALL_PREFIX "/usr/local")
set(INSTALL_QMLDIR "lib/qt-6/qml" CACHE STRING "QML install dir")
set(QT_QML_GENERATE_QMLLS_INI ON)

add_compile_options(
    -Wall -Wextra -Wpedantic -Wshadow -Wconversion
    -Wold-style-cast -Wnull-dereference -Wdouble-promotion
    -Wformat=2 -Wfloat-equal -Woverloaded-virtual
    -Wsign-conversion -Wredundant-decls -Wswitch
    -Wunreachable-code
)

add_subdirectory(Plugins)
