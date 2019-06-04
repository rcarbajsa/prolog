%Menor devuelve A o B según en M según Comp

menor(A,B,Comp,M):-
	C=..[Comp,A,B],
	call(C),!, % Si se cumple call(C) ya no se comprueban más opciones
	M=A.
menor(_,B,_,B):-
	A\=B.
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
	N1 @< N2.
menor_o_igual(X,Y):-
	compound(X),
	compound(Y),
	functor(X,N,A1),
	functor(Y,N,A2),
	A1 < A2.
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
	
lista_hojas(L,H):-
	findall(tree(X,void,void),(member(X,L)),H).

hojas_arbol([L|[]],_,L).
hojas_arbol(L,C,A):-
	recA(L,C,R),
	hojas_arbol(R,C,A).
recA([],_,_).
recA([X|[Y|Z]],C,A):-
	X=tree(V,_,_),
	Y=tree(W,_,_),
	menor(V,W,C,M),
	(A=[] ->append(tree(M,X,Y),A,R)
	; append(tree(M,X,Y),A,R)) ,
	recA(Z,C,R).
recA([X|[]],_,R):-
	append([X],R,Z),
	recA([],_,Z).



lista([X|[]],X).
