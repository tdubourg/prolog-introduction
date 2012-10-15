%% Retrieves last element of the list
% example usage: l(c, [a,b,c]).
l(I, [A|R]) :- (A = I, R = []) ; (l(I, R)).
