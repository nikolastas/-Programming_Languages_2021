zebra(Houses):-
    Houses = [house(norwegian,_,_,_,_),house(_,blue,_,_,_),house(_,_,_,milk,_),_H4,_H5],
    member(house(englishman,red,_,_,_),Houses),
    member(house(spaniard,_,dog,_,_),Houses),
    member(house(_,green,_,coffe,_),Houses),
    member(house(ukranian,_,_,tea,_),Houses),
    rightof(house(_,ivory,_,_,_),house(_,green,_,_,_),Houses),
    member(house(_,_,sneals,_,old_gold),Houses),
    member(house(_,yellow,_,_,cools),Houses),
    near(house(_,_,_,_,chesterfields),house(_,_,fox,_,_),Houses),
    near(house(_,_,_,_,cools),house(_,_,horse,_,_),Houses),
    member(house(_,_,_,orange_juice,lucky_strike),Houses),
    member(house(japanese,_,_,_,parliaments),Houses).


rightof(H1,H2,[H1,H2,_,_,_]).
rightof(H1,H2,[_,H1,H2,_,_]).
rightof(H1,H2,[_,_,H1,H2,_]).
rightof(H1,H2,[_,_,_,H1,H2]).
near(H1,H2,Houses):- rightof(H1,H2,Houses).
near(H1,H2,Houses):- rightof(H2,H1,Houses).
owner_zebra(Owner):- zebra(Houses), member(house(Owner,_,fish,_,_),Houses).