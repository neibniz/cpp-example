find_package(benchmark CONFIG REQUIRED)

project_add_executable(app_benchmark greeting_benchmark.cpp)
target_link_libraries(app_benchmark PRIVATE app::core benchmark::benchmark)

add_test(NAME app_benchmark COMMAND app_benchmark --benchmark_min_time=0.01s)
set_tests_properties(app_benchmark PROPERTIES LABELS benchmark)
