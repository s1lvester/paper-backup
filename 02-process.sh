#!/bin/bash

LANGUAGE="deu" # the tesseract language
BASE="/tmp"    # local storage
HOST="freenas" # remote host
FOLDER="/mnt/citadel/documents" # remote location
YEAR=`date '+%Y'`
TS=`date '+%Y-%m-%d_%H-%M-%S'` # timestamp

# Look for keyword
if [ -z $3 ]; then
    3="untagged"
fi

OUTPUT="$BASE/$1" # where 01-scan.sh did put the files
REMOTE="$2@$HOST:$FOLDER/$YEAR/$3/${TS}"
ssh "$2@$HOST" "mkdir -p $FOLDER/$YEAR/$3"  # create remote path

cd "$OUTPUT"


for i in $(ls scan_*.pnm); do
    filename=$(basename $i)
    filename="${filename%.*}"
    number="${filename//[^0-9]/}"
    unpaper "${i}" "${filename}_unpapered.pnm" # remove stuff from scaned doc
    convert "${filename}_unpapered.pnm" "${filename}.pdf" 
	ocrmypdf \
        --deskew \
        --clean \
        --rotate-pages \
        --keywords "$3" \
        --language "$LANGUAGE" \
        "${filename}.pdf" "${filename}.pdf"
    scp "${i}" "${REMOTE}_${number}.pnm" # copy only renamed pnm
done

pdfunite $(ls *pdf) out.pdf # merge pdf
scp out.pdf "${REMOTE}.pdf"

rm -rf "$OUTPUT"

