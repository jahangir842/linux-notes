#!/bin/bash

DIR_TO_WATCH="/home/"
LOG_FILE="/home/adminit/projects/commands/monitoring-fs/"

# Ensure the log file exists
touch "$LOG_FILE"

# Start monitoring
inotifywait -m -r -e create,delete,modify,move "$DIR_TO_WATCH" --format '%w%f %e' |
while read file event; do
    echo "$(date) - $file - $event" >> "$LOG_FILE"
done
