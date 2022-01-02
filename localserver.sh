#!/bin/bash

source config.ini

getstatus(){
result=$(curl -s -k https://sso.pokemon.com/sso/login -o /dev/null -w '%{http_code}')
}

while :
do
getstatus
curl -X POST -d "data=$result" http://$ip_madserver:$port
sleep $ptcCheckInterval
done
