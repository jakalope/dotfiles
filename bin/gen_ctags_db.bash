#!/bin/bash

mv tags tagss
2>/dev/null ctags $(cfiles) $(2>/dev/null find /opt/ros/${ROS_DISTRO} -name "*.c" -o -name "*.cpp" -o -name "*.h" -o -name "*.hpp")
if [[ $# > 0 ]]; then
    vim --servername ${1} --remote-send '<ESC>:echo "CTags database generated."<CR>'
fi
rm tagss
