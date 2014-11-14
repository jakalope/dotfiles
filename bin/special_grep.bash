#!/bin/bash

filetype=$1
shift
2>/dev/null grep --line-number "$@" $(find -regex "${file_type}" --print) | nl | grep "$@"

