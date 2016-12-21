FROM sebp/elk:es500_l500_k500

ENV ES_HOME /opt/elasticsearch
WORKDIR ${ES_HOME}
RUN gosu elasticsearch bin/elasticsearch-plugin install x-pack

WORKDIR ${KIBANA_HOME}
RUN gosu kibana bin/kibana-plugin install x-pack
