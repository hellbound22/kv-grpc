#!/bin/bash

export RUST_LOG=info

./target/release/grpc-server &
binary1_pid=$!

sleep 1

./target/release/proxy-server &
binary2_pid=$!

stop_binaries() {
    echo "Stopping services..."
    kill $binary1_pid $binary2_pid
    echo "Services stopped."
}

trap stop_binaries SIGINT

wait
