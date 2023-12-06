#!/bin/bash

OLDIFS=$IFS
IFS=' '

cat "$1" | awk -v RS= '{print > ("subfile-" NR)}'

#seeds=$(cat subfile-1.txt | cut -d " " -f2- )
#seeds=( $seeds )
seedIndices=( $(cat subfile-1 | cut -d " " -f2- ) )
IFS=','
#for i in "${seedIndices[@]}"; do echo $i; done
declare -a beginSeeds=()
declare -a endSeeds=()
for (( i=0; i < ${#seedIndices[@]} ; i++ )); do
	begin="${seedIndices[$i]}"
	i=$(($i + 1))
	end=$(( $begin + ${seedIndices[$i]} ))
	beginSeeds+=("$begin,$end")
done
#for i in "${beginSeeds[@]}"; do echo $i; done

#for (( i=2; -f "subfile-$i" ; i++ )); do
#	echo "subfile-$i exists"

for (( i=2; i < 9 ; i++ )); do
	#for (( seedNr=0; seedNr < "${#seeds[@]}" ; seedNr++ )); do]
	echo "file$i"
	for (( r=0 ; r < ${#beginSeeds[@]} ; r++ )) ; do
		#echo "set: ${beginSeeds[$r]}"
		set ${beginSeeds[$r]}
		changed=false
		#for aaa in "${beginSeeds[@]}"; do echo $aaa; done
		#echo "boe $seedNr"
		while read line; do
			if [[ $(echo $line | grep -o ":") = "" ]]; then
				#echo $line
				#echo ""
				IFS=' '
				#echo "    $line"
				numbers=( $line )
				#echo "    ${numbers[0]} ${numbers[1]} ${numbers[2]}"
				IFS=','
				#echo "$numbers"
				#echo "$1 $2"
				#echo "seed:  ${seeds[$seedNr]} "
				
				numbers[2]=$(( ${numbers[1]} + ${numbers[2]} ))
				if (( ${numbers[1]} > $1 )); then #minimum links van range
					#echo "${numbers[1]} > $1"
					if (( ${numbers[2]} < $2 )); then #max rechts van range
						#echo "${numbers[2]} < $2"
						#echo case1
						newEnd=$(( ${numbers[2]} - ${numbers[1]} + ${numbers[0]} ))
						newBegin=$(( ${numbers[1]} - ${numbers[1]} + ${numbers[0]} ))
						endSeeds+=( "$newBegin,$newEnd" )
						remEnd=$(( ${numbers[1]} - 1 ))
						beginSeeds+=( "$1,$remEnd" )
						remBegin=$(( ${numbers[2]} + 1 ))
						beginSeeds+=( "$remBegin,$2" )
						changed=true
					elif (( ${numbers[1]} <= $2 )); then # max in range
						#echo case2
						newEnd=$(( $2 - ${numbers[1]} + ${numbers[0]} ))
						newBegin=$(( ${numbers[1]} - ${numbers[1]} + ${numbers[0]} ))
						endSeeds+=( "$newBegin,$newEnd" )
						remEnd=$(( ${numbers[1]} - 1 ))
						beginSeeds+=( "$1,$remEnd" )
						changed=true
					fi # if max links van range: doe niks
				elif (( ${numbers[2]} >= $1 )); then # minimum in range
					if (( ${numbers[2]} < $2 )); then #max rechts van range
						#echo case3
						newBegin=$(( $1 - ${numbers[1]} + ${numbers[0]} ))
						newEnd=$(( ${numbers[2]} - ${numbers[1]} + ${numbers[0]} ))
						endSeeds+=( "$newBegin,$newEnd" )
						remBegin=$(( ${numbers[2]} + 1 ))
						beginSeeds+=( "$remBegin,$2" )
						changed=true
					elif (( ${numbers[1]} <= $2 )); then # max in range
						#echo case4
						newBegin=$(( $1 - ${numbers[1]} + ${numbers[0]} ))
						newEnd=$(( $2 - ${numbers[1]} + ${numbers[0]} ))
						endSeeds+=( "$newBegin,$newEnd" )
						changed=true
					fi # max kan niet links van range liggen, dan is het kleiner dan min
				fi # if min rechts van range: doe niks
				
			fi
		done < "subfile-$i"
		if ! $changed; then
			#echo unchanged
			endSeeds+=($1,$2) #put unchanged in end if nothing changed. if partially changed: copy of unchanged has been appended to the input and will be treated later on
		fi
	done
	#echo "beginSeeds: $beginSeeds" 
	beginSeeds="$endSeeds"
	endSeeds=()
done

IFS=','
for i in "${beginSeeds[@]}"; do
	set $i
	echo $1
done
#sum=$(IFS=+; echo "$((${seeds[*]}))")
#echo "$sum"

#run : ./sol1.bash example | datamash min 1

IFS=$OLDIFS
