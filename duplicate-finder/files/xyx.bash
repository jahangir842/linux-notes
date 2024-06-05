#!/bin/bash

# Redirect stdout to output.txt
exec > output.txt

echo "This will be written to output.txt"
ls
echo "This will also be written to output.txt"

