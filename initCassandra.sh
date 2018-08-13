#!/bin/bash

#import
. config.cfg

DB=$CASSANDRA_DB
HOSTS=$CASSANDRA_HOSTS
TOTAL_TASK=$TOTAL_TASK

. $DB/truncate.sh
. $DB/load.sh
. $DB/run.sh

WORKLOAD="workloada"
OUTPUT_DIR="$OUTPUT_DIR/$DB/$WORKLOAD"

mkdir -p $OUTPUT_DIR
cd $YCSB_BIN

counter=1
until [ $counter -gt $TOTAL_TASK ]
do
    cleartable
    wait
    loaddata "$DB" "$WORKLOAD" "$OUTPUT_DIR" "$counter" "$HOSTS"
    wait
    runtask  "$DB" "$WORKLOAD" "$OUTPUT_DIR" "$counter" "$HOSTS"
    wait
    ((counter++))
    echo $counter
done

cd $SCRIPT_DIR
