#!/bin/bash
# Tymoteusz Cywinski
echo "*********************************"
echo "* kopia zapasowa / wyszukiwanie *"
echo "*********************************"
echo "witaj" $USER "!"
echo "------------------------"
echo "wybierz co chcesz zrobic:"

select y in "kopia zapasowa plikow o danym rozszerzeniu" "wyszukiwanie plikow o danym rozszerzeniu" "wyjscie"
do
  case $y in
    "kopia zapasowa plikow o danym rozszerzeniu") 
echo "Wybrałeś kopie zapasowa plikow o danym rozszerzeniu" 
x="0"
touch $HOSTNAME.$USER.$(date +"%d-%m-%Y").tar
while [ "$x" == "0" ] ; do 
    echo "podaj rozszerzenie pliku (bez kropki): "
    read typ
    echo "dodaje pliki o rozszerzeniu .$typ ..."
    tar -rvf $HOSTNAME.$USER.$(date +"%d-%m-%Y").tar `find $HOME -iname "*.$typ"`
    echo "pliki dodane do archiwum."
    echo "dodac plik tekstowy ze sciezkami plikow (t/n)?"
    read czytak1
    if [ "$czytak1" == "t" ] ; then
	echo "dodaje plik tekstowy..."
	find $HOME -iname "*.$typ" > $typ.txt
	tar -rvf $HOSTNAME.$USER.$(date +"%d-%m-%Y").tar $typ.txt
	rm $typ.txt
	echo "plik tekstowy dodany."
    fi
    echo "dodac pliki z innym rozszerzeniem? (t/n)"
    read czytak2
    if [ "$czytak2" == "n" ] ; then
	x="1"
    fi
done
;;
    "wyszukiwanie plikow o danym rozszerzeniu") 
     x="0"
     while [ "$x" == "0" ] ; do
	  echo "Wybrałeś wyszukiwanie plikow o danym rozszerzeniu"
	  echo "podaj rozszerzenie pliku (bez kropki):"
	  read typ
	  echo "znalezione pliki:"
	  find $HOME -iname "*.$typ"
	  echo "zapisac sciezki plikow do pliku tekstowego? (t/n)"
	  read czytak1
	  if [ "$czytak1" == "t" ] ; then
	      echo "tworze plik $typ.txt"
	      find $HOME -iname "*.$typ" > $typ.txt
              echo "utworzono plik $typ.txt"
	  fi
	  echo " wyszukac kolejne pliki? (t/n)"
	  read czytak2
	  if [ "$czytak2" == "n" ] ; then
	      x="1"
	  fi
     done
 ;;
    "wyjscie")
	  exit
 ;;
    *) echo "nic nie wybrales.."
  esac
break
done