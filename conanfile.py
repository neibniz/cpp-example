from conan import ConanFile
from conan.tools.cmake import CMakeDeps, CMakeToolchain


class ProjectConan(ConanFile):
    package_type = "application"

    settings = "os", "arch", "compiler", "build_type"
    options = {
        "with_benchmarks": [True, False],
        "with_tests": [True, False],
    }
    default_options = {
        "with_benchmarks": False,
        "with_tests": False,
    }

    def requirements(self):
        self.requires("fmt/12.1.0")

        if self.options.with_tests:
            self.requires("gtest/1.17.0")

        if self.options.with_benchmarks:
            self.requires("benchmark/1.9.5")

    def layout(self):
        self.folders.generators = "generators"

    def generate(self):
        deps = CMakeDeps(self)
        deps.generate()

        toolchain = CMakeToolchain(self)
        toolchain.user_presets_path = False
        toolchain.generate()
