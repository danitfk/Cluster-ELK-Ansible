#!/bin/bash
# Author: Daniel Gordi (danitfk)
# Date: 3/Dec/2019

if [ "$1" == "" ]
then
	echo "No input"
	exit 1
else
	# Detect Elastic servers
	es_instances=$(echo $1 | sed 's/\["//g' | sed 's/\"//g' | sed 's/\]//g' | sed 's/,/ /g')
fi

for es_instance in $es_instances
do


	

done
