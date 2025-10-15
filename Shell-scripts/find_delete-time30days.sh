#shell script to find and delete all files in a directory that are older than 30 day
#pseudo 
# check given folder is exists or not
# use command to find and delete.
#!/bin/bash
FOLDER=$1
if [ -d "$FOLDER" ]; then 
    echo "$FOLDER does exist"
else
    echo "$FOLDER does not exist"
fi

find $FOLDER -type f -mtime +30 -delete


  