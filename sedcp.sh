#!/bin/bash
#
#	Wykorzystując program sed, napisać skrypt w języku powłoki, służący do kopiowania zestawu plików między podanymi katalogami i zmiany rozszerzenia nazw tych plików. Postać wywołania skryptu:
#	
#   nazwa_skryptu  roz1  katalog1  roz2  katalog2
#
#   np.:    copy .abc kat1 .cba kat2
# 
#   Skrypt powinien kopiować wszystkie pliki zwykłe o nazwach z rozszerzeniem roz1 z katalogu katalog1 do katalogu katalog2, zamieniając rozszerzenia roz1 na roz2.
#
#   Skrypt powinien zawierać obsługę błędów:
#
#   * sygnalizować błędy składni (podając poprawną postać),
#   * sygnalizować użycie niepoprawnego argumentu (np. nie istniejący katalog),
#   * sygnalizować brak odpowiednich praw dostępu.

FROM="$2"
TO="$4"
EXTFROM="$1"
EXTTO="$3"

if [ $# -ne 4 ]; then
    echo "Error: Invalid number of parameters. Correct call: $0 .ext1 source_path .ext2 destination_path"
    exit 1
fi

if [ ! -d "$FROM" ]; then
    echo "Error: $FROM : Not a directory."
    exit 1
fi
if [ ! -d "$TO" ]; then
    echo "Error: $TO : Not a directory."
    exit 1
fi

if [ ! -r "$FROM" ]; then
    echo "Error: $FROM : Cannot read from directory."
    exit 1
fi
if [ ! -w "$TO" ]; then
    echo "Error: $TO : Cannot write to directory."
    exit 1
fi

if [[ ! $EXTFROM == "."* ]]; then
    echo "Error: $EXTFROM is not valid file extension (eg. .txt, .c)."
    exit 1
fi
if [[ ! $EXTTO == "."* ]]; then
    echo "Error: $EXTTO is not valid file extension (eg. .txt, .c)."
    exit 1
fi

ORIGINALS=`find $FROM -maxdepth 1 -name \*$EXTFROM`
CHECKIFFOUND=`echo "$ORIGINALS" | grep -c "."`
if [ $CHECKIFFOUND -eq 0 ]; then
    echo "Found no files matching criteria. Terminating."
    exit 0
fi
echo "${ORIGINALS}" | xargs -I {} cp {} $3

FROMESCAPED=`echo "$FROM" | sed 's/\//\\\//g' `
TOESCAPED=`echo $TO | sed 's/\//\\\//g' `

#COPIES=`echo "$ORIGINALS" | sed "s/"$FROMESCAPED"/"$TOESCAPED"/"`
#RENAMED=`echo "$COPIES" | sed "s/"$EXTFROM"/"$EXTTO"/"`
echo "$FROMESCAPED"
#echo "$COPIES"
#echo "$RENAMED"
