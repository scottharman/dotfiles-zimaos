#!/bin/bash

# Set paths
OUTPUT_FOLDER=/DATA/logs
TAR_OUTPUT=/DATA/logs.tar.gz

# Ensure output folder exists
if [ ! -d "$OUTPUT_FOLDER" ]; then
    echo "$OUTPUT_FOLDER does not exist. Creating it."
    mkdir -p "$OUTPUT_FOLDER"
fi

# Copy logs from /var/log, excluding 'journal' and 'private'
rsync -av --exclude='journal/' --exclude='private/' /var/log/ "$OUTPUT_FOLDER"

# Capture journalctl output separately
journalctl -m > "$OUTPUT_FOLDER/journalctl.log"

# Compress the full content of /DATA/logs into logs.tar.gz
tar -czvf "$TAR_OUTPUT" -C "$OUTPUT_FOLDER" . 

# Remove the logs folder after archiving
rm -rf "$OUTPUT_FOLDER"