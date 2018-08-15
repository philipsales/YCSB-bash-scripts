#!/bin/bash

#import
. settings/config.cfg

DB=$MONGO_DB
HOSTS=$MONGO_HOSTS
TOTAL_RUN=$TOTAL_RUN

. $DB/truncate.sh
. $DB/load.sh
. $DB/run.sh

#WORKLOAD="workloada"
#OUTPUT_DIR="$OUTPUT_DIR/$DB/$WORKLOAD"
#mkdir -p $OUTPUT_DIR

echo "WOrkload items:"


OUTPUT_DIR="$RESULTS_DIR/$DB"
mkdir -p $OUTPUT_DIR

#cd $YCSB_BIN
for item in ${DAT_FILES[*]}
do
    DAT_FILE=$item

    counter=1
    until [ $counter -gt $TOTAL_RUN ]
    do
        cleartable
        wait
        loaddata "$DB" "workloada" "$OUTPUT_DIR" "$counter" "$HOSTS" "$DAT_FILE"
        wait
        
        for item in ${WORKLOADS[*]}
        do
            WORKLOAD=$item
            WORKLOAD_DIR="$OUTPUT_DIR/$WORKLOAD"
            mkdir $WORKLOAD_DIR
            runtask  "$DB" "$WORKLOAD" "$WORKLOAD_DIR" "$counter" "$HOSTS" "$DAT_FILE"
            wait
        done
        ((counter++))
        echo $counter
    done
done

cd $SCRIPT_DIR
