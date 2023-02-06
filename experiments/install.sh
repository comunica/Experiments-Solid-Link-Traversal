#!/bin/bash
pushd index-vs-storage
npm install
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

pushd fragmentation
npm install
popd
