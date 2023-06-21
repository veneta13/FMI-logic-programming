%%%%%%%%%%%%%%%%%%%%%%%%% TASK 2 %%%%%%%%%%%%%%%%%%%%%%%%%
inB(1).
inB(N) :-
    N > 0,
    N1 is N - 2,
    N1 > 0, 
    N2 is N1 // 3,
    N2 > 0,
    N1 =:= N2 * 3,
    inB(N2).

sumBs(N) :-
    between(1, N, A),
    B is N - A,
    inB(A),
    inB(B).
