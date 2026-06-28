include(GoogleTest)

find_package(GTest CONFIG REQUIRED)

project_add_executable(app_tests greeting_test.cpp)
target_link_libraries(app_tests PRIVATE app::core GTest::gtest_main)

gtest_discover_tests(app_tests DISCOVERY_MODE PRE_TEST)
