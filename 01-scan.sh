#!/bin/bash

BASE="/tmp"

if [ -z "$1" ]; then
    echo "Usage: $0 <jobid>"
    echo
    echo "Please provide unique jobid name as first parameter"
    exit 1
fi

OUTPUT="$BASE/$1"
mkdir -p "$OUTPUT"

echo 'scanning...'
scanimage \
	--device=net:localhost:canon_dr:libusb:001:006 \
	--source="ADF Duplex" \
	--format=pnm \
	--mode=Color \
	--resolution=300 \
	--rollerdeskew=yes \
	--stapledetect=yes \
	--swdeskew=yes \
	--df-length=yes \
	--batch="/tmp/out%d.tiff"

echo "Output in $OUTPUT/scan*.pnm"
