#!/bin/bash -u

#NETWORK_ENV_FILE='./network/.env'
TIMESTAMP=$(date +%s)

RESULTS_DIR=./results/"$TIMESTAMP"

mkdir -p "$RESULTS_DIR"

#for NODES_NUMBER in 7 12 17 22; do
  #sed -i 's/NODES_NUMBER=.*/NODES_NUMBER='$NODES_NUMBER'/' $NETWORK_ENV_FILE
  #for CONSENSUS_ALGO in raft clique ibft qbft; do
    #sed -i 's/GOQUORUM_CONS_ALGO=.*/GOQUORUM_CONS_ALGO='$CONSENSUS_ALGO'/' $NETWORK_ENV_FILE
    #for TYPE in public private; do
for TPS in 50 100 200 300; do
        #cd ./network || exit 1
        #./run.sh
        #cd ..
        #sleep 90 # wait for network to init
        sed -i 's/tps:.*/tps: '$TPS'/' ./caliper/benchmarks/scenario/bank-private/config.yaml
        echo "Executing benchmark with 17 nodes, QBFT, $TPS, Private"

        cd ./caliper || exit 1
        #if [[ "$TYPE" = "public" ]]; then
          #npm run launch-bank-public
        #else
          npm run launch-bank-private-17-nodes
        #fi

        cd ..
        sleep 5
        cp ./caliper/report.html "$RESULTS_DIR"/report-QBFT-17-private-$TPS.html
        #cd ./network || exit 1
        cd ..
        echo "Benchmark ran successfully"
done
    #done
  #done
#done
