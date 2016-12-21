#!/bin/bash

service elasticsearch stop
service kibana stop

/usr/share/elasticsearch/bin/elasticsearch-plugin install x-pack
service elasticsearch start

/opt/kibana/bin/kibana-plugin install x-pack
service kibana start
