#!/bin/bash

function loaddata() {
    FILE_NAME="load"
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

    ./bin/ycsb load $DB -P workloads/$WORKLOAD -p redis.host=$HOSTS -p redis.port=$PORT -s > $OUTPUT_DIR/$FILE_NAME.$COUNTER.$FILE_TYPE
}
