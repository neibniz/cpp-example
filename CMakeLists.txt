cmake_minimum_required(VERSION 3.25)

project(
  cpp_project
  VERSION 0.1.0
  DESCRIPTION "C++ project using CMake and Conan"
  LANGUAGES CXX
)

include(estate_neibniz_protocolbuffers_cpp.cmake)
include(cmake/Targets.cmake)
include(CTest)

option(PROJECT_ENABLE_TESTS "Build unit tests" "${BUILD_TESTING}")
option(PROJECT_ENABLE_BENCHMARKS "Build benchmarks" OFF)

find_package(fmt CONFIG REQUIRED)

project_add_library(app_core src/greeting.cpp)
add_library(app::core ALIAS app_core)

target_include_directories(
  app_core PUBLIC "$<BUILD_INTERFACE:${PROJECT_SOURCE_DIR}/include>")
target_link_libraries(app_core PRIVATE fmt::fmt)

project_add_executable(app src/main.cpp)

target_link_libraries(app 
  PRIVATE app::core
  estate_neibniz_protocolbuffers_cpp
)

if(PROJECT_ENABLE_TESTS)
  add_subdirectory(tests)
endif()

if(PROJECT_ENABLE_BENCHMARKS)
  add_subdirectory(benchmarks)
endif()
