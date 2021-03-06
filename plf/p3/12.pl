%candidate(N-integer(index), M-integer(length), L-list, E-integer(0, 1
% or -1))
%flow(i i o i)
candidate(1,_,[0],E):-
	!,
	abs(0-E)>0.
candidate(N, M, [0|R], _):-
	N = M,
	!,
	N1 is N-1,
	candidate(N1, M, R, 0).
candidate(N, M, [1|R], E):-
	abs(1-E)>0,
	N1 is N-1,
	candidate(N1, M, R, 1).
candidate(N, M, [0|R], E):-
	abs(0-E)>0,
	N1 is N-1,
	candidate(N1, M, R, 0).
candidate(N, M, [-1|R], E):-
	abs(-1-E)>0,
	N1 is N-1,
	candidate(N1, M, R, -1).

%onesol(N-integer, L-list)
%flow(i o)
onesol(0,[]).
onesol(N,L):-
	N1 is N*2+1,
	candidate(N1, N1, L, 0).

%allsol(N-integer, L-list)
%flow(i o)
allsol(N, L):-
	findall(M, onesol(N, M), L).
