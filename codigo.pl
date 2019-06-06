
	%Menor devuelve A o B según en M según Comp

menor(A,B,Comp,M):-
	C=..[Comp,A,B],
	call(C), % Si se cumple call(C) ya no se comprueban más opciones
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
	recArg(X,Y,A1),
	\+menor_o_igual(C1,C2).
recArg(_,_,_).







lista_hojas(L,H):-
	findall(tree(X,void,void),(member(X,L)),H).

hojas_arbol([L|[]],_,L).
hojas_arbol(L,C,A):-
	recA(L,C,_,Res),
	hojas_arbol(Res,C,A).
recA([],_,R,R).
recA([X|[Y|Z]],C,A,Res):-
	X=..[_,V,_,_],
	Y=..[_,W,_,_],
	menor(V,W,C,M),
	(A=[] ->append([tree(M,X,Y)],A,R);
	append([tree(M,X,Y)],A,R)) ,
	recA(Z,C,R,Res).
recA([X|[]],_,R,Res):-
	append([X],R,Z),
	recA([],_,Z,Res).

ordenacion(void,_,[]).
ordenacion(Arbol,Comp,Orden):-
	ordenacionR(Arbol,Comp,[],Orden).

ordenacionR(void,_,Orden,O):-
	reverse(Orden,O),!.
ordenacionR(Arbol,Comp,Acc,Orden):-
	Arbol=tree(V,_,_),
	N=[V|Acc],
	borrar_hoja(Arbol,ArbolR,V,_,_),
	obtener_hojas(ArbolR,_,Hojas),
	hojas_arbol(Hojas,Comp,Res),
	ordenacionR(Res,Comp,N,Orden).
	

borrar_hoja(tree(Valor,void,void),ArbolR,Valor,Encontrado,0):-
	ArbolR=void,
	Encontrado=1.
borrar_hoja(tree(Z,H1,H2),A,V,Encontrado,0):-
	borrar_hoja(H1,ArbolI,V,E1,_),
	borrar_hoja(H2,ArbolD,V,E2,E1),
	(E1=1 -> Encontrado=1;
	 Encontrado=E2),
	A=tree(Z,ArbolI,ArbolD).

borrar_hoja(Arbol,Arbol,_,0,1).


obtener_hojas(void,Res,Res).	
obtener_hojas(tree(V,void,void),Hojas,Res):-
	A=tree(V,void,void),
	(Hojas=[]->append([A],Hojas,Res);
	    append([A],Hojas,Res)).
obtener_hojas(tree(_,H1,H2),Hojas,Res):-
	obtener_hojas(H1,Hojas,ResI),
	obtener_hojas(H2,ResI,Res).

ordenar(Lista,Comp,Orden):-
	lista_hojas(Lista,Hojas),
	hojas_arbol(Hojas,Comp,Arbol),
	ordenacion(Arbol,Comp,Orden).