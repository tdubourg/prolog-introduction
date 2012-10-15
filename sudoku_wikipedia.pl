/** Helper relation, more readable than member() */
:-op(400, xfx, in).
X in L :- member(X, L).
 
/**
* The standard Sudoku relation is defined by following predicate:
*   - R -- row number
*   - C -- column number
*   - A -- 3x3 area number
*/
related(vt(R,_,_), vt(R,_,_)).
related(vt(_,C,_), vt(_,C,_)).
related(vt(_,_,A), vt(_,_,A)).
 
/**
* Brute force Sudoku solver (graph colouring).
*
* For all vertices(1) choose a color from Colors, such
* that none of the related vertices have the same color.
* Grouping constraints are encoded in related(V1, V2) predicate.
*/
sudoku_solve([], _, _, Solution, Solution).
sudoku_solve([V | Vr], Colors, Hints, Solution, Result) :-
    s(V,Ch) in Hints -> % already given as hint
        sudoku_solve(Vr, Colors, Hints, [s(V,Ch) | Solution], Result)
    ; (
        C in Colors, %try next color
        forall(s(Vs1,Cs1) in Hints, (Cs1 \= C ; not(related(V, Vs1)))), % hints reserved
        forall(s(Vs2,Cs2) in Solution, (Cs2 \= C ; not(related(V, Vs2)))), % ensure color is unique
        sudoku_solve(Vr, Colors, Hints, [s(V,C) | Solution], Result) %repeat for the rest
    ).
 
% ======- End of program. The following is the test of code above -===========
% define colors
colors(C) :- C = [1, 2, 3, 4, 5, 6, 7, 8, 9].
 
% define board
test_board(B) :- 
    colors(C),
    def_row_board(C, C, [], B).
 
def_row_board([], _, S, S).
def_row_board([R | Rs], C, B, S) :-
    def_col_board(R, C, B, S1),
    def_row_board(Rs, C, S1, S).
 
def_col_board(_, [], S, S).
def_col_board(R, [C | Cs], B, S) :-
    K is ((R - 1) // 3) * 3,
    J is ((C - 1) // 3) + 1,
    A is K + J,
    def_col_board(R, Cs, [vt(R, C, A) | B], S).
 
% hints from image example (Wikipedia's "Sudoku" page)
hints(H) :- H = [s(vt(1,1,1), 5), s(vt(1,2,1), 3), s(vt(1,5,2), 7),
                 s(vt(2,1,1), 6), s(vt(2,4,2), 1), s(vt(2,5,2), 9),
                 s(vt(2,6,2), 5), s(vt(3,2,1), 9), s(vt(3,3,1), 8),
                 s(vt(3,8,3), 6), s(vt(4,1,4), 8), s(vt(4,5,5), 6),
                 s(vt(4,9,6), 3), s(vt(5,1,4), 4), s(vt(5,4,5), 8),
                 s(vt(5,6,5), 3), s(vt(5,9,6), 1), s(vt(6,1,4), 7),
                 s(vt(6,5,5), 2), s(vt(6,9,6), 6), s(vt(7,2,7), 6),
                 s(vt(7,7,9), 2), s(vt(7,8,9), 8), s(vt(8,4,8), 4),
                 s(vt(8,5,8), 1), s(vt(8,6,8), 9), s(vt(8,9,9), 5),
                 s(vt(9,5,8), 8), s(vt(9,8,9), 7), s(vt(9,9,9), 9)].
 
% query solution
test(S) :-
    test_board(B),
    colors(C),
    hints(H),
    sudoku_solve(B, C, H, [], S).
