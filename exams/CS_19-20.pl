num_to_list(0, [0]).
num_to_list(N, [D|L]) :-
    N > 0,
    D is N mod 8,
    NR is N div 8,
    num_to_list(NR, L).

get_by_index_help(_, _, [], []).
get_by_index_help(N, N, [H|T], H).
get_by_index_help(N, C, [H|T], R) :-
    N =\= C,
    C1 is C + 1,
    get_by_index_help(N, C1, T, R).

get_by_index(I, L, R) :- get_by_index_help(I, 0, L, R).

%%%%%%%%%%%%%%%%%%%%%%%%% TASK 1 %%%%%%%%%%%%%%%%%%%%%%%%%

check_num_tree_1(N) :-
    num_to_list(N, NL),
    not((
        get_by_index(U, NL, AU),
        get_by_index(V, NL, AV),
        V =:= U div 8,
        AU mod 7 =\= 0,
        (AV - AU - 1) mod 6 =\= 0
    )).

check_num_tree_2(N) :-
    num_to_list(N, NL),
    not((
        get_by_index(U, NL, AU),
        get_by_index(V, NL, AV),
        V =:= U div 8,
        AU mod 6 =\= 0,
        (AV - AU - 1) mod 7 =\= 0
    )).

byteTreeNum(N) :- check_num_tree_1(N); check_num_tree_2(N).

%%%%%%%%%%%%%%%%%%%%%%%%% TASK 2 %%%%%%%%%%%%%%%%%%%%%%%%%
%%%%% The task is similar, but the number of elements in the
%%%%% sequence is desregarded.

append_([], L, L).
append_([H|T], L, [H|R]) :- append(T, L, R).

member_(X, L) :- append(_, [X|_], L).

remove_(_, [], []).
remove_(H, [H|T], R) :- remove_(H, T, R).
remove_(E, [H|T], [H|R]) :- E \= H,  remove_(E, T, R).

remove_first(_, [], []).
remove_first(H, [H|T], T).
remove_first(E, [H|T], R) :- remove_first(E, T, R).

permutation_([], []).
permutation_([H|T], L) :-
    permutation_(T, TP),
    append_(TP1, TP2, TP),
    append_(TP1, [H|TP2], L).

is_anagram(L1, L2) :- permutation_(L1, L2).

length_([], 0).
length_([H|T], C) :- length_(T, C1), C is C1 + 1.

count_X_anagrams(_, [], 0).
count_X_anagrams(X, [H|T], C) :-
    not(is_anagram(X, H)),
    count_X_anagrams(X, T, C).
count_X_anagrams(X, [H|T], C) :-
    is_anagram(X, H),
    count_X_anagrams(X, T, C1),
    C is C1 + 1.

between_(A, B, A) :- A =< B.
between_(A, B, X) :- A < B, A1 is A + 1, between_(A1, B, X). 

list_counts([], []).
list_counts([X|T], [C|R]) :-
    list_counts(T, R),
    count_X_anagrams(X, T, C1),
    C is C1 + 1.

max_element([H], H).
max_element([H|T], H) :- max_element(T, M), M < H.
max_element([H|T], M) :- max_element(T, M), M >= H.

maxAnagrams1(L, M) :- 
    list_counts(L, C),
    max_element(C, M).

maxAnagrams1(L, M) :- 
    list_counts(L, C),
    max_element(C, M1),
    M is M1 - 2. 



