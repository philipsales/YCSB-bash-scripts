#!/bin/bash

function runtask() {
    FILE_NAME="run"
    FILE_TYPE="txt"

    DB=$1
    WORKLOAD=$2
    OUTPUT_DIR=$3
    COUNTER=$4
    HOSTS=$5

    ./bin/ycsb run $DB -P workloads/$WORKLOAD -p redis.host=$HOSTS -p redis.port=$PORT -s > $OUTPUT_DIR/$FILE_NAME.$COUNTER.$FILE_TYPE
}