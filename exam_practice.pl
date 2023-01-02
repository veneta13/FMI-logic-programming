:- use_module(library(clpfd)).

% find if X is in list
member_1(X, [H|T]) :- X #= H; member_1(X, T).

member_2(X, [X|T]).
member_2(X, [H|T]) :- X  #\= H, member_2(X, T).

% concatenate lists
concat_lists([], L, L).
concat_lists([H|T], L, [H|T1]) :- concat_lists(T, L, T1).

% check if X is the last element
check_last(X, [X]).
check_last(X, [_|T]) :- check_last(X, T).

% remove last element of list
remove_last([], []).
remove_last([X], []).
remove_last([H|T], [H|R]) :- remove_last(T, R).

% remove the first element of the list equal to X
remove_first_X(X, [X|T], T).
remove_first_X(X, [H|T], [H|T1]) :- X #\= H, remove_first_X(X, T, T1).

% remove element from list
remove_element(_, [], []).
remove_element(X, [X|T], T1) :- remove_element(X, T, T1).
remove_element(X, [H|T], [H|T1]) :- X #\= H, remove_element(X, T, T1).

% permutate a list
list_permutation([], []).
list_permutation(P, [H|T]) :- remove_firsts(H, P, R), list_permutation(T, R).

% reverse a list
list_reverse([], []).
list_reverse(L, [H|T]) :- check_last(H, L), remove_last(L, L1), list_reverse(L1, T).

% sort list
list_sorted([]).
list_sorted([_]).
list_sorted([A, B|T]) :- A #=< B, list_sorted([B|T]).

% get/check subsequence of list
list_subsequence([], []).
list_subsequence([H|T1], [H|T2]) :- list_subsequence(T1, T2).
list_subsequence([_|T], L) :- list_subsequence(T, L).

% get cartesian product of lists
list_cartesian_product([], []).
list_cartesian_product([H1|T1], [H2|T2]) :- member_1(H2, H1), list_cartesian_product(T1, T2).

% get element by index
get_by_index([E|_], 0, E).
get_by_index([H|T], I, E) :- I #\= 0, I1 #= I - 1, get_by_index(T, I1, E).

% get the smaller one of two elements
smaller_2(A, B, A) :- A #=< B.
smaller_2(A, B, B) :- A #> B.

% get the minimal element of list
list_minimal([E], E).
list_minimal([H|T], E) :- list_minimal(T, MT), smaller_2(MT, H, E).

% sort with selection sort
list_selection_sort([], []).
list_selection_sort(L, [H|T]) :- 
    list_minimal(L, H), 
    remove_first_X(H, L, LR),
    list_selection_sort(LR, T).

% merge lists
list_merge([], L2, L2).
list_merge(L1, [], L1).
list_merge([H1|T1], [H2|T2], [H1|TR]) :- H1 #=< H2, list_merge(T1, [H2|T2], TR).
list_merge([H1|T1], [H2|T2], [H2|TR]) :- H1 #> H2, list_merge([H1|T1], T2, TR).

% split list
list_split([], [], []).
list_split([A], [A], []).
list_split([A, B|T], [A|T1], [B|T2]) :- list_split(T, T1, T2).

% sort with merge sort
list_merge_sort([], []).
list_merge_sort([A], [A]).
list_merge_sort([A, B|T], L) :- 
    list_split([A, B|T], L1, L2), 
    list_merge_sort(L1, L1M), 
    list_merge_sort(L2, L2M),
    list_merge(L1M, L2M, L).
