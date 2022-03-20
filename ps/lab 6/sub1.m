#test for 2 populations
#a
alpha = 0.05


#h0: sigma1 = sigma2 (they start at identical temperatures)
#h1: sigma1 != sigma2 (the temperatures are not equal anymore) - 2-tailed test

x = [4.6, 0.7, 4.2, 1.9, 4.8, 6.1, 4.7, 5.5, 5.4] #sample test 1
y = [2.5, 1.3, 2.0, 1.8, 2.7, 3.2, 3.0, 3.5, 3.4] #sample test 2
n1 = length(x)
n2 = length(y)
#tail can have the following values: -1 for left-tailed
#                                     0 for 2-tailed
#                                     1 for right-tailed
tail = 0
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
fprintf('Observed valued is %1.4f\n', varstat.fstat)
fprintf('P-value is %1.4f\n', p)
fprintf('Rejection region RR is (-inf, %3.4f) U (%3.4f, inf)\n', q1, q2)


#b
fprintf('\nb\n')
#h0: miu1 = miu2
#h1: miu1 > miu2 - right-tailed test  
[h, p, xi, tstats] = ttest2(x, y, 'alpha', alpha, 'tail', 'right', 'vartype', 'unequal')
%vartype is unequal bc in point a we got different values for population variance. if they were equal, we would have used the 'equal' parameter

if h == 0
  fprintf('H0 is NOT rejected. Steel pipes do NOT lose more heat than glass pipes.\n')
else
  fprintf('H0 is rejected. Steel pipes lose more heat than glass pipes.\n')
end

fprintf('P-value of the test statistic is %f\n', p)
fprintf('Observed value of the test statistic is %1.4f.\n', tstats.tstat)

q = tinv(1-alpha, tstats.df) #quantile
fprintf('Rejection region R is (%3.4f, +inf)\n', q)
