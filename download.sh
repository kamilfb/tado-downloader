input_start=2023-4-30
input_end=2023-6-1

# After this, startdate and enddate will be valid ISO 8601 dates,
# or the script will have aborted when it encountered unparseable data
# such as input_end=abcd
startdate=$(date -I -d "$input_start") || exit -1
enddate=$(date -I -d "$input_end")     || exit -1

home="12345"
token="ey..."

d="$enddate"
zone="1"
while [ "$d" != "$startdate" ]; do 
  echo $d

  curl -s 'https://my.tado.com/api/v2/homes/'$home'/zones/'$zone'/dayReport?date='$d -H 'authorization: Bearer '$token \
  --compressed -o data/zone$zone/$d.json  
  
  d=$(date -I -d "$d - 1 day")
    
done

d="$enddate"
zone="2"
while [ "$d" != "$startdate" ]; do 
  echo $d

  curl -s 'https://my.tado.com/api/v2/homes/'$home'/zones/'$zone'/dayReport?date='$d -H 'authorization: Bearer '$token \
  --compressed -o data/zone$zone/$d.json  
  
  d=$(date -I -d "$d - 1 day")
    
done
