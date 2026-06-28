include_guard(GLOBAL)

option(PROJECT_ENABLE_WARNINGS "Enable project compiler warnings" ON)

function(project_apply_options target)
  target_compile_features(${target} PRIVATE cxx_std_20)
  set_target_properties(${target} PROPERTIES CXX_EXTENSIONS OFF)

  if(NOT PROJECT_ENABLE_WARNINGS)
    return()
  endif()

  set(_gnu_like_warnings
      -Wall
      -Wextra
      -Wpedantic
      -Wconversion
      -Wshadow
      -Wnon-virtual-dtor
      -Wold-style-cast
      -Woverloaded-virtual
      -Wformat=2)
  set(_msvc_warnings /W4 /permissive-)

  target_compile_options(
    ${target} PRIVATE
    "$<$<COMPILE_LANG_AND_ID:CXX,AppleClang,Clang,GNU>:${_gnu_like_warnings}>"
    "$<$<COMPILE_LANG_AND_ID:CXX,MSVC>:${_msvc_warnings}>")
endfunction()
