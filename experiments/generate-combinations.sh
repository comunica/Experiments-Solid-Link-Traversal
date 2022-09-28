#!/bin/bash
pushd index-vs-storage
npm run jbr -- generate-combinations
popd

pushd queries-short
npm run jbr -- generate-combinations
popd

pushd queries-discover
npm run jbr -- generate-combinations
popd

pushd queries-complex
npm run jbr -- generate-combinations
popd
