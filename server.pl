:- use_module(library(http/thread_httpd)).
:- use_module(library(http/http_dispatch)).
:- use_module(library(http/http_json)).

% URL handlers.
:- http_handler('/', handle_request, [methods([post])]).
:- http_handler('/start', handle_start_request, [methods([get])]).
:- http_handler('/verify', handle_verify_request, []).

verify(_{guess:Guess}, _{status:Status,data:Data}) :-
    selected_word(Word),
    consult('wordle'),
    atom_string(Atom_Guess, Guess),
    wordle(Atom_Guess, Word, Status, Colors),
    guesses(Guesses),
    append(Guesses, [_{guess:Guess,colors:Colors}], NewGuesses),
    retractall(guesses(_)),
    assertz(guesses(NewGuesses)),
    guesses(Data).

handle_verify_request(Request) :-
    http_read_json_dict(Request, Query),
    verify(Query, Answer),
    reply_json_dict(Answer).

start(Word) :-
    consult('word_utils'),
    get_random_word(Selected_Word),
    retractall(guesses(_)),
    assertz(guesses([])),
    retractall(selected_word(_)),
    assertz(selected_word(Selected_Word)),
    selected_word(Word).

handle_start_request(Request) :-
    start(Word),
    reply_json_dict(Word).

% Calculates a + b.
solve(_{a:X, b:Y}, _{answer:N}) :-
    number(X),
    number(Y),
    N is X + Y.

handle_request(Request) :-
    http_read_json_dict(Request, Query),
    solve(Query, Solution),
    reply_json_dict(Solution).

server(Port) :-
    http_server(http_dispatch, [port(Port)]).

:- initialization(server(8000)).

