%%%%%%%%%%%%%%%%%%%%%%%%% TASK 1 %%%%%%%%%%%%%%%%%%%%%%%%%

append_([], L, L).
append_([H|T], L, [H|R]) :- append_(T, L, R).

member_(X, L) :- append_(_, [X|_], L).

subset_(S1, S2) :- not((member_(X, S1), not(member_(X, S2)))).

union_element_(S1, S2, X) :- member_(X, S1), member_(X, S2). 

nested_sets_(S1, S2) :- subset_(S1, S2); subset_(S2, S1).

list_good_condition_(L1, L2) :- not(union_element_(L1, L2, X)); nested_sets_(L1, L2).

is_laminar(L) :- not((member_(X, L), member_(Y, L), not(list_good_condition_(X, Y)))).
