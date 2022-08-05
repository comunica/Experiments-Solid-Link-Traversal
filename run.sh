#!/bin/bash
pushd queries-short
./run.sh
popd

pushd queries-complex
./run.sh
popd
