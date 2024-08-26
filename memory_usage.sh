#Write a shell script to check memory usage in linux server and send sns notification if it exceeds threshold.
#! /bin/bash
# Set threshold (e.g., 80% of total memory)
THRESHOLD=80
# Get total memory
TOTAL_MEM=$(awk -F " " '/MemTotal/ {print $2}' /proc/meminfo)
# Get available memory
AVAILABLE_MEM=$(awk -F " " '/MemFree/ {print $2}' /proc/meminfo)
# Calculate used memory
USED_MEM=$((TOTAL_MEM - AVAILABLE_MEM))
# Calculate the percentage of USER MEMORY
USED_MEM_PER=$((USED_MEM * 100 / TOTAL_MEM))
# Check if the used memory percentage exceeds threshold
if [ $USED_MEM_PER -gt $THRESHOLD ]; then
aws sns publish --topic-arn arn:aws:sns:us-east-1:010526277866:devops_team --message "Memory Usage Exceeded $THRESHOLD% threshold!" 
fi