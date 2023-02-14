#!/bin/bash
# Create plots
# This requires global installation of psbr: https://github.com/rubensworks/process-sparql-benchmark-results.js/

#psbr tex query --name 'plot_queries_all' --svg \
#    --overrideCombinationLabels cnone-base,cmatch-base,call-base,cnone-ldp,cmatch-ldp,call-ldp,cnone-ldp-idx,cmatch-ldp-idx,call-ldp-idx,cnone-ldp-idx-filt,cmatch-ldp-idx-filt,call-ldp-idx-filt \
#    --overrideQueryLabels IS1,IS2,IS3,IS4,IS5,IS6,IS7 \
#    --color Paired-12 \
#    output/combination_0 output/combination_1 output/combination_2 output/combination_3 output/combination_4 output/combination_5 output/combination_6 output/combination_7 output/combination_8 output/combination_9 output/combination_10 output/combination_11

#psbr tex query --name 'plot_queries_base' --svg \
#    --overrideCombinationLabels cnone-base,cmatch-base,call-base \
#    --overrideQueryLabels ID1,ID2,ID3,ID4,ID5,ID6,ID7,ID8 \
#    combination_0/output combination_1/output combination_2/output

#psbr tex query --name 'plot_queries_cmatchall' --svg \
#    --overrideCombinationLabels cmatch-base,call-base,cmatch-ldp,call-ldp,cmatch-ldp-idx,call-ldp-idx,cmatch-ldp-idx-filt,call-ldp-idx-filt \
#    --overrideQueryLabels IS1,IS2,IS3,IS4,IS5,IS6,IS7 \
#    --color Paired-12 \
#    output/combination_1 output/combination_2 output/combination_4 output/combination_5 output/combination_7 output/combination_8 output/combination_10 output/combination_11
#





psbr tex query --name 'queries_indexvsstorage_time' --svg --logY --legendPos '1.5,0.9' --maxY 100 \
    --overrideCombinationLabels TypeIndex,TypeIndex-f,LDP+TypeIndex,LDP+TypeIndex-f,LDP \
    --overrideQueryLabels D1,D2,D3,D4,D5,D6,D7,D8 \
    --color Paired-12 \
    combination_1/output combination_2/output combination_3/output combination_4/output combination_0/output

psbr tex query --name 'queries_indexvsstorage_time_relative' --svg --legendPos '1.5,0.9' --relative \
    --overrideCombinationLabels TypeIndex,TypeIndex-f,LDP+TypeIndex,LDP+TypeIndex-f,LDP \
    --overrideQueryLabels D1,D2,D3,D4,D5,D6,D7,D8 \
    --color Paired-12 \
    combination_1/output combination_2/output combination_3/output combination_4/output combination_0/output

psbr tex query --name 'queries_indexvsstorage_http' --metric httpRequests --svg --legendPos '1.5,0.9' \
    --overrideCombinationLabels TypeIndex,TypeIndex-f,LDP+TypeIndex,LDP+TypeIndex-f,LDP \
    --overrideQueryLabels D1,D2,D3,D4,D5,D6,D7,D8 \
    --color Paired-12 \
    combination_1/output combination_2/output combination_3/output combination_4/output combination_0/output

psbr tex query --name 'queries_indexvsstorage_http_relative' --metric httpRequests --svg --legendPos '1.5,0.9' --relative \
    --overrideCombinationLabels TypeIndex,TypeIndex-f,LDP+TypeIndex,LDP+TypeIndex-f,LDP \
    --overrideQueryLabels D1,D2,D3,D4,D5,D6,D7,D8 \
    --color Paired-12 \
    combination_1/output combination_2/output combination_3/output combination_4/output combination_0/output

psbr tex queryTimes 'interactive-discover-1.3' --name 'querytimes_d1-3' --svg \
    --overrideCombinationLabels TypeIndex,TypeIndex-f,LDP+TypeIndex,LDP+TypeIndex-f,LDP \
    --color Paired-12 \
    combination_1/output combination_2/output combination_3/output combination_4/output combination_0/output

psbr tex queryTimes 'interactive-discover-1.4' --name 'querytimes_d1-4' --svg \
    --overrideCombinationLabels TypeIndex,TypeIndex-f,LDP+TypeIndex,LDP+TypeIndex-f,LDP \
    --color Paired-12 \
    combination_1/output combination_2/output combination_3/output combination_4/output combination_0/output

psbr tex queryTimes 'interactive-discover-2.3' --name 'querytimes_d2-3' --svg \
    --overrideCombinationLabels TypeIndex,TypeIndex-f,LDP+TypeIndex,LDP+TypeIndex-f,LDP \
    --color Paired-12 \
    combination_1/output combination_2/output combination_3/output combination_4/output combination_0/output

psbr tex queryTimes 'interactive-discover-2.4' --name 'querytimes_d2-4' --svg \
    --overrideCombinationLabels TypeIndex,TypeIndex-f,LDP+TypeIndex,LDP+TypeIndex-f,LDP \
    --color Paired-12 \
    combination_1/output combination_2/output combination_3/output combination_4/output combination_0/output

psbr tex queryTimes 'interactive-discover-5.4' --name 'querytimes_d5-4' --svg \
    --overrideCombinationLabels TypeIndex,TypeIndex-f,LDP+TypeIndex,LDP+TypeIndex-f,LDP \
    --color Paired-12 \
    combination_1/output combination_2/output combination_3/output combination_4/output combination_0/output

