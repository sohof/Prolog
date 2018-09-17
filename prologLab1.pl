history(
 b(
  l(yeast),
  b(
    b(
      l(fly),
      l(mosquito)
     ),
    b(
      l(frog),
      b(
	l(chicken),
	b(
	  l(mouse),
	  b(
	    l(human),
	    l(chimp)
	   )
	 )
       )
     )
   )
 )).

tree1(l(enkelt)).
tree2(b(l(1),l(2))).
tree3(b(l(1),b(l(2),l(3)))).
tree4(b(b(l(1),l(2)), b(l(3), l(4)))).
tree5(b(l(1), b(l(2), b(l(3),b(l(4),l(5)))))).

tree6(b(b(b(l(9),l(4)),nil),b(b(nil,nil),l(3)))).


writetree(T) :- writetree(T, 0).
writetree(l(X), N) :-
	indent(N),
	write(X).
writetree(b(X,Y), N) :-
	indent(N),
	write('('), nl,
	Next is N + 2,
	writetree(X, Next),
	write(', '), nl,
	writetree(Y, Next), nl,
	indent(N),
	write(')').

indent(0).
indent(N) :- N>0, write(' '), Next is N-1, indent(Next).


% predikat count_leaves som räknar löven i ett träd.
count_leaves(l(_),1).
count_leaves(b(LT,RT),NrLeaves):-
  count_leaves(LT,LT_NrLeaves),
  count_leaves(RT,RT_NrLeaves),
    NrLeaves is LT_NrLeaves + RT_NrLeaves.

% predikat leaves som givet ett träd som första parameter unifierar en lista
% med lövens information till andra parametern.

%leaves(nil,[]).               % We expand the code to allow for nil/non-existing nodes.
leaves(l(Data), [Data|[]]).   % 2nd arg. could also be written: [Data]
leaves(b(LT,RT), List):-
	leaves(LT,LeftL),
	leaves(RT,RightL),
	append(LeftL,RightL,List).

% We can use leaves the build the tree. BUT!! the first clause leaves(nil,[]) needs
% to be commented out for this version of build_tree to work.
build_tree(List,Tree):-
	leaves(Tree,List).

% This version does not interface with leaves. 
build_tree2([H],l(H)).        % When we reach a list with one elem. Put that elem. in a leaf.
build_tree2([H|Tail],Tree):-  % Pick the head and create a tree, put the head in the left leaf.
     Tree=b(l(H),RightLeaf),  % Now build the right leaf from the tail of the list.
    build_tree2(Tail,RightLeaf).


% height calculates the height of given tree. A tree of one leaf has height 1. If the tree has 
% structure b(S,T), then the height is 1 + max height of S and T.

height(l(_),1).
height(b(LT,RT), Height):-
	height(LT,Height_of_LT),
	height(RT,Height_of_RT),
	max(Height_of_LT,Height_of_RT, Max_Height),
        Height is Max_Height + 1.
	
max(X,Y,X):-
    X>=Y.
max(X,Y,Y):-
    X=<Y.


balanced(l(_)).
balanced(b(LT,RT)):-
	balanced(LT),
	balanced(RT),
	height(LT,LT_Height),height(RT,RT_Height),
	Res is LT_Height-RT_Height,
	Res =< 1,
	Res >= -1.