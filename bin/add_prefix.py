#!/usr/bin/env python

# USAGE: add_prefix.py <file-list> <new-prefix>
# Adds new-prefix to each file in file-list.

import sys
import shutil

new_prefix = sys.argv[1]
print new_prefix
for i in range(2,len(sys.argv)):
    print 'Copying', sys.argv[i], 'to', new_prefix + sys.argv[i]
    shutil.copy(sys.argv[i], new_prefix + sys.argv[i])
    
