% Examples of using prolog for generating and querying on a genealogy tree

% Defining atoms (our entities in the tree)
male('Bob').
male('Henry').
male('John').
male('Gautier').
male('Uncle1').
male('Intermarriageor').
female('Aunt1').
female('Sandra').
female('Jeanette').
female('Gislaine').
female('Marie-Jeanette').


% Defining relationships
father('Henry', 'Bob').
father('Intermarriageor', 'Bob').
father('John', 'Uncle1').
father('John', 'Henry').
father('Henry', 'Gautier').
father('Henry', 'Jeanette').


mother('Sandra', 'Jeanette').
mother('Marie-Jeanette', 'Sandra').
mother('Marie-Jeanette', 'Aunt1').
mother('Sandra', 'Bob').

% Defining tools to query on the tree
gfather(X, Y) :- father(X, Z), father(Z, Y).
gfather(X, Y) :- father(X, Z), mother(Z, Y).
gmother(X, Y) :- mother(X, Z), mother(Z, Y).
gmother(X, Y) :- mother(X, Z), father(Z, Y).

ancestor('Gislaine', 'Marie-Jeanette').
ancestor(X, Y) :- father(X, Y).
ancestor(X, Y) :- gfather(X, Y).
ancestor(X, Y) :- mother(X, Y).
ancestor(X, Y) :- gmother(X, Y).
ancestor(X, Y) :- ancestor(X, Z), ancestor(Z, Y).

brother('Intermarriageor', 'Sandra').
brother(X, Y) :- male(X), father(Z, X), father(Z, Y).
brother(X, Y) :- male(X), mother(Z, X), mother(Z, Y).

sister(X, Y) :- female(X), father(Z, X), father(Z, Y).
sister(X, Y) :- female(X), mother(Z, X), mother(Z, Y).

uncle(X, Y) :- male(X), brother(X, Z), (father(Z, Y) ; mother(Z, Y)).

aunt(X, Y) :- female(X), sister(X, Z), (father(Z, Y) ; mother(Z, Y)).
