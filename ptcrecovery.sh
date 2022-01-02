#!/bin/bash

source config.ini
source $StatsPath/config.ini

getstatus(){
if "$serverLocal"
then
  sleep $ptcCheckInterval
  result=$(curl -s -k https://sso.pokemon.com/sso/login -o /dev/null -w '%{http_code}')
else
  result=$(netcat -l $port  < response.txt | grep data | cut -d= -f2)
fi
}

ptcpause(){
ptcpausecount=$(mysql -u$SQL_user -p$SQL_password -h$DB_IP -P$DB_PORT $MAD_DB -NB -e "select count(a.device_id) from settings_device a, madmin_instance b, trs_status c where a.logintype = 'ptc' and a.device_id = c.device_id and a.instance_id = b.instance_id and a.instance_id = c.instance_id and c.idle = 1;")
}

pausePTC(){
$StatsPath/scripts/pause_noproto_ptc_devices.sh
}

unpausePTC(){
$StatsPath/scripts/unpause_batch_ptc_devices_exit.sh
}

# start endless loop to check PTC login page every $checkinterval
while :
do
getstatus
if (( $result != 200 ))
then
  echo "PTC login did NOT respond, status code $result"

# start seconday loop, until PTC login can be reached again
  while :
  do
  getstatus
  if (( $result == 200 ))
  then
    echo "PTC login responded again"

#     start third loop, we keep checking for code 200 and start unpausing devices
      while :
      do
      getstatus
      ptcpause
      if (( $result == 200 && $ptcpausecount != 0 ))
      then
      echo "$ptcpausecount devices paused, unpausing in batches according to Stats settings"
      unpausePTC
      sleep $batch_wait_ptc
      else
      echo "no devices (left) to unpause, reverting to main loop"
      break
      fi
      done

    break
  else
    echo "Pausing PTC device not idle and no proto received according to Stats settings"
    pausePTC
    echo "PTC login did NOT respond, status $result, continue failure loop"
  fi
  done
else
#  echo $result
  echo "PTC login responded, status $result, continue main loop"
#  sleep 1m
fi
done
