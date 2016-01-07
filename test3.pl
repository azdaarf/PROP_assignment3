parse(-ParseTree, +Program, []):-
    parser(+Program, []).

parser --> [].
parser --> assign.

assign(assignment(ident(X), '=', E)) --> id(X), [=], expression(E), [;].

expression(expression(T)) --> term(T).
expression(expression(T, O, E)) --> term(T), (add_op(O); sub_op(O)), expression(E).	

term(term(F)) --> factor(F).
term(term(O, T)) --> (mul_op(O); div_op(O)), term(T).

factor(factor(I)) --> number(I).
factor(factor('(', E, ')') --> [(], expression(E), [)].

id(Xs, Ys):- 
	[Z|Zs] = Xs,
	atomic(Z),	
	Ys = Zs.

add_op --> [x].
sub_op --> [-].
mul_op --> [*].
div_op --> [/].
