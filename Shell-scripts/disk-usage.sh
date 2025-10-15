#!/bin/bash
THRESHOLD=80
USAGE=$(df /application | grep / | awk '{ print $5 }' | sed 's/%//g')
if [ $USAGE -gt $THRESHOLD ]; then
    echo " Disk usage is above $THRESHOLD%!" | mail -s "Disk Alert" admin@example.com
fi

