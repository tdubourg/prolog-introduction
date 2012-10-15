%% el(index, X, L) will be true if X is the index-th element of the list L
% example usage: el(3, c, [a,b,c,d,e,f]).
el(1, X, [X|_]).
el(I, X, [_|S]) :- N is I - 1, el(N, X, S).