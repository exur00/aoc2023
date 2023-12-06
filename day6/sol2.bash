#!/bin/bash


cat $1 | tr -cd '[[:digit:]]\n' > input.2.blobbed
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
}' input.2.blobbed > input.2.transposed #grep to remove all lines containing non-numbers

while read line; do
	time=$(echo "$line" | awk '{print $1}')
	record=$(echo "$line" | awk '{print $2}')
	#echo $time
	#echo $record
	
	#find a positive value
	curr=$(( $time / 2 ))
	min=0
	max=$time
	while (( ( ( $time - $curr) * $curr ) < $record )); do
		echo "checked $curr"
		leftNext=$(( ($curr + $min) /2 ))
		rightNext=$(( ($curr + $max) /2 ))
		if (( ( ( $time - $leftNext) * $leftNext ) < ( ( $time - $rightNext) * $rightNext ) )); then
			min=$curr
			curr=$rightNext
		else
			max=$curr
			curr=$leftNext
		fi
	done
	echo "found win at $curr"
	win=$curr
	
	#search first value for which we win
	min=0
	max=$win
	curr=$(( ($max - $min) /2 ))
	while ! (( ( ( ( $time - ( $curr - 1 )) * ( $curr - 1 ) ) <= $record ) && ( ( ( $time - $curr) * $curr ) > $record ) )); do
		if (( ( ( ( $time - $curr) * $curr ) > $record ) )); then
			max=$curr
			curr=$(( ($curr + $min) /2 ))
		else
			min=$curr
			curr=$(( ($curr + $max) /2 ))
		fi
	done
	echo "found minimum win value at $curr"
	minWin=$curr
	#search max value to win
	min=$win
	max=$time
	curr=$(( ($max - $min) /2 ))	
		while ! (( ( ( ( $time - ( $curr + 1 )) * ( $curr + 1 ) ) <= $record ) && ( ( ( $time - $curr) * $curr ) > $record ) )); do
		if (( ( ( ( $time - $curr) * $curr ) <= $record ) )); then
			max=$curr
			curr=$(( ($curr + $min) /2 ))
		else
			min=$curr
			curr=$(( ($curr + $max) /2 ))
		fi
	done
	echo "found max win value at $curr"
	maxWin=$curr

	echo $(( $maxWin - $minWin + 1 ))
done < input.2.transposed

#run: ./sol1.bash input | awk '{s=s*$1} BEGIN {s=1} END {print s}'
