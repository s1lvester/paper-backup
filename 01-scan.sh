#!/bin/bash

BASE="/tmp"

OUTPUT="$BASE/$1"
mkdir -p "$OUTPUT"

echo 'scanning...'
scanimage \
	--source='ADF Duplex' \
	--format=pnm \
	--mode=Gray \
	--page-width=210 \
	-x 210 \
	--page-height=297 \
	-y 297 \
	--resolution=240 \
    --buffermode=yes \
    --batch="$OUTPUT/scan_%03d.pnm"

