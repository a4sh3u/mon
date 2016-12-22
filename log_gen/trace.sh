#!/bin/bash

for files in $(find /var/log/ubi -type f -name "*application.log")
do
  if [ -f /tmp/perma_num_${files} ]
  then
    grep -P "(WARN|ERROR|^\tat |Exception|^Caused by: |\t... \d)" $file >/tmp/raw_${files}
    egrep -n "\[[0-9]{4}-[0-9]{2}-[0-9]{2} [0-9]{2}:[0-9]{2}:[0-9]{2},[0-9]{3}\]" /tmp/raw.${files}| awk -F ":" '{print $1}' >/tmp/num_${files}
    last=$(cat /tmp/num_${files} | wc -l)
    last=$(expr $last - 1)

    for i in $(seq 1 $last)
    do let j=$i+1
      k=`awk 'NR == n' n=$i /tmp/num_${files}`
      l=`awk 'NR == n' n=$j /tmp/num_${files}`
      let l=$l-1
      if [ `grep -q "$k:$l" /tmp/perma_num_${files}` -ne 0 ]
        then
          sed -n "${k},${l}p" /tmp/raw_${files} >>/var/log/ubi/err/error.log
          echo "$k:$l" >> /tmp/perma_num_${files}
      fi
    done
  fi
done
