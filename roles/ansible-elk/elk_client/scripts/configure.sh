#!/bin/bash
# Author: Daniel Gordi (danitfk)
# Date: 3/Dec/2019


es_instances=$(grep elasticsearch=true $INVENTORY_FILE | grep -o "ansible_host=.*" | awk {'print $1'} | cut -d"=" -f2)

for es_instance in $es_instances
do

# run the job

done
