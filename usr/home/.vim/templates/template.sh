#!/usr/bin/bash

if [ "$#" -lt 1 ] || [ "$#" -gt 3 ]; then
    echo "Usage: $0 arg1 [arg2] [arg3]"
    exit 1
fi

# interactive session check
if [ -t 0 ]; then
    echo -n "Delete existing output files? [y/N]: "
    read ans
    case "$ans" in
        y|Y) rm -f *.school ;;
        *) echo "Aborted"; exit 0 ;;
    esac
fi

# process input file
while IFS= read -r line; do
    new_f="${line%.*}.school"
    f > "$new_f"
done < "$FILE"

exit 0

