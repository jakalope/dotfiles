#!/bin/bash
while read line
do
    printf "%s\r" $line
    sleep .01
done
