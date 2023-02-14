#/bin/bash
# Analyze the results using R
# This requires global installation of R and psbr: https://github.com/rubensworks/process-sparql-benchmark-results.js/

psbr csv query --name 'analysis_queries_all.csv' \
    --overrideCombinationLabels composite-1,separate-1,single-1,location-1,time-1,composite-5,separate-5,single-5,location-5,time-5 \
    combination_0/output combination_1/output combination_2/output combination_3/output combination_4/output combination_5/output combination_6/output combination_7/output combination_8/output combination_9/output

# Rscript analyze.r
