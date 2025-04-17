# #!/bin/bash

# # Define Output File
# OUTPUT_FILE="/tmp/system_info.txt"

# # Collect system information
# echo "Hostname: $(hostname)" > $OUTPUT_FILE
# echo "OS Version: $(cat /etc/os-release | grep PRETTY_NAME)" >> $OUTPUT_FILE
# echo "Kernel Version: $(uname -r)" >> $OUTPUT_FILE
# echo "CPU Info: $(lscpu | grep 'Model name')" >> $OUTPUT_FILE
# echo "Total RAM: $(free -h | grep Mem | awk '{print $2}')" >> $OUTPUT_FILE
# echo "Disk Usage: $(df -h / | grep / | awk '{print $5}')" >> $OUTPUT_FILE
# echo "Network Interfaces: $(ip -br a)" >> $OUTPUT_FILE

# # Print output file location
# echo "System info collected at: $OUTPUT_FILE"

#!/bin/bash
set -euo pipefail

OUTPUT_FILE="/tmp/system_info.txt"
DEBUG_LOG="/tmp/debug.log"

# Clear previous contents
> "$OUTPUT_FILE"
> "$DEBUG_LOG"

{
  echo "Script started"
  echo "Running as user: $(whoami)"
  echo "Creating system info report..."

  echo    "-----------------------------------------------------------"
  echo -n "System Name: ";  uname -n
  echo -n "Date: ";  date
  echo -n "Timezone: "; date | awk '{print $5}'
  echo -n "$(lscpu | sed -n '4p')"
  echo -n "$(cat /proc/meminfo | sed -n '1p')"

  echo "-----------------------------------------------------------"

  echo
  echo "Operating System Information"
  echo "============================"
  echo -n -e "\tOS Version: "; uname -s
  echo -n -e "\tRelease: "; cat /etc/????*-release | uniq

  echo
  echo "Logical Disk Information"
  echo "========================"
  df -Ph | awk '{printf "\t%-25s\t%s\t%s\t%s\t%s\t%s\n",$1,$2,$3,$4,$5,$6}' | grep -vE "/tmp|/var"

  echo
  echo "Mount Points Information"
  echo "========================"
  cat /etc/fstab

  echo
  echo "Service Status:"
  echo "==============="
  /sbin/service --status-all | grep -E "running|stopped" | sed 's/^/\t/g'

  echo
  echo "/etc Directory Status:"
  echo "======================"
  find /etc -type f | xargs du -sh

  echo
  echo "/opt Directory Status:"
  echo "======================"
  find /opt -type f | xargs du -sh

  echo
  echo "Ora Mounts Status:"
  echo "=================="
  find /u02 -type f | xargs du -sh

  echo
  echo "============================================End of Compliance Report============================================"
} >> "$OUTPUT_FILE" 2>> "$DEBUG_LOG"

echo "✅ Script executed successfully." >> "$OUTPUT_FILE"

