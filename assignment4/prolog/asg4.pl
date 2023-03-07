% Q1
is_binary_tree(nil).
is_binary_tree(bt(Left,_,Right)) :- is_binary_tree(Left), is_binary_tree(Right).

% Q2
% (a)
lt(0,s(_)).
lt(s(X),s(Y)) :- lt(X,Y).

% Q2(b)
% problem: success notation - base case wrong

bt_Member(E,bt(L,E,R)).
bt_Member(E,bt(L,Rt,R)):- bt_Member(E,L).
bt_Member(E,bt(L,Rt,R)):- bt_Member(E,R).
bt_center(E,bt(L,E,R)).

bt_max(E,bt(nil,E,nil)).
bt_max(E,bt(L,Rt,R)):- bt_Member(E,bt(L,Rt,R)),bt_max(Lm,L),bt_max(Rm,R),lt(Lm,s(E)),lt(Rm,s(E)),lt(Rt,s(E)).

bt_min(E,bt(nil,E,nil)).
bt_min(E,bt(L,Rt,R)):- bt_Member(E,bt(L,Rt,R)),bt_min(Lm,L),bt_min(Rm,R),lt(E,s(Lm)),lt(E,s(Rm)),lt(E,s(Rt)).

bs_tree(bt(nil,_,nil)).
bs_tree(bt(L,M,R)) :- bs_tree(L),bs_tree(R),is_binary_tree(bt(L,M,R)),bt_max(X,L),lt(X,M),bt_min(Y,R),lt(M,Y).


% Q3
% 

parent(bt(L,P,R),P,C) :- is_binary_tree(bt(L,P,R)),bt_center(C,L).
parent(bt(L,P,R),P,C) :- is_binary_tree(bt(L,P,R)),bt_center(C,R).
parent(bt(L,T,R),P,C) :- is_binary_tree(bt(L,T,R)),bt_Member(P,L),parent(L,P,C).
parent(bt(L,T,R),P,C) :- is_binary_tree(bt(L,T,R)),bt_Member(P,R),parent(R,P,C).



% Q4

descendent(bt(L,T,R), A, D):- parent(bt(L,T,R),A,D).
descendent(bt(L,T,R), A, D):- parent(bt(L,T,R),A,Z),descendent(bt(L,T,R),Z,D).

% Q5

sum(0, X, X).
sum(s(X), Y, s(Z)) :- sum(X, Y, Z).

count_nodes(nil,0).
count_nodes(bt(L,T,R),X) :- count_nodes(L,M),count_nodes(R,N),sum(M,s(N),X),is_binary_tree(bt(L,T,R)).


% Q6

sum_nodes(nil,0).
sum_nodes(bt(L,T,R),X) :- sum_nodes(L,M),sum_nodes(R,N),sum(M,N,Y),sum(Y,T,X),is_binary_tree(bt(L,T,R)).



% Q7

append([],L,L).
append([H|T],L2,[H|L3]):-append(T,L2,L3).

preorder(nil, []).
preorder(bt(L,T,R), X):- preorder(L,M),preorder(R,N),append([T],M,Z),append(Z,N,X).

















% Q7