# slightly malformed input data
input_start=2023-03-30
input_end=2023-06-1
#input_end=2023-3-22

# After this, startdate and enddate will be valid ISO 8601 dates,
# or the script will have aborted when it encountered unparseable data
# such as input_end=abcd
startdate=$(date -I -d "$input_start") || exit -1
enddate=$(date -I -d "$input_end")     || exit -1

d="$startdate"
zone="1"
while [ "$d" != "$enddate" ]; do 
  echo $d

  jq '.weather.condition.dataIntervals[] | [.from, .to, .value.temperature.celsius] | @csv' data/zone$zone/$d.json >> parsed/zone$zone-weather.csv
  jq '.callForHeat.dataIntervals[] | [.from, .to, .value] | @csv' data/zone$zone/$d.json >> parsed/zone$zone-heat.csv
  jq '.measuredData.insideTemperature.dataPoints[] | [.timestamp, .value.celsius] | @csv' data/zone$zone/$d.json >> parsed/zone$zone-inside.csv

  d=$(date -I -d "$d + 1 day")

  #sleep 10
    
done

d="$startdate"
zone="2"
while [ "$d" != "$enddate" ]; do 
  echo $d

  jq '.weather.condition.dataIntervals[] | [.from, .to, .value.temperature.celsius] | @csv' data/zone$zone/$d.json >> parsed/zone$zone-weather.csv
  jq '.callForHeat.dataIntervals[] | [.from, .to, .value] | @csv' data/zone$zone/$d.json >> parsed/zone$zone-heat.csv
  jq '.measuredData.insideTemperature.dataPoints[] | [.timestamp, .value.celsius] | @csv' data/zone$zone/$d.json >> parsed/zone$zone-inside.csv

  d=$(date -I -d "$d + 1 day")

  #sleep 10
    
done
