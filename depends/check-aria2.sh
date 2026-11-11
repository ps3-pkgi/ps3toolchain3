#!/bin/sh
# check-aria2.sh by Naomi Peori (naomi@peori.ca)

## Check for aria2.
aria2c --version 1>/dev/null 2>&1 || { echo "ERROR: Install aria2 before continuing."; exit 1; }
