#!/bin/bash
#
# Warning: this does not have robust error checking!

bad=67
if [ $# -lt 1 ]
then
    echo "Usage: $0 <filename> [delay in seconds]"
    exit $bad
fi

if [ $# -eq 1 ] #check for arguments
then
    time=3 #if one (only filename) exists, sleep for 3 seconds
    filename=$1 #set filename
else
    time=$2 #else, we'll sleep for $2 seconds
    filename=$1 #set filename
fi

winfo=$(xwininfo -tree -root | grep rviz | tail -n1 | awk '{print $1}' | xargs xwininfo -id)
winid=$(echo $winfo | grep "Window id:" | sed -e "s/xwininfo\:\ Window id:\ //;s/\ .*//")
abs_x=25
abs_y=50
win_width=$(expr $(xwininfo -id ${winid} | grep "Width:" | awk '{print $2}') - 50)
win_height=$(expr $(xwininfo -id ${winid} | grep "Height:" | awk '{print $2}') - 160)

recordmydesktop --windowid ${winid} -o $filename.ogv --delay $time --no-sound \
    -x ${abs_x} -y ${abs_y} --width ${win_width} --height ${win_height}

mencoder $filename.ogv -o $filename.avi -oac mp3lame -lameopts fast:preset=standard -ovc lavc -lavcopts vcodec=mpeg4:vbitrate=4000
