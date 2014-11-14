#!/usr/bin/env python

# USAGE: remove_suffix.py <file-list> <old-suffix>
# Removes old-suffix from each file in file-list.

import sys
import shutil

old_suffix = sys.argv[1]
print old_suffix
for i in range(2,len(sys.argv)):
    print 'Copying', sys.argv[i], 'to', sys.argv[i].split(old_suffix)[0]
    shutil.copy(sys.argv[i], sys.argv[i].split(old_suffix)[0])
    
