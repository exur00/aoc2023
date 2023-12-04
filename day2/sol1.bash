#!/bin/bash

maxRed=12
maxGreen=13
maxBlue=14

while read line; do
	#echo "$line"
	#game=$(echo "$line" | awk -F'[: ]' -v OFS= '{printf "%s\n",$2"}')
	#echo "$game"
	#hints=($(echo "$line" | awk -F',' '{print $2\n}'))
	#echo "$hints"
	#echo $line | awk -F'[,;: ]' '{out=$2";"; for(i=4;i<=NF;i+=2){out=out"."$i","$(i+1)}; print out}'
	#parsed=($(echo $line | awk -F'[,;: ]' '{out=$2; for(i=4;i<=NF;i+=2){out=out"\n"$i","$(i+1)}; print out}'))
	game=$(echo $line | cut -d ":" -f 1 | tr -cd '[:digit:]\n')	# correct
	info=$(echo $line | cut -d ":" -f 2)
	#echo "$game\n$info\n\n"
	parsed=($(echo $info | awk -F'[,;]* ' '{out=""; for(i=1;i<=NF;i+=2){out=out"\n"$i","$(i+1)}; print out}'))
	tooMany=false
	for i in "${parsed[@]}"; do
		#echo "$i"
		number=$(echo $i | cut -d "," -f 1)
		color=$(echo $i | cut -d "," -f 2)
		#echo "$number $color"
		if [ "$color" = "red" ]; then
			#echo "$color"
			#tooMany= [ $tooMany -o $(( $number > $maxRed )) ]
			#tooMany= $( (echo $tooMany) || $number > $maxRed )
			if (( $number > $maxRed )); then
				tooMany=true
			fi
		fi
		if [ "$color" = "green" ]; then
			#echo "$color"
			#tooMany= [ $tooMany -o $(( $number > $maxRed )) ]
			if (( $number > $maxGreen )); then
				tooMany=true
			fi
		fi
		if [ "$color" = "blue" ]; then
			#echo "$color"
			#tooMany= [ $tooMany -o $(( $number > $maxRed )) ]
			if (( $number > $maxBlue )); then
				tooMany=true
			fi
		fi
	done
	#echo "$tooMany"
	if ! $tooMany; then
		echo "$game"
	fi
	
done < ./input

# run bash sol1.bash | awk '{s+=$1} END {print s}'


# awk '{out=$2; for(i=3;i<=NF;i++){out=out" "$i}; print out}'
# line="Game 83: 3 green, 3 red, 1 blue; 3 blue, 4 green, 3 red; 3 blue, 4 green, 1 red; 2 red, 8 green, 2 blue"
