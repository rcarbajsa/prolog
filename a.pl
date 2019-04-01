less(0,s(X)):-nat(X).
less(0,0).
less(s(X),s(Y)):-less(X,Y).
eq(s(X),s(Y)):-eq(X,Y).
eq(0,0).
nat(0).
nat(s(X)):-nat(X).
dim(s(X)):-dim(X).
dim(s(0)).
pieza(X,Y,Z,C) :- dim(X),dim(Y),dim(Z),color(C).
color(r).
color(am).
color(b).
color(v).
construccion( [pieza(H,J,O,P)|B] ):-pieza(H,J,O,P),construccion(B).
esTorre(construccion([G|K])):-
	esMayor(G,construccion(K)),construccion([G|K]).
esMayor(pieza(X,Y,Z,C),construccion([pieza(Q,W,E,R)|K])):-
	less(X,Q),less(Z,E),esMayor(pieza(Q,W,E,R),construccion(K)),pieza(X,Y,Z,C),pieza(Q,W,E,R).
esMayor(_,construccion([])).
construccion([]).	
alturaTorre(construccion(T),A):-esTorre(construccion(T)),nat(A),sumaAltura(construccion(T),A).
sumaAltura(construccion([S|B]),A):-sumRec(S,construccion(B),0,A).
sumRec(pieza(X,Y,Z,C),construccion([pieza(Q,W,E,R)|K]),P,A):-
	sum(Y,P,J),sumRec(pieza(Q,W,E,R),construccion(K),J,A),pieza(X,Y,Z,C),pieza(Q,W,E,R).
sumRec(pieza(X,Y,Z,C),construccion([]),P,A):-pieza(X,Y,Z,C),sum(Y,P,J),eq(J,A).
sum(0,Y,Y):-nat(Y).
sum(s(X),Y,s(Z)):-sum(X,Y,Z).
coloresTorre([pieza(X,Y,Z,C)|R],[V|B]):-
	pieza(X,Y,Z,C),C=V,coloresTorre(R,B).
coloresTorre([],[]).
	