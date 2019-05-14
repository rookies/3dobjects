#!/usr/bin/python3
import sys, re

## Config
dInnerStock = 7
dOuterStock = 300

## Check command line arguments:
if len(sys.argv) != 2:
    print(f'Usage: {sys.argv[0]} inputfile')
    sys.exit(1)

## Read input file:
regex1 = re.compile('^ECHO: "NUM", [0-9]+\n$')
regex2 = re.compile('^ECHO: [0-9]+\.?[0-9]*, [0-9]+\.?[0-9]*\n$')
num = -1
rings = []
with open(sys.argv[1]) as f:
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
    print('Error: No NUM line found.')
    sys.exit(1)
if num != len(rings):
    print(f'Error: Expected {num} rings, got {len(rings)}.')
    sys.exit(1)

## Sort them according to their inner diameters:
rings.sort(key=lambda x: x[0], reverse=True)

print(rings)
stock = []
while len(rings) > 0:
    # Check if we have space on used stock left:
    for i in range(len(stock)):
        s = stock[i]
        if (s['dInner'] <= rings[0][0]) and (s['dOuter'] >= rings[0][1]):
            # Use existing stock:
            # TODO: Best fit instead of first fit?
            # TODO: Add some tolerance?
            s['dOuter'] = rings[0][0]
            s['rings'].append(rings[0])
            print(f'Put ring {rings[0]} on stock #{i+1}.')
            rings.pop(0)
            break
    else:
        # Create new stock:
        if (rings[0][0] < dInnerStock) or (rings[0][1] > dOuterStock):
            raise ValueError('Stock is not large enough!')
        stock.append({
            'dInner': dInnerStock,
            'dOuter': rings[0][0],
            'rings': [rings[0]]
        })
        print(f'Put ring {rings[0]} on new stock #{len(stock)}.')
        rings.pop(0)
for i in range(len(stock)):
    s = stock[i]
    print(f'Stock #{i+1}:')
    if len(s['rings']) == 1:
        print(f'  {len(s["rings"])} ring: {s["rings"]}')
    else:
        print(f'  {len(s["rings"])} rings: {s["rings"]}')
    left = []
    for i in range(len(s['rings'])-1):
        r1 = s['rings'][i]
        r2 = s['rings'][i+1]
        left.append((r2[1], r1[0]))
    left.append((s['dInner'], s['dOuter']))
    print(f'  Left: {left}')
