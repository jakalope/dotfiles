#!/usr/bin/env python

# USAGE: remove_prefix.py <file-list> <old-prefix>
# Removes old-prefix from each file in file-list.

import sys
import shutil

old_prefix = sys.argv[1]
print old_prefix
for i in range(2,len(sys.argv)):
    print 'Copying', sys.argv[i], 'to', sys.argv[i].split(old_prefix)[1]
    shutil.copy(sys.argv[i], sys.argv[i].split(old_prefix)[1])
    
