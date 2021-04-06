#!/bin/bash

DIR="./files"

URL="https://your.school.domain/playback/presentation/2.0/playback.html"
MEETING_IDS=(
UUID1
UUID2
UUID3
)

for MEETING_ID in ${!MEETING_IDS[@]}; do
        echo "Retrieving ${MEETING_IDS[$MEETING_ID]}..."
        python3.8 bbb2.py "$URL?meetingId=${MEETING_IDS[$MEETING_ID]}" > /dev/null

        FILENAME=`find . -name *.mp4 -printf "%f\n" | tr '[:upper:]' '[:lower:]' | cut -f1 -d'.'`
        VIDEO="${MEETING_ID}_${FILENAME}.mp4"
        SLIDES="${MEETING_ID}_${FILENAME}.pdf"

        mv *.mp4 $DIR/$VIDEO

        (cd *_slides ; convert `ls -1v` ../$DIR/$SLIDES)
        rm -r *_slides
done
