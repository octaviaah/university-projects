#test for 2 populations
#a
alpha = 0.05

#h0: sigma1 = sigma2
#h1: sigma1 != sigma2 - 2-tailed test

x = [46, 37, 39, 48, 47, 44, 35, 31, 44, 37]
y = [35, 33, 31, 35, 34, 30, 27, 32, 31, 31]

#tail can have the following values: -1 for left-tailed
#                                     0 for 2-tailed
#                                     1 for right-tailed

#population variances - vartest2
[h, p, ci, varstat] = vartest2(x, y, 'alpha', alpha, 'tail', 'both')
#p - P-value, ci = confidence interval/level

if h == 0
  fprintf('H0 is NOT rejected, i.e. the variances are equal\n')
else
  fprintf('H0 is rejected, population variances differ\n')
end

q1 = finv(alpha/2, varstat.df1, varstat.df2) #we calculate the quantile using an inverse cdf of f distribution, with the parameters 1-alpha/2 or alpha/2 and the degrees of freedom of the test statistic
q2 = finv(1-alpha/2, varstat.df2, varstat.df1)
fprintf('Observed value is %1.4f\n', varstat.fstat)
fprintf('P-value is %1.4f\n', p)
fprintf('Rejection region RR is (-inf, %3.4f) U (%3.4f, +inf)\n', q1, q2)



#b
#sigma1 != sigma2, quantiles refer to the T(n) distribution. using c, we compute n
fprintf('\nb\n')
n1 = length(x)
n2 = length(y)
mx = mean(x)
my = mean(y)
varx = var(x)
vary = var(y)
c = (varx/n1)/(varx/n1 + vary/n2)
n = 1/(c^2/(n1-1)+(1-c)^2/(n2-1))

#we compute the quantile
q = tinv(1-alpha/2, n)
fprintf("Quantile is %f\n", q)
rt = sqrt(varx/n1+vary/n2) #the square root from the formula
mdif = mx - my #difference between means
l = mdif - q*rt
r = mdif + q*rt

fprintf("Confidence interval for the difference of 2 population means where variances are different(sample mean diff. = %f)\n", mdif)
fprintf("Confidence level %.2f: (%f, %f)\n", 1-alpha, l, r)




