#!/bin/bash

function runtask() {
    FILE_NAME="run"
    FILE_TYPE="txt"

    DB=$1
    WORKLOAD=$2
    OUTPUT_DIR=$3
    COUNTER=$4
    HOSTS=$5
    PORT=$6
    BUCKET=$7
    USERNAME=$8
    PASSWORD=$9

    ./bin/ycsb run $DB -P workloads/$WORKLOAD  \
        -p hosts=$HOSTS -s > $OUTPUT_DIR/$FILE_NAME.$COUNTER.$FILE_TYPE
}
