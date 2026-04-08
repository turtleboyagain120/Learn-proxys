cmake_minimum_required(VERSION 3.10)
project(BlackBoxNative)

set(CMAKE_CXX_STANDARD 17)

# vm_instr static lib
add_library(vm_instr STATIC vm_instr.c)
target_include_directories(vm_instr PUBLIC .)

# graphics lib
find_package(Vulkan REQUIRED)  # For holo sim
add_library(graphics SHARED graphics.cpp)
target_link_libraries(graphics Vulkan::Vulkan)
target_include_directories(graphics PUBLIC .)

# Convenience build
add_custom_target(build_all DEPENDS vm_instr graphics)

