#!/bin/bash

# Define colors
GREEN=$(echo -en '\033[00;32m')
RED=$(echo -en '\033[00;31m')
BLUE=$(echo -en '\033[00;34m')
RESTORE=$(echo -en '\033[0m')

# help
function help {
echo ${RED}"ERROR!!"
sleep 0.5
echo ${GREEN}"eg: ./deployer.sh -g [VALUE] -u [VALUE] -p [VALUE] -d [VALUE] -s [BOOLEAN]"
echo ${BLUE}"USAGE: ./deployer.sh [SWITCH] [OPTION]"${RESTORE}
echo "SWITCHES:"
echo "       -g | --git -> git URL"
echo "       -u | --user -> Web site user"
echo "       -p | --password -> MySQL Root Password"
echo "       -d | --domain -> Websites domain without www"
echo
}
# Read variables from input
while [[ "$#" > 0 ]]; do case $1 in
  -E|--elastic) ELASTIC_INSTANCES="$2"; shift;;
  -K|--kibana) KIBANA_INSTANCES="$2"; shift;;
  -L|--logstash) LOGSTASH_INSTACES="$2"; shift;;
  -U|--username) KIBANA_USERNAME="$2"; shift;;
  -s|--ssl) SSL="$2"; shift;;
  *) echo "Unkown Parameter: $1"; exit 1;;
esac; shift; done

# check sudo access
if [ "$(whoami)" != "root" ]; then
then
	echo "Check sudo access =>" ${RED} "NOT OK!" ${RESTORE}
else
        echo "Check sudo access =>" ${GREEN} "OK!" ${RESTORE}

fi

# Exit on no input
if [[ "$1" == "" ]];
then
        help
        exit 1
fi

