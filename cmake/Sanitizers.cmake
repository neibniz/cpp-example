include_guard(GLOBAL)

set(PROJECT_SANITIZER
    "none"
    CACHE STRING "Sanitizer to enable")
set_property(
  CACHE PROJECT_SANITIZER
  PROPERTY STRINGS none address undefined thread address-undefined)

function(project_apply_sanitizer target)
  if(PROJECT_SANITIZER STREQUAL "none")
    return()
  endif()

  if(NOT CMAKE_CXX_COMPILER_ID MATCHES "AppleClang|Clang|GNU")
    message(FATAL_ERROR "Sanitizers are configured only for Clang, AppleClang, and GCC")
  endif()

  if(PROJECT_SANITIZER STREQUAL "address")
    set(sanitize_flags -fsanitize=address)
  elseif(PROJECT_SANITIZER STREQUAL "undefined")
    set(sanitize_flags -fsanitize=undefined)
  elseif(PROJECT_SANITIZER STREQUAL "thread")
    set(sanitize_flags -fsanitize=thread)
  elseif(PROJECT_SANITIZER STREQUAL "address-undefined")
    set(sanitize_flags -fsanitize=address,undefined)
  else()
    message(FATAL_ERROR "Unknown PROJECT_SANITIZER: ${PROJECT_SANITIZER}")
  endif()

  target_compile_options(
    ${target}
    PRIVATE ${sanitize_flags} -fno-omit-frame-pointer -fno-optimize-sibling-calls)
  target_link_options(${target} PRIVATE ${sanitize_flags})
endfunction()
