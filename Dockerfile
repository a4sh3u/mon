FROM sebp/elk:es500_l500_k500

ENV ES_HOME /opt/elasticsearch
WORKDIR ${ES_HOME}
RUN pwd
RUN gosu elasticsearch /opt/elasticsearch/bin/elasticsearch-plugin install x-pack

WORKDIR ${KIBANA_HOME}
RUN pwd
RUN gosu kibana bin/kibana-plugin install x-pack
