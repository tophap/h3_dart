#!/bin/bash

cd cpp || exit
git clone https://github.com/uber/h3

mkdir build || echo "Build folder exists"
cd build
cmake ..
make h3
