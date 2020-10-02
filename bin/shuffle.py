#!/usr/bin/env python
import sys, random

lines = sys.stdin.readlines()
random.shuffle(lines)
for line in lines: print line,

