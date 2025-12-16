from conan import ConanFile
from conan.tools.cmake import cmake_layout, CMakeDeps, CMakeToolchain

required_conan_version = ">=2.0"

class MyProjConan(ConanFile):
    name = "myproj"
    version = "0.1.0"

    settings = "os", "arch", "compiler", "build_type"

    # Runtime deps
    requires = (
        "opencv/4.12.0",
    )

    # Test-only deps
    test_requires = (
        "catch2/3.11.0",
    )

    def layout(self):
        cmake_layout(self)

    def generate(self):
        deps = CMakeDeps(self)
        deps.generate()

        tc = CMakeToolchain(self)
        # keep it simple; project enforces C++20 in CMake
        tc.generate()
