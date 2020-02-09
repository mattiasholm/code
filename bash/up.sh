#!/bin/bash

function up() {
    cd $(eval printf '../'%.0s {1..$1})
}
