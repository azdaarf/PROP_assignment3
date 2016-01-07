sentence(Xs, Ys):-
	nounphrase(Xs,Zs),
	verbphrase(Zs,Ys).

verbphrase(Xs, Ys):- 
	[Z|Zs] = Xs,
	verb(Z),
	nounphrase(Zs, Ys).

nounphrase(Xs, Ys):-
	[Z|Zs] = Xs,
	determiner(Z),
	[N|Ns] = Zs,
	noun(N),
	Ys = Ns.
	
determiner(a).

noun(cat).
noun(mouse).

verb(scares).
verb(hates).