cmake_minimum_required(VERSION 3.25)

project(myproj VERSION 0.1.0 LANGUAGES CXX)

option(MYPROJ_BUILD_TESTS "Build unit tests" ON)
option(MYPROJ_BUILD_APPS  "Build demo apps"  ON)

list(APPEND CMAKE_MODULE_PATH "${CMAKE_CURRENT_SOURCE_DIR}/cmake")
include(ProjectOptions)

# ---- Library ----
add_library(myproj
  src/vision.cpp
)
add_library(myproj::myproj ALIAS myproj)

target_include_directories(myproj
  PUBLIC
    $<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}/include>
)

target_compile_features(myproj PUBLIC cxx_std_20)
myproj_apply_warnings(myproj)

# ---- OpenCV (robust find: try OpenCV then opencv) ----
find_package(OpenCV QUIET CONFIG)
if(NOT OpenCV_FOUND)
  find_package(opencv QUIET CONFIG)
endif()

if(OpenCV_FOUND)
  # Try common target names first (OpenCV exports module targets like opencv_core, opencv_imgproc, ...)
  if(TARGET opencv_core)
    target_link_libraries(myproj PUBLIC opencv_core opencv_imgproc)
  elseif(TARGET OpenCV::opencv_core)
    target_link_libraries(myproj PUBLIC OpenCV::opencv_core OpenCV::opencv_imgproc)
  else()
    # Fallback: classic variables (works with many OpenCV installs)
    target_include_directories(myproj PUBLIC ${OpenCV_INCLUDE_DIRS})
    target_link_libraries(myproj PUBLIC ${OpenCV_LIBS})
  endif()
elseif(TARGET opencv::opencv)
  target_link_libraries(myproj PUBLIC opencv::opencv)
else()
  message(FATAL_ERROR "OpenCV not found. Conan install should provide it.")
endif()

# ---- Apps ----
if(MYPROJ_BUILD_APPS)
  add_executable(demo apps/demo.cpp)
  target_link_libraries(demo PRIVATE myproj::myproj)
  myproj_apply_warnings(demo)
endif()

# ---- Tests ----
if(MYPROJ_BUILD_TESTS)
  include(CTest)
  enable_testing()
  add_subdirectory(tests)
endif()
