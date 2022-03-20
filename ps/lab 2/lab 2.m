#Exercise 2

n=input("Give n(number of trials): ")
x = 0 : n
p=input("Give p(probability of success): ")
plot(x, binopdf(x, n, p), '*r')
hold on
stairs(x, binocdf(x, n, p))
legend('pdf', 'cdf')

#Application
#a
n = 3
x = 0 : n
fprintf('pdf is')
binopdf(x, n, 1/2)

#b
fprintf('cdf is')
binocdf(x, n, 1/2)

#c
#p(x=0), p(x!=1)
pc1 = binopdf(0, n, 1/2)
fprintf('P(x=0) =  %1.4f\n', pc1)
pc2 = 1 - binopdf(1, n, 1/2)
fprintf('P(x!=1) =  %1.4f\n', pc2)

#d
#p(x<=2), p(x<2)
pd1 = binocdf(2, n,1/2)
fprintf('P(x<=2) =  %1.4f\n', pd1)
pd2 = binocdf(1, n, 1/2)
fprintf('P(x<2) =  %1.4f\n', pd2)

#e
#p(x>=1), p(x>1)
pe1 = 1 - binocdf(0, n, 1/2)
fprintf('P(x>=1) =  %1.4f\n', pe1)
pe2 = 1 - binocdf(1, n, 1/2)
fprintf('P(x>1) =  %1.4f\n', pe2)

#f

