
not(Var):- Var,!,fail.
not(Var).

[a].

test(_) :-
    % No hace falta hacer testing con 0 porque siempre hay al menos una pieza o dimension
    %testNat(_),
    %testMenorIgualQue(_),
    %testPar(_),
    %testColor(_),
    testEsTorre(_).
    %testAlturaTorre(_),
    %testColoresIncluidos(_).

add(X, X1) :-
    X1 is X+1.

assert(D,C) :-
    format('   |  Test ~w',[D]),
    C,
    format('             |  OK                    |~n',[]).

tNat(A) :- nat(A).
testNat(_) :-
    format('~n   ------------------ TEST NAT ------------------~n',[]),
    assert(1,tNat(0)),             
    assert(2,tNat(s(0))),
    assert(3,tNat(s(s(s(s(0)))))),
    assert(4,not(tNat(t))),
    %assert(4,not(tNat(_))),
    format('   ------------------------------------------------~n',[]).


tMenorIgualQue(A,B) :- menorIgualQue(A,B).
testMenorIgualQue(_) :-
    format('~n   --------------TEST MENOR IGUAL QUE--------------~n',[]),
    assert(1,tMenorIgualQue(        s(0),       s(0))),             
    assert(2,tMenorIgualQue(        s(s(0)),    s(s(0)))),
    assert(3,tMenorIgualQue(        s(0),       s(s(0)))),
    assert(4,tMenorIgualQue(        s(0),       s(s(s(0))))),
    assert(5,not(tMenorIgualQue(    s(s(0)),    s(0)))),
    assert(6,not(tMenorIgualQue(    s(s(s(0))), s(0)))),
    assert(7,not(tMenorIgualQue(    t,          0))),
    assert(8,not(tMenorIgualQue(    0,          t))),
    assert(9,not(tMenorIgualQue(    t,          t))),
    format('   ------------------------------------------------~n',[]).

tPar(A) :- par(A).
testPar(_) :-
    format('~n   ------------------ TEST PAR ------------------~n',[]),
    assert(1,tPar(      0)),             
    assert(2,tPar(      s(s(0)))),
    assert(3,tPar(      s(s(s(s(0)))))),
    assert(4,not(tPar(  s(0)))),
    assert(5,not(tPar(  s(s(s(0)))))),
    assert(6,not(tPar(  s(s(s(s(s(0)))))))),
    assert(6,not(tPar(  t))),
    format('   ------------------------------------------------~n',[]).

tColor(A) :- color(A).
testColor(_) :-
    format('~n   ------------------ TEST COLOR ------------------~n',[]),
    assert(1,tColor(r)),
    assert(1,tColor(v)),
    assert(1,tColor(am)),
    assert(1,tColor(a)),
    assert(1,not(tColor(t))),
    assert(1,not(tColor(0))),
    assert(1,not(tColor(s(0)))),
    format('   ------------------------------------------------~n',[]).

tEsTorre(A) :- esTorre(A).
testEsTorre(_):-
    format('~n   --------------- TEST ES TORRE ----------------~n',[]),
    assert(1,tEsTorre([pieza(s(0),s(0),s(0),r),pieza(s(0),s(0),s(0),a)])),
    assert(2,tEsTorre([pieza(s(0),s(0),s(s(0)),r),pieza(s(0),s(0),s(s(s(0))),a)])),
    assert(3,tEsTorre([pieza(s(0),s(0),s(s(0)),r),pieza(s(0),s(0),s(s(0)),a),pieza(s(0),s(0),s(s(s(0))),a)])),
    assert(4,tEsTorre([pieza(s(0),s(0),s(0),am)])),
    assert(5,tEsTorre([pieza(s(0),s(s(0)),s(0),v)])),
    assert(6,tEsTorre([pieza(s(0),s(0),s(0),r),pieza(s(0),s(s(s(0))),s(0),a)])),
    assert(7,tEsTorre([pieza(s(0),s(0),s(0),r),pieza(s(0),s(s(0)),s(0),r),pieza(s(0),s(s(s(0))),s(0),r)])),
    assert(8,tEsTorre([pieza(s(0),s(0),s(0),r),pieza(s(0),s(s(0)),s(0),r),pieza(s(s(0)),s(s(0)),s(s(0)),v),pieza(s(s(s(0))),s(s(s(0))),s(s(s(0))),am)])),
    assert(9,tEsTorre([pieza(s(s(s(0))),s(s(s(0))),s(s(s(0))),am),pieza(s(s(s(0))),s(s(s(0))),s(s(s(0))),r),pieza(s(s(s(0))),s(s(s(0))),s(s(s(0))),v)])),
    assert(10,tEsTorre([pieza(s(0),s(0),s(0),am),pieza(s(0),s(s(0)),s(0),v),pieza(s(0),s(s(0)),s(s(0)),v),pieza(s(s(s(0))),s(s(s(0))),s(s(s(0))),am)])),
    assert(11,not(tEsTorre([pieza(s(s(0)),s(0),s(0),r),pieza(s(0),s(0),s(0),a)]))),
    assert(12,not(tEsTorre([pieza(s(0),s(0),s(s(0)),v),pieza(s(0),s(0),s(0),am)]))),
    assert(13,not(tEsTorre([pieza(s(0),s(0),s(s(0)),r),pieza(s(0),s(0),s(0),a)]))),
    assert(14,not(tEsTorre([pieza(s(s(0)),s(s(0)),s(s(0)),r),pieza(s(0),s(0),s(0),a)]))),
    assert(15,not(tEsTorre([s(s(s(s(0)))),pieza(s(0),s(0),r),pieza(s(0),s(0),s(0),a)]))),
    assert(16,not(tEsTorre([pieza(t,s(0),s(0),r),pieza(s(0),s(0),s(0),a)]))),
    assert(17,not(tEsTorre([pieza(s(0),s(0),s(0),r),pieza(s(0),s(0),t,a)]))),
    assert(18,not(tEsTorre([pieza(s(s(s(0))),s(s(s(0))),s(s(s(0))),am),pieza(s(0),s(0),s(0),am),pieza(s(0),s(s(0)),s(0),v),pieza(s(0),s(s(0)),s(s(0)),v)]))),
    assert(19,not(tEsTorre([pieza(s(0),s(0),s(0),am),pieza(s(0),s(s(0)),s(0),v),pieza(s(s(s(0))),s(s(s(0))),s(s(s(0))),am),pieza(s(0),s(s(0)),s(s(0)),v)]))),
    assert(20,not(tEsTorre([pieza(s(0),s(0),s(0),t),pieza(s(0),s(0),s(0),a)]))),
    assert(21,not(tEsTorre([pieza(s(0),s(0),s(0),r),pieza(s(0),s(0),s(0),t)]))),
    assert(22,not(tEsTorre([pieza(s(0),s(0),s(0),t)]))),
    %assert(12,not(tEsTorre([pieza(s(0),s(0),s(0),r),pieza(s(0),_,s(0),a)]))),
    %assert(20,not(tEsTorre([pieza(_,_,s(0),r),pieza(s(0),s(0),s(0),a)]))),
    format('   ------------------------------------------------~n',[]).

testAlturaTorre(_):-
    format('Test 9: alturaTorre9 ~n',[]),
    alturaTorre([pieza(s(0),s(0),s(0),r),pieza(s(0),s(0),s(0),a)],s(s(0))),
    format('Test 10: alturaTorre10 ~n',[]),
    alturaTorre([pieza(s(0),s(0),s(0),r),pieza(s(0),s(s(0)),s(0),r),pieza(s(0),s(s(s(0))),s(0),r)],s(s(s(0)))),
    format('Test 11: alturaTorre11 ~n',[]),
    alturaTorre([pieza(s(0),s(0),s(0),r),pieza(s(0),s(s(0)),s(0),r),pieza(s(s(0)),s(s(0)),s(s(0)),v),pieza(s(s(s(0))),s(s(s(0))),s(s(s(0))),am)],s(s(s(s(0))))), 
    format('Test 12: alturaTorre12 ~n',[]),
    alturaTorre([pieza(s(0),s(0),s(0),r),pieza(s(0),s(0),s(0),r),pieza(s(0),s(0),s(0),r),pieza(s(0),s(0),s(0),r),pieza(s(0),s(0),s(0),a)],s(s(s(s(s(0)))))),
    format('Test 13: alturaTorre13 ~n',[]),
    not(alturaTorre([pieza(s(0),s(0),s(0),r),pieza(s(0),s(0),s(0),a)],s(0))),
    format('Test 14: alturaTorre14 ~n',[]),
    not(alturaTorre([pieza(s(0),s(0),s(0),r),pieza(s(0),s(s(0)),s(0),r),pieza(s(0),s(s(s(0))),s(0),r)],s(s(0)))),
    format('Test 15: alturaTorre15 ~n',[]),
    not(alturaTorre([pieza(s(s(0)),s(0),s(0),r),pieza(s(0),s(0),s(0),a)],s(s(0)))).


testColoresIncluidos(_):-
    format('Test 16: alturaTorre15 ~n',[]),
    coloresIncluidos([pieza(s(0),s(0),s(0),r)],[pieza(s(0),s(0),s(0),r),pieza(s(0),s(0),s(0),v),pieza(s(0),s(0),s(0),a)]),
    format('Test 17: alturaTorre17 ~n',[]),
    coloresIncluidos([pieza(s(0),s(0),s(0),r),pieza(s(s(0)),s(0),s(0),a)],[pieza(s(0),s(0),s(0),a),pieza(s(0),s(0),s(0),r)]),
    format('Test 18: alturaTorre18 ~n',[]),
    coloresIncluidos([pieza(s(0),s(0),s(0),a),pieza(s(0),s(0),s(0),a)],[pieza(s(s(0)),s(0),s(s(0)),a)]),
    format('Test 19: alturaTorre19 ~n',[]),
    coloresIncluidos([pieza(s(0),s(0),s(0),a),pieza(s(0),s(0),s(0),a),pieza(s(0),s(0),s(0),am)],[pieza(s(0),s(0),s(0),a),pieza(s(0),s(0),s(0),am)]),
    format('Test 20: alturaTorre20 ~n',[]),
    coloresIncluidos([pieza(s(0),s(0),s(0),a),pieza(s(0),s(0),s(0),v),pieza(s(0),s(0),s(0),r),pieza(s(0),s(0),s(0),am)],[pieza(s(0),s(0),s(0),am),pieza(s(0),s(0),s(0),r),pieza(s(0),s(0),s(0),v),pieza(s(0),s(0),s(0),a)]),
    format('Test 21: alturaTorre21 ~n',[]),
    coloresIncluidos([pieza(s(s(0)),s(0),s(0),r)],[pieza(s(0),s(0),s(0),r),pieza(s(0),s(0),s(0),v),pieza(s(0),s(0),s(0),a)]),
    format('Test 22: alturaTorre22 ~n',[]),
    not(coloresIncluidos([pieza(s(s(0)),s(0),s(0),r),pieza(s(0),s(0),s(0),r)],[pieza(s(0),s(0),s(0),r),pieza(s(0),s(0),s(0),v),pieza(s(0),s(0),s(0),a)])),
    format('Test 23: alturaTorre23 ~n',[]),
    not(coloresIncluidos([pieza(s(0),s(0),s(0),r),pieza(s(0),s(0),s(0),r)],[pieza(s(s(0)),s(0),s(0),r),pieza(s(0),s(0),s(0),v),pieza(s(0),s(0),s(0),a)])), 
    format('Test 24: alturaTorre24 ~n',[]),
    not(coloresIncluidos([pieza(s(s(0)),s(0),s(0),r),pieza(s(0),s(0),s(0),r)],[pieza(s(s(0)),s(0),s(0),r),pieza(s(0),s(0),s(0),v),pieza(s(0),s(0),s(0),a)])),
    format('Test 25: alturaTorre25 ~n',[]),
    not(coloresIncluidos([pieza(s(0),s(0),s(0),r),pieza(s(0),s(0),s(0),r),pieza(s(0),s(0),s(0),r),pieza(s(0),s(0),s(0),r)],[pieza(s(0),s(0),s(0),v)])),
    format('Test 26: alturaTorre26 ~n',[]),
    not(coloresIncluidos([pieza(s(0),s(0),s(0),a),pieza(s(0),s(0),s(0),v),pieza(s(0),s(0),s(0),r),pieza(s(0),s(0),s(0),am)],[pieza(s(0),s(0),s(0),r),pieza(s(0),s(0),s(0),v),pieza(s(0),s(0),s(0),a)])),
    format('Test 27: alturaTorre27 ~n',[]),
    not(coloresIncluidos([pieza(s(0),s(0),s(0),a),pieza(s(0),s(0),s(0),v),pieza(s(0),s(0),s(0),r),pieza(s(0),s(0),s(0),am)],[pieza(s(0),s(0),s(0),r)])).

