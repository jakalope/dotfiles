#!/bin/bash
color=$1
colors[0]="91"
colors[1]="92"
colors[2]="93"
colors[3]="94"
colors[4]="95"
colors[5]="96"
colors[6]="97"
colors[7]="31"
colors[8]="32"
colors[9]="33"
colors[10]="34"
colors[11]="35"
colors[12]="36"
colors[13]="37"
shift

if [[ $1 == "-p" ]]
then
    prefix=$2
    shift
    shift
fi

while read line
do
    echo -e "\033[${colors[${color}]}m" $prefix$line
done
echo -en "\033[0m"
