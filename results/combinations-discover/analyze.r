# Compare means with Kruskal-Wallis test (nonparametric, because non-normal distribution)

data <- read.csv('analysis_queries_all.csv', sep = ';')

# To test normality (p < 0.05, so not normal)
# ks.test(data$time, 'pnorm')
# ks.test(data$requests, 'pnorm')

# Rebalance data to make times and requests for incomplete results max value
data$time <- ifelse(data$correctness > 0, data$time, 120000)
data$requests <- ifelse(data$correctness > 0, data$requests, 1000)

# Means
aggregate(data$time, list(data$experiment), median)
aggregate(data$requests, list(data$experiment), median)

# H0: No statistical difference between combinations
#kruskal.test(time ~ experiment, data = data)
# p: < 2.2e-16
# => Reject H0, non-equal means => big statistical difference

# H0: No statistical difference between cMatch-based combinations in terms of time
data_cmatch <- data[which(data$experiment=='cmatch-base' | data$experiment=='cmatch-idx' | data$experiment=='cmatch-idx-filt' | data$experiment=='cmatch-ldp' | data$experiment=='cmatch-ldp-idx' | data$experiment=='cmatch-ldp-idx-filt'),]
#aggregate(data_cmatch$time, list(data_cmatch$experiment), median)
#kruskal.test(time ~ experiment, data = data_cmatch)
# p: 3.711e-16
# => Reject H0, non-equal means

# H0: No statistics difference between (cMatch) type index and LDP
data_idxvsldp <- data[which(data$experiment=='cmatch-idx' | data$experiment=='cmatch-ldp'),]
#kruskal.test(requests ~ experiment, data = data_idxvsldp)
# p: 0.01296 => Reject H0 for number of HTTP requests
#kruskal.test(time ~ experiment, data = data_idxvsldp)
# p: 0.4052 => Accept H0 for query exec time

# H0: No statistics difference between (cMatch) type index and type index filtered
data_idxvsidxfilt <- data[which(data$experiment=='cmatch-idx' | data$experiment=='cmatch-idx-filt'),]
#kruskal.test(requests ~ experiment, data = data_idxvsidxfilt)
# p: 0.6994 => Accept H0 for number of HTTP requests
#kruskal.test(time ~ experiment, data = data_idxvsidxfilt)
# p: 0.6896 => Accept H0 for query exec time

# H0: No statistics difference between (cMatch) ldp+idx and idx
data_idxldpvsidx <- data[which(data$experiment=='cmatch-ldp-idx' | data$experiment=='cmatch-idx'),]
#aggregate(data_idxldpvsidx$requests, list(data_idxldpvsidx$experiment), median)
#kruskal.test(requests ~ experiment, data = data_idxldpvsidx)
# p: 0.02053 => Reject H0 for number of HTTP requests => ldp+idx > idx
#kruskal.test(time ~ experiment, data = data_idxldpvsidx)
# p: 0.7146 => Accept H0 for query exec time

# Check correlation between http and time
data_cmatch_index_filt <- data[which(data$experiment=='cmatch-idx-filt'),]
#cor.test(data_cmatch_index_filt$time, data_cmatch_index_filt$requests, method='spearman')
# p: 0.04329 => Significant
# rho: 0.3211926 => weak