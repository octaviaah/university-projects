#alpha belongs to (0, 1)
#100(1-alpha) confidence interval


#for a population mean miu
#large sample(n>30) or normal underlying population and sigma known
miu = (mx - sigma/sqrt(n)*norminv(1-alpha/2), mx + sigma/sqrt(n)*norminv(1-alpha/2))
#quantiles refer to the N(0, 1) distribution


#large sample(n>30) or normal underlying population
miu = (mx - s/sqrt(n)*tinv(1-alpha/2), mx + s/sqrt(n)*tinv(1-alpha/2, n-1))
#quantiles refer to the T(n-1) distribution




#for a population variance sigma^2, for a normal underlying population
sigma^2 = (((n-1)*varx)/chi2inv(1-alpha/2, n-1), ((n-1)*varx)/chi2inv(alpha/2, n-1))
#quantiles refer to the chiSquared(n-1) distribution




#for the difference of 2 population means, miu1-miu2, for large samples(n1+n2 > 40) or normal underlying populations and independent sample,
#sigma1, sigma2 known
miu1-miu2 = (mx - my - norminv(1-alpha/2)*sqrt(varx/n1 + vary/n2), mx-my+norminv(1-alpha/2)*sqrt(varx/n1 + vary/n2))
#quantiles refer to the N(0, 1) distribution


#sigma1 = sigma2, unknown
sp = sqrt(((n1-1)*varx + (n2-1)*vary)/(n1+n2-2))
miu1-miu2 = (mx-my-tinv(1-alpha/2, n1+n2-2)*sp*sqrt(1/n1+1/n2), mx-my+tinv(1-alpha/2, n1+n2-2)*sp*sqrt(1/n1+1/n2))
#where the quantiles refer to the T(n1+n2-2) distribution




#sigma1 != sigma2, unknown
c = (varx/n1)/(varx/n1+vary/n2)
n = ((n1-1)*(n2-1))/(c^2*(n2-1) + (n1-1)*(1-c)^2)
miu1-miu2 = (mx - my - tinv(1-alpha/2, n)*sqrt(varx/n1 + vary/n2), mx-my+tinv(1-alpha/2, n)*sqrt(varx/n1+vary/n2))
#where the quantiles refer to the T(n) distribution



#for the ratio of 2 population variances, sigma1^2/sigma2^2, for normal underlying populations and independent samples:
sigma1^2/sigma2^2 = (varx/(vary*finv(1-alpha/2, n1-1, n2-1)), varx/(vary*finv(alpha/2, n1-1, n2-1)))
#where the quantiles refer to the F(n1-1, n2-1) distribution
