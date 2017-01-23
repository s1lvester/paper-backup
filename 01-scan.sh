#!/bin/bash

BASE="/tmp"

OUTPUT="$BASE/$1"
mkdir -p "$OUTPUT"

echo 'scanning...'
scanimage \
	--source='ADF Duplex' \
	--format=pnm \
	--mode=Color \
	--resolution=300 \
	--df-length=yes \
    --batch="$OUTPUT/scan_%03d.pnm"

