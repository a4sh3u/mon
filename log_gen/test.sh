#!/bin/bash

for files in $(find /tmp/int -type f -name "*application.log")
do
  echo "${files}"
  file_name=$(basename ${files})
  application=${file_name%.*}
  if [ -f /tmp/perma_num_${file_name} ]
  then
    echo "/tmp/perma_num_${file_name}"
    grep -P "(WARN|ERROR|^\tat |Exception|^Caused by: |\t... \d)" ${files} >/tmp/raw_${file_name}
    if [ -f /tmp/raw_${file_name} ]
    then
      egrep -n "\[[0-9]{4}-[0-9]{2}-[0-9]{2} [0-9]{2}:[0-9]{2}:[0-9]{2},[0-9]{3}\]" /tmp/raw_${file_name}| awk -F ":" '{print $1}' >/tmp/num_${file_name}
      last=$(cat /tmp/num_${file_name} | wc -l)
      last=$(expr $last - 1)
      echo "$last"
      for i in $(seq 1 $last)
      do
        let j=$i+1
        k=`awk 'NR == n' n=$i /tmp/num_${file_name}`
        l=`awk 'NR == n' n=$j /tmp/num_${file_name}`
        let l=$l-1
        if ! grep -q "$k:$l" /tmp/perma_num_${file_name}
          then
            log_level=WARN
            echo "$(hostname) - sends you a big freaking gift for application: ${application}"
            echo "$(hostname) - sends you a big freaking gift for application: ${application}" >>/tmp/error.log
            msg=$(sed -n "${k},${l}p" /tmp/raw_${file_name})
            echo "$msg"| grep -q ERROR
            if [ $? -eq 0 ]
            then
              log_level=ERROR
            fi
            echo "$msg" >>/tmp/error.log
            echo -e "{\"hostname\":\""$(hostname)"\", \"application\":\""$application"\", \"log_level\":\""$log_level"\", \"msg\":\""$msg"\"}" >>/tmp/error.json
            echo "$k:$l" >> /tmp/perma_num_${file_name}
            echo "you sure are a big shot looking till the end of the error log"
            echo "you sure are a big shot looking till the end of the error log" >>/tmp/error.log
        fi
      done
    fi
  fi
  echo "################################################################################################"
done
rm /tmp/raw*
rm /tmp/num*
