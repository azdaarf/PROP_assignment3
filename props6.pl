
union([],Ys, Ys).

union([X|Xs], Ys, Ws):-
	\+member(X,Ys),
	union(Xs,Ys,Zs),
	Ws = [X|Zs].
	
union([X|Xs], Ys, Ws):-
	member(X,Ys),
	union(Xs,Ys,Zs),
	Ws=Zs.
	
	

intersection([],Ys,[]).

intersection([X|Xs], Ys, Ws):-
	\+member(X,Ys),
	intersection(Xs,Ys,Zs),
	Ws = Zs.
	
intersection([X|Xs], Ys, Ws):-
	member(X,Ys),
	intersection(Xs,Ys,Zs),
	Ws = [X|Zs].
	

	
difference([],Ys,[]).

difference([X|Xs], Ys, Ws):-
	\+member(X,Ys),
	difference(Xs,Ys,Zs),
	Ws = [X|Zs].
	
difference([X|Xs], Ys, Ws):-
	\+member(X,Ys),
	difference(Xs,Ys,Zs),
	Ws=Zs.

	
	
subset([], Ys).

subset([X|Xs], Ys):-
	member(X,Ys),
	subset(Xs,Ys).
	
	

equal([], []).

equal(Xs, Ys):-
	difference(Xs,Ys,[]),
	difference(Ys,Xs[]).
	
	
	
cartesian_product(Xs, Ys, Zs):-
	findall((X,Y), (member(X,Xs),member(Y,Ys)),Zs).