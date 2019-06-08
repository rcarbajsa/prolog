
%Predicado alumno_prode(Apellido1, Apellido2, Nombre, NumMatricula)
alumno_prode('Senovilla', 'Tejedor', 'Alejandro', '160172').
alumno_prode('Carbajosa', 'Gonzalez', 'Raul', '160311').
alumno_prode('Gonzalez', 'Jurado', 'Gema Maria', '160133').


%menor(A,B,Comp,M): Devuelve A o B según Comp en M.
%Comp debe ser <.
menor(A,B,Comp,M):-
	C=..[Comp,A,B],
	call(C), % Si se cumple call(C) ya no se comprueban más opciones
	M=A,!.
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
	N1@<N2.
menor_o_igual(X,Y):-
	functor(X,N,A1),
	functor(Y,N,A2),
	A1<A2.
menor_o_igual(X,Y):-
	functor(X,N,A),
	functor(Y,N,A),
	recArgMenor(X,Y,A).
recArgMenor(_,_,0).
recArgMenor(X,Y,A):-
	A > 0,
	A1 is A-1,
	recArgMenor(X,Y,A1),
	arg(A,X,C1),
	arg(A,Y,C2),
	menor_o_igual(C1,C2).

mayor_o_igual(X,_):-
	var(X). %En el caso de que A o B sea una variable libre => A es igual a B
mayor_o_igual(_,Y):-
	var(Y).
mayor_o_igual(X,X).
mayor_o_igual(X,Y):-
	functor(X,N1,_),
	functor(Y,N2,_),
	N2@<N1.
mayor_o_igual(X,Y):-
	functor(X,N,A1),
	functor(Y,N,A2),
	A2<A1.
mayor_o_igual(X,Y):-
	functor(X,N,A),
	functor(Y,N,A),
	recArgMayor(X,Y,A).
recArgMayor(_,_,0).
recArgMayor(X,Y,A):-
	A > 0,
	A1 is A-1,
	recArgMayor(X,Y,A1),
	arg(A,X,C1),
	arg(A,Y,C2),
	mayor_o_igual(C1,C2).

comp(A,B,C,M):-
	(C = 'menor_o_igual'; C = '<' ; C = '=<' ; C = '@<' -> Comp = menor;
	Comp = mayor),
	(Comp = menor -> (menor_o_igual(A,B) -> M = A ;
			     M = B);
	    (mayor_o_igual(A,B) -> M = A;
			     M = B)).
%lista_hojas(Lista,Hojas): Dada una lista,
%te devuelve una lista de hojas de arbol(tree(_,void,void)).
lista_hojas(L,H):-
	findall(tree(X,void,void),(member(X,L)),H).

%hojas_arbol(Hojas,Comp,Arbol): Dada una lista de hojas,
%devuelve un arbol flotante creado con dichas hojas.

hojas_arbol([X|Xs], Comp, A):-
	hojas_arbol_rec(X,Xs,Comp,A),!.
	
hojas_arbol_rec(A,[],_,A).
hojas_arbol_rec(X,[Y|Ys],Comp,A):-
	arg(1,X,Rx),
	arg(1,Y,Ry),
	comp(Rx,Ry,Comp,M),!,
	Aux=..[tree,M,X,Y],
	hojas_arbol_rec(Aux,Ys,Comp,A).

%ordenacion(Arbol,Comp,Orden): Dado un arbol, mediante un Comp,
%devuelve una lista Orden con las hojas de dicho arbol.
ordenacion(void,_,[]). %Caso base
ordenacion(Arbol,Comp,Orden):-
	ordenacionR(Arbol,Comp,[],Orden),!.

ordenacionR(void,_,Orden,Orden).
ordenacionR(Arbol,Comp,Acc,Orden):-
	Arbol=tree(V,_,_),
	push(V,Acc,N),
	reflotar(Arbol,ArbolR,V,_,_,Comp),!,
	ordenacionR(ArbolR,Comp,N,Orden).
	

reflotar(tree(Valor,void,void),ArbolR,Valor,Encontrado,0,_):-
	ArbolR=void,
	Encontrado=1.
reflotar(tree(V,H1,H2),A,V,Encontrado,0,C):-
	reflotar(H1,ArbolI,V,E1,_,C),
	reflotar(H2,ArbolD,V,E2,E1,C),
	(E1=1 -> Encontrado=1;
	Encontrado=E2),
	(ArbolI = void -> A = ArbolD;
	ArbolD = void -> A = ArbolI;
	ArbolI = tree(VI,_,_),ArbolD = tree(VD,_,_),comp(VI,VD,C,R),A=tree(R,ArbolI,ArbolD)).
reflotar(Arbol,Arbol,_,0,_,_).

%ordenar(Lista,Comp,Orden): Dada una lista de elementos y un Comp,
%devuelve la lista ordenada pero utilizando arboles flotantes
%(Llamando a los metodos creados anteriormente).
ordenar(Lista,Comp,Orden):-
	lista_hojas(Lista,Hojas),
	hojas_arbol(Hojas,Comp,Arbol),
	ordenacion(Arbol,Comp,Orden),! .


push(V,[],[V]).
push(V,[L|R],[L|T]):-
	push(V,R,T).


