%Menor devuelve A o B según en M según Comp

menor(A,B,Comp,M):-
	C=..[Comp,A,B],
	call(C),!, % Si se cumple call(C) ya no se comprueban más opciones
	M=A.
menor(A,B,_,B):-
	A\=B.%En el caso de que no se cumpla call(C) menor devuelve B

% menor_o_igual comprueba si X es menor o igual a Y
% menor_o_igual(X,Y)

menor_o_igual(X,_):-
	var(X). %En el caso de que A o B sea una variable libre => A es igual a B
menor_o_igual(_,Y):-
	var(Y).
menor_o_igual(X,X).
menor_o_igual(X,Y):-
	functor(X,N1,_),
	functor(Y,N2,_),
	menor(N1,N2,@<,X).
menor_o_igual(X,Y):-
	compound(X),
	compound(Y),
	functor(X,N,A1),
	functor(Y,N,A2),
	menor(A1,A2,<,A1).
menor_o_igual(X,Y):-
	compound(X),
	compound(Y),
	functor(X,N,A),
	functor(Y,N,A),
	recArg(X,Y,A).
recArg(_,_,0).
recArg(X,Y,A):-
	arg(A,X,C1),
	arg(A,Y,C2),
	A1 is A -1,
	menor_o_igual(C1,C2),
	recArg(X,Y,A1).
	
	