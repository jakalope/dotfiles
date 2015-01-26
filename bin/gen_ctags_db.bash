#!/bin/bash

mv tags tagss
2>/dev/null ctags $(cfiles ./ /opt/ros/${ROS_DISTRO})
if [[ $# > 0 ]]; then
    vim --servername ${1} --remote-send '<ESC>:echo "CTags database generated."<CR>'
fi
rm tagss
