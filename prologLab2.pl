:-['chars.pl'].

words(Words):-
        words('dr.txt', Words).

words(Source, Words):-
	open(Source, read, In),
	read_words(In, Words),
	close(In).

read_words(In, Words):-
	get_code(In, Char),           % Read a char from the stream.
	read_words(Char, In, Words).  % Call 3-arg. version to process the char.


% Char was eof stop. No more backtracking! Finish the list off with empty list as last elem. 
read_words(-1, _In, []):- !.          
read_words(Char, In, Words):-         % the char read was not eof so call 4-arg version.
	read_words(Char, Word, Word, In, Words). % Beware arg.3 and 4 is the same variable!
/*
the char read was 10="\n". We reached the end of the word and finish with the empty list
as the last element. Now since arg. 3 was a copy of arg.2 the list which we were using to build the current
word. Via this neat trick we have access to the whole list through arg 3=Word and just put that word as the
head of our main list Words,and the tail of our main list is built trough calling read_words again to start
procsseing a new word. Also from here we forbid backtracking and read next char from inputstream. 
*/
read_words(10, [], Word, In, [Word|Words]):- !,
	read_words(In, Words).

read_words(Char, [Char|Rest], Word, In, Words):-
	get_code(In, Next),
	read_words(Next, Rest, Word, In, Words).


t9_version_1(InputList, Database, Word):- 
    getSuggestion(InputList,Word),
    member(Word,Database).

getSuggestion([],[]).
getSuggestion([Head|Tail], [HeadSuggest|TailSuggest]):-
    digit_char(Head,HeadSuggest),
    getSuggestion(Tail,TailSuggest).


test_version_1:-
	words(Words),
	statistics(runtime,_),
	t9_version_1([3,2,7,8,4], Words, Word),
	statistics(runtime,[_, Time]),
	format("one solution is \"~s\", found in ~w ms~n" ,[Word, Time]).


t9_version_2(Code, Words, Word) :-
	decode(Code, Words, Word).

decode([], _, []).
decode([Digit|Code], Words, [Char|Word]):-
	digit_char(Digit, Char),
	memberchk([Char|_T], Words),
	filter(Words, Char, Filtered),
	decode(Code, Filtered, Word).



%filter([[]],_,[]). % Base case for when we have processed all the words in our words database/list. Does not seem to be needed now!
filter([],_,[]).  % Base case for when we have processed all the elements in our current word.

/*
With this notation, we first select a word from our database/list of words. Since the
word itself is a list  we select its head and compared it with the given Char. We test
these non matches in the first clause of filter since we are likely to have a lot
more "non-matches" than actual matches.
*/
filter([[NotMatch|_Tail_Word]|Tail_Words], Char, FilteredList):-
	NotMatch \==Char,
	filter(Tail_Words,Char,FilteredList).

/*
We should reach the second and third clause if the first clause fails and we actually had a match". So
start building of Filtered List, by throwing away the head and only appending the tail
of the current word. Then procceed to check the remainder of our words list database.
The second is to match a singleton list with one element [Char|[]]. The reason for this rule is we do not
want to append its tail which is [] to our filtered list! We just match and then ignore the tail!
*/

filter([[Char|[]]|Tail_Words], Char, Rest_of_FilteredList):-
	filter(Tail_Words,Char,Rest_of_FilteredList).
filter([[Char|Tail_Word]|Tail_Words], Char, [Tail_Word|Rest_of_FilteredList]):-
	filter(Tail_Words,Char,Rest_of_FilteredList).

test_version_2:-
	words(Words),
	statistics(runtime,_),
	t9_version_2([3,2,7,8,4], Words, Word),
	statistics(runtime,[_, Time]),
	format("one solution is \"~s\", found in ~w ms~n" ,[Word, Time]).



decodeTree([], _, []).
decodeTree([Digit|Code], Tree, [Char|Word]):-
    	digit_char(Digit, Char),
	memberchk(branch(Char, Sub), Tree),
	decodeTree(Code, Sub, Word).

insert_word([], _).
insert_word([Char|Word], Tree):-
	memberchk(branch(Char, Branches), Tree), !,
        insert_word(Word, Branches).

insert_all([], _).  
insert_all([Word|Words], Tree) :-
	insert_word(Word, Tree), 
        insert_all(Words, Tree).

done([]):-!.
done([branch(_,Branches)|Rest]):-
	done(Branches),
	done(Rest).

build(Words, Tree):-
	insert_all(Words,Tree),
	done(Tree).

t9_version_3(Code, Tree, Word):-
	decodeTree(Code, Tree, Word).

test:-
	words(Words),
	statistics(runtime,_),
	build(Words, Tree),!,
	statistics(runtime,[_,Build]),
	t9_version_3([3,2,7,8,4], Tree, Word),
	statistics(runtime,[_, Time]),
	format("one solution is \"~s\", found in ~w ms, (building of tree in ~w ms)~n" ,[Word, Time, Build]).