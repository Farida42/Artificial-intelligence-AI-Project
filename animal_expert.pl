
/* ======================================
   Animal Identification Expert System
   File: animal_expert.pl
   ====================================== */

:- dynamic yes/1, no/1.

/* ---------- Start System ---------- */

start :-
    write('---- Animal Identification Expert System ----'), nl,
    identify(Animal),
    nl,
    write('Identified Animal: '),
    write(Animal), nl,
    undo.

/* ---------- Identification Rules ---------- */

identify(human) :-
    chordate,
    mammal,
    has(cognitive_ability),
    !.

identify(dog) :-
    chordate,
    mammal,
    has(four_legs),
    has(tail),
    eats(meat),
    !.

identify(cat) :-
    chordate,
    mammal,
    has(four_legs),
    has(sharp_claws),
    eats(meat),
    !.

identify(cow) :-
    chordate,
    mammal,
    has(horns),
    eats(plants),
    !.

identify(bird) :-
    chordate,
    has(wings),
    has(hollow_bones),
    lays_eggs,
    !.

identify(fish) :-
    chordate,
    lives(water),
    has(fins),
    has(gills),
    !.

identify(snake) :-
    chordate,
    has(scales),
    cold_blooded,
    has(no_legs),
    !.

identify(crocodile) :-
    chordate,
    has(scales),
    cold_blooded,
    lives(water),
    !.

identify(frog) :-
    chordate,
    lives(land_water),
    cold_blooded,
    lays_eggs,
    !.

identify(insect) :-
    non_chordate,
    has(six_legs),
    has(antenna),
    !.

identify(spider) :-
    non_chordate,
    has(eight_legs),
    !.

identify(unknown).

/* ---------- Classification Rules ---------- */

chordate :-
    has(backbone).

non_chordate :-
    no(backbone).

mammal :-
    has(hair),
    gives_milk.

cold_blooded :-
    has(cold_blood).

/* ---------- Knowledge Checking ---------- */

has(X) :-
    yes(X),
    !.

has(X) :-
    no(X),
    !,
    fail.

has(X) :-
    ask(has, X).

gives_milk :-
    yes(gives_milk),
    !.

gives_milk :-
    no(gives_milk),
    !,
    fail.

gives_milk :-
    ask(gives, milk).

eats(Type) :-
    yes(eats(Type)),
    !.

eats(Type) :-
    no(eats(Type)),
    !,
    fail.

eats(Type) :-
    ask(eats, Type).

lives(Place) :-
    yes(lives(Place)),
    !.

lives(Place) :-
    no(lives(Place)),
    !,
    fail.

lives(Place) :-
    ask(lives_in, Place).

lays_eggs :-
    yes(lays_eggs),
    !.

lays_eggs :-
    no(lays_eggs),
    !,
    fail.

lays_eggs :-
    ask(lays, eggs).

/* ---------- Question System ---------- */

ask(Verb, Trait) :-
    format('Does the animal ~w ~w? (yes/no): ', [Verb, Trait]),
    read(Reply),
    nl,
    (
        (Reply == yes ; Reply == y)
        ->
        assertz(yes(Trait))
        ;
        assertz(no(Trait)),
        fail
    ).

/* ---------- Clear Memory ---------- */

undo :-
    retract(yes(_)),
    fail.

undo :-
    retract(no(_)),
    fail.

undo.
