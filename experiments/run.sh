#!/bin/bash
pushd index-vs-storage
./run.sh
popd

pushd queries-short
./run.sh
popd

pushd queries-discover
./run.sh
popd

pushd queries-complex
./run.sh
popd

pushd fragmentation
./run.sh
popd
