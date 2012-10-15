%% removes a given element from the list
% example usage: rm(a, [a,b,c], [b,c]).
% another example usage: rm(a, [a,b,c,a], [b,c]).
% another example usage: rm(a, [a,b,a,c,a], [b,c]).
rm(_, [], []).
rm(E, [E|L], R) :- rm(E, L, R).
rm(E, [C|L], [C|R]) :- rm(E, L, R).