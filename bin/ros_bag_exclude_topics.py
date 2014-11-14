#!/usr/bin/env python
# Extracts a whitelist of topics from a bag file by excluding a blacklist.
# Author: Jake Askeland, 2014
#         jake.askeland@us.bosch.com

import sys
import ros_bag_get_topics

def main(bagfile, blacklist):
    topics    = ros_bag_get_topics.main(bagfile)

    # get only non-blacklisted topics
    whitelist = []
    for topic in topics:
        fail = False

        # look for each blacklisted word this topic
        for word in blacklist:
            if topic.count(word) != 0:
                fail = True
                break

        # if none of the words were found, print
        if not fail:
            whitelist.append(topic)

    return whitelist
    
if __name__ == '__main__':
    bagfile   = sys.argv[1]
    blacklist = sys.argv[2:]
    whitelist = main(bagfile, blacklist)
    for topic in whitelist:
        print topic

