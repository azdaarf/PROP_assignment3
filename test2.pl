% parse([a,=,1,*,2,+,'(',3,-,4,')','/',5,';'],[]).
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
	
expr(In,Out):-
	term(In,Ys),
	[A|As] = Ys,
	expr_sign(A),
	expr(As, Out).
	
expr(Xs, Ys):- 
	term(Xs, Ys).

term(In,Out):-
	factor(In, Ys),
	[A|As] = Ys,
	term_sign(A),
	term(As, Out).
	
term(Xs,Ys):-
	factor(Xs, Ys).
	
factor(Xs, Ys):-
	[Z|Zs] = Xs,
	integer(Z),
	%int(Z),
	Ys = Zs.

factor(In, Out):-
	[A|As] = In,
	left_paren(A),
	expr(As, Ys),
	[B|Bs] = Ys,
	right_paren(B),
	Out = Bs.
	
semicolon(Xs, Ys):-
	[Z|Zs] = Xs,
	semicolon_sign(Z),
	Ys = Zs.
	
expr_sign('+').
expr_sign('-').
term_sign('*').
term_sign('/').
left_paren('(').
right_paren(')').
semicolon_sign(';').	
assign_sign('=').

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