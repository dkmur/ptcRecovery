#!/bin/bash

source config.ini
source $StatsPath/config.ini

while :
do
#netcat -l 8888  < response.txt | grep data | cut -d= -f2
PTClogin=$(netcat -l $port  < response.txt | grep data | cut -d= -f2)
# echo $PTClogin
done
