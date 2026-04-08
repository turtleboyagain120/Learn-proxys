#!/bin/bash
# Build native libs for Rust FFI

mkdir -p build
cd build
cmake ..
make -j$(nproc)
cp libvm_instr.a ../
cp libgraphics.so ../
echo "Built vm_instr.a and libgraphics.so"

# For Windows (WSL/MinGW adjust)
# cmake -G "MinGW Makefiles" ..
# mingw32-make

