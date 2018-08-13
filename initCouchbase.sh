#!/bin/bash

#import
. config.cfg

DB=$COUCHBASE_DB
HOSTS=$COUCHBASE_HOSTS
BUCKET=$COUCHBASE_BUCKET
USERNAME=$COUCHBASE_USERNAME
PASSWORD=$COUCHBASE_PASSWORD

TOTAL_TASK=$TOTAL_TASK

. $DB/truncate.sh
. $DB/load.sh
. $DB/run.sh

WORKLOAD="workloadb"
OUTPUT_DIR="$OUTPUT_DIR/$DB/$WORKLOAD"

mkdir -p $OUTPUT_DIR
cd $YCSB_BIN

counter=1
until [ $counter -gt $TOTAL_TASK ]
do
    cleartable "$DB" "$WORKLOAD" "$OUTPUT_DIR" "$counter" "$HOSTS" "$PORT" "$BUCKET" "$USERNAME" "$PASSWORD"
    wait
    loaddata "$DB" "$WORKLOAD" "$OUTPUT_DIR" "$counter" "$HOSTS" "$PORT" "$BUCKET" "$USERNAME" "$PASSWORD"
    wait
    runtask "$DB" "$WORKLOAD" "$OUTPUT_DIR" "$counter" "$HOSTS" "$PORT" "$BUCKET" "$USERNAME" "$PASSWORD"
    wait
    ((counter++))
    echo $counter
done

cd $SCRIPT_DIR
