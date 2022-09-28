#!/bin/bash
pushd index-vs-storage
./run.sh
popd

pushd queries-short
npm install
popd

pushd queries-discover
npm install
popd

pushd queries-complex
npm install
popd
