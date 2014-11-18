#!/bin/sh
# $1 = name of a log file
# the rest of the args are names of files that were modified
log="$1"
shift

date +%s >>$log 
while test -n "$1" ; do
  echo >>$log $1
  shift
done

# We use this to prove that our output stream goes to the right place
echo "WOOT from trig.sh"

