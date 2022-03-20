%add2N(L-list, E-element to add, integer, P-position, integer, I-index,
%integer, R-resulted list)
%add2N(i, i, i, i, o)
add2N([], _, _, _, []).
add2N([H|T], E, P, I, [H, E|R]):-
    P =:= I,
    NP is P*2,
    NI is I + 1,
    add2N(T, E, NP, NI, R).
add2N([H|T], E, P, I, [H|R]):-
    P =\= I,
    NI is I+1,
    add2N(T, E, P, NI, R).


%add2NMain(L-list, E-element to add, integer, R-resulted list)
%add2NMain(i, i, o)
add2NMain(L, E, R):-
    add2N(L, E, 1, 1, R).
