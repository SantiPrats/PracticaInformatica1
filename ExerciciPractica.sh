#!/bin/bash
q="q"
while [ $q=="q" ]
do
        echo "Introdueix una ordre:"
        read option
        case $option in
                'q')
                        echo "Sortint de l'aplicació"
                        exit
                ;;
                'lp')
                        cut -d',' -f7,8 cities.csv | uniq
                ;;
                'sc')
                        pais="XX"
                        echo "Introdueix país:"
                        read x
                        CADENA='(("\w+( +\w+)+")|\w+)'
                        if [ -n "$x" ]; then
                                pais=$(cut -d',' -f7,8 cities.csv | egrep "$x" | cut -d',' -f1 | uniq)
                                if [ -z "$pais" ]; then
                                        pais="XX"
                                fi
                        fi
                        echo $pais
                ;;
                'se')
                        echo "Introdueix estat:"
                        read y

                        if [ -n "$y" ]; then
                                estat=$(egrep "$pais" cities.csv | cut -d',' -f4,5 | egrep "$y" | cut -d',' -f1 | uniq)
                                if [ -z "$estat" ]; then
                                        estat="XX"
                                fi
                        fi
                        echo $estat
                ;;
                'le')
                        cut -d',' -f4,5,8 cities.csv | egrep "$x" | cut -d',' -f1,2 | uniq
                ;;
                'lcp')
                        cut -d',' -f2,7,11 cities.csv | egrep "$pais" | cut -d',' -f1,3 | uniq
                ;;
                'ecp')
                        cut -d',' -f2,7,11 cities.csv | egrep "$pais" | cut -d',' -f1,3 | uniq > "$pais".csv

                ;;
                'lce')
                        cut -d',' -f2,5,7,11 cities.csv | egrep "$pais" | egrep "$y" | cut -d',' -f1,4 | uniq
                        #El problema 9 el fem dins el 8, ja que és el mateix codi (lce)
                        cut -d',' -f2,5,7,11 cities.csv | egrep "$pais" | egrep "$y" | cut -d',' -f1,4 | uniq > "$pais"_"$estat".csv
                ;;
                'gwd')
                        echo "Introdueix una població:"
                        read z
                        wiki=$(cut -d',' -f2,5,7,11 cities.csv | egrep "$pais" | egrep "$y" | cut -d',' -f1,4 | sed 's/"//g' | egrep ^"$z" | cut -d',' -f2)
                        if [ -n "$wiki" ]; then
                                wget -q https://www.wikidata.org/wiki/Special:EntityData/"$wiki".json
                        fi
                ;;
		'est')
                        awk -F',' 'BEGIN{ Nord=0; Sud=0; Est=0; Oest=0; Noubic=0; NoWDld=0; }  { if ( NR > 0 ) { Nord += ( $9 > 0 ) } { Sud += ( $9 < 0 ) } { Est += ( $10 > 0 ) } { Oest += ( $10 < 0 ) } { Noubic += ( $9 == 0  )&&( $10 == 0 ) } { NoWDld += ( $11=="" ) } } END { print "Nord " Nord " Sud " Sud " Est " Est " Oest " Oest " No ubic " Noubic " No WDld " NoWDld }' cities.csv
                ;;
		       
	esac
done
