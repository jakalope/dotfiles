#!/usr/bin/env python

import os
import sys
import argparse


def make(args):
    command = ['make']
    debug = ['-gddb3', '-O0'] if args.debug else []
    jobs = ['-j', args.jobs] if len(args.jobs) > 0 else []
    return command + debug + jobs


def bazel(args):
    command = ['bazel']
    subcommand = ['test'] if args.test else ['build']
    debug = ['--compilation_mode=dbg', '--test_output=errors']
    jobs = ['--jobs', args.jobs] if len(args.jobs) > 0 else []
    return command + subcommand + debug + jobs


if __name__ == '__main__':
    parser = argparse.ArgumentParser('[Description]')

    parser.add_argument('path', help='' +
                        'File belonging to the package to be built')

    parser.add_argument('-d', '--debug', action='store_true', help='' +
                        'Compile with debug flags and without optimizations')

    parser.add_argument('-j', '--jobs', type=int, help='' +
                        'Number of concurrent jobs to compile with')

    parser.add_argument('-t', '--test', action='store_true', help='' +
                        'Compile and run tests')

    function_dict = {'Makefile': make,
                     'BUILD': bazel,
                     }

    args = parser.parse_args()
