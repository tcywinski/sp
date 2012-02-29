#!/bin/bash
# Tymoteusz Cywinski
echo "****************************************************"
echo "* wyszukiwanie plikow dla studentow informatyki UG *"
echo "****************************************************"
echo "witaj" $USER "!"
echo "------------------------"
echo "wybierz gdzie chcesz szukac:"
	    select z in "w katalogu domowym" "w podanym katalogu"
	    do
		case $z in
		    "w katalogu domowym")
		    echo "zostanie przeszukany katalog domowy"
		    SCIEZKA=$HOME
		;;
		    "w podanym katalogu")
		    echo "podaj sciezke do katalogu:"
		    read SCIEZKA
		    echo "zostanie przeszukany katalog" $SCIEZKA
		;;
		    *) echo "nic nie wybrales.."
		       echo "zostanie przeszukany katalog domowy"
		    SCIEZKA=$HOME
	        esac
	    echo "podaj nazwe pliku lub jej czesc:"
	    read NAZWA
	    echo "--------------------------"
	    echo "znaleziono pliki:"
	    find $SCIEZKA -iname "$NAZWA" 
	    echo "przeniesc je do public_html wraz z informacja na email? (t/n)"
	    read CZYTAK
	    if [ "$CZYTAK" == "t" ] ; then
		TEMAT="adres_do_pliku"
		echo "podaj adres email:"
		read EMAIL
		echo "dodac wiadomosc tekstowa? (t/n)"
		read CZYTAK2
		touch message.txt
		echo "sciezka do pliku $NAZWA.tar to:" >> message.txt
		echo "http://sigma.inf.ug.edu.pl/~$USER/$NAZWA.tar" >> message.txt
		if [ "$CZYTAK2" == "t" ] ; then
		    echo "-----------------" >> message.txt
		    echo "wprowadz tekst:"
		    read EMAILMESSAGE
		    echo "$EMAILMESSAGE" >> message.txt
		fi
		echo "pakuje pliki.."
		tar -rvf $NAZWA.tar `find $SCIEZKA -iname "$NAZWA"`
		echo "przenosze pliki do public_html.."
		mv $NAZWA.tar ~/public_html/$NAZWA.tar
		echo "wysylam emaila z informacja.."
		cat message.txt | mail -s "$TEMAT" $EMAIL 
		echo "mail wyslany."
		rm message.txt
	    fi
break
done