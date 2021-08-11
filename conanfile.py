from conans import ConanFile, CMake

class ConanHelloWorld(ConanFile):
    name = "ConanHelloWorld"
    version = "1.0.0"
    license = "MIT"
    settings = "os", "compiler", "build_type", "arch"
    url = "https://github.com/joshua-barnett/conan-hello-world.git"
    generators = "cmake"
    requires = [
        "sdl2/2.0.14@bincrafters/stable",
        "sdl2_ttf/2.0.15@bincrafters/stable",
        "sdl2_image/2.0.5@bincrafters/stable",
        "entt/3.2.2"
    ]

    def source(self):
        self.run("git clone https://github.com/MasonRG/SnakeGame.git")

    def build(self):
        cmake = CMake(self)
        # if self.settings.os == "Windows":
            # cmake.definitions['CMAKE_CXX_FLAGS'] = "-static-libstdc++ -static-libgcc"
        cmake.configure()
        cmake.build()
