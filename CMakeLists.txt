cmake_minimum_required(VERSION 3.16)

project(PrintReportDemo VERSION 0.1 LANGUAGES CXX)

set(CMAKE_CXX_STANDARD_REQUIRED ON)

find_package(Qt6 REQUIRED COMPONENTS Quick Sql PrintSupport)
find_package(Qt6 REQUIRED COMPONENTS Core)

qt_standard_project_setup(REQUIRES 6.8)

qt_add_executable(appPrintReportDemo
    main.cpp
)

qt_add_qml_module(appPrintReportDemo
    URI PrintReportDemo
    VERSION 1.0
    QML_FILES
        Main.qml
        SOURCES backendhelper.h
        SOURCES ordermodel.h ordermodel.cpp
        SOURCES orderdetailmodel.h orderdetailmodel.cpp
        RESOURCES icons/back.png icons/forward.png icons/printer.png
        SOURCES printhandler.h printhandler.cpp
        RESOURCES
        RESOURCES icons/preview.svg
)

# Qt for iOS sets MACOSX_BUNDLE_GUI_IDENTIFIER automatically since Qt 6.1.
# If you are developing for iOS or macOS you should consider setting an
# explicit, fixed bundle identifier manually though.
set_target_properties(appPrintReportDemo PROPERTIES
#    MACOSX_BUNDLE_GUI_IDENTIFIER com.example.appPrintReportDemo
    MACOSX_BUNDLE_BUNDLE_VERSION ${PROJECT_VERSION}
    MACOSX_BUNDLE_SHORT_VERSION_STRING ${PROJECT_VERSION_MAJOR}.${PROJECT_VERSION_MINOR}
    MACOSX_BUNDLE TRUE
    WIN32_EXECUTABLE TRUE
)

target_link_libraries(appPrintReportDemo
    PRIVATE Qt6::Quick Qt6::Sql Qt6::PrintSupport
)
target_link_libraries(appPrintReportDemo PRIVATE Qt6::Core)

include(GNUInstallDirs)
install(TARGETS appPrintReportDemo
    BUNDLE DESTINATION .
    LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR}
    RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR}
)
