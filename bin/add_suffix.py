#!/usr/bin/env python

# USAGE: add_suffix.py <file-list> <new-suffix>
# Adds new-suffix to each file in file-list.

import sys
import shutil

new_suffix = sys.argv[1]
print new_suffix
for i in range(2,len(sys.argv)):
    print 'Copying', sys.argv[i], 'to', sys.argv[i] + new_suffix
    shutil.copy(sys.argv[i], sys.argv[i] + new_suffix)
    
