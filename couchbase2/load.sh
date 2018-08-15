#!/bin/bash

#import
. settings/config.cfg

function loaddata() {
    COMMAND="load"

    DB=$1
    WORKLOAD=$2
    OUTPUT_DIR=$3
    COUNTER=$4
    DAT_FILE=$5
    THROUGHPUT=$(echo "$DAT_FILE" | cut -f 1 -d '.')
    FILE_EXT="txt"
    RESULT_FILE=$OUTPUT_DIR/$THROUGHPUT.$COMMAND-$COUNTER.$WORKLOAD.$FILE_EXT
    
    . settings/$DB.cfg
    cd $YCSB_BIN

    ./bin/ycsb $COMMAND $DB \
        -P workloads/$WORKLOAD  \
        -P $SETTINGS_DIR/$DAT_FILE \
        -s \
        -p $HOSTS \
        -p $PORT \
        > $RESULT_FILE
}
