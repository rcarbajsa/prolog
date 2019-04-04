%Funciones auxiliares
dim(s(0)).
dim(s(X)) :-
	dim(X).
nat(0).
nat(s(X)) :-
	nat(X).
menor(0,X) :-
	dim(X).
menor(s(X),s(Y)) :-
	menor(X,Y).
not(Var) :-
	Var,
	!,
	fail.
not(_).
eq(0,0).
eq(s(X),s(Y)) :-
	eq(X,Y).
esPar(s(s(X))) :-
	esPar(X).
esPar(0).
sum(0,Y,Y) :-
	nat(Y).
sum(s(X),Y,s(Z)) :-
	sum(X,Y,Z).
menor_o_igual(0,X) :-
	nat(X).
menor_o_igual(s(X),s(Y)) :-
	menor_o_igual(X,Y).

%Comprobacion de colores y de pieza
color(r).
color(a).
color(v).
color(am).
pieza(X,Y,Z,C):-
	dim(X),
	dim(Y),
	dim(Z),
	color(C).

%esTorre(Construccion):
esTorre([A|B]) :-
	esMenor(A,B).	   

esMenor(pieza(X,Y,Z,C),[]) :-
	pieza(X,Y,Z,C).
esMenor(pieza(X,Y,Z,C),[pieza(A,D,E,F)|B]) :-
	menor_o_igual(X,A),
	menor_o_igual(Z,E),
	esMenor(pieza(A,D,E,F),B),
	pieza(X,Y,Z,C),
	pieza(A,D,E,F).

%alturaTorre(Construccion,altura):
alturaTorre(T,A) :-
	esTorre(T),
	nat(A),
	sumaAltura(T,A).
sumaAltura([S|B],A) :-
	sumRec(S,B,0,A).
sumRec(pieza(_,Y,_,_),[pieza(Q,W,E,R)|K],P,A) :-
	sum(Y,P,J),
	sumRec(pieza(Q,W,E,R),K,J,A).
sumRec(pieza(X,Y,Z,C),[],P,A) :-
	pieza(X,Y,Z,C),
	sum(Y,P,J),
	eq(J,A).

%coloresTorre(Construccion,Lista_colores):	
coloresTorre(A,B) :-
	esTorre(A),
	colores(A,B).
colores([pieza(X,Y,Z,C)|R],[V|B]) :-
	pieza(X,Y,Z,C),
	C=V,
	colores(R,B).
colores([],[]).

%coloresIncluidos(Construccion1,Construccion2):
coloresIncluidos(L,T):-
	esTorre(L),
	esTorre(T),
	colorSub(L,T,T).
colorSub([pieza(_,_,_,X)|Xs],[pieza(_,_,_,X)|_],T):-
	colorSub(Xs,T,T).
colorSub(A,[_|Ys],T):-
	colorSub(A,Ys,T).
colorSub([],_,_).

%esEdificioPar(Construccion):
esEdificioPar([A|B]) :-
	recFila(A,0),
	esEdificioPar(B).
esEdificioPar([]).
recFila([r|A],C):-
	recFila(A,s(C)).
recFila([am|A],C):-
	recFila(A,s(C)).
recFila([a|A],C):-
	recFila(A,s(C)).
recFila([v|A],C):-
	recFila(A,s(C)).
recFila([b|A],C):-
	recFila(A,C).
recFila([],C):-
	esPar(C).

%esEdificioPiramide(Construccion):
esEdificioPiramide([L1,L2|R]):-
	pirComp(L1,L2),
	esEdificioPiramide([L2|R]).
esEdificioPiramide([_|[]]).
pirComp(L1,L2):-
	recFila1(L1,0,L2).
recFila1([r|A],C,L2):-
	recFila1(A,s(C),L2).
recFila1([am|A],C,L2):-
	recFila1(A,s(C),L2).
recFila1([a|A],C,L2):-
	recFila1(A,s(C),L2).
recFila1([v|A],C,L2):-
	recFila1(A,s(C),L2).
recFila1([b|A],C,L2):-
	recFila1(A,C,L2).
recFila1([],C,L2) :-
	recFila2(L2,C,0).

recFila2([r|A],C1,C2):-
	recFila2(A,C1,s(C2)).
recFila2([am|A],C1,C2):-
	recFila2(A,C1,s(C2)).
recFila2([a|A],C1,C2):-
	recFila2(A,C1,s(C2)).
recFila2([v|A],C1,C2):-
	recFila2(A,C1,s(C2)).
recFila2([b|A],C1,C2):-
	recFila2(A,C1,C2).
recFila2([],C1,C2) :-
	menor(C1,C2).
	
