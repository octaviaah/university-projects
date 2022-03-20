#Exercise 1

A = [1, 0, -2; 
     2, 1, 3; 
     0, 1, 0]
B = [2, 1, 1; 
     1, 0, -1; 
     1, 1, 0]

C = A - B
D = A * B
E = A .* B



#Exercise 2

x = 0:0.1:3

f1 = x.^5 / 10
f2 = x .* sin(x)
f3 = cos(x)

title("plots")

plot(x, f1, 'r-')
hold on

plot(x, f2, 'b--')
hold on

plot(x, f3, 'g-')
hold on

legend('x^5 / 10', 'x * sin(x)', 'cos(x)')