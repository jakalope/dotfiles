#!/usr/bin/env python
# Extracts a list of topics from a bag file.
# Author: Jake Askeland, 2014
#         jake.askeland@us.bosch.com

import subprocess, yaml, sys

def main(bagfile):
    # build and execute terminal command
    command   = ['rosbag', 'info', '--yaml', bagfile]
    yaml_file = subprocess.Popen(command, stdout=subprocess.PIPE).communicate()[0]

    # parse the command output as a yaml file
    info_dict = yaml.load(yaml_file)

    # pull out all topics
    topics    = [item['topic'] for item in info_dict['topics']]

    return topics

if __name__ == '__main__':
    bagfile   = sys.argv[1]
    topics = main(bagfile)
    for topic in topics:
        print topic


