#test for 2 populations
#a
fprintf('point a\n')
alpha = 0.05 #significance level
fprintf('Significance level is %1.4f\n', alpha)

#h0: sigma1 = sigma2 (they start at identical temperatures)
#h1: sigma1 != sigma2 (the temperatures are not equal anymore) - 2-tailed test

x = [4.6, 0.7, 4.2, 1.9, 4.8, 6.1, 4.7, 5.5, 5.4] #sample test 1(steel)
y = [2.5, 1.3, 2.0, 1.8, 2.7, 3.2, 3.0, 3.5, 3.4] #sample test 2(glass)
n1 = length(x) #length of vector x
n2 = length(y) #length of vector y
#tail can have the following values: -1 for left-tailed
#                                     0 for 2-tailed
#                                     1 for right-tailed
#in our case, tail is 0
tail = 0

#to see if the population variances differ, we use the test statistic vartest2
[h, p, ci, valstat] = vartest2(x, y, 'alpha', alpha, 'tail', 'both')
#h - hypothesis
#p - P-value
#ci - confidence intervals
#valstat - value of the test statistic

fprintf('P-value is %1.4f.\n', p)
fprintf('The observed value is %1.4f.\n', valstat.fstat)

if h == 0
  fprintf('The null hypothesis is NOT rejected. In our case, the variances seem to be equal\n')
else
  fprintf('The null hypothesis is rejected. In our case, population variances seem to differ\n')
end

#we calculate the quantiles using an inverse cdf of f distribution, with the parameters 1-alpha/2 or alpha/2 and the degrees of freedom of the test statistic
#because we have a 2-tailed test, we calculate 2 quantiles
q1 = finv(alpha/2, valstat.df1, valstat.df2) 
q2 = finv(1-alpha/2, valstat.df2, valstat.df1)
fprintf('Rejection region RR is (-inf, %3.4f) U (%3.4f, inf)\n', q1, q2)




#b
fprintf('\n\npoint b\n')
#from point a, we know that population variances seem to differ
#in this case, to compute the confidence interval, the quantiles will refer to the T(n) distribution.
#we need to calculate n, which also uses a ratio given by c

mx = mean(x) #sample mean of x
my = mean(y) #sample mean of y
varx = var(x) #sample variance of x
vary = var(y) #sample variance of y

c = (varx/n1)/(varx/n1 + vary/n2)
n = 1/(c^2/(n1-1)+(1-c)^2/(n2-1))

#we compute the quantileusing the inverse cdf for T distribution
q = tinv(1-alpha/2, n)
fprintf("Quantile is %f\n", q)

rt = sqrt(varx/n1+vary/n2) #the square root from the formula
mdif = mx - my #difference between means

#lhs and rhs of the confidence interval
l = mdif - q*rt
r = mdif + q*rt

fprintf('For 2 population means whose variances seem to be different (sample mean difference = %1.4f) :\n', mdif)
fprintf('The confidence interval for the confidence level %1.4f is (%3.4f, %3.4f)\n', 1-alpha, l, r)