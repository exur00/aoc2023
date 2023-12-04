cat input | sed 's/one/1/g; s/two/2/g; s/three/3/g; s/four/4/g; s/five/5/g; s/six/6/g; s/seven/7/g; s/eight/8/g; s/nine/9/g' | tr -cd '[:digit:]\n' | awk -v OFS= '{print substr($0,0,1),substr($0,length,1)}' | awk '{s+=$1} END {print s}'
# work in progress
# TODO: oneight should be replaced by 1 if in beginnen, or eight in the end?


manually calculated overlaps and solved them first:
cat input | sed 's/oneight/18/g; s/twone/21/g; s/threeight/38/g; s/fivecat input | sed 's/oneight/18/g; s/twone/21/g; s/threeight/38/g; s/fiveight/58/g; s/eightwo/82/g; s/eighthree/83/g; s/nineight/98/g' | sed 's/one/1/g; s/two/2/g; s/three/3/g; s/four/4/g; s/five/5/g; s/six/6/g; s/seven/7/g; s/eight/8/g; s/nine/9/g' | tr -cd '[:digit:]\n' | awk -v OFS= '{print substr($0,0,1),substr($0,length,1)}' | awk '{s+=$1} END {print s}'
