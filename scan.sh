#!/bin/bash

DIR=$( cd $( dirname "${BASH_SOURCE[0]}" ) && pwd )
JOBID=`date '+%Y-%m-%d_%H%M%S'`
USER="markus"
KEYWORD=$1

# run the scanning in foreground
$DIR/01-scan.sh "$JOBID"

# execute processing in background
(
    # lock processing to make sure only one is running at a time
    (
        flock -x 200 # wait for lock
        $DIR/02-process.sh "$JOBID" "$USER" "$KEYWORD"
    ) 200>/tmp/scan.lock
) &

