:- include(words).

% check if a char in on a list
check_char(_, []):- fail, !.
check_char(X, [H|_]):-
    X=H, !.
check_char(X, [_|T]):-
    check_char(X, T).

% base call
get_colors([], [], _, _, COLOR, COLOR).
% add a entry green on the list 
get_colors([H1 | T1], [H2 | T2], GUESS, WORD, COLORS, [green | Z]):-
    write(H1), nl,
    H1=H2,
    get_colors(T1, T2, GUESS, WORD, COLORS, Z).
% add a entry yello on the list
get_colors([H1 | T1], [_ | T2], GUESS, WORD, COLORS, [yellow | Z]):-
    check_char(H1, WORD),
    get_colors(T1, T2, GUESS, WORD, COLORS, Z).
get_colors([_ | T1], [_ | T2], GUESS, WORD, COLORS, [cyan | Z]):-
    get_colors(T1, T2, GUESS, WORD, COLORS, Z).

wordle(GUESS, WORD):-
    word5(GUESS),
    atom_chars(GUESS, L_GUESS),
    atom_chars(WORD, L_WORD),
    get_colors(L_GUESS, L_WORD, L_GUESS, L_WORD, [], X),
    write(X), nl, !.

