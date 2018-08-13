#!/bin/bash

function cleartable() {
    echo "use ycsb; TRUNCATE ycsb.usertable; exit" | cqlsh
}
