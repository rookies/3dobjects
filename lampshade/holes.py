#!/usr/bin/python3
import sys, math, cmath
from load import load

# NOTE: number of holes per plate is assumed to be four!
alpha = 13 # offset angle between holes

## Check command line arguments:
if len(sys.argv) != 2:
    print(f'Usage: {sys.argv[0]} inputfile')
    sys.exit(1)

## Read input file:
rings = load(sys.argv[1])

## Print infos:
print('d1 .. distance from inner rim of bigger ring')
print('d2 .. distance from inner rim of smaller ring')
print('d3 .. linear distance between holes on one plate')
print('d4 .. linear distance to next set of holes')
for i in range(len(rings)-1):
    ns = (i+1,i+2)
    r1,r2 = rings[i],rings[i+1]
    diameterAvg = (r1[0] + r1[1] + r2[0] + r2[1]) / 4.
    d1 = (diameterAvg - r1[0]) / 20.
    d2 = (diameterAvg - r2[0]) / 20.
    d3 = (diameterAvg / math.sqrt(2)) / 10.
    if i != len(rings)-2:
        r1n,r2n = rings[i+1],rings[i+2]
        diameterAvgNext = (r1n[0] + r1n[1] + r2n[0] + r2n[1]) / 4.
        p1 = diameterAvg / 2.
        p2 = (diameterAvgNext / 2.) * cmath.exp(1j * math.pi * alpha / 180.)
        d4 = abs(p1 - p2) / 10.
        print('Rings %s: d1=%.1fcm, d2=%.1fcm, d3=%.1fcm, d4=%.1fcm' % (ns, d1, d2, d3, d4))
    else:
        print('Rings %s: d1=%.1fcm, d2=%.1fcm, d3=%.1fcm' % (ns, d1, d2, d3))
