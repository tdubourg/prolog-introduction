%% appends list 2 to list 1
% a() example usage:  a([a,b,c],[1,2,3],[a,b,c,1,2,3]).
a([], L2, L2).
a([X|L1], L2, [Y|R]) :- X = Y, a(L1, L2, R).

%% reverses the list
% r example usage : r([a,b,c], [c,b,a]).
r([], []). % empty list is the reverse of itself
r([X|R1], [Y|R2]) :- R1 = [], R2 = [], X = Y. %  list of only one element is the reverse of itself
r([X|R1], L2) :- a(Sub2, [X], L2), r(R1, Sub2).
