#test for 1 population
#a
alpha = 0.05
x = [3.26, 1.89, 2.42, 2.03, 3.07, 2.95, 1.39, 3.06, 2.46, 3.35, 1.56, 1.79, 1.76, 3.82, 2.42, 2.96]
mx = mean(x) #sample mean of x
fprintf("Sample mean: %f\n", mx)

#we use a standard variance
s = std(x)
fprintf('Sample standard deviation: %f\n', s)

#we calculate the lhs and rhs of the confidence interval
#unknown sigma -> we use tinv
l = mx - (s/sqrt(length(x))*tinv(1-alpha/2, length(x)-1))
r = mx + (s/sqrt(length(x))*tinv(1-alpha/2, length(x)-1))
fprintf('Confidence interval for the mean (sample standard deviation = %f and sample mean = %f)\n', s, mx)
fprintf('Confidence level %.2f: (%f, %f)\n', 1-alpha, l, r)



#b
fprintf('\n\nb\n')
alpha = 0.01#significance level
#less than - left tailed test
m0 = 3
[h, p, ci, valstat] = ttest(x, m0, 'alpha', alpha, 'tail', 'left')
fprintf("Observed value is %f\n", valstat.tstat)

q = tinv(alpha, valstat.df)
fprintf('Rejection region RR is (-inf, %3.4f)\n', q)
if h == 1
  fprintf('The null hypothesis is rejected(t in RR) - nickel particles are not smaller than 3\n')
else
  fprintf('The null hypothesis is NOT rejected(t not in RR) = nickel particles are smaller than 3\n')
end

fprintf('P-value is %f\n', p)
  