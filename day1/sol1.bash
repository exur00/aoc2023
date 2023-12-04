cat input | tr -cd '[:digit:]\n' | awk -v OFS= '{print substr($0,0,1),substr($0,length,1)}' | awk '{s+=$1} END {print s}'
# awk -v OFS= removes collumn separation (OFS=x sets x as separation)
