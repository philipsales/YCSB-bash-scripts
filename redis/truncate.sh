#!/bin/bash

function cleartable() {
    redis-cli -n 0 FLUSHDB
}
