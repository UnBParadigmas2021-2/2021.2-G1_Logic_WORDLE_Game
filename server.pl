:- use_module(library(http/thread_httpd)).
:- use_module(library(http/http_dispatch)).
:- use_module(library(http/http_json)).

% URL handlers.
:- http_handler('/', handle_request, []).
:- http_handler('/word', handle_word_request, [methods([get])]).

get_word(Word) :-
    consult('word_utils'),
    get_random_word(Word).

handle_word_request(Request) :-
    get_word(Word),
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

