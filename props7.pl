/**
* sentence(nounphrase, verbphrase).
*
* sentence(Xs,Ys):- nounphrase(Xs, Ys), verbphrase(Ys, Zs).
*
* Input blir meningen, output blir det som "blir över".
* Nounphrase tar alltså in hela meningen, skickar ut det som
* blir över till verbphrase. Om det inte finns något kvar
* efter verbphrase (som det borde vara) så skickas en tom
* lista ut.
*
*/ 

/**
* verbphrase(verb, nounphrase).
*/
verbphrase([X|Xs], Ys):-
	verb(X),
	nounphrase(Xs, Ys).

/**
* nounphrase(determiner, noun).
*/
nounphrase([X|Xs],Ys):-
	determiner(X), 
	noun(Xs)
	Ys = [].




determiner(a).

noun(cat).
noun(mouse).

verb(scares).
verb(hates).