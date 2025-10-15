#!/bin/bash
# to monitor the server cpu utilization and memory utlization and send the warning message when its exceeds 80%.
#psesudo
#get the cpu and memory utilz values in percentages(mpstat command, 100 - idle)
# variableize the cpu utilization and memory utulization
# define the threshold value.
#write a if condition to compare threshold value to the actual util.

#!/bin/bash

THRESHOLD=0

# Get CPU Utilization
CPU_UTIL_RAW=$(LANG=en_GB.UTF-8 mpstat 1 1 | awk '$2 ~ /CPU/ { for (i=1;i<=NF;i++) { if ($i ~ /idle/) field =i } } $2 ~ /all/ { print 100 - $field }' | tail -1)
CPU_UTIL=$(printf "%.2f" "$CPU_UTIL_RAW")

# Get Memory Info
MemFreeB=$(awk '/MemFree/ {print $2}' /proc/meminfo)
MemTotalB=$(awk '/MemTotal/ {print $2}' /proc/meminfo)
MemUsedB=$(expr $MemTotalB - $MemFreeB)

# Convert to MB
MemFree=$(printf "%.2f" $(bc -q <<< "scale=2; $MemFreeB/1024/1024"))
MemUsed=$(printf "%.2f" $(bc -q <<< "scale=2; $MemUsedB/1024/1024"))
MemTotal=$(printf "%.2f" $(bc -q <<< "scale=2; $MemTotalB/1024/1024"))

# Calculate Memory Utilization %
MEM_UTIL=$(printf "%.2f" $(bc -q <<< "scale=2; $MemUsed*100/$MemTotal"))

# Compare CPU Utilization
if (( $(echo "$CPU_UTIL > $THRESHOLD" | bc -l) )); then
    echo "CPU Utilization is High: $CPU_UTIL% (Threshold: $THRESHOLD%)"
fi

# Compare Memory Utilization
if (( $(echo "$MEM_UTIL > $THRESHOLD" | bc -l) )); then
    echo "Memory Utilization is High: $MEM_UTIL% (Threshold: $THRESHOLD%)"
fi


++++++++++++++++++++++++++++++++++++++++++++++++
#In another way.
#!/bin/bash
ALERT_EMAIL="your.email@example.com"
THRESHOLD=0
#top -bn1 | grep "Cpu(s)" | awk '{print 100 - $8}'
CPU_UTIL_RAW=$(vmstat 1 2 | tail -1 | awk '{print 100 - $15}')
CPU_UTIL=$(printf "%.2f" "$CPU_UTIL_RAW")
# Get memory info
MemFreeB=$(awk '/MemFree/ {print $2}' /proc/meminfo)
MemTotalB=$(awk '/MemTotal/ {print $2}' /proc/meminfo)
MemUsedB=$(expr $MemTotalB - $MemFreeB)

# Convert to MB
MemFree=$(printf "%.2f" $(bc -q <<< "scale=2; $MemFreeB/1024/1024"))
#scale=2; → tells bc to keep 2 digits after the decimal for division results (note: bc truncates, it doesn’t round).
#<<< is a here-string that feeds the expression to bc via stdin.
#printf "%.2f" ...Formats the number to exactly 2 decimals (e.g., 117.73 → 117.73; 3 → 3.00).
MemUsed=$(printf "%.2f" $(bc -q <<< "scale=2; $MemUsedB/1024/1024"))
MemTotal=$(printf "%.2f" $(bc -q <<< "scale=2; $MemTotalB/1024/1024"))

# Calculate Memory Utilization %
MEM_UTIL=$(printf "%.2f" $(bc -q <<< "scale=2; $MemUsed*100/$MemTotal"))

# Compare CPU Utilization
if (( $(echo "$CPU_UTIL > $THRESHOLD" | bc -l) )); then
    echo "CPU Utilization is High: $CPU_UTIL%" | mail -s "High CPU alert on $(hostname)" "$ALERT_EMAIL"
fi

# Compare Memory Utilization
if (( $(echo "$MEM_UTIL > $THRESHOLD" | bc -l) )); then
    echo "MEMORY Utilization is High: $MEM_UTIL%" | mail -s "High Memory alert on $(hostname)" "$ALERT_EMAIL"| 
fi



