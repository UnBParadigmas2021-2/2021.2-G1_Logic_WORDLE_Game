% check if a char in on a list
check_char(_, []):- fail, !.
check_char(X, [H|_]):-
    X=H, !.
check_char(X, [_|T]):-
    check_char(X, T).

% remove a element from buffer -> bufferRemove(ELEMENT, BUFFER, NEWBUFFER)
bufferRemove(ELEM, [ELEM], []). % buffer with elem only
bufferRemove(ELEM, [ELEM | TAIL], TAIL). % elem in head
bufferRemove(ELEM, [HEAD | TAIL], [HEAD | RESULT]) :-	% elem in tail (recursive)
	bufferRemove(ELEM, TAIL, RESULT).

% base call
get_colors([], [], _, _, _, COLOR, COLOR).

% add a entry green on the list
get_colors([H1 | T1], [H2 | T2], GUESS, WORD, BUFFER, COLORS, [green | Z]):-
    % write(H1), nl,
    H1 == H2,
	bufferRemove(H1, BUFFER, NEWBUFFER),
    get_colors(T1, T2, GUESS, WORD, NEWBUFFER, COLORS, Z).

% add a entry yellow on the list
get_colors([H1 | T1], [_ | T2], GUESS, WORD, BUFFER, COLORS, [yellow | Z]):-
    check_char(H1, BUFFER),
	bufferRemove(H1, BUFFER, NEWBUFFER),
    get_colors(T1, T2, GUESS, WORD, NEWBUFFER, COLORS, Z).

% add a entry cyan on the list
get_colors([H1 | T1], [H2 | T2], GUESS, WORD, BUFFER, COLORS, [cyan | Z]):-
    H1 \== H2,
    get_colors(T1, T2, GUESS, WORD, BUFFER, COLORS, Z).

define_success_status(TIPS, STATUS) :-
    member(cyan, TIPS) -> atom_string(STATUS, "going"); atom_string(STATUS, "ok"),
    member(yellow, TIPS) -> atom_string(STATUS, "going"); atom_string(STATUS, "ok").

wordle(GUESS, WORD, STATUS, TIPS) :-
    consult('words'),
    word5(GUESS) ->
        atom_chars(GUESS, L_GUESS),
    	atom_chars(WORD, L_WORD),
	get_colors(L_GUESS, L_WORD, L_GUESS, L_WORD, L_WORD, [], TIPS),
        define_success_status(TIPS, STATUS), !
	% write(TIPS), nl, !.
	;
	atom_string(STATUS, "fail"),
	TIPS is 0.
