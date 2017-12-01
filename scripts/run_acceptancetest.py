#!/usr/bin/env python
# -*- coding: utf-8 -*-

"""Runner script for acceptance testing"""

import os
import re
import sys
import string
from subprocess import call

def rework_args(args):
    """Rework args to be able to exclude list of tags (pybot hack)"""

    # first loop to distinguish between previous, --exclude, and next args
    prev_args = []
    next_args = []
    found_next_arg = False
    parse_next_args = False
    excluded_tags_string = None
    for arg in args:
        if arg == "--exclude":
            found_next_arg = True
        elif found_next_arg:
            excluded_tags_string = arg
            found_next_arg = False
            parse_next_args = True
        elif parse_next_args:
            next_args.append(arg)
        else:
            prev_args.append(arg)

    # Rebuild the final args
    final_args = prev_args
    if excluded_tags_string is not None:
        excluded_tags = excluded_tags_string.split("AND")
        for exc in excluded_tags:
            final_args.append("--exclude")
            final_args.append(exc)
    final_args += next_args

    return final_args

def run_tests(args):
    """Run pybot command with given args"""
    extra_args = ['--removekeywords', 'wuks'] # remove keywords
    extra_args += ['--suitestatlevel', '1']   # limit stat size
    extra_args += ['--splitlog']              # split logs to limit per-file size

    args = rework_args(args=args)

    args = extra_args + args
    cmd_line = string.join(['pybot'] + args)
    print "pybot command line: ", cmd_line
    retcode = call(['pybot'] + args , shell=(os.sep == '\\'))
    print "pybot command return code was:", retcode
    return retcode

if __name__ == '__main__':

    sys.exit(run_tests(sys.argv[1:]))
