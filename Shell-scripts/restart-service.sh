#!/bin/bash
SERVICE=nfs-server
if ! pgrep -x "$SERVICE" > /dev/null; then 
    systemctl restart $SERVICE
fi


+++++++++++++++++++++
#!/bin/bash
SCRIPT_NAME=$0
LOGS_DIR=/tmp/
LOGFILE=$LOGS_DIR/$0-$DATE.log
SERVICE=nfs-server
DATE=$(date +%F:%H:%M:%S)

if ! pgrep -x "$SERVICE" > /dev/null; then
    systemctl restart $SERVICE; echo "Service was started at $DATE" &>>$LOGFILE
fi