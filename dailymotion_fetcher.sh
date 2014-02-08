#!/bin/sh

if [ $# -ne 1 ]; then
    echo "Usage: $0 <DAILYMOTION_URL>"
    exit 1
fi

URL=$1
BASENAME=`basename $URL | cut -d# -f1 | cut -d? -f1`
FILENAME=`echo ${BASENAME} | cut -d_ -f2`.mp4
JSON_URL=http://www.dailymotion.com/json/video/${BASENAME}?fields=stream_h264_url,stream_h264_ld_url,stream_h264_hq_url,stream_h264_hd_url,stream_h264_hd1080_url

wget -O - -q $JSON_URL | tr ',' '\n' | sed 's/^.*\(http:.*\)"/\1/' | grep http | tail -n 1 | xargs wget -O $FILENAME



