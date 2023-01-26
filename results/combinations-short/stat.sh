#/bin/bash
# Create stats files
# This requires global installation of psbr: https://github.com/rubensworks/process-sparql-benchmark-results.js/

psbr csv summary --name 'stats_queries_all.md' --markdown \
    --overrideCombinationLabels cnone-base,cmatch-base,call-base,cnone-idx,cmatch-idx,call-idx,cnone-idx-filt,cmatch-idx-filt,call-idx-filt,cnone-ldp,cmatch-ldp,call-ldp,cnone-ldp-idx,cmatch-ldp-idx,call-ldp-idx,cnone-ldp-idx-filt,cmatch-ldp-idx-filt,call-ldp-idx-filt \
    --correctnessReference correctnessReference.json \
    --queryAverage \
    --markRows 1,4,7,10,13,16 \
    combination_0/output combination_1/output combination_2/output combination_3/output combination_4/output combination_5/output combination_6/output combination_7/output combination_8/output combination_9/output combination_10/output combination_11/output combination_12/output combination_13/output combination_14/output combination_15/output combination_16/output combination_17/output
