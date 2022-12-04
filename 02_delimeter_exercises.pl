% find the greatest commom delimeter of A and B
gcd(A, 0, A, 1, 0).
gcd(A, B, G, U, V):- A >= B, B > 0, A1 is A-B, gcd(A1, B, G, U, V1), V is V1 - U.
gcd(A, B, G, U, V):- A < B, gcd(B, A, G, V, U).


% check if list contains coprime elements
non_coprime_list([A]):- A =\= 1.
non_coprime_list([A, B|T]):- gcd(A, B, G, _, _), non_coprime_list([G|T]).


% generate the subsequences of a list
subseq([], []).
subseq([H|T], [H|L]):- subseq(T, L).
subseq([H|T], L):- subseq(T, L).
