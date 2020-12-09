#!/usr/bin/env bash

# (c) 2019 Akira KOmamura

# Start Xephyr with the correct DPI

if [[ $# -eq 0 ]]; then
    echo "Please specify the display as the first argument." >&2
    exit 1
fi

dimensions=$(xdpyinfo -display "$DISPLAY" | grep dimensions:)
if [[ "$dimensions" =~ ([[:digit:]]+)x([[:digit:]]+)\ pixels ]]; then
    widthInPixels=${BASH_REMATCH[1]}
    heightInPixels=${BASH_REMATCH[2]}
else
    echo "Dimensions mismatch (1)" >&2
    exit 1
fi
if [[ "$dimensions" =~ ([[:digit:]]+)x([[:digit:]]+)\ millimeters ]]; then
    widthInMm=${BASH_REMATCH[1]}
    heightInMm=${BASH_REMATCH[2]}
else
    echo "Dimensions mismatch (2)" >&2
    exit 1
fi

spec="${widthInPixels}/${widthInMm}x${heightInPixels}/${heightInMm}"
echo "Creating a new display $1 with screen $spec"
Xephyr "$1" -screen "$spec" -resizeable &
