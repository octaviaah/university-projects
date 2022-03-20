#Part A
X = [20 21 22 23 24 25 26 27
      2 1 3 6 5 9 2 2];
      
Y = [75 76 77 78 79 80 81 82
      3 2 2 5 8 8 1 1];

Xnew = reshape(X, 2, []);
Ynew = reshape(Y, 2, []);

#a
fprintf("The means of X and Y are %f and %f \n", mean(Xnew), mean(Ynew))
#b
fprintf("The variances of X and Y are %f and %f \n", var(Xnew, 1), var(Ynew, 1))
#c
C = cov(Xnew, Ynew, 1)
fprintf("the covariance is %f \n", C(1, 2))
#d
R = corrcoef(Xnew, Ynew)
fprintf("the correlation coefficient: %f\n", R(1, 2))

figure(1)
hold on
box on
plot(Xnew, Ynew, 'r*')
xlabel('X')
ylabel('Y')      


#Part B
#Exercise 1
x = [ 7, 7, 4, 5, 9, 9, 4, 12, 8, 1, 8, 7, 3, 13, 2, 1, 17, 7, 12, 5, 6, 2, 1, 13, 14, 10, 2, 4, 9, 11, 3, 5, 12, 6, 10, 7];
n = length(x);
oneMinusAlpha = input('Enter confidence level: ');
Alpha = 1 - oneMinusAlpha;
% B1a

sigma = 5;
meanOfX = mean(x); %sample mean

m1 = meanOfX - (sigma/sqrt(n))*norminv(1-Alpha/2)
m2 = meanOfX + (sigma/sqrt(n))*norminv(1-Alpha/2)
fprintf('Confidence interval for the mean (standard deviation = %f and sample mean = %f)\n', sigma, meanOfX)
fprintf('Confidence level %.2f: (%f, %f)\n', 1-Alpha, m1, m2)

%B1b
% s - standard deviation of the sample
s = std(x);
b1 = meanOfX - (s/sqrt(n))*tinv(1-Alpha/2, n-1)
b2 = meanOfX + (s/sqrt(n))*tinv(1-Alpha/2, n-1)
fprintf('Confidence interval for the mean (sample standard deviation = %f and sample mean = %f)\n', s, meanOfX)
fprintf('Confidence level %.2f: (%f, %f)\n', 1-Alpha, b1, b2)

%B1c
sSquare = var(x);
c1 = ((n-1)*sSquare)/chi2inv(1-Alpha/2, n-1)
c2 = ((n-1)*sSquare)/chi2inv(Alpha/2, n-1)
C1 = sqrt(c1)
C2 = sqrt(c2)
fprintf('Confidence interval for the variance(sample variance = %f and sample mean = %f)\n', sSquare, meanOfX)
fprintf('Confidence level %.2f: (%f, %f)\n', 1-Alpha, C1, C2)


#Exercise 2
x = [22.4, 21.7, 24.5, 21.6, 23.3, 22.4, 21.6, 24.8, 20.0]
y = [17.7, 14.8, 19.6, 12.1, 14.8, 15.4, 12.6, 14.0, 12.2]

n1 = length(x)
n2 = length(y)
mx = mean(x)
my = mean(y) #sample means for x and y
mdif = mx-my #difference between means
varx = var(x)
vary = var(y) #sample variances for x and y
rapvar = varx/vary #ratio between the variances

alpha= input("Enter confidence level: ")

#a
sp = sqrt(((n1 - 1)*varx + (n2-1)*vary)/(n1+n2-2))
qa = tinv(1-alpha/2, n1+n2-2)#quantile
ca = sqrt(1/n1+1/n2)
la=mdif-qa*sp*ca
ra=mdif+qa*sp*ca

fprintf('Confidence interval for difference of 2 population means, variances are equal, (sample diff. means = %f)\n', mdif)
fprintf('Confidence level %.2f: (%f, %f)\n', 1-alpha, la, ra)


#b
c = (varx/n1)/(varx/n1 + vary/n2)
n = 1/(c^2/(n1-1)+(1-c)^2/(n2-1))
qb = tinv(1-alpha/2, n)#quantile
cb = sqrt(varx/n1+vary/n2)
lb=mdif-qb*cb
rb=mdif+qb*cb

fprintf('Confidence interval for difference of 2 population means, variances are different, (sample diff. means = %f)\n', mdif)
fprintf('Confidence level %.2f: (%f, %f)\n', 1-alpha, lb, rb)


#c
qcl = finv(1-alpha/2, n1-1, n2-1)
qcr = finv(alpha/2, n1-1, n2-1)
lc = rapvar/qcl
rc = rapvar/qcr
fprintf('Confidence interval for ratio of variances(sample ratio variances = %f)\n', rapvar)
fprintf('Confidence level %.2f: (%f, %f)\n', 1-alpha, lc, rc)
