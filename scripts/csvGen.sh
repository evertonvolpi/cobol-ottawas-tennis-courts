#!/bin/bash

API="https://opendata.arcgis.com/datasets/dba3be479b2d44e2a90b28b522a6e39d_21.geojson"

FILE="/root/cobol-ottawas-tennis-courts/files/otwData.csv"

/usr/bin/curl $API | jq -r '.features | .[].properties | "\(.OBJECTID),\(.PARK_ID),\(.PARKNAME),\(.ADDRESS | split(",")[0]),\(.ADDRESS | split(", ")[1]),\(.NO_COURTS),\(.INDOOR_COURT),\(.OUTDOOR_COURT),\(.LIGHTS),\(.CLUBHOUSE),\(.BENCHES),\(.FENCE),\(.PRACTICE_COURT),\(.BACKWALL)"' | sed 'y/çāáǎàēéěèīíǐìōóǒòūúǔùǖǘǚǜĀÁǍÀĒÉĚÈĪÍǏÌŌÓǑÒŪÚǓÙǕǗǙǛ/caaaaeeeeiiiioooouuuuüüüüAAAAEEEEIIIIOOOOUUUUÜÜÜÜ/' > $FILE
