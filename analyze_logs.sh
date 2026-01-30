#!/bin/bash
LOG_DIR="hospital_data/active_logs"
REPORT="hospital_data/reports/analysis_report.txt"

echo "Select log file to analyze:"
echo "1) Heart Rate"
echo "2) Temperature"
echo "3) Water Usage"
read -p "Enter choice (1-3): " choice

case $choice in
  1) file="heart_rate_log.log";;
  2) file="temperature_log.log";;
  3) file="water_usage_log.log";;
  *) echo "Invalid choice"; exit 1;;
esac

src="$LOG_DIR/$file"

if [ ! -f "$src" ]; then
  echo "Log file not found: $src"
  exit 1
fi

echo "----- Analysis of $file on $(date) -----" >> "$REPORT"
awk '{print $3}' "$src" | sort | uniq -c >> "$REPORT"
first=$(head -n 1 "$src" | awk '{print $1}')
last=$(tail -n 1 "$src" | awk '{print $1}')
echo "First entry: $first" >> "$REPORT"
echo "Last entry: $last" >> "$REPORT"
echo "" >> "$REPORT"

echo "Analysis complete. Results appended to $REPORT"
