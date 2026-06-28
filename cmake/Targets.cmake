include_guard(GLOBAL)

include("${CMAKE_CURRENT_LIST_DIR}/Coverage.cmake")
include("${CMAKE_CURRENT_LIST_DIR}/ProjectOptions.cmake")
include("${CMAKE_CURRENT_LIST_DIR}/Sanitizers.cmake")

function(project_add_library target)
  add_library(${target})
  target_sources(${target} PRIVATE ${ARGN})

  project_apply_options(${target})
  project_apply_coverage(${target})
  project_apply_sanitizer(${target})
endfunction()

function(project_add_executable target)
  add_executable(${target})
  target_sources(${target} PRIVATE ${ARGN})

  project_apply_options(${target})
  project_apply_coverage(${target})
  project_apply_sanitizer(${target})
endfunction()
