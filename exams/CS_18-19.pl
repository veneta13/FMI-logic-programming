% append lists
append_([], L, L).
append_([H|T], L, [H|R]) :- append_(T, L, R).

% check if X in L
member_(X, L) :- append_(_, [X|_], L).

% find the length of list
list_length(0, []).
list_length(N, [H|T]) :- list_length(N1, T), N is N1 + 1. 

% subsequence
subsequence_([], []).
subsequence_([H|T], [H|TR]) :- subsequence_(T, TR).
subsequence_([_|T], R) :- subsequence_(T, R).

% permutation
permutation_([], []).
permutation_([H|T], P) :- 
    permutation_(T,TP),
    append_(TP1, TP2, TP),
    append_(TP1, [H|TP2], P).

% append element to list of vertices if not in it already
append_vertice(A, VL, VL) :- member_(A, VL).
append_vertice(A, VL, VR) :- not(member_(A, VL)), append_([A], VL, VR).

% extract vertices from graph representation
extract_vertices([], []).
extract_vertices([[V1, V2]|T], V) :- 
    extract_vertices(T, TV),
    append_vertice(V1, TV, TTV),
    append_vertice(V2, TTV, V).

% get subset of set
subset_([], []).
subset_([H|L], [H|SS]) :- subset_(L, SS), not(member_(H,SS)).
subset_([H|L], SS) :- subset_(L, SS), member_(H,SS).

% check if clique
clique(V, E) :-
    not((
        member(V1, V),
        member(V2, V),
        V1 \= V2,
        not((
            member_([V1, V2], E);
            member_([V2, V1], E)
        ))
    )).

% check if not clique
anticlique(V, E) :-
    not((
        member(V1, V),
        member(V2, V),
        V1 \= V2,
        member_([V1, V2], E);
        member_([V2, V1], E)
    )).

%%%%%%%%%%%%%%%%%%%%%%%%% TASK 1.1 %%%%%%%%%%%%%%%%%%%%%%%%%

cl(K, X) :- 
    K > 2,
    extract_vertices(X, V),
    subset_(V, VSS),
    list_length(VSS, K),
    clique(VSS, X).

%%%%%%%%%%%%%%%%%%%%%%%%% TASK 1.2 %%%%%%%%%%%%%%%%%%%%%%%%%
acl(K, X) :- 
    K > 2,
    extract_vertices(X, V),
    subset_(V, VSS),
    list_length(VSS, K),
    clique(VSS, X).

%%%%%%%%%%%%%%%%%%%%%%%%% TASK 2.1 %%%%%%%%%%%%%%%%%%%%%%%%%

insert_farey([], _, []).
insert_farey([X], _, [X]).
insert_farey([[A, B], [C, D]|T], N, [[A, B], [N1, N2]|F]) :-
    insert_farey([[C, D]|T], N, F),
    B + D =:= N,
    N1 is A + C,
    N2 is B + D.
insert_farey([[A, B], [C, D]|T], N, [[A, B]|F]) :-
    insert_farey([[C, D]|T], N, F),
    B + D =\= N.

farey_helper([[0, 1], [1 , 1]], 1).
farey_helper(F, N) :- 
    farey_helper(F1, N1),
    N is N1 + 1,
    insert_farey(F1, N, F).

farey(F) :- farey_helper(F, _).

%%%%%%%%%%%%%%%%%%%%%%%%% TASK 2.2 %%%%%%%%%%%%%%%%%%%%%%%%%

raney([[1, 1]]).
raney(L) :- raney(PL), raney_add_level(PL, L).

raney_add_level([], []).
raney_add_level([[A, B]|T], [[A, AB], [AB, B]|LT]) :-
    raney_add_level(T, LT),
    AB is A + B.
