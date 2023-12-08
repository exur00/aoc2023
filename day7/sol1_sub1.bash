#!/bin/bash

while read line; do

	cards=$(echo "$line" | awk '{print $1}')
	#echo "cards: $cards"
	sorted=$( echo "$cards" | sed 's/./&\n/g' | sort | uniq -ic | sort -r | sed \$d )  # head -n -1 werkt ook
	
	value=$(echo "$sorted" | awk 'BEGIN{ RS = "" ; FS = "\n" } {print $1}' | awk '{print $1}')
	
	tmp=$(echo "$sorted" | awk 'BEGIN{ RS = "" ; FS = "\n" } {print $2}' | awk '{print $1}')
	#echo "$tmp"
	if [ "$tmp" = "" ]; then
		value="${value}0"
	else
		value="$value$tmp"
	fi
	
	
	value="${value}$(echo $cards | sed 's/2/02/g;s/3/03/g;s/4/04/g;s/5/05/g;s/6/06/g;s/7/07/g;s/8/08/g;s/9/09/g;s/T/10/g;s/J/11/g;s/Q/12/g;s/K/13/g;s/A/14/g')"
	#echo "value: $value"
	
	tmp=$(echo "$line" | awk '{print $2}')
	echo "$value $tmp"

done < $1

#Neem elk getal, we maken het punt door:
#eerst score: # meest voorkomende # 2e meest voorkomende. 50 > 41 > 32 > 31 > 22 > 21 > 1
#dan appenden we daarna voor elke kaart in de hand
#01 02 03 ... 10 11 12 13 14 voor een
#1  2  3      T  J  Q  K  A
#dan zijn de grootste getallen de beste handen
