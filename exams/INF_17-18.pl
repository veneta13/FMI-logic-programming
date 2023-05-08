%%%%%%%%%%%%%%%%%%%%%%%%% TASK 1 %%%%%%%%%%%%%%%%%%%%%%%%%

append_([], L, L).
append_([H|T], L, [H|R]) :- append_(T, L, R).

member_(X, L) :- append_(_, [X|_], L).

smallest_element([X], X).
smallest_element([H|T], H) :- smallest_element(T, M), H =< M.
smallest_element([H|T], M) :- smallest_element(T, M), M < H.

biggest_element([X], X).
biggest_element([H|T], H) :- biggest_element(T, M), H >= M.
biggest_element([H|T], M) :- biggest_element(T, M), M > H.

list_biggest_elements([], []).
list_biggest_elements([H|T], [B|R]) :-
    list_biggest_elements(T, R),
    biggest_element(H, B).

list_smallest_elements([], []).
list_smallest_elements([H|T], [B|R]) :-
    list_smallest_elements(T, R),
    smallest_element(H, B).

biggest_smallest(L, E) :-
    list_smallest_elements(L, SE),
    biggest_element(SE, E).

smallest_biggest(L, E) :-
    list_biggest_elements(L, BE),
    smallest_element(BE, E).

get_balance(L, R) :-
    smallest_biggest(L, B),
    biggest_smallest(L, S),
    R is B - S.

balance_in_all(L) :-
    get_balance(L, B),
    not((
        member_(SL, L),
        not(member_(B, SL))
    )).


%%%%%%%%%%%%%%%%%%%%%%%%% TASK 2 %%%%%%%%%%%%%%%%%%%%%%%%%

boolean_value(0).
boolean_value(1).

count_eq_pos([X], [X], 1).
count_eq_pos([X], [Y], 0) :- X \= Y.
count_eq_pos([X|TX], [Y|TY], C) :- X \= Y, count_eq_pos(TX, TY, C).
count_eq_pos([X|TX], [X|TY], C) :- count_eq_pos(TX, TY, C1), C is C1 + 1.

sum_eq_pos(Y, [X], C) :- count_eq_pos(Y, X, C).
sum_eq_pos(Y, [H|T], C) :- 
    count_eq_pos(Y, H, C1),
    sum_eq_pos(Y, T, C2),
    C is C1 + C2.

peripheral_list(L, X, C) :-
    member_(X, L),
    sum_eq_pos(X, L, C),
    not((
        member_(Y, L),
        sum_eq_pos(L, Y, CY),
        CY > C
    )).

boolean_list(0, []).
boolean_list(C, [H|T]) :- 
    C > 0,
    C1 is C - 1,
    boolean_value(H),
    boolean_list(C1, T).
