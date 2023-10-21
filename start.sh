#!/bin/bash

echo "started"

docmd() {
    read -p "root@MyVPS:~ " CMD
    eval "$CMD"
    echo "root@MyVPS:~ "
    docmd2
}

docmd2() {
    read -p "root@MyVPS:~ " CMD2
    eval "$CMD2"
    echo "root@MyVPS:~ "
    docmd
}

docmd
