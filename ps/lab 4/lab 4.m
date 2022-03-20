#Exercise 1
clear all
clc
close all

N=10000;

y=rand(1,N);

figure(1)
hold on
hist(y,20)
title('RAND')

z=randn(1,N);

figure(2)
hold on
hist(z,20)
title('RANDN')

a=0;b=2;
w=a+(b-a)*y;

figure(3)
hold on
hist(w,20)
title(['RAND [',num2str(a),',',num2str(b),']'])

med=0; sig=2;
u=normrnd(med,sig,1,N);

figure(4)
hold on
hist(u,20)
title(['RANDN  $\mu$=',num2str(med),'\quad$\sigma$=',num2str(sig)],'Interpreter','Latex')

#Exercise 2
p = input('probability of success = ');
N = input('number of simulations = ');
U = rand(1, N);
X = (U < p);
U_X = unique(X)
n_X = hist(X, length(U_X));
rel_frq = n_X / N

#a - Bern
#simulate Bern(p) distribution
clear ALL
p = input('probability of success = ');
U = rand
#define success U<p, failure U>=p
X = (U < p)
#generate a sample
N = input('number of simulations = ');
for i = 1:N
   U = rand;
   X(i) = (U < p);
end
#compare to the Bern(p) distribution
UX = unique(X) #distribution values of X
fr = hist(X, length(UX)) #histogram - rectangle telling us how many elements are in each class, like a frequency vector
relfr = fr / N #the number of occurrences of a success


#b - Bino
#simulate a Bino(p) distribution
clear ALL
n = input('number of trials = ');
p = input('probability of success = ');
#generate one variable
U = rand(n, 1);
#success U<p, failure U>=p
X = sum(U<p);
#generate a sample
N = input('number of simulations = ')
for i = 1:N
   U = rand(n, 1)
   X(i) = sum(U<p)
end
%compare to the Bino(n, p) distribution
UX = unique(X) #distribution values of X
fr = hist(X, length(UX)) #histogram - rectangle telling us how many elements are in each class, like a frequency vector
relfr = fr/N #the number of occurrences of a success

#compare graphically to the Bino(n, p) distribution
k = 0:n
kpdf = binopdf(k, n, p)
plot(k, kpdf, '*', UX, relfr, 'ro', 'MarkerSize', 10)  
legend('binopdf', 'simulation')


#c - Geo
#simulate a Geo(p) distribution
p = input('probability of success = ')
X = 0
while (rand >= p)
   X = X+1 #count the number of failures before the 1st success
end
#generate a sample
N = input('number of simulations = ')
for i = 1:N
     X(i) = 0
     while (rand >= p)
       X(i) = X(i) + 1 #count the number of failures before the 1st success
     end
end
fprintf('%d ', X)

hist(X)#histogram for X
figure(2)
hist(geornd(p, 1, N))#histogram for random numbers from a Geo distribution

#compare to Bino(n, p) distribution
UX = unique(X)
fr = hist(X, length(UX))
relfr = fr/N

#compare graphically
k=0:n
kpdf = geopdf(kpdf, p)
figure(3)
plot(k, kpdf, '*', UX, relfr, 'ro')
legend('geopdf',  'simulation')  

#d - Pascal
n = input('rank of success = ')
p = input('probability of success = ')
for j = 1:n
      Y(j) = 0
      while(rand >= p)
        Y(j) = Y(j) + 1
      end
end
X = sum(Y)
#generate a sample
N = input('number of simulations = ')
for i = 1:N
     for j = 1:n
       Y(j) = 0
       while (rand >= p)
         Y(j) = Y(j) + 1
       end
     end
     X(i) = sum(Y)
end

fprintf('%d ', X)
hist(X) #histogram for X
figure(2)
hist(nbinrnd(n, p, 1, N)) #histogram for random numbers from a Pascal distribution

#Exercise 3
#discrete uniform
m = input("enter m = ");
[MDU,VDU] = unidstat(1:m)   

#binomial
n = input("enter n = ");
p = input("enter p = ");
[MB, VB] = binostat(1:n, p)

#hypergeometric
M = input("enter M = ")
K = input("enter K = ")
N = input("enter N = ")
[MHG, VHG] = hygestat(M, K, N)

#Poisson
lambda = input("enter lambda = ")
[MP, VP] = poisstat(lambda)

#Pascal(negative binomial)
n = input("enter n = ")
p = input("enter p = ")
[MNB, VNB] = nbinstat(n, p)

#geometric
p = input("enter p = ")
[MG, VG] = geostat(p)

#uniform
a = input("enter a = ")
b = input("enter b = ")
[MU, VU] = unifstat(a, b)

#normal
mu = input("enter mu = ")
sigma = input("enter sigma = ")
[MN, VN] = normstat(mu, 1:sigma)

#gamma
a = input("enter a = ")
b = input("enter b = ")
[MGM, VGM] = gamstat(a, b)

#exponential
mu = input("enter mu = ")
[ME, VE] = expstat(mu)

#beta
a = input("enter a = ")
b = input("enter b = ")
[MB, VB] = betastat(a, b)

#Student
nu = input("enter nu = ")
[MS, VS] = tstat(nu)

#chi squared
nu = input("enter nu = ")
[MCS, VCS] = chi2stat(nu)

#Fisher
v1 = input("enter v1 = ")
v2 = input("enter v2 = ")  
[MF, VF] = fstat(v1, v2)
