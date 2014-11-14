#!/bin/bash

find /usr/lib -name "libboost_*" | awk -F_ '{print $2}' | awk -F. '{print $1}' | sort -u
