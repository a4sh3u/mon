FROM sebp/elk:es500_l500_k500

ENV ES_HOME /usr/share/elasticsearch
WORKDIR ${ES_HOME}
RUN pwd
RUN gosu elasticsearch bin/elasticsearch-plugin install x-pack

WORKDIR ${KIBANA_HOME}
RUN pwd
RUN gosu kibana bin/kibana-plugin install x-pack
