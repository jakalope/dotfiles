#!/bin/bash

echo "USAGE EXAMPLE: create_video.sh 'frame_*.png' output.avi"

if [[ $# > 1 ]]; then
    echo mencoder "mf://${2}" -mf fps=10 -o ${1} -ovc lavc -lavcopts vcodec=mpeg4
    mencoder "mf://${2}" -mf fps=10 -o ${1} -ovc lavc -lavcopts vcodec=mpeg4
fi
