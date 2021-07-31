from conans import ConanFile, CMake, tools

class HelloWorld(ConanFile):
    settings = "os", "build_type", "arch"

    def source(self):
        self.run("git clone https://github.com/conan-io/hello.git")

    def build(self):
        cmake = CMake(self)
        if self.settings.os == "Windows":
            cmake.definitions['CMAKE_CXX_FLAGS'] = "-static-libstdc++ -static-libgcc"
        cmake.configure(
            source_folder="hello"
        )
        cmake.build()
