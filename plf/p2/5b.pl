% insert2(S:list, L:list to add, R:resulted list)
% insert2(i, i, o)

insert2([], L, L).
insert2([H|T], L, [H|R]):-
    insert2(T, L, R).

% subst2(S:list, E:integer, L:list to add, R:resulted list)
% subst2(i, i, i, o)

subst2([], _, _, []).
subst2([H|T], E, L, R):-
    H =:= E,
    insert2(L, T, NR),
    subst2(NR, E, L, R).
subst2([H|T], E, L, [H|R]):-
    H =\= E,
    subst2(T, E, L, R).

% heterList(S:list, L:list to add, R:resulted list)
% heterList(i, i, o)
heterList([], _, []).
heterList([[H|HT]|T], L, [HR|R]):-
    subst2([H|HT], H, L, HR),
    heterList(T, L, R).
heterList([H|T], L, [H|R]):-
    number(H),
    heterList(T, L, R).
heterList([[]|T], L, R):-
    heterList(T, L, R).
