/* config(Man,Wolf, Goat, cabbage). */
initial(config(w,w,w,w)).
final(config(e,e,e,e)).
opposite(w,e).
opposite(e,w).
/*move (config1,Move,config2). */
move(config(Coast,Coast,G,C), wolf, config(OppCoast,OppCoast,G,C)):- 
    opposite(Coast,OppCoast).
move(config(Coast,W,Coast,C),goat , config(OppCoast,W,OppCoast,C)):- 
    opposite(Coast,OppCoast).
move(config(Coast,W,G,Coast),cabbage , config(OppCoast,W,G,OppCoast)):- 
    opposite(Coast,OppCoast).
move(config(Coast,W,G,C),nothing , config(OppCoast,W,G,C)):- 
    opposite(Coast,OppCoast).
/*safe states*/
together(Coast,Coast,Coast).
together(_,Coast,OppCoast):- opposite(Coast,OppCoast).
safe(config(M,W,G,C)):-
    together(M,W,G),
    together(M,G,C).
solve(Conf,[]):- final(Conf).
solve(Conf,[Move|Moves]):- 
    move(Conf,Move,Conf1),
    safe(Conf1),
    solve(Conf1,Moves).
solve(Moves):-
    initial(InitialConf),
    length(Moves,_),
    solve(InitialConf,Moves).