#!/bin/sh
set -e

# Get the process
FULL_COMMAND="$(sed -n l "/proc/1/cmdline" | sed -e 's/\\$//g' | tr -d '\n' | sed -e 's/\$$//g' | sed -e 's/\\000/ /g' | sed -e 's/ *$//g' | head -1)"

# Look for the process
pgrep --full "$FULL_COMMAND" 2> /dev/null > /dev/null;
exit ${?};