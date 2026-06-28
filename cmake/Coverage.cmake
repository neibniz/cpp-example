include_guard(GLOBAL)

option(PROJECT_ENABLE_COVERAGE "Enable coverage instrumentation" OFF)

function(project_apply_coverage target)
  if(NOT PROJECT_ENABLE_COVERAGE)
    return()
  endif()

  if(NOT CMAKE_CXX_COMPILER_ID MATCHES "AppleClang|Clang|GNU")
    message(FATAL_ERROR "Coverage is configured only for Clang, AppleClang, and GCC")
  endif()

  target_compile_options(${target} PRIVATE --coverage -O0 -g)
  target_link_options(${target} PRIVATE --coverage)
endfunction()
