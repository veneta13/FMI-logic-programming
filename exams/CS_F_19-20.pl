%%%%%%%%%%%%%%%%%%%%%%%%% TASK 1 %%%%%%%%%%%%%%%%%%%%%%%%%

between_(A, B, A) :- A =< B.
between_(A, B, X) :- A < B, A1 is A + 1, between_(A1, B, X).

length_([], 0).
length_([_|T], C) :- length_(T, C1), C is C1 + 1.

sum_([], 0).
sum_([H|T], S) :- sum_(T, ST), S is H + ST.

is_squared_(X) :- between_(0, X, X1), X1 * X1 =:= X.

is_cubic_(X) :- between_(0, X, X1), X1 * X1 * X1 =:= X.

squareList(L) :- 
    length_(L, LL), 
    is_squared_(LL),
    sum_(L, LS),
    is_squared_(LS).

cubeList(L) :-
    length_(L, LL),
    is_cubic_(LL),
    sum_(L, LS),
    is_cubic_(LS).
