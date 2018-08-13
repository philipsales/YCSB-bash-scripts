#!/bin/bash

function cleartable() {
    DB=$1
    WORKLOAD=$2
    OUTPUT_DIR=$3
    COUNTER=$4
    HOSTS=$5
    PORT=$6
    BUCKET=$7
    USERNAME=$8
    PASSWORD=$9

    COUCHBASE_APP="Couchbase\ Server.app"
    CLI_DIR="/Applications/$COUCHBASE_APP/Contents/Resources/couchbase-core/bin/"

    echo "Y" | eval $CLI_DIR/couchbase-cli bucket-flush \
        -c 127.0.0.1:8091 \
        --bucket=$BUCKET \
        -u $USERNAME \
        -p $PASSWORD \
        --enable-flush=1 
}
