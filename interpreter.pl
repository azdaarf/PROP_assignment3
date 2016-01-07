/***
A skeleton for Assignment 3 on PROP HT2015 at DSV/SU.
Peter Idestam-Almquist, 2015-12-09.
***/

:- [tokenizer].

/***
Example call of the top level predicate run/2:
?- run('program1.txt','myparsetree1.txt').
***/

run(InputFile,OutputFile):-
	tokenize(InputFile,Program),
	parse(ParseTree,Program,[]),
	%parse(Program,[]),
	%evaluate(ParseTree,[],VariablesOut), 
	output_result(OutputFile,ParseTree,VariablesOut).

parse([]) --> [].
parse(Tree) --> assignment(Tree).
	
<<<<<<< HEAD
=======
assignment(Program, Out):-
	id(Program, Bs),
	assign(Bs, Cs),
	expr(Cs, Ds),
	semicolon(Ds, Out).
	
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
	
expr(In,Out):-
	term(In,Ys),
	[A|As] = Ys,
	expr_sign(A),
	expr(As, Out).

term(Xs,Ys):-
	factor(Xs, Ys).
	
term(In,Out):-
	factor(In, Ys),
	[A|As] = Ys,
	term_sign(A),
	term(As, Out).
	
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
	
>>>>>>> origin/master
output_result(OutputFile,ParseTree,Variables):- 
	open(OutputFile,write,OutputStream),
	write(OutputStream,'PARSE TREE:'), 
	nl(OutputStream), 
	writeln_term(OutputStream,0,ParseTree),
	nl(OutputStream), 
	write(OutputStream,'EVALUATION:'), 
	nl(OutputStream), 
	write_list(OutputStream,Variables), 
	close(OutputStream).
	
writeln_term(Stream,Tabs,int(X)):-
	write_tabs(Stream,Tabs), 
	writeln(Stream,int(X)).
writeln_term(Stream,Tabs,ident(X)):-
	write_tabs(Stream,Tabs), 
	writeln(Stream,ident(X)).
writeln_term(Stream,Tabs,Term):-
	functor(Term,_Functor,0), !,
	write_tabs(Stream,Tabs),
	writeln(Stream,Term).
writeln_term(Stream,Tabs1,Term):-
	functor(Term,Functor,Arity),
	write_tabs(Stream,Tabs1),
	writeln(Stream,Functor),
	Tabs2 is Tabs1 + 1,
	writeln_args(Stream,Tabs2,Term,1,Arity).
	
writeln_args(Stream,Tabs,Term,N,N):-
	arg(N,Term,Arg),
	writeln_term(Stream,Tabs,Arg).
writeln_args(Stream,Tabs,Term,N1,M):-
	arg(N1,Term,Arg),
	writeln_term(Stream,Tabs,Arg), 
	N2 is N1 + 1,
	writeln_args(Stream,Tabs,Term,N2,M).
	
write_tabs(_,0).
write_tabs(Stream,Num1):-
	write(Stream,'\t'),
	Num2 is Num1 - 1,
	write_tabs(Stream,Num2).

writeln(Stream,Term):-
	write(Stream,Term), 
	nl(Stream).
	
write_list(_Stream,[]). 
write_list(Stream,[Ident = Value|Vars]):-
	write(Stream,Ident),
	write(Stream,' = '),
	format(Stream,'~1f',Value), 
	nl(Stream), 
	write_list(Stream,Vars).
	
/***
parse(-ParseTree)-->
	TODO: Implement a definite clause grammar defining our programming language,
	and returning a parse tree.
***/

parse(parseTree) --> id, assign, expr, semicolon.
id --> [X], {atomic(X)}.
assign --> ['='].
expr --> term.
expr --> term, add_op, expr. 
expr --> term, sub_op, expr.
term --> factor.
term --> factor, mult_op, term.
term --> factor, div_op, term.
factor --> [X], {integer(X)}.
factor --> left_paren, expr, right_paren.

left_paren --> ['('].
right_paren --> [')'].
add_op --> ['+'].
sub_op --> ['-'].
div_op --> ['/'].
mult_op --> ['*'].
semicolon --> [';'].
	
/***
evaluate(+ParseTree,+VariablesIn,-VariablesOut):-
	TODO: Implement an evaluate predicate that evaluates a parse-tree and 
	returns the state of the program after evaluation as a list of variables and 
	their values.
***/

