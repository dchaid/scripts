#!/usr/bin/python3

import csv

with open('logs.tsv') as input, open('logs.tsv', 'w+') as output:
    non_blank = (line for line in input if line.strip())
    output.writelines(non_blank)

