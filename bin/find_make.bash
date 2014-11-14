#!/bin/bash

if [[ $# > 0 ]]; then
    dir=$1
else
    dir='./'
fi

2>/dev/null find ${dir} -regex ".*/\(Makefile\|CMakeLists\.txt\)" -print
