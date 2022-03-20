%lcm(M - first number, N - second number, C-intermediate result, R -
% result)
%lcm(i, i, i, o)

lcm(M, N, C, R):-
    R1 is (C+N) mod M,
    R1 =:= 0,
    R is C+N.
lcm(M, N, C, R):-
    R1 is (C+N) mod M,
    R1 =\= 0,
    R2 is C+N,
    lcm(M, N, R2, R).

%lcmList(L-list, R-result)
%lcmList(i, o)
lcmList([E], E).
lcmList([H|T], R):-
    lcmList(T, R1),
    lcm(H, R1, 0, R).


