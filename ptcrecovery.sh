#!/bin/bash

source config.ini
source $StatsPath/config.ini

startListen(){
while :
do
#netcat -l 8888  < response.txt | grep data | cut -d= -f2
result=$(netcat -l $port  < response.txt | grep data | cut -d= -f2)
# echo $result
done
}

checkPTC(){
while :
do
result=$(curl -s -k https://sso.pokemon.com/sso/login -o /dev/null -w '%{http_code}')
sleep $ptcCheckInterval
done
}

pausePTC(){
cd $StatsPath/scripts  && ./pause_noproto_ptc_devices.sh
}

unpausePTC(){
cd $StatsPath/scripts  && ./unpause_batch_ptc_devices_exit.sh
}

# check if server is local and get sso status
if "serverLocal"
then
  checkPTC
else
  startListen
fi

# start endless loop to check PTC login page every $checkinterval
while :
do
# getstatus
if (( $result != 200 ))
then
  echo "PTC login did not respond, status code $result"
  echo "sleeping $checkinterval, main loop"
  sleep 1m

# start seconday loop, until PTC login can be reached again
  while :
  do
#  getstatus
  if (( $result == 200 ))
  then
    echo "PTC login responded again"
    echo "sleeping $checkinterval, failure loop"
    sleep 1m

#     start third loop, we keep checking for code 200 and start unpausing devices
      while :
      do
#      getstatus
      if (( $result == 200 && $ptcpause != 0 ))
      then
      echo "Unpausing batch of devices according to Stats settings"
      unpausePTC
      sleep $batch_wait_ptc
      else
      break
      fi
      done

    break
  else
    echo $result
    echo "Pausing PTC device not idle and no proto received according to Stats settings"
    pausePTC
    echo "sleeping $checkinterval, continue login failure loop"
    sleep 1m
  fi
  done
else
  echo $result
  echo "sleeping $checkinterval, main loop"
  sleep 1m
fi
done
