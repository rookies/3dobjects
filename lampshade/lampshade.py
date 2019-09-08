#!/usr/bin/python3
import sys
from load import load

## Config
dInnerStock = 7
dOuterStock = 300
# TODO: Support different stock sizes?

## Check command line arguments:
if len(sys.argv) != 2:
    print(f'Usage: {sys.argv[0]} inputfile')
    sys.exit(1)

## Read input file:
rings = load(sys.argv[1])

## Sort rings according to their inner diameters:
rings.sort(key=lambda x: x[0], reverse=True)

print(rings)
stock = []
while len(rings) > 0:
    # Check if we have space on used stock left:
    bestStock = -1
    for i in range(len(stock)):
        s = stock[i]
        if (s['dInner'] <= rings[0][0]) and (s['dOuter'] >= rings[0][1]):
            if (bestStock == -1) or (abs(s['dOuter'] - rings[0][1]) < abs(stock[bestStock]['dOuter'] - rings[0][1])):
                bestStock = i
    ringFmt = '(Ri=%.1fcm, Ro=%.1fcm)' % (rings[0][0] / 20, rings[0][1] / 20)
    if bestStock != -1:
        # Use existing stock:
        # TODO: Best fit instead of first fit?
        # TODO: Add some tolerance?
        stock[bestStock]['dOuter'] = rings[0][0]
        stock[bestStock]['rings'].append(rings[0])
        print(f'Put ring {ringFmt} on stock #{bestStock+1}.')
        rings.pop(0)
    else:
        # Create new stock:
        if (rings[0][0] < dInnerStock) or (rings[0][1] > dOuterStock):
            raise ValueError('Stock is not large enough!')
        stock.append({
            'dInner': dInnerStock,
            'dOuter': rings[0][0],
            'rings': [rings[0]]
        })
        print(f'Put ring {ringFmt} on new stock #{len(stock)}.')
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
