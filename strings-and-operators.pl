inf([], []) :- fail.
inf([A|AS], []) :- fail.
inf([], [B|BS]).
inf([A|AS], [B|BS]) :- A < B.
inf([A|AS], [B|BS]) :- A == B, inf(AS, BS).
before(X, Y) :- name(X, N1), name(Y, N2), inf(N1, N2).
:- op(1200, xfy, [before]).