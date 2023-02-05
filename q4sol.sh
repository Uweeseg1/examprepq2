#!/bin/bash
for country in temperature/*.csv ; do
	echo "year,yearly_temperature_average" >> "${country}"_years.csv
	years=$(./xsv select 1 "${country}" | grep -E "[[:digit:]]" |sort | uniq)
	for year in ${years}; do
		average=$(grep "${year}" "${country}" | ./xsv select 3 | ./xsv stats |./xsv select mean|tail -1)
	echo "${year},${average}" >‌> "${country}"_years.csv
	done
done
