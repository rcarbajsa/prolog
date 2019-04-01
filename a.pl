less(0,s(X)):-nat(X).
less(0,0).
less(s(X),s(Y)):-less(X,Y).
nat(0):-true.
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
	less(Q,X),less(E,Z),esMayor(pieza(Q,W,E,R),construccion(K)),pieza(X,Y,Z,C),pieza(Q,W,E,R).
esMayor(H,construccion([])).
construccion([]).	
