#!/usr/bin/python3
import re

def load(inputFile):
    ## Read input file:
    regex1 = re.compile('^ECHO: "NUM", [0-9]+\n$')
    regex2 = re.compile('^ECHO: [0-9]+\.?[0-9]*, [0-9]+\.?[0-9]*\n$')
    num = -1
    rings = []
    with open(inputFile) as f:
        for line in f:
            if re.match(regex1, line):
                num = int(line.split(',')[1])
            elif re.match(regex2, line):
                data = line[6:-1].split(',')
                dInner = float(data[0])
                dOuter = float(data[1])
                rings.append((dInner, dOuter))

    ## Check if input file is valid:
    if num == -1:
        raise ValueError('No NUM line found.')
    if num != len(rings):
        raise ValueError(f'Error: Expected {num} rings, got {len(rings)}.')

    ## Return result:
    return rings
