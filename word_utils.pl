use_module(library(lists)).

get_random_word(Word) :-
	% read the words knowledge base
	consult('words.pl'),
	% count how many words are available
	predicate_property(word5(_), number_of_clauses(N)),
	% pick a random word from the available ones
	Index is random(N),
	nth_clause(word5(_), Index, Ref),
	clause(Head, _, Ref),
	% convert predicate and atoms into list
	Head =.. List,
	% select the word atom
	nth1(2, List, Element),
	% return atom as a string
	atom_string(Element, Word).
