# Compare means with Kruskal-Wallis test (nonparametric, because non-normal distribution)

data <- read.csv('analysis_queries_all.csv', sep = ';')

# To test normality (p < 0.05, so not normal)
# ks.test(data$time, 'pnorm')
# ks.test(data$requests, 'pnorm')

# Means
aggregate(data$time, list(data$experiment), median)
aggregate(data$requests, list(data$experiment), median)

# H0: No statistical difference between combinations
kruskal.test(time ~ experiment, data = data)
# p: 0.014 (= 1.4% strong)
# => Reject H0, non-equal means => big statistical difference
kruskal.test(requests ~ experiment, data = data)
# p: < 2.2e-16
# => Reject H0, non-equal means => big statistical difference

# H0: No statistical difference frag approaches in scale 1
data_scale1 <- data[which(data$experiment=='composite-1' | data$experiment=='separate-1' | data$experiment=='single-1' | data$experiment=='location-1' | data$experiment=='time-1'),]
aggregate(data_scale1$time, list(data_scale1$experiment), median)
kruskal.test(time ~ experiment, data = data_scale1)
# p: 0.7221
# => Accept H0, equal means for time
aggregate(data_scale1$requests, list(data_scale1$experiment), median)
kruskal.test(requests ~ experiment, data = data_scale1)
# p: 1.896e-10
# => Reject H0, non-equal means for requests

# H0: No statistical difference frag approaches in scale 5
data_scale5 <- data[which(data$experiment=='composite-5' | data$experiment=='separate-5' | data$experiment=='single-5' | data$experiment=='location-5' | data$experiment=='time-5'),]
aggregate(data_scale5$time, list(data_scale5$experiment), median)
kruskal.test(time ~ experiment, data = data_scale5)
# p: 0.8813
# => Accept H0, equal means for time
aggregate(data_scale5$requests, list(data_scale5$experiment), median)
kruskal.test(requests ~ experiment, data = data_scale5)
# p: 4.586e-10
# => Reject H0, non-equal means for requests

# Check correlation between http and time
cor.test(data[which(data$experiment=='composite-1'),]$time, data[which(data$experiment=='composite-1'),]$requests, method='spearman')
# p: 0.1877 => No significant correlation! (only very weak)