#!/bin/bash

function cleartable() {
    mongo ycsb --eval "db.usertable.remove({})"
}
