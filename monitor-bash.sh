#!/bin/bash

# Get current date and time
DATE=$(date +"%Y-%m-%d_%H-%M-%S")

# Get CPU usage
CPU=$(top -b -n 1 | grep "Cpu(s)" | awk '{print $2+$4}')

# Get real memory usage
MEMORY=$(free | awk '/Mem/{printf("%.2f"), $3/$2*100}')

# Get top 10 CPU consuming processes
CPU_PROCESSES=$(ps -eo pid,%cpu,comm --sort=-%cpu | head -n 11)

# Get top 10 memory consuming processes
MEMORY_PROCESSES=$(ps -eo pid,%mem,comm --sort=-%mem | head -n 11)

# Get top 10 processes occupying swap memory
SWAP_PROCESSES=$(swapon -s | tail -n +2 | awk '{print $1}' | xargs -n 1 sudo swapusage -p | sort -k4 -n -r | head -n 11)

# Write data to a file
echo "$DATE,$CPU,$MEMORY" >> /var/log/system_metrics.log
echo "Top 10 CPU consuming processes:" >> /var/log/system_metrics.log
echo "$CPU_PROCESSES" >> /var/log/system_metrics.log
echo "Top 10 memory consuming processes:" >> /var/log/system_metrics.log
echo "$MEMORY_PROCESSES" >> /var/log/system_metrics.log
echo "Top 10 processes occupying swap memory:" >> /var/log/system_metrics.log
echo "$SWAP_PROCESSES" >> /var/log/system_metrics.log
