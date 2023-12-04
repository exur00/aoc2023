#!/bin/bash
totalCards=202
declare -A amounts
for i in $(seq $totalCards ); do
	#echo $i
	amounts["$i"]=1
done

while read line; do
	
	cardNr=$(echo "$line" | sed -r 's/^([^.]+).*$/\1/; s/^[^0-9]*([0-9]+).*$/\1/' ) # awk -F'[^0-9]+' '{ print $2 }')
	#echo "zoek: $cardNr"
	#card=$(grep "Card $cardNr" example | cut -d ":" -f 2)
	card=$(echo "$line" | cut -d ":" -f 2)
	#echo "$card"
	
	winning=$(echo "$card" | cut -d "|" -f 1)
	numbers=$(echo "$card" | cut -d "|" -f 2)
	#echo "$winning\n$numbers\n\n"
	winning=$(echo "$winning" | tr " " "\n")
	echo "$winning" > tmp.txt
	#echo "$winning\n$numbers\n\n"
	overlap=$(echo "$numbers" | grep -o -w -f tmp.txt) #-o only matching part, -w whole word, -f for wordlist
	#echo "$overlap"
	overlap=$(echo "$overlap" | tr " " "\n")
	amt=$(echo "$overlap" | wc --words)
	#echo "er zijn $amt"
	for i in $(seq $(($cardNr + 1)) $(($cardNr + $amt))); do
		if (( "$i" <= "$totalCards" )); then
			#echo "$i ${amounts[$i]}"
			amounts["$i"]=$(( "${amounts[$i]}" + ${amounts[$cardNr]} )) 
		fi
	done
done

amtCards=0
for card in "${!amounts[@]}"; do
	amtCards=$(( $amtCards + ${amounts[$card]} ))
done
echo $amtCards
