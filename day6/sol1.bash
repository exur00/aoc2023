#!/bin/bash

awk '
{ 
    for (i=1; i<=NF; i++)  {
        a[NR,i] = $i
    }
}
NF>p { p = NF }
END {    
    for(j=1; j<=p; j++) {
        str=a[1,j]
        for(i=2; i<=NR; i++){
            str=str" "a[i,j];
        }
        print str
    }
}' $1 | grep -v [a-zA-Z] > input.transposed #grep to remove all lines containing non-numbers

while read line; do
	time=$(echo "$line" | awk '{print $1}')
	record=$(echo "$line" | awk '{print $2}')
	#echo $time
	#echo $record
	wins=0
	for press in $(seq $time); do
		if (( ( ( $time - $press) * $press ) > $record )); then
			(( wins += 1 ))
		fi
	done
	echo $wins
done < input.transposed

#run: ./sol1.bash input | awk '{s=s*$1} BEGIN {s=1} END {print s}'
