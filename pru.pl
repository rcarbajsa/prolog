suma(0,Y,Y).
suma(s(X),Y,s(Z)):-
	suma(X,Y,Z).

sumaRec(0,_,S,S).
sumaRec(s(N),[X|Y],S,C):-
	suma(X,C,R),
	sumaRec(N,Y,S,R).

sumaN(N,L,S):-
	sumaRec(N,L,S,0).

programa('Supervivientes').
programa('El Hormiguero').
programa('Hora Punta').
programa('Perdoname Señor').
programa('Salvame').
serie('Perdoname Señor').
cadena('Supervivientes','Telecinco').
cadena('El Hormiguero','Antena3').
cadena('Hora Punta','La1').
cadena('Perdoname Señor','Telecinco').
cadena('Salvame','Telecinco').
programaDeAudiencia(X):- programa(X),cadena(X,'Telecinco'), \+ serie(X).
resta(X, Y, Z) :- Z is X - Y.

selec(P,S):-
	read(T),
	findall(X,(member(X,P),X=..[T|_]),S).
estaEnAlineacion(X) :- \+lesionado(X).%, entrenadorConfiaEn(X).
entrenadorConfiaEn(X) :- entrenaBien(X).
entrenadorConfiaEn(X) :- buenaActitud(X).
lesionado(carvajal).
lesionado(benzema).
entrenaBien(ramos).
entrenaBien(marcelo).
buenaActitud(bale).
buenaActitud(benzema).
