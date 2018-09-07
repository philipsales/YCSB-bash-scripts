#!/bin/bash

#import
. settings/config.cfg

DB=$DEFAULT_DB || DB=$1
TOTAL_RUN=$TOTAL_RUN || TOTAL_RUN=$2

. $DB/truncate.sh
. $DB/load.sh
. $DB/run.sh

OUTPUT_DIR="$RESULTS_DIR/$DB"
mkdir -p $OUTPUT_DIR

for dat_file in ${DAT_FILES[*]}
do
    DAT_FILE=$dat_file

    counter=1
    until [ $counter -gt $TOTAL_RUN ]
    do
        cleartable
        wait
        loaddata "$DB" "workloada" "$OUTPUT_DIR" "$counter" "$DAT_FILE"
        wait
        
        for workload in ${WORKLOADS[*]}
        do
            WORKLOAD=$workload 
            WORKLOAD_DIR="$OUTPUT_DIR/$WORKLOAD"
            mkdir -p $WORKLOAD_DIR

            runtask  "$DB" "$WORKLOAD" "$WORKLOAD_DIR" "$counter" "$DAT_FILE"
            wait
        done
        ((counter++))
        echo $counter
    done
done

cd $SCRIPT_DIR
