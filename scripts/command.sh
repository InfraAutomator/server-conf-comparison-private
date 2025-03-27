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
########################################################
OUTPUT_FILE="/tmp/system_info.txt"

# Clear previous contents if the file exists
> $OUTPUT_FILE

(
echo    "-----------------------------------------------------------"

echo -n "System Name:" ;  uname -n ;
echo
echo -n  "Date:"  $(date);
echo
echo -n   "Timezone:" $(date | awk '{print $5}');
echo
echo -n  $(lscpu | sed -n '4p');
echo
echo -n  $(cat /proc/meminfo | sed -n '1p');
echo

echo    "-----------------------------------------------------------"

echo

echo "Operating System Information"

echo "============================"

echo

echo -n -e "\tOS Version: "; uname -s | awk '{print}'

echo -n -e "\tRelease: "; cat /etc/????*-release | uniq | awk '{print "\t",$1,$2,$3,$4,$5,$6,$7,$8}'

echo

echo "Logical Disk Information"

echo "========================"

df -Ph | awk '{printf "\t%-25s\t%s\t%s\t%s\t%s\t%s\n",$1,$2,$3,$4,$5,$6}' | grep -vE "/tmp|/var"

echo

echo "Mount Points Information"

echo "========================"

cat /etc/fstab | awk '{print "\t",$1,$2,$3,$4,$5,$6,$7,$8,$9,$10}';

echo

echo "Service Status:"

echo "==============="

/sbin/service --status-all | grep -E "running|stopped" | sed 's/^/\t/g';

echo

echo "/etc Directory Status:"

echo "======================"
echo
find /etc -type f | xargs du -sh

echo

echo "/opt Directory Status:"

echo "======================"
echo
find /opt -type f | xargs du -sh

echo

echo "Ora Mounts Status:"

echo "=================="
echo
find /u02 -type f | xargs du -sh
echo
echo "============================================End of Compliance Report============================================"
) >> $OUTPUT_FILE
