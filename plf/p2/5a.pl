% insert(S:list, L:list, R:resulted list)
% insert(i, i, o)

insert([], L, L).
insert([H|T], L, [H|R]):-
    insert(T, L, R).

% subst(S:list, E:integer, L:list, R:resulted list)
% subst(i, i, i, o)

subst([], _, _, []).
subst([H|T], E, L, R):-
    H =:= E,
    insert(L, T, NR),
    subst(NR, E, L, R).
subst([H|T], E, L, [H|R]):-
    H =\= E,
    subst(T, E, L, R).
