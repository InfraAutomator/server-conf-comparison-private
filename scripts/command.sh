#!/bin/bash

# Define Output File
OUTPUT_FILE="/tmp/system_info.txt"

# Collect system information
echo "Hostname: $(hostname)" > $OUTPUT_FILE
echo "OS Version: $(cat /etc/os-release | grep PRETTY_NAME)" >> $OUTPUT_FILE
echo "Kernel Version: $(uname -r)" >> $OUTPUT_FILE
echo "CPU Info: $(lscpu | grep 'Model name')" >> $OUTPUT_FILE
echo "Total RAM: $(free -h | grep Mem | awk '{print $2}')" >> $OUTPUT_FILE
echo "Disk Usage: $(df -h / | grep / | awk '{print $5}')" >> $OUTPUT_FILE
echo "Network Interfaces: $(ip -br a)" >> $OUTPUT_FILE

# Print output file location
echo "System info collected at: $OUTPUT_FILE"