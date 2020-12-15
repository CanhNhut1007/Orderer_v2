FROM hyperledger/fabric-orderer:2.0

LABEL  maintainer="Thach Canh Nhut"

#2. Create the folder for configurations
RUN rm -r /etc/hyperledger/fabric

RUN mkdir -p /var/hyperledger/OrdererOrg

ENV FABRIC_CFG_PATH=/var/hyperledger/OrdererOrg

ENV ORDERER_HOME=/var/hyperledger/OrdererOrg

#3. Copy the crypto for orderer
COPY ./config-org/Orderer/orderer1 /var/hyperledger/OrdererOrg

RUN chmod 755 /var/hyperledger/OrdererOrg/msp/config.yaml

ENV ORDERER_GENERAL_LOCALMSPDIR=/var/hyperledger/OrdererOrg/msp

ENV ORDERER_GENERAL_CLUSTER_ROOTCAS=/var/hyperledger/OrdererOrg/tls-msp/tlscacerts/tls-10-102-10-236-7052.pem

ENV ORDERER_GENERAL_TLS_ENABLED=true

ENV CORE_VM_DOCKER_ATTACHSTDOUT=true

ENV CORE_LOGGING_GRPC=DEBUG

#4. Copy the genesis file
COPY genesis.block  /var/hyperledger/OrdererOrg

#5. Copy the orderer YAML
COPY ./config-org/Orderer/orderer1/orderer.yaml /var/hyperledger/OrdererOrg 

CMD ["orderer"]
