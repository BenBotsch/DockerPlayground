find_package(Catch2 3 REQUIRED CONFIG)

add_executable(unit_tests
  test_vision.cpp
)

target_link_libraries(unit_tests
  PRIVATE
    myproj::myproj
    Catch2::Catch2WithMain
)

myproj_apply_warnings(unit_tests)

include(CTest)
include(Catch)
catch_discover_tests(unit_tests)
