#!/bin/bash

2>/dev/null grep --recursive --line-number --color $@ $(find_launch_script.bash) $(find_yaml.bash)
