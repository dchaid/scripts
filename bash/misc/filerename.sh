#!/bin/bash


#removes text from filenames and removes trailing whitespace from end of title

find . -name '*(USA)*' | while read f; do mv "$f" "${f//\(USA)/}"; done

find . -name '*(USA, Europe)*' | while read f; do mv "$f" "${f//\(USA, Europe)/}"; done

find . -name '*(World)*' | while read f; do mv "$f" "${f//\(World)/}"; done

find . -name '*(Japan, USA)*' | while read f; do mv "$f" "${f//\(Japan, USA)/}"; done

find . -name '*(Rev A)*' | while read f; do mv "$f" "${f//\(Rev A)/}"; done

find . -name '*(En,Fr,De,It)*' | while read f; do mv "$f" "${f//\(En,Fr,De,It)/}"; done

find . -name '*(Europe)*' | while read f; do mv "$f" "${f//\(Europe)/}"; done

find . -name '*(Japan)*' | while read f; do mv "$f" "${f//\(Japan)/}"; done

find . -name '*(J)*' | while read f; do mv "$f" "${f//\(J)/}"; done

find . -name '*(EU)*' | while read f; do mv "$f" "${f//\(EU)/}"; done

find . -type f | while read i; do mv "$i" "$(sed 's/ \.\([a-z0-9]*\)$/\.\1/' <<< "$i")"; done;

exit 0
