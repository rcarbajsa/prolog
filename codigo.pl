
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
menor(A,B,_,B):-%En el caso de que no se cumpla call(C) menor devuelve B
	A\=B.%En el caso de que A sea igual que B y no se haya cumplido el call, menor devuelve no. Ej: ? menor(3,3,<,M). devuelve no


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
	N1@<N2. %Comparamos el functor de los 2 términos
menor_o_igual(X,Y):-
	functor(X,N,A1),
	functor(Y,N,A2),
	A1<A2. %Comparamos la aridad de los 2 términos
menor_o_igual(X,Y):-
	functor(X,N,A),
	functor(Y,N,A),
	recArgMenor(X,Y,A). %Recorremos los argumentos de los 2 términos y los vamos comparando
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

%comp utiliza menor_o_igual o mayor_o_igual (dependiendo de C) y devuelve el menor o mayor número en M
comp(A,B,C,M):-
	(C = 'menor_o_igual'; C = '<' ; C = '=<' ; C = '@<'; C= '@=<' -> Comp = menor;
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

ordenacionR(void,_,Orden,Orden). %Caso base: Cuando ya no quedan hojas en el árbol. Devuelve en Orden los valores que hemos ido acumulando
ordenacionR(Arbol,Comp,Acc,Orden):-
	Arbol=tree(V,_,_),
	push(V,Acc,N), %Metemos el valor de la raíz en la lista Acc
	reflotar(Arbol,ArbolR,V,_,_,Comp),!, %Reflotamos el árbol
	ordenacionR(ArbolR,Comp,N,Orden).
	
%reflotar(Arbol,ArbolR,Valor,Encontrado1,Encontrado2,Comp):
%Arbol: Árbol/nodo que hay que reflotar
%ArbolR: Árbol reflotado a partir de Arbol
%Valor: Valor del nodo raíz, que es el valor de la hoja más pequeña(o mayor)
%Encontrado1: Devuelve 1 si se ha encontrado la hoja más pequeña(o mayor) en Arbol, devuelve 0 e.o.c
%Encontrado2: Vale 1 si ya se ha encontrado la hoja más pequeña(o mayor) en algún nodo del árbol, devuelve 0 e.o.c
%Comp: Criterio de comparación que se utiliza para construir el nuevo árbol.

reflotar(tree(Valor,void,void),void,Valor,1,0,_). %En el caso de que encontremos una hoja con el Valor de la raíz borramos esa hoja (Ponemos ese nodo a void)
reflotar(tree(V,H1,H2),A,V,Encontrado1,0,C):- %Si aún no se ha encontrado la hoja más pequeña(o mayor) (Encontrado2 = 0) y el valor de este nodo tiene el valor de la raíz buscamos en este nodo. 
	reflotar(H1,ArbolI,V,E1,_,C),
	reflotar(H2,ArbolD,V,E2,E1,C), 
	(E1=1 -> Encontrado1=1;
	Encontrado1=E2), %Devolvemos en Encontrado1 si se ha encontrado la hoja con el valor de la raíz en este nodo
	(ArbolI = void -> A = ArbolD;
	ArbolD = void -> A = ArbolI; %En el caso de que se haya borrado alguna hoja, la hoja que no se ha borrado sustituye al nodo padre
	ArbolI = tree(VI,_,_),ArbolD = tree(VD,_,_),comp(VI,VD,C,R),A=tree(R,ArbolI,ArbolD)). %Añadimos el nuevo valor del nodo padre que se obtiene con el predicado comp
reflotar(Arbol,Arbol,_,0,_,_). %Si el nodo no tiene el valor de la raíz lo dejamos como estaba

%ordenar(Lista,Comp,Orden): Dada una lista de elementos y un Comp,
%devuelve la lista ordenada pero utilizando arboles flotantes
%(Llamando a los metodos creados anteriormente).
ordenar(Lista,Comp,Orden):-
	lista_hojas(Lista,Hojas),
	hojas_arbol(Hojas,Comp,Arbol),
	ordenacion(Arbol,Comp,Orden),! .

%Predicado para almacenar valores en una lista
push(V,[],[V]).
push(V,[L|R],[L|T]):-
	push(V,R,T).


