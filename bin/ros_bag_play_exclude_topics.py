#!/usr/bin/env python
# Plays back all topics except those listed after the '--exclude' token.
# Author: Jake Askeland, 2014
#         jake.askeland@us.bosch.com

import sys
import ros_bag_exclude_topics
from subprocess import call

# look for the command line token '--exclude'.
# if it isn't found, show usage.
try:
    exclude_token = sys.argv.index('--exclude')
except:
    print "No '--exclude' token found."
    print 'USAGE:', sys.argv[0], '<bag-file> [rosbag options]',
    print ' --exclude <exclude-terms>'
    sys.exit(1)

# extract rosbag arguments
args      = sys.argv[1:exclude_token]
bagfile   = sys.argv[1]

# extract blacklist words
blacklist = sys.argv[exclude_token+1:]

# get a list of topics from the bag file that do not contain words from the
# blacklist.
whitelist = ros_bag_exclude_topics.main(bagfile, blacklist)
command   = ['rosbag', 'play'] + args + ['--topics'] + whitelist
print ' '.join(command)
call(command)

