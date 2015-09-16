#!/bin/bash

cfiles > cscope.files
if [[ $ROS_EDIT == 1 ]]; then
    2>/dev/null find /opt/ros/${ROS_DISTRO} -name "*.cxx" -o -name "*.c" -o -name "*.cpp" -o -name "*.h" -o -name "*.hpp" >> cscope.files
fi

2>/dev/null cscope -b -q
notify-send 'CSCOPE completed'
