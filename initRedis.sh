#!/bin/bash

#import
. config.cfg

DB=$REDIS_DB
HOSTS=$REDIS_HOSTS
PORT=$REDIS_PORT
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
    loaddata "$DB" "$WORKLOAD" "$OUTPUT_DIR" "$counter" "$HOSTS" "$PORT"
    wait
    runtask  "$DB" "$WORKLOAD" "$OUTPUT_DIR" "$counter" "$HOSTS" "$PORT"
    wait
    ((counter++))
    echo $counter
done

cd $SCRIPT_DIR
