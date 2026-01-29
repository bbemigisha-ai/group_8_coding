#!/bin/bash
LOG_DIR="hospital_data/active_logs"
ARCHIVE_DIR="hospital_data/archived_logs"
DATE=$(date '+%Y-%m-%d_%H:%M:%S')

echo "Select log to archive:"
echo "1) Heart Rate"
echo "2) Temperature"
echo "3) Water Usage"
read -p "Enter choice (1-3): " choice

case $choice in
  1) file="heart_rate_log.log"; folder="heart_data_archive";;
  2) file="temperature_log.log"; folder="temperature_data_archive";;
  3) file="water_usage_log.log"; folder="water_usage_data_archive";;
  *) echo "Invalid choice"; exit 1;;
esac

src="$LOG_DIR/$file"
dest="$ARCHIVE_DIR/$folder/${file%.log}_$DATE.log"

if [ ! -f "$src" ]; then
  echo "Log file not found: $src"
  exit 1
fi

mv "$src" "$dest" || { echo "Archiving failed"; exit 1; }
touch "$src"
echo "Archived $file to $dest"
