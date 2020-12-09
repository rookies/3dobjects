#!/bin/bash
cd $(dirname $0)

# Retrieve echo output of OpenSCAD:
echofile=$(mktemp --suffix=.echo)
trap "rm -f $echofile" EXIT
openscad -o $echofile workshop_shelf.scad

# Call BOM calculator:
python3 bom.py $echofile
