cmake_minimum_required(VERSION 3.5)

project(SnakeGame CXX)

include(${CMAKE_BINARY_DIR}/conanbuildinfo.cmake)
conan_basic_setup()

# Reorder linker flags to fix 'undefined reference to WinMain'
# https://github.com/msys2/MINGW-packages/issues/6379#issue-598436450
if (MINGW)
    list(REMOVE_ITEM CONAN_LIBS "mingw32")
    list(APPEND CONAN_LIBS "-mwindows")
    list(PREPEND CONAN_LIBS "mingw32")
endif()

file(GLOB_RECURSE SNAKE_GAME_SRCS SnakeGame/Src/*.cpp)
file(GLOB_RECURSE SNAKE_GAME_HDRS SnakeGame/Src/*.h)
add_executable(${CMAKE_PROJECT_NAME} ${SNAKE_GAME_SRCS} ${SNAKE_GAME_HDRS})
target_link_libraries(${CMAKE_PROJECT_NAME} ${CONAN_LIBS})
target_compile_features(${CMAKE_PROJECT_NAME} PRIVATE cxx_std_17)
