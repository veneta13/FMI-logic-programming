%%%%%%%%%%%%%%%%%%%%%%%%% TASK 1 %%%%%%%%%%%%%%%%%%%%%%%%%

get_between_(L, E, B, E, []) :- B =< E.
get_between_([H|T], C, B, E, R) :-
    B =< E,
    C =< B,
    C1 is C + 1,
    get_between_(T, C1, B, E, R).
get_between_([H|T], C, B, E, [H|R]) :-
    B =< E,
    C > B,
    C1 is C + 1,
    get_between_(T, C1, B, E, R).

filter_([], _, _, []).
filter_([H|T], I, N, [H|R]) :- 
    I mod N =:= 0,
    I1 is I + 1,
    filter_(T, I1, N, R).
filter_([H|T], I, N, R) :- 
    I mod N =\= 0,
    I1 is I + 1,
    filter_(T, I1, N, R).

slice(L, Begin, End, N, S) :- 
    get_between_(L, 0, Begin, End, BTW),
    filter_(BTW, 0, N, S).
