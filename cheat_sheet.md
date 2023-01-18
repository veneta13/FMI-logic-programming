# Cheat Sheet

## Expressions

## Built-in predicates

[TutorialsPoint](https://www.tutorialspoint.com/prolog/prolog_built_in_predicates.htm#)

- **between**
	```
	between(X,Y,X) :- X=<Y.
	between(X,Y,Z) :- X<Y,X1 is X+1,between(X1,Y,Z).
	```
 
 ### Quantifiers
 
 - $\exists X \in A, \ \exists Y \in B: p(X, Y)$
 
 	**Prolog**:
 	```
	p1(A, B) :- member(X, A), member(Y, B), p(X, Y).
	```

-  $\exists X \in A, \ \forall Y \in B: p(X, Y)$
	
	**Prolog**:
	```
	p2(A, B) :- member(X, A), not((member(Y, B), not(p(X, Y)))).
	```
	
- $\forall X \in A, \ \exists Y \in B: p(X, Y)$
	
	**Prolog**:
	```
	p3(A, B) :- not(member(X, A), not((member(Y, B), p(X, Y)))).
	```

- $\forall X \in A, \ \forall Y \in B: p(X, Y)$

	**Prolog**:
	```
	p4(A, B) :- not((member(X, A), member(Y, B), not(p(X, Y)))).
	```
