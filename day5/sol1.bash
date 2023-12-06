#!/bin/bash

cat "$1" | awk -v RS= '{print > ("subfile-" NR)}'

#seeds=$(cat subfile-1.txt | cut -d " " -f2- )
#seeds=( $seeds )
seeds=( $(cat subfile-1 | cut -d " " -f2- ) )
#for i in "${seeds[@]}"; do echo $i; done

#for (( i=2; -f "subfile-$i" ; i++ )); do
#	echo "subfile-$i exists"
for (( i=2; i < 9 ; i++ )); do
	for (( seedNr=0; seedNr < "${#seeds[@]}" ; seedNr++ )); do
		#echo "boe $seedNr"
		while read line; do
			if [[ $(echo $line | grep -o ":") = "" ]]; then
				#echo $line
				#echo ""
				numbers=( $line )
				#echo "seed:  ${seeds[$seedNr]} "
				if (( ${numbers[1]} <= ${seeds[$seedNr]} && ${seeds[$seedNr]} <= (${numbers[1]} + ${numbers[2]}) )); then
					seeds[$seedNr]=$((${seeds[$seedNr]} - ${numbers[1]} + ${numbers[0]}))
					break
				fi
			fi
		done < "subfile-$i"
	done
done

for i in "${seeds[@]}"; do echo $i; done
#sum=$(IFS=+; echo "$((${seeds[*]}))")
#echo "$sum"

#run : ./sol1.bash example | datamash min 1
