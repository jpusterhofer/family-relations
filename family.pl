% Knowledge base
child(alicia, beatriz).
child(esther, beatriz).

child(william, alicia).
child(victor, alicia).
child(kristen, alicia).
child(glen, alicia).

child(alex, william).
child(logan, victor).
child(matthew, victor).
child(james, kristen).

child(don, esther).
child(theresita, esther).

child(jacob, don).
child(benjamin, theresita).

child(coty, jacob).
child(sarah, benjamin).

age(beatriz, 113).
age(alicia, 83).
age(victor, 55).
age(william, 53).
age(kristen, 51).
age(glen, 50).
age(alex, 30).
age(logan, 25).
age(matthew, 23).
age(james, 20).
age(esther, 81).
age(theresita, 54).
age(don, 53).
age(benjamin, 25).
age(jacob, 31).
age(coty, 28).
age(sarah, 20).

parent(P, C):- 
    child(C, P).

grandparent(GP, GC):- 
    parent(GP, P), 
    parent(P, GC).

sibling(S1, S2):- 
    parent(P, S1),
    parent(P, S2), 
    dif(S1, S2).

nthcousin(C1, C2, 1):-
    grandparent(GP, C1),
    grandparent(GP, C2),
    dif(C1, C2),
    \+ sibling(C1, C2).

nthcousin(C1, C2, N):-
    parent(P1, C1),
    parent(P2, C2),
    nthcousin(P1, P2, Next),
    N is Next + 1.

nthcousinkremoved(C1, C2, N, 0):-
    nthcousin(C1, C2, N).

nthcousinkremoved(C1, C2, N, K):-
    parent(P, C1),
    nthcousinkremoved(P, C2, N, Next),
    K is Next + 1.

%Helper relation for finding the kth child
find_kthchild(C, [], 1).

find_kthchild(C, [S | T], K):-
    age(C, A1),
    age(S, A2),
    A2 > A1,  
    find_kthchild(C, T, Next),
    K is Next + 1.

find_kthchild(C, [S | T], K):-
    age(C, A1),
    age(S, A2),
    A1 > A2, 
    find_kthchild(C, T, K).

kthchild(C, P, K):-
    child(C, P),
    findall(S, sibling(C, S), Sibs),
    find_kthchild(C, Sibs, K).

    