#/bin/bash
# Create stats files
# This requires global installation of psbr: https://github.com/rubensworks/process-sparql-benchmark-results.js/

psbr csv summary --name 'stats_queries_all.md' --markdown \
    --overrideCombinationLabels Composite-1,Composite-5,Separate-1,Separate-5,Single-1,Single-5,Location-1,Location-5,Time-1,Time-5 \
    --correctnessReference correctnessReference.json \
    --queryAverage \
    combination_0/output combination_5/output combination_1/output combination_6/output combination_2/output combination_7/output combination_3/output combination_8/output combination_4/output combination_9/output
