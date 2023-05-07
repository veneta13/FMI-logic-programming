%%%%%%%%%%%%%%%%%%%%%%%%% TASK 1 %%%%%%%%%%%%%%%%%%%%%%%%%%%%5

append_([], L, L).
append_([H|T], L, [H|R]) :- append_(T, L, R).

member_(X, L) :- append_(_, [X|_], L).

biggest_element(X, [X]).
biggest_element(H, [H|T]) :- biggest_element(X, T), H >= X.
biggest_element(X, [H|T]) :- biggest_element(X, T), X > H.

remove_first(_, [], []).
remove_first(H, [H|T], T).
remove_first(X, [H|T], [H|R]) :- X \= H, remove_first(X, T, R).

remove_biggest(L, R) :- 
    biggest_element(B, L),
    remove_first(B, L, R).

remove_fifth(_, [_], []).
remove_fifth(5, [_|T], T).
remove_fifth(C, [H|T], R) :- 
    C \= 5,
    C1 is C + 1,
    append_(T, [H], TH),
    remove_fifth(C1, TH, R).

erase(_, [K], K).
erase(1, L, K) :-
    remove_biggest(L, R),
    erase(2, R, K).
erase(C, [H|T], K) :-
    C \= 1,
    C1 is C + 1,
    remove_fifth(1, [H|T], R),
    erase(C1, R, K).

ivan_last_erased(L, K) :- erase(1, L, K).