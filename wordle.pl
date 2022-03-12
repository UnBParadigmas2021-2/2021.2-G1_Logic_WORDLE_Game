:- include(words).

fullmatches([], [], X, X).
fullmatches([H1 | T1], [H2 | T2], L, X):-
    H1=H2,
    fullmatches(T1, T2, [H1 | L], X), !.
fullmatches([ _ | T1], [ _ | T2], L, X):-
    fullmatches(T1, T2, L, X).

wordle(GUESS, WORD):-
    word5(GUESS),
    atom_chars(GUESS, L_GUESS),
    atom_chars(WORD, L_WORD),
    L = [],
    fullmatches(L_GUESS, L_WORD, L, X),
    write(X), nl.

