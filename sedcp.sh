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

find $2 -name \*$1 -print0 | xargs -0 -I {} cp {} $3
#| sed 's/'$1'/'$3'/'  
