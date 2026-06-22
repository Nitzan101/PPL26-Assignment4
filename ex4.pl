/*
 * **********************************************
 * Printing result depth
 *
 * You can enlarge it, if needed.
 * **********************************************
 */
maximum_printing_depth(100).

:- current_prolog_flag(toplevel_print_options, A),
   (select(max_depth(_), A, B), ! ; A = B),
   maximum_printing_depth(MPD),
   set_prolog_flag(toplevel_print_options, [max_depth(MPD)|B]).

% Signature: sub_list(Sublist, List)/2
% Purpose: All elements in Sublist appear in List in the same order.
% Precondition: List is fully instantiated (queries do not include variables in their second argument).

sub_list([], []).
sub_list([X | L1], [X | L2]) :- sub_list(L1, L2).
sub_list(L1, [_X | L2]) :- sub_list(L1, L2).


% Signature: swap_list(List, InversedList)/2
% Purpose: InversedList is the ‘mirror’ representation of List, i.e, each item in the list is recursively replaced with the item at the position, with refers to the beginning and the end of the list.   

swap_list([], []).
swap_list([X | L1], L2) :- 


% Signature: sub_tree(Subtree, Tree)/2
% Purpose: Tree contains Subtree.

sub_tree(T, T).
sub_tree(T, tree(_X, L, _R)) :- sub_tree(T, L).
sub_tree(T, tree(_X, _L, R)) :- sub_tree(T, R).


% Signature: swap_tree(Tree, InversedTree)/2
% Purpose: InversedTree is the �mirror� representation of Tree.

swap_tree(void, void).
swap_tree(tree(X, L1, R1), tree(X, L2, R2)) :- swap_tree(L1, R2), swap_tree(R1, L2).