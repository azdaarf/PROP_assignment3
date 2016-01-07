%parse(Tree ,Program, []):- parser(Program, []).

parser([]) --> [].
parser(Tree) --> assign(Tree).

assign(assignment(ident(X), '=', Exp)) --> id(X), [=], expression(Exp), [;].

id(X) --> [X], { atom(X) }.

expression(expression(T)) --> term(T).
expression(expression(T, O, E)) --> term(T), (add_op(O); sub_op(O)), expression(E).	

term(term(F)) --> factor(F).
term(term(O, T)) --> (mul_op(O); div_op(O)), term(T).

factor([factor, int(N)]) --> num(N).
factor(factor( '(' , E, ')' )) --> ['('], expression(E), [')'].



/*add_op(Op) --> [Op], { ['+'] }.
sub_op(Op) --> [Op], { ['-'] }.
div_op(Op) --> [Op], { ['/'] }.
mul_op(Op) --> [Op], { ['*', '/'] }.*/

sub_op(Xs, Ys):-
	[Z|Zs] = Xs,
	sub_op_sign(Z),
	Ys = Zs.
	
sub_op_sign(';').	
	
add_op(Xs, Ys):-
	[Z|Zs] = Xs,
	add_op_sign(Z),
	Ys = Zs.
	
add_op_sign('+').
	
div_op(Xs, Ys):-
	[Z|Zs] = Xs,
	div_op_sign(Z),
	Ys = Zs.
	
div_op_sign('/').
	
mul_op(Xs, Ys):-
	[Z|Zs] = Xs,
	mul_op_sign(Z),
	Ys = Zs.
	
mul_op_sign('*').

num(N) --> [N], { number(N) }.

% [a, '=', 1, '*', 2, '+', '(', 3, '-', 4, ')', '/', 5, ';'] [O],