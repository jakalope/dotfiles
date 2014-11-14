#!/bin/bash

rospack list | grep $HOME | awk '{print $1}' | 2>&1 xargs rosdep install | grep "Missing resource" | awk '{print $NF}' | sort -u
