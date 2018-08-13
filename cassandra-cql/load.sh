#!/bin/bash

function loaddata() {
    FILE_NAME="load"
    FILE_TYPE="txt"

    DB=$1
    WORKLOAD=$2
    OUTPUT_DIR=$3
    COUNTER=$4
    HOSTS=$5

    ./bin/ycsb load $DB -P workloads/$WORKLOAD -p hosts=$HOSTS -s > $OUTPUT_DIR/$FILE_NAME.$COUNTER.$FILE_TYPE
}
