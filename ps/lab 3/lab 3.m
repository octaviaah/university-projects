#Exercise 1
clear

alpha = input('alpha = ');
beta = input('beta = ');

#normal

fprintf('normal case\n');
mu = input('mu=');
sigma = input('sigma=');

#a
pna1 = normcdf(0, mu, sigma);
pna2 = 1 - pna1;
fprintf('P(X<=0) %f\n', pna1);
fprintf('P(X>=0) %f\n', pna2);

#b
pnb1 = normcdf(1, mu, sigma) - normcdf(-1, mu, sigma);
pnb2 = 1 - pnb1;
fprintf('P(-1<=X<=1) %f\n', pnb1);
fprintf('P(X<=-1 or X>=1) %f\n', pnb2);

#c
pnc = norminv(alpha, mu, sigma);
fprintf('P(X < Xa) = alpha %f\n', pnc);

#d
pnd = norminv(1 - beta, mu, sigma);
fprintf('P(X > Xb) = beta %f\n', pnd);


#student
fprintf('student case\n');
n = input("n=")

#a
psa1 = tcdf(0, n);
psa2 = 1 - psa1;
fprintf('P(X<=0) %f\n', psa1);
fprintf('P(X>=0) %f\n', psa2);

#b
psb1 = tcdf(1, n) - tcdf(-1, n);
psb2 = 1 - psb1;
fprintf('P(-1<=X<=1) %f\n', psb1);
fprintf('P(X<=-1 or X>=1) %f\n', psb2);

#c
psc = tinv(alpha, n);
fprintf('P(X < Xa) = alpha %f\n', psc);

#d
psd = tinv(1 - beta, n);
fprintf('P(X > Xb) = beta %f\n', psd);
        
        
#fischer
fprintf('fischer case\n');
fm = input("m=")
fn = input("n=")

#a
pfa1 = fcdf(0, fm, fn);
pfa2 = 1 - pfa1;
fprintf('P(X<=0) %f\n', pfa1);
fprintf('P(X>=0) %f\n', pfa2);

#b
pfb1 = fcdf(1, fm, fn) - fcdf(-1, fm, fn);
pfb2 = 1 - pfb1;
fprintf('P(-1<=X<=1) %f\n', pfb1);
fprintf('P(X<=-1 or X>=1) %f\n', pfb2);

#c
pfc = finv(alpha, fm, fn);
fprintf('P(X < Xa) = alpha %f\n', pfc);

#d
pfd = finv(1 - beta, fm, fn);
fprintf('P(X > Xb) = beta %f\n', pfd);

#Exercise 2
#bino ~ norm
n = 160;
p=0.65;
k=0:n;

y = binopdf(k,n,p);

figure(1)
hold on
bar(k,y)

mu = n*p;
sig = sqrt(n*p*(1-p));

x = mu-3*sig:0.01:mu+3*sig;
z=normpdf(x,mu,sig);

plot(x,z,'Color','r','LineWidth',2);

#bino ~ poisson
n =150;
p=0.05;
k=0:n;

y = binopdf(k,n,p);

figure(1)
hold on
bar(k,y)

lambda=n*p;
z=poisspdf(k,lambda);

plot(k,z,'Color','r','LineWidth',1);

#Exercise 2 v2
clear
p = input("p = ");

for n = 1:20
  values = 1:n;
  bd = binopdf(values, n, p);
  hold on
  nd = normpdf(values, n*p, sqrt(n*p*(1-p)));
  plot(values, bd, 'r*');
  hold on
  plot(values, nd, 'b-');
  pause(1);
endfor  

clear
p2 = input("p2 = ");
for n = 30:50
  values = 30:n;
  bd = binopdf(values, n, p2);
  pd = poisspdf(values, n*p2);
  plot(values, bd, 'r*');
  hold on
  plot(values, pd, 'b-');
  pause(1);
endfor 
  