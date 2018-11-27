-module(yatzy_score).
-export([calc/2]).
-spec calc(yatzy:slot(), yatzy:roll()) -> non_neg_integer().

calc(chance,Roll) ->
  lists:sum(Roll);

calc(yatzy,Roll) ->
  case Roll of
    [Element,Element,Element,Element,Element] -> 50;
    _ -> 0
  end;

calc(full_house, Roll) ->
  case Roll of
    [Element,Element,Element,Element2,Element2] -> lists:sum(Roll);
    [Element2,Element2,Element,Element,Element] -> lists:sum(Roll);
    _ -> 0
  end;

calc(ones,Roll) ->
  lists:sum(lists:filter(fun(R) -> filterhelper(R,1) end, Roll));

calc(twos,Roll) ->
  lists:sum(lists:filter(fun(R) -> filterhelper(R,2) end, Roll));

calc(threes,Roll) ->
  lists:sum(lists:filter(fun(R) -> filterhelper(R,3) end, Roll));

calc(fours,Roll) ->
  lists:sum(lists:filter(fun(R) -> filterhelper(R,4) end, Roll));

calc(fives,Roll) ->
  lists:sum(lists:filter(fun(R) -> filterhelper(R,5) end, Roll));

calc(sixes,Roll) ->
  lists:sum(lists:filter(fun(R) -> filterhelper(R,6) end, Roll));

calc(one_pair,Roll) ->
  SortRoll = lists:reverse(lists:sort(Roll)),
  case SortRoll of
    [Element,Element|_] -> Element * 2;
    [_,Element,Element|_] -> Element * 2;
    [_,_,Element,Element,_] -> Element * 2;
    [_,_,_,Element,Element] -> Element * 2;
    _ -> 0
  end;

calc(two_pair,Roll) ->
  SortRoll = lists:reverse(lists:sort(Roll)),
  case SortRoll of
    [Element,Element,Element2,Element2,_] -> (Element*2) + (Element2*2);
    [_,Element,Element,Element2,Element2] -> (Element*2) + (Element2*2);
    [Element,Element,_,Element2,Element2] -> (Element*2) + (Element2*2);
    _ -> 0
  end;

calc(three_of_a_kind,Roll) ->
  SortRoll = lists:sort(Roll),
  case SortRoll of
    [Element,Element,Element,_,_] -> (Element*3);
    [_,_,Element,Element,Element] -> (Element*3);
    [_,Element,Element,Element,_] -> (Element*3);
    _ -> 0
  end;

calc(four_of_a_kind,Roll) ->
  SortRoll = lists:sort(Roll),
  case SortRoll of
    [Element,Element,Element,Element,_] -> (Element*4);
    [_,Element,Element,Element,Element] -> (Element*4);
    _ -> 0
  end;

calc(small_straight,Roll) ->
  SortRoll = lists:sort(Roll),
  case SortRoll of
    [1,2,3,4,5,_] -> 15;
    [_,1,2,3,4,5] -> 15;
    [_|_] -> 0
  end;

calc(large_straight,Roll) ->
  SortRoll = lists:sort(Roll),
  case SortRoll of
    [_,2,3,4,5,6] -> 20;
    [2,3,4,5,6,_] -> 20;
    [_|_] -> 0
  end.

filterhelper(R, C) ->
  R =:= C.
