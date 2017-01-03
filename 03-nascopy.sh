#!/bin/bash

BASE="/tmp"
HOST="freenas"
FOLDER="/mnt/citadel/documents"
YEAR=`date '+%Y'`

if [ -z "$1" ]; then
    echo "Usage: $0 <jobid> <user> [<keyword>]"
    echo
    echo "Please provide existing jobid as first parameter"
    exit 1
fi

if [ -z "$2" ]; then
    echo "Usage: $0 <jobid> <user> [<keyword>]"
    echo
    echo "Please provide user as second parameter"
    exit 1
fi

OUTPUT="$BASE/$1"
REMOTE="$2@$HOST:$FOLDER/$YEAR/$3/$1.pdf"
LOCAL="$OUTPUT/$1.pdf"

if [ ! -f "$LOCAL" ]; then
    echo "jobid does not exist"
    exit 1
fi


echo copying to $REMOTE
scp "$LOCAL" "$REMOTE"

