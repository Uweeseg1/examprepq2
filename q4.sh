#! /bin/bash

for f in $(ls temperature/); 
do 
	minyear=$(cat temperature/$f  | ./xsv stats | awk -F ',' '{print $4}' | head -2 | tail -1)
	maxyear=$(cat temperature/$f  | ./xsv stats | awk -F ',' '{print $5}' | head -2 | tail -1) 
	echo minyear for file $f is $minyear and max is $maxyear
	mkdir temperannual
	echo year, average_temp > temperannual/"$f"annual_avg.csv
	for year in $(seq $minyear $maxyear); do
		annav=$(cat temperature/$f | grep -E ^$year, | ./xsv stats | awk -F ',' '{print $8}' | tail -1)
		echo $year, $annav, for file $f
		echo $year, $annav >> temperannual/"$f"annual_avg.csv

	done
done

#b
echo the hottest year was: 
cat temperannual/israel.csvannual_avg.csv | ./xsv stats | ./xsv select 'max' | tail -2
echo the coldest year in isr was
cat temperannual/israel.csvannual_avg.csv | ./xsv stats | ./xsv select 'min' | tail -2


#c
echo the hottest 8 years in isr is:
cat temperannual/israel.csvannual_avg.csv | ./xsv sort -s 2 | tail -8


#d
cat temperature/israel.csv | awk -F ',' '{if ($3 <= 9 || $3 >= 29) {print $0}}' | sed -En 's/^([0-9]{4}),([0-9]{2}).*/\1-\2/p'
