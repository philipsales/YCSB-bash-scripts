#!/bin/bash

#import
. settings/config.cfg

DB=$COUCHBASE_DB
HOSTS=$COUCHBASE_HOSTS
BUCKET=$COUCHBASE_BUCKET
USERNAME=$COUCHBASE_USERNAME
PASSWORD=$COUCHBASE_PASSWORD

TOTAL_RUN=$TOTAL_RUN

. $DB/truncate.sh
. $DB/load.sh
. $DB/run.sh

WORKLOAD="workloadf"
OUTPUT_DIR="$OUTPUT_DIR/$DB/$WORKLOAD"

mkdir -p $OUTPUT_DIR
cd $YCSB_BIN

counter=1
until [ $counter -gt $TOTAL_RUN ]
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
