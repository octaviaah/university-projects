function RR_Ftest(alpha, n1, n2, type)
      switch type
        case -1
          l = -Inf
          r = finv(alpha, n1-1, n2-1)
          fprintf('The rejection region RR is (%f, %f)\n', l, r)
        case 0
          r = finv(1-alpha/2, n1-1, n2-1)
          l = -r
          fprintf('The rejection region RR is (%f, %f)U(%f, %f)\n', -Inf, l, r, Inf)
        case 1
          l = finv(1-alpha, n1-1, n2-1)
          r = Inf
          fprintf('The rejection region RR is (%f, %f)\n', l, r)
      endswitch
endfunction 

function RR_Ttest(alpha, n, type)
    switch type
      case -1
        l = -Inf
        r = tinv(alpha, n-1)
        fprintf('The rejection region RR is (%f, %f)\n', l, r)
      case 0
        r = tinv(1-alpha, n-1)
        l = -r
        fprintf('The rejection region RR is (%f, %f)U(%f, %f)\n', -Inf, l, r, Inf)
      case 1
        l = tinv(1-alpha, n-1)
        r = Inf
        fprintf('The rejection region RR is (%f, %f)\n', l, r)
    endswitch
endfunction



#Exercise 1
#a
alpha = input("give a significance level ");

A=[7 7 4 5 9 9
4 12 8 1 8 7
3 13 2 1 17 7
12 5 6 2 1 13
14 10 2 4 9 11
3 5 12 6 10 7];

x=A(:);
n=length(x);
sigma=5;

fprintf("left tailed test for alpha = %f\n", alpha);

m0 = 9;
[h,p,ci,zval] = ztest(x,m0,sigma,"alpha",alpha,"tail","left")

tt0 = norminv(alpha);
RR=[-inf, tt0];

if h == 1
    fprintf('\n So the null hypothesis is rejected,\n')
    fprintf('i.e. the data suggests that the standard IS NOT met.\n')
else
    fprintf('\n So the null hypothesis is not rejected,\n')
    fprintf('i.e. the data suggests that the standard IS  met.\n')
end   

fprintf('the rejection region is (%4.4f, %4.4f)\n', RR)
fprintf('the value of the test statistic z is %4.4f\n', zval)
fprintf('the P-value of the test is %4.4f\n\n', p)


#b
x = [7, 7, 4, 5, 9, 9, 4, 12, 8, 1, 8, 7, 3, 13, 2, 1, 17, 7, 12, 5, 6, 2, 1, 13, 14, 10, 2, 4, 9, 11, 3, 5, 12, 6, 10, 7]
n = length(x)
fprintf('length of x is %d\n', n)
med = mean(x)
fprintf('Sample mean %f\n', med)
sigma_s = std(x)
fprintf('Sample standard deviation %f\n', sigma_s)

m0 = 5.5
type = 1 #right-tailed test
alpha = input('Give significance level: ')
[hb, pb, cib, tstatb] = ttest(x, m0, 'alpha', alpha, 'tail', 'right')
t1 = (med - m0)/sigma_s*sqrt(n)
fprintf('The value of the test statistic t is %f (given by ttest %f)\n', t1, tstatb.tstat)

RR_Ttest(alpha, n, type)
if hb == 1
  fprintf('The null hypothesis is rejected(t in RR)\n')
else 
  fprintf('The null hypothesis is NOT rejected (t not in RR)\n')
end 

fprintf('The P-value of the test is %f\n', pb)
if alpha >= pb
  fprintf('The null hypothesis is rejected\n')
else
  fprintf('The null hypothesis is NOT rejected\n')
end  


#Exercise 2
x=[22.4, 21.7, 24.5, 23.4, 21.6, 23.3, 22.4, 21.6, 24.8, 20.0]
y=[17.7, 14.8, 19.6, 19.6, 12.1, 14.8, 15.4, 12.6, 14.0, 12.2]

n1 = length(x)
n2 = length(y)
mx = mean(x)
my = mean(y)
varx = var(x)
vary = var(y)

alpha = 0.05 #significance level

#a
typea = 0 #2 tailed test
fprintf('a)\n')
fprintf('\n')
fprintf('SIGNIFICANCE LEVEL %f:\', alpha)

[ha, pa,ci, valstata] = vartest2(x, y, 'alpha', alpha, 'tail', 'both')
f = varx/vary
fprintf("The value of the test statistic f is %f (given by vartest2 %f)\n", f,  valstata.fstat)
RR_Ftest(alpha, n1, n2, typea)

if ha == 1
  fprintf('The null hypothesis is rejected(f in RR) i.e.the variances seem to be different\n')
else
  fprintf('The null hypothesis is NOT rejected(f not in RR) i.e. the variances seem to be equal\n')
end

fprintf('The P-value of the test is %f\n', pa)

if alpha >= pa
    fprintf('The null hypothesis is rejected, i.e. the variances seem to be different\n')
else
    fprintf('The null hypothesis is NOT rejected, i.e. the variances seem to be equal\n')
end


#b
typeb = 1#right-tailed test
n = n1+n2-2
if ha == 0
  vartype = 'equal'
else
  vartype = 'unequal'
end

fprintf('\n b)\n')
[hb, pb, cib, valstatb] = ttest2(x, y, 'alpha', alpha, 'tail', 'right', 'vartype', vartype)
t = (mx-my)/sqrt((n1-1)*varx+(n2-1)*vary)*sqrt((n1+n2-2)/(1/n1+1/n2))
fprintf('The value of the test statistic t is %f (given by ttest2 %f)\n', t, valstatb.tstat)

RR_Ttest(alpha, n, typeb)
if hb == 1
  fprintf('The null hypothesis is rejected (t in RR) i.e. gas mileage IS higher with premium gasoline \n')
else
  fprintf('The null hypothesis is NOT rejected (t not in RR) i.e. gas mileage IS NOT higher with premium gasoline\n')
end
fprintf('The P-value of the test is %.10f\n', pb)

if alpha >=pb
    fprintf('The null hypothesis is rejected (t in RR) i.e. gas mileage IS higher with premium gasoline \n')
else
    fprintf('The null hypothesis is NOT rejected (t not in RR) i.e. gas mileage IS NOT higher with premium gasoline\n')
end    
  
    
