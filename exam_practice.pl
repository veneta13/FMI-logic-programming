:- use_module(library(clpfd)).

% find if X is in list
member_1(X, L) :- concat_lists(_, [X|_], L).

member_2(X, [X|_]).
member_2(X, [H|T]) :- X  #\= H, member_2(X, T).

% concatenate lists
concat_lists([], L, L).
concat_lists([H|T], L, [H|T1]) :- concat_lists(T, L, T1).

% prefix
list_prefix(X ,L) :- concat_lists(X, _, L).

% suffix
list_suffix(X, L) :- concat_lists(_, X, L).

% sublist of a given list
list_sublist(S, [H|T]) :- 
    list_prefix(S, [H|T]);
    list_suffix(S, [H|T]);
    list_sublist(S, T).

% check if X is the last element
check_last(X, [X]).
check_last(X, [_|T]) :- check_last(X, T).

% remove last element of list
remove_last([], []).
remove_last([_], []).
remove_last([H|T], [H|R]) :- T \= [], remove_last(T, R).

% remove the first element of the list equal to X
remove_first_X(X, [X|T], T).
remove_first_X(X, [H|T], [H|T1]) :- X #\= H, remove_first_X(X, T, T1).

% remove element from list
remove_element(_, [], []).
remove_element(X, [X|T], T1) :- remove_element(X, T, T1).
remove_element(X, [H|T], [H|T1]) :- X #\= H, remove_element(X, T, T1).

% permutate a list
list_permutation([], []).
list_permutation(P, [H|T]) :- 
    list_permutation(PT, T),
    concat_lists(PT1, PT2, PT),
    concat_lists(PT1, [H|PT2], P).

% reverse a list
list_reverse([], []).
list_reverse(L, [H|T]) :- check_last(H, L), remove_last(L, L1), list_reverse(L1, T).

% find even elements
get_even(L, R) :- findall(X, (member(X, L), X mod 2 =:= 0), R).

% find odd elements
get_odd(L, R) :- findall(X, (member(X, L), X mod 2 =:= 1), R).

% check if list is sorted
list_sorted([]).
list_sorted([_]).
list_sorted([A, B|T]) :- A #=< B, list_sorted([B|T]).

% get/check subsequence of list
list_subsequence([], []).
list_subsequence([H|T1], [H|T2]) :- list_subsequence(T1, T2).
list_subsequence([_|T], L) :- list_subsequence(T, L).

% get cartesian product of lists
list_cartesian_product([], []).
list_cartesian_product([L1|T1], [X|T2]) :- 
    member_1(X, L1),
    list_cartesian_product(T1, T2).

% get element by index
get_by_index([E|_], 0, E).
get_by_index([_|T], I, E) :- I #\= 0, I1 #= I - 1, get_by_index(T, I1, E).

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

% partition by pivot
list_partition(_, [], [], []).
list_partition(P, [H|R], [H|S], L) :- P #>= H, list_partition(P, R, S, L).
list_partition(P, [H|R], S, [H|L]) :- P #< H, list_partition(P, R, S, L).

% sort with quicksort
list_quicksort([], []).
list_quicksort([H|T], L) :- 
    list_partition(H, T, LS, LL),
    list_quicksort(LS, SLS),
    list_quicksort(LL, SLL),
    concat_lists(SLS, [H|SLL], L). 

% check/get element in union
elem_union(X, A, B) :- member_1(X, A); member_1(X, B).

% check/get element in intersection
elem_intersection(X, A, B) :- member_1(X, A), member_1(X, B).

% check/get element in differenence
elem_difference(X, A, B) :- member_1(X, A), not(member_1(X, B)).

% check if A is subset of B
is_subset(A, B) :- not((member_1(X, A), not(member_1(X, B)))).

% check if A is equal to B
equal_set(A, B) :- is_subset(A, B), is_subset(B, A).

% check if lists are equal
list_equal([], []).
list_equal([H|T1], [H|T2]) :- list_equal(T1, T2).

% get elements of list of lists
elem_list_of_lists([H|T], E) :- list_equal(E, H); elem_list_of_lists(T, E).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% list to set
list_to_set([], []).
list_to_set([H|T], S) :- list_to_set(T, S), member_1(H, S).
list_to_set([H|T], [H|S]) :- list_to_set(T, S), not(member_1(H, S)).

% extract vertices of edge list
extract_vertices([], []).
extract_vertices([H|T], L) :-
    extract_vertices(T, PV),
    concat_lists(H, PV, LL),
    list_to_set(LL, L).

% check if something is not path
% for some vertices U and V in the path, an edge between them does not exist
is_not_path(E, P) :- 
    concat_lists(_, [U, V|_], P),
    not((
        member_1([U, V], E);
        member_1([V, U], E)
    )).

% check if something is path
is_path(E, P) :- not(is_not_path(E, P)).

% check if all vertices are not in path
all_vertices_not_in_path(E, P) :- 
    extract_vertices(E, VL),
    member_1(X, VL),
    not(member(X, P)).

% check if all vertices are in path
all_vertices_in_path(E, P) :- not(all_vertices_not_in_path(E, P)).

% check if hamiltonian path
hamiltonian_path(E, P) :-
    is_path(E, P),
    extract_vertices(E, V),
    list_permutation(P, V).

% get all hamiltonian paths in graph
all_hamiltonian(E, VP) :-
    extract_vertices(E, V),
    list_permutation(VP, V),
    hamiltonian_path(E, VP).
    

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% count elements of list
count_elements([], 0).
count_elements([_|T], C) :- count_elements(T, C1), C is C1 + 1.

% get/check the numbers between A and B
between_1(A, B, A) :- A =< B.
between_1(A, B, X) :- A < B, A1 is A + 1, between_1(A1, B, X).

% common denominator of X and Y
common_denom(X, Y, D) :- 
    between_1(1, X, D),
    D =< Y,
    X mod D =:= 0,
    Y mod D =:= 0.

% greatest common denominator of X and Y
greatest_common_denom(X, Y, D) :- 
    common_denom(X, Y, D),
    not((
        common_denom(X, Y, A),
        A > D)
    ).

% get/check Fibonacci sequence member
fibonacci_help(0, 1).
fibonacci_help(F1, F2) :- fibonacci_help(F0, F2), F2 is F1 + F0.

fibonacci_sequence(X) :- fibonacci_help(X, _).

% check if a number is prime
check_prime(X) :- 
    XB is X // 2, 
    not((between_1(2, XB, N), X mod N =:= 0)), 
    X > 1. 

% define natural numbers
nat(0).
nat(X) :- nat(X1), X is X1 + 1.

% generate prime numbers
generate_prime(X) :- nat(X), check_prime(X).

% generate pairs
pair(X, Y) :- nat(N), between_1(0, N, X), Y is N - X.

% generate triples
triples(X, Y, Z) :- 
    nat(N), 
    between(0, N, X), 
    N1 is N - X,
    between(0, N1, Y), 
    Z is N1 - Y.
