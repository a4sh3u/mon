FROM sebp/elk:es500_l500_k500

# Add custom files
ADD ./conf.d /etc/logstash/conf.d
ADD ./patterns /etc/logstash/patterns
ADD ./jvm.options /etc/elasticsearch/jvm.options
ADD ./certs/elk_filebeats.crt /etc/pki/tls/certs/elk_filebeats.crt
ADD ./certs/elk_filebeats.key /etc/pki/tls/private/elk_filebeats.key
ADD ./kibana.yml /opt/kibana/config/kibana.yml
ADD ./elasticsearch.yml /etc/elasticsearch/elasticsearch.yml

ENV ES_HOME /usr/share/elasticsearch
WORKDIR ${ES_HOME}
RUN bin/elasticsearch-plugin install -Edefault.path.conf=/etc/elasticsearch x-pack

WORKDIR ${KIBANA_HOME}
RUN gosu kibana bin/kibana-plugin install x-pack
