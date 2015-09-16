#!/bin/bash

2>/dev/null ctags $(cfiles ./ /opt/ros/${ROS_DISTRO})
notify-send 'CTAGS complete'
