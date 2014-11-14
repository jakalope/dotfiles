#!/bin/bash

cfiles > cscope.files
if [[ $ROS_EDIT == 1 ]]; then
    2>/dev/null find /opt/ros/${ROS_DISTRO} -name "*.cxx" -o -name "*.c" -o -name "*.cpp" -o -name "*.h" -o -name "*.hpp" >> cscope.files
fi

if [[ $# > 0 ]]; then
    if [ -e cscope.out ]; then
        2>/dev/null cscope -b -q
# BUG: escapes user to normal mode
        vim --servername ${1} --remote-send '<ESC>:cs add cscope.out<CR>:cs reset<CR>'
    else
        2>/dev/null cscope -b -q
# BUG: escapes user to normal mode
        vim --servername ${1} --remote-send '<ESC>:cs add cscope.out<CR>:cs reset<CR>'
    fi
else
    echo "No vim server specified. Just building the cscope database."
    2>/dev/null cscope -b -q
fi
