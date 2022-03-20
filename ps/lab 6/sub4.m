#test for 2 populations
#a
alpha = 0.05

a = [1021, 980, 1017, 988, 1005, 998, 1014, 985, 995, 1004, 1030, 1015, 995, 1023]
b = [1070, 970, 993, 1013, 1006, 1002, 1014, 997, 1002, 1010, 975]

n1 = length(a)
n2 = length(b) #lengths of vectors a and b

#h0: sigma1 = sigma2
#h1: sigma1 != sigma2 -> 2 tailed test

#tail can have the following values: -1 for left-tailed
#                                     0 for 2-tailed
#     
tail = 0

#population variances - vartest2
[h, p, ci, valstat] = vartest2(a, b, 'alpha', alpha, 'tail', 'both')
#p - P-value, ci - confidence interval

if h == 0
  fprintf('H0 is NOT rejected, i.e. the variances seem to be equal\n')
else
  fprintf('H0 is rejected, population variances seem to differ\n')
end


q1 = finv(alpha/2, varstat.df1, varstat.df2) #we calculate the quantile using an inverse cdf of f distribution, with the parameters 1-alpha/2 or alpha/2 and the degrees of freedom of the test statistic
q2 = finv(1-alpha/2, varstat.df2, varstat.df1)
fprintf('Observed valued is %1.4f\n', valstat.fstat)
fprintf('P-value is %1.4f\n', p)
fprintf('Rejection region RR is (-inf, %3.4f) U (%3.4f, +inf)\n', q1, q2)




#b
fprintf("\n\nb\n")
#h0: miu1 = miu2
#h1: miu1 > miu2
#more reliable - right tailed test

[h, p, xi, tstats] = ttest2(x, y, 'alpha', alpha, 'tail', 'right', 'vartype', 'equal')
%vartype is equal bc in point a we got equal values for population variance. if they were unequal, we would have used the 'unequal' parameter

fprintf('Observed value of the test statistic is %1.4f.\n', tstats.tstat)

q = tinv(1-alpha, tstats.df)
fprintf('Rejection region RR is (%3.4f, +inf)\n', q)
if h == 0
  fprintf('H0 is NOT rejected. Supplier A is NOT more reliable than supplier B.\n')
else
  fprintf('H0 is rejected. Supplier A is more realible than supplier B\n')
end

fprintf('P-value of the test statistic is %f\n', p)


