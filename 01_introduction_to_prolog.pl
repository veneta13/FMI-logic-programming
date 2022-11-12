% define the natural numbers
% think of c as 0
nat(c).
nat(f(X)):-nat(X).


% define sum of natural numbers
sum(c, N, N).
sum(f(M), N, f(K)):-sum(M, N, K).


% define append function on lists
app([], X, X).
app([H|T], Y, [H, Z]):-app(T, Y, Z).
