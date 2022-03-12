:- include(words).

fullmatches([], [], L).
fullmatches([H1 | T1], [H2 | T2], L):-
    H1=H2,
    write(L), nl,
    fullmatches(T1, T2, [H1|L]).

wordle(GUESS, WORD):-
    word5(GUESS),
    atom_chars(GUESS, L_GUESS),
    atom_chars(WORD, L_WORD),
    L = [],
    fullmatches(L_GUESS, L_WORD, L),
    write(L), nl.

