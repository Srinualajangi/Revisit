#shell script that renames all .txt files in a given directory by appending the current date (in YYYY-MM-DD format) to the end of each filename, before the file extension
#pseudo
#!/bin/bash

FOLDER=$1
DATE=$(date +%F)

if [ -d "$FOLDER" ]; then 
    echo "$FOLDER does exist"
else
    echo "$FOLDER does not exist"
    exit 1
fi

find "$FOLDER" -type f -name "*.txt" -exec bash -c '
DATE="$1"
shift
for file in "$@"; do
    dir=$(dirname "$file")
    base=$(basename "$file" .txt)
    mv "$file" "$dir/${base}_$DATE.txt"
done
' bash "$DATE" {} +

++++++++++++++++++++++++++++++++++++++++++++
#!/bin/bash

DIR=$1
DATE=$(date +%F)

for file in "$DIR"/*.txt; do
    [ -e "$file" ] || continue 
    base=$(basename "$file" .txt)
    mv "$file" "$DIR/${base}_$DATE.txt"
done




++++++++++++++++++++++++++++++++=
#!/bin/bash
DIR=$1
DATE=(date +%F)

for file in "$DIR"/*.txt; do
    [-e "$file"] || continue
    base=$(basename "$file" .txt)
    mv "$file" "$DIR/${base}_$DATE.txt"
done






