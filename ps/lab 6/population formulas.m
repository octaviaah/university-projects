#for the difference of 2 populations theta = miu1 - miu2, for large samples(n1+n2 > 40) or normal underlying populations and independent samples

#sigma1, sigma2 known:
t = (mx - my)/sqrt(varx/n1 + vary/n2)
#mx, my - means of x and y
#n1, n2 - lengths of x and y
#varx, vary - variances of x and y
#the result belongs to N(0, 1)


#sigma1 = sigma2, unknown
s = ((n1-1)*varx + (n2-1)*vary)/(n1+n2-2)
t = (mx - my)/sqrt(s*(1/n1+1/n2))
or
t = (mx-my)/sqrt((n1-1)*varx+(n2-1)*vary)*sqrt((n1+n2-2)/(1/n1+1/n2))
#mx, my - means of x and y
#n1, n2 - lengths of x and y
#varx, vary - variances of x and y
#the result belongs to T(n1+n2-2)



#sigma1 != sigma2, unknown
t = (mx - my)/sqrt(varx/n1+vary/n2)
where
c = (varx/n1)/(varx/n1 + vary/n2)
1/n = ((n2-1)*c^2 + (n1-1)*(1-c)^2)/(n1-1)*(n2-1)
#mx, my - means of x and y
#n1, n2 - lengths of x and y
#varx, vary - variances of x and y
#the result belongs to T(n)



#ratio of 2 population variances: theta = sigma1^2/sigma2^2
t = varx/vary
#varx, vary - variances of x and y
#the result belongs to F(n1-1, n2-1) where n1 and n2 are the lengths of x and y




#for a population mean, theta = miu

#large sample (n > 30) or normal underlying population and sigma known:
t = (med - minit)/sigma*sqrt(n)
#med - mean of vector x
#minit - given value of a mean(in the problem it is asked if bla bla exceeds minit)
#sigma - known deviation
#n - length of x
#the result belongs to N(0, 1)



#large sample (n>30) or normal underlying population
t(or z) = (med - minit)/s*sqrt(n)
#med - mean of vector x
#minit - given value of a mean(in the problem it is asked if bla bla exceeds minit)
#s - standard deviation
#n - length of x
#the result belongs to T(n-1)



#population variance theta = sigma^2
t = ((n-1)*s^2)/sigma^2
#n - length of x
#sigma - known deviation
#s - standard deviation
#the result belongs to chiSquared(n-1)

