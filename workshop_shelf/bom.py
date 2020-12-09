#!/usr/bin/env python3
import sys

# Define prices per quantity:
partsPrices = {
    'extrusion': 6.65 / 1000,
    'euroContainer': 10,
}

# Initialize parts list:
parts = {}
for k, v in partsPrices.items():
    parts[k] = {
        'quantity': 0,
        'pricePerQuantity': v,
    }

# Collect parts:
with open(sys.argv[1]) as f:
    for line in f:
        strippedLine = line.strip().split('"')[1]
        if not strippedLine.startswith('BOM'):
            continue

        part, _, quantity = strippedLine[4:].partition(',')
        if quantity == '':
            intQuantity = 1
        else:
            intQuantity = int(quantity)

        parts[part]['quantity'] += intQuantity

# Calculate prices:
totalPrice = 0
for part in parts.values():
    part['price'] = part['quantity'] * part['pricePerQuantity']
    totalPrice += part['price']

# Print BOM:
maxNameLength = max([len(k) for k in parts.keys()])
for k, v in parts.items():
    print(f'{v["quantity"]:10d}x {k:{maxNameLength}s} ' +
          f'({v["pricePerQuantity"]:9.5f} each) = {v["price"]:7.2f}')
print('Total: %.2f' % totalPrice)
