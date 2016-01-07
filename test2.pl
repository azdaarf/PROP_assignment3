parse(Program, Es):-
	id(Program, Bs),
	assign(Bs, Cs),
	expr(Cs, Ds),
	semicolon(Ds, Es).
	
id(Xs, Ys):- 
	[Z|Zs] = Xs,
	atomic(Z),
	%id_sign(Z),
	Ys = Zs.
	
assign(Xs, Ys):- 
	[Z|Zs] = Xs,
	assign_sign(Z),
	Ys = Zs.
	
expr(Xs, Ys):- 
	term(Xs, Ys).
	
term(Xs,Ys):-
	factor(Xs, Ys).
	
factor(Xs, Ys):-
	[Z|Zs] = Xs,
	%integer(Z),
	int(Z),
	Ys = Zs.
	
semicolon(Xs, Ys):-
	[Z|Zs] = Xs,
	semicolon_sign(Z),
	Ys = Zs.
	
int(1).
int(2).
int(3).
int(4).
int(5).
int(6).
id_sign(a).
id_sign(b).
id_sign(c).
id_sign(d).
id_sign(e).
semicolon_sign(';').	
assign_sign('=').
	

	

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