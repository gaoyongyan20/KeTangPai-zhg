cmake_minimum_required(VERSION 3.29)

project(
  Ketangpai
  VERSION 0.1
  LANGUAGES CXX)

# find_package(Qt6 6.5 REQUIRED COMPONENTS Quick) find_package(Qt6 6.5 REQUIRED
# COMPONENTS Quick HttpServer)
find_package(Qt6 6.5 REQUIRED COMPONENTS Quick HttpServer Sql)
# find_package(Qt6 REQUIRED COMPONENTS Quick Sql HttpServer Network)

qt_standard_project_setup()
include_directories(${Qt6Sql_INCLUDE_DIRS})

qt_add_executable(appKetangpai main.cpp)

qt_add_qml_module(
  appKetangpai
  URI
  Ketangpai
  VERSION
  1.0
  SOURCES
  QML_FILES
  Content.qml #
  QML_FILES
  Window.qml #
  SOURCES
  httpserver.h #
  httpserver.cpp #
  QML_FILES
  HomePage_student.qml #
  QML_FILES
  HomePage_teacher.qml #
  # RESOURCES
  QML_FILES
  Dialogs.qml #
  QML_FILES
  DisplayCourseCodePage.qml #
  QML_FILES
  Login.qml #
  QML_FILES
  Createcourse_teacher.qml #
  QML_FILES
  CourseDetail_student.qml #
  QML_FILES
  CourseDetail_teacher.qml #
  QML_FILES
  HomeworkDetail_student.qml #
  QML_FILES
  HomeworkDetail_teacher.qml #
  QML_FILES
  Submithomework.qml #
  SOURCES
  courseservice.h #
  SOURCES
  courseservice.cpp #
  SOURCES
  databasemanagement.h #
  SOURCES
  databasemanagement.cpp #
  SOURCES
  loginservice.h #
  SOURCES
  loginservice.cpp #
  QML_FILES
  CourseController.js #
  QML_FILES
  LoginController.js #
  SOURCES
  user.cpp #
  SOURCES
  user.h #
  SOURCES
  course.cpp
  course.h
  RESOURCES
  resourses.qrc #
  RESOURCES
  images/fujian
  images/kong
  images/D58FCE77E028C973A38D484FEF0ACDEB.jpg
  images/26EED3BCBAB42F269D4C7341E6DC5DDC.jpg
  images/8AA714276B6E7A6B96EF4FC1F77CA075.jpg
  images/7A8BC5015BA46B22BEC63AE81A579405.jpg
  images/0AA1239AAD8E13F9414FBF57703D8F48.jpg)

# SOURCES databasemanagement.h databasemanagement.cpp SOURCES loginservice.h
# loginservice.cpp SOURCES user.h user.cpp QML_FILES LoginController.js
# QML_FILES CourseController.js SOURCES course.h course.cpp SOURCES
# courseservice.h courseservice.cpp)

target_compile_features(appKetangpai PRIVATE cxx_std_20)

set_target_properties(
  appKetangpai
  PROPERTIES AUTORCC TRUE
             MACOSX_BUNDLE_GUI_IDENTIFIER my.example.com
             MACOSX_BUNDLE_BUNDLE_VERSION ${PROJECT_VERSION}
             MACOSX_BUNDLE_SHORT_VERSION_STRING
             ${PROJECT_VERSION_MAJOR}.${PROJECT_VERSION_MINOR}
             MACOSX_BUNDLE TRUE
             WIN32_EXECUTABLE TRUE)

target_link_libraries(appKetangpai PRIVATE Qt6::Quick Qt6::HttpServer Qt6::Sql)

# target_link_libraries(appKetangpai PRIVATE Qt6::Quick Qt6::Sql Qt6::Core
# Qt6::HttpServer Qt6::Network)
include(GNUInstallDirs)
install(
  TARGETS appKetangpai
  BUNDLE DESTINATION .
  LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR}
  RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR})

# qt_add_executable(Ketangpai)  //Creates and finalizes an application target of
# a platform-specific type. This command performs the following tasks: 1. Create
# a CMake target of the appropriate type for the target platform. 2. Link the
# target to the Qt::Core library. 3. Handle finalization of the CMake target.

# qt_standard_project_setup()     #set(CMAKE_AUTOUIC ON)  set(CMAKE_AUTOMOC ON)

# @if %{HasTranslation} find_package(Qt6 REQUIRED COMPONENTS Core Quick
# LinguistTools) @else find_package(Qt6 REQUIRED COMPONENTS Core Quick) @endif

# target_sources(appKetangpai PRIVATE main.cpp qml.qrc @if %{HasTranslation}
# %{TsFileName} @endif
#
# PUBLIC
#
# )

# qt_import_qml_plugins(Ketangpai)

# cmake_minimum_required(VERSION 3.16)
#
# project(Ketangpai VERSION 0.1 LANGUAGES CXX)
#
# @if !true set(CMAKE_AUTOMOC ON) @endif set(CMAKE_CXX_STANDARD_REQUIRED ON)
#
# find_package(Qt6 6.4 REQUIRED COMPONENTS Quick)
#
# @if true @if false qt_standard_project_setup(REQUIRES 6.5) @else
# qt_standard_project_setup() @endif @endif
#
# qt_add_executable(appKetangpai main.cpp )
#
# qt_add_qml_module(appKetangpai URI Ketangpai VERSION 1.0 QML_FILES Main.qml )
#
# # Qt for iOS sets MACOSX_BUNDLE_GUI_IDENTIFIER automatically since Qt 6.1. #
# If you are developing for iOS or macOS you should consider setting an #
# explicit, fixed bundle identifier manually though.
# set_target_properties(appKetangpai PROPERTIES # MACOSX_BUNDLE_GUI_IDENTIFIER
# com.example.appKetangpai MACOSX_BUNDLE_BUNDLE_VERSION ${PROJECT_VERSION}
# MACOSX_BUNDLE_SHORT_VERSION_STRING
# ${PROJECT_VERSION_MAJOR}.${PROJECT_VERSION_MINOR} MACOSX_BUNDLE TRUE
# WIN32_EXECUTABLE TRUE )
#
# target_link_libraries(appKetangpai PRIVATE Qt6::Quick )
#
# include(GNUInstallDirs) install(TARGETS appKetangpai BUNDLE DESTINATION .
# LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR} RUNTIME DESTINATION
# ${CMAKE_INSTALL_BINDIR} )
