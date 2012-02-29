#!/bin/bash
# Tymoteusz Cywinski
echo "**********************"
echo "* wyszukiwanie plikow*"
echo "**********************"
echo "witaj" $USER "!"
echo "------------------------"
echo "wybierz gdzie chcesz szukac:"
	    select z in "w katalogu domowym" "w podanym katalogu" "x"
	    do
		case $z in
		    "w katalogu domowym")
		    echo "zostanie przeszukany katalog domowy"
		    SCIEZKA="$HOME"
		;;
		    "w podanym katalogu")
		    echo "podaj sciezke do katalogu:"
		    read SCIEZKA
		    echo "zostanie przeszukany katalog" $SCIEZKA
		;;
		    *) echo "nic nie wybrales.."
		       echo "zostanie przeszukany katalog domowy"
		    SCIEZKA="$HOME"
	        esac
	    echo "podaj nazwe pliku lub jej czesc:"
	    read NAZWA
	    echo "--------------------------"
	    echo "znaleziono pliki:"
	    find $SCIEZKA -iname "$NAZWA" 
	    echo "wyslac je w zalaczniku email? (t/n)"
	    read CZYTAK
	    if [ "$CZYTAK" == "t" ] ; then
		TEMAT="wyslanie pliku"
		echo "podaj adres email:"
		read EMAIL
		EMAILMESSAGE=" "
		echo "dodac wiadomosc tekstowa? (t/n)"
		read CZYTAK2
		if [ "$CZYTAK2" == "t" ] ; then
		    echo "wprowadz tekst:"
		    read EMAILMESSAGE
		fi
		echo "kompresuje zalaczniki.."
		touch $NAZWA.tar
		tar -rvf $NAZWA.tar `find $SCIEZKA -iname "$NAZWA"`
		echo "wysylam emaila.."
		/bin/mail -s "$TEMAT" -a $NAZWA.tar "$EMAIL"
		echo "mail wyslany."
#		rm $NAZWA.tar
	    fi
break
done