main :-
  intro,
  resetAnswers,
  testFengshui,nl.

intro.

intro :-
  write('Feng Shui Expert System'), nl, nl.

testFengshui :-
  result(_), !.

% Store user answers to be able to track his progress
:- dynamic(progress/2).

% Clear stored user progress
resetAnswers :-
  retract(progress(_, _)),
  fail.
resetAnswers.

% =====
% Rules
% =====
fengshui(RulesCF) :-
  decoration_effort(CF1),
  patience(CF2),
  larger_than_CF(CF1),
  larger_than_CF(CF2),
  calculateCF([CF1, CF2], 100, RulesCF).

writeCombinedCF(CF1, CF2, CombinedCF) :-
  write('====='), nl,
  write('CF1: '), write(CF1), nl,
  write('CF2: '), write(CF2), nl,
  write('CombinedCF: '), write(CombinedCF), nl,
  write('====='), nl.

writeCombinedCF(CF1, CF2, CF3, CombinedCF) :-
  write('====='), nl,
  write('CF1: '), write(CF1), nl,
  write('CF2: '), write(CF2), nl,
  write('CF3: '), write(CF3), nl,
  write('CombinedCF: '), write(CombinedCF), nl,
  write('====='), nl.

%=======
%Subject
%=======

questionaire(computing, CombinedCF, E) :-
  fengshui(CF1),
  decorating(no),
  sensitivity_of_surrounding(CF2),
  position_of_furniture(yes),
  brightness_of_house(yes),
  location(yes),
  larger_than_CF(CF1),
  larger_than_CF(CF2),
  calculateCF([CF1, CF2], 100, CombinedCF),
  % Debug
  writeCombinedCF(CF1, CF2, CombinedCF),
  E = 'You do not like decorating. \c
  However, you mind about the location you are in.'.

questionaire(computing, CombinedCF, E) :-
  sensitivity_of_surrounding(CF1),
  brightness_of_house(no),
  location(yes),
  larger_than_CF(CF1),
  calculateCF([CF1], 85, CombinedCF),
  % Debug
  writeCombinedCF(CF1, 100, CombinedCF),
  E = 'You are in a good location.'.

questionaire(computing, CombinedCF, E) :-
  position_of_furniture(yes),
  most_importance(aesthetic),
  calculateCF([CF1], 70, CombinedCF),
  % Debug
  writeCombinedCF(100, 100, CombinedCF),
  E = 'Position of furniture is important to you.'.

questionaire(engineering, CombinedCF, E) :-
  fengshui(CF1),
  tidy(yes),
  north_or_south(south),
  sensitivity_of_surrounding(CF2),
  mirror_in_hallway(yes),
  brightness_of_house(yes),
  larger_than_CF(CF1),
  larger_than_CF(CF2),
  calculateCF([CF1, CF2], 100, CombinedCF),
  E = 'You keep your home tidy. \c
  You mind alot about where things should be. \c
  You are very sensentive about the things that should be in your home. \c'.


questionaire(engineering, CombinedCF, E) :-
  tidy(yes),
  most_importance(tidy),
  north_or_south(south),
  sensitivity_of_surrounding(CF1),
  mirror_in_hallway(yes),
  larger_than_CF(CF1),
  calculateCF([CF1], 90, CombinedCF),
  E = 'You love keeping your home tidy but dont really care \c
  about the positioning of your home. \c'.

% Subject: tidy
questionaire(tidy, CombinedCF, E) :-
  fengshui(CF1),
  tidy(yes),
  sensitivity_of_surrounding(CF2),
  north_or_south(north),
  brightness_of_house(yes),
  most_importance(tidy),
  larger_than_CF(CF1),
  larger_than_CF(CF2),
  calculateCF([CF1, CF2], 90, CombinedCF),
  E = 'Your home has a good brightness level'.

questionaire(tidy, CombinedCF, E) :-
  tidy(yes),
  north_or_south(north),
  calculateCF([100], 80, CombinedCF),
  E = 'You seem to keep your home tidy, and your kitchen is facing north. \c
  Which shows that the position of the home and is decent and you care about that'.

% Subject: vibe
questionaire(vibe, CombinedCF, E) :-
  accessibilities(yes),
  communicating_with_people(CF1),
  hot_or_not(yes),
  risk(CF2),
  larger_than_CF(CF1),
  larger_than_CF(CF2),
  calculateCF([CF1, CF2], 80, CombinedCF),
  E = 'The home you have chosen has good accessibilities nearby \c'.

questionaire(vibe, CombinedCF, E) :-
  accessibilities(yes),
  communicating_with_people(CF1),
  most_importance(vibe),
  hot_or_not(yes),
  larger_than_CF(CF1),
  calculateCF([CF1], 80, CombinedCF),
  E = ''.

% Subject: Art
questionaire(art, CombinedCF, E) :-
  imagination(CF1),
  tidy(no),
  balcony_facing_north(yes),
  brightness_of_house(no),
  cooking_stove_beside_bathroom(yes),
  larger_than_CF(CF1),
  calculateCF([CF1], 100, CombinedCF),
  E = 'You do not care much about your home.'.

questionaire(art, CombinedCF, E) :-
  tidy(no),
  balcony_facing_north(yes),
  brightness_of_house(no),
  calculateCF([100], 90, CombinedCF),
  E = 'You are a do not care about the brigthness of your home.\c
  And you want your balcony to be facing north.\c.'.

% Subject: Hospitality
questionaire(hospitality, CombinedCF, E) :-
  position_of_furniture(no),
  accessibilities(yes),
  hot_or_not(yes),
  bathroom_aligned_with_front_door(yes),
  living_room_near_front_door(yes),
  calculateCF([100], 90, CombinedCF),
  E = 'The positioning of the home is good but the positioning of the furniture should be better.'.

questionaire(hospitality, CombinedCF, E) :-
  position_of_furniture(no),
  bathroom_aligned_with_front_door(yes),
  living_room_near_front_door(yes),
  calculateCF([100], 90, CombinedCF),
  E = 'The positioning of the home is good but the positioning of the furniture should be better.'.

questionaire(hospitality, CombinedCF, E) :-
  position_of_furniture(no),
  living_room_near_front_door(yes),
  calculateCF([100], 90, CombinedCF),
  E = ''.

% Test: yes tidy
result(yes_tidy) :-
  questionaire(computing, CF1, E),
  yes_systems(CF2),
  aesthetic(CF3),
  larger_than_CF(CF1),
  larger_than_CF(CF2),
  larger_than_CF(CF3),
  calculateCF([CF1, CF2, CF3], 100, CF),
  % Debug
  writeCombinedCF(CF1, CF2, CF3, CF),
  nl, write('Feng Shui Level: yes tidy '),
  write('(cf '), write(CF), write(')'), nl,
  write(E),nl,
  write('You are interested in the details of how yes systems or software works.\c
  You also prefer to develop aesthetic rather than apply aesthetic.\c
  So, you are suitable for the result of yes tidy.').



% Test: Information aesthetic
result(information_aesthetic) :-
  questionaire(computing, CF1, E),
  accessibilities(CF2),
  hot_or_not(yes),
  larger_than_CF(CF1),
  larger_than_CF(CF2),
  calculateCF([CF1, CF2], 100, CF),
  % Debug
  writeCombinedCF(CF1, CF2, CF),
  nl, write('Feng Shui Level: Good'),
  write('(cf '), write(CF), write(')'), nl,
  write(E),nl,
  write('The fengshui of the home is good but you should improve on certain things such as decoration').

result(information_aesthetic) :-
  questionaire(computing, CF1, E),
  larger_than_CF(CF1),
  calculateCF([CF1], 70, CF),
  % Debug
  writeCombinedCF(CF1, 100, CF),
  nl, write('Feng Shui Level: Good '),
  write('(cf '), write(CF), write(')'), nl,
  write(E),nl,
  write('The fengshui of the home you have chosen is good').


% Test: Electrical Engineering
result(electrical_engineering) :-
  questionaire(engineering, CF1, E),
  larger_than_CF(CF1),
  decorating(yes),
  playground_nearby(yes),
  calculateCF([CF1], 90, CF),
  nl, write('Feng Shui Level:Great '),
  write('(cf '), write(CF), write(')'), nl,
  write(E),nl,
  write('You like decorating and like to have a playground nearby. \c
  Congratulations, the home you have chosen has a great surrounding and fengshui').

% Test: Mechanical Engineering
result(mechanical_engineering) :-
  questionaire(engineering, CF1, E),
  larger_than_CF(CF1),
  decorating(yes),
  calculateCF([CF1], 90, CF),
  nl, write('Feng Shui Level: Awesome '),
  write('(cf '), write(CF), write(')'), nl,
  write(E),nl,
  write('You like decorating. Your home has all the criterias of a home \c
  that has astounding fengshui. Congratulations').

% Test: Chemical Engineering
result(chemical_engineering) :-
  questionaire(engineering, CF1, E),
  larger_than_CF(CF1),
  furnish(yes),
  calculateCF([CF1], 90, CF),
  nl, write('Feng Shui Level: Great '),
  write('(cf '), write(CF), write(')'), nl,
  write(E),nl,
  write('Congratulations the home you have picked has great fengshui').

% Test: Bioaesthetic
result(bioaesthetic) :-
  questionaire(tidy, CF1, E),
  larger_than_CF(CF1),
  cleaning(yes),
  dusty(yes),
  calculateCF([CF1], 90, CF),
  nl, write('Feng Shui Level: Good '),
  write('(cf '), write(CF), write(')'), nl,
  write(E),nl,
  write('You like cleaning. The house you have chosen has a not bad fengshui').

result(pure_tidy) :-
  questionaire(tidy, CF1, E),
  larger_than_CF(CF1),
  calculateCF([CF1], 90, CF),
  nl, write('Feng Shui Level: Good. '),
  write('(cf '), write(CF), write(')'), nl,
  write(E),nl,
  write('You are in a good place.').

% Test: Marketing
result(marketing) :-
  questionaire(vibe, CF1, E),
  larger_than_CF(CF1),
  nature_nearby(yes),
  calculateCF([CF1], 90, CF),
  nl, write('Feng Shui Level: Not bad '),
  write('(cf '), write(CF), write(')'), nl,
  write(E),nl,
  write('There is good greenery nearby. Fengshui is decent').

% Test: Accounting
result(accounting) :-
  questionaire(vibe, CF1, E),
  larger_than_CF(CF1),
  brightness_of_house(yes),
  noise_nearby(yes),
  calculateCF([CF1], 90, CF),
  nl, write('Feng Shui Level: Not good '),
  write('(cf '), write(CF), write(')'), nl,
  write(E),nl,
  write('The house you have chosen does not have a good fengshui. We do not recommend this home choice').

% Test: vibe Management
result(vibe_management) :-
  questionaire(vibe, CF1, E),
  larger_than_CF(CF1),
  calculateCF([CF1], 90, CF),
  nl, write('Feng Shui Level: Neutral '),
  write('(cf '), write(CF), write(')'), nl,
  write(E),nl,
  write('This is a common home. Fengshui is neither good nor bad').

% Test: vase_in_living_room Art
result(vase_in_living_room_art) :-
  questionaire(art, CF1, E),
  larger_than_CF(CF1),
  traffic_congestion(yes),
  hospital_nearby(no),
  vase_in_living_room(yes),
  calculateCF([CF1], 90, CF),
  nl, write('Feng Shui Level: Very Bad '),
  write('(cf '), write(CF), write(')'), nl,
  write(E),nl,
  write('You have chosen a home with very bad fengshui. We advise you pick another home').

% Test: Digital house_facing_crossroad Production
result(digital_house_facing_crossroad_production) :-
  questionaire(art, CF1, E),
  larger_than_CF(CF1),
  hospital_nearby(yes),
  house_facing_crossroad(yes),
  calculateCF([CF1], 90, CF),
  nl, write('Feng Shui Level: Bad '),
  write('(cf '), write(CF), write(')'), nl,
  write(E),nl,
  write('Home chosen has bad fengshui. You prefer a home with a hospital nearby.\c
  But you do not mind your home being in front of a crossroad.').


% Test: Culinary Art
result(culinary_art) :-
  questionaire(hospitality, CF1, E),
  larger_than_CF(CF1),
  cook(yes),
  calculateCF([CF1], 100, CF),
  nl, write('Feng Shui Level: Neutral '),
  write('(cf '), write(CF), write(')'), nl,
  write(E),nl,
  write('').

% Test: Hotel Management
result(hotel_management) :-
  questionaire(hospitality, CF1, E),
  larger_than_CF(CF1),
  calculateCF([CF1], 100, CF),
  nl, write('Feng Shui Level: Neutral'),
  write('(cf '), write(CF), write(')'), nl,
  write(E),nl,
  write('').


%WE TESTING STUFFS MAN

questionaire(computing, CombinedCF, E) :-
  fengshui(CF1),
  decorating(no),
  sensitivity_of_surrounding(CF2),
  position_of_furniture(yes),
  brightness_of_house(yes),
  location(yes),
  larger_than_CF(CF1),
  larger_than_CF(CF2),
  calculateCF([CF1, CF2], 100, CombinedCF),
  % Debug
  writeCombinedCF(CF1, CF2, CombinedCF),
  E = ''.

% Test: yes tidy
result(yes_tidy) :-
  questionaire(computing, CF1, E),
  yes_systems(CF2),
  aesthetic(CF3),
  larger_than_CF(CF1),
  larger_than_CF(CF2),
  larger_than_CF(CF3),
  calculateCF([CF1, CF2, CF3], 100, CF),
  % Debug
  writeCombinedCF(CF1, CF2, CF3, CF),
  nl, write('Feng Shui Level: Good '),
  write('(cf '), write(CF), write(')'), nl,
  write(E),nl,
  write('').

questionaire(badFengshui, CombinedCF, E) :-
  position_of_furniture(no),
  living_room_near_front_door(no),
  balcony_facing_north(no),
  tidy(no),
  decoration_effort(CF1),
  sensitivity_of_surrounding(CF2),
  calculateCF([100], 90, CombinedCF),
  E = 'The home you have chosen has horrible fengshui. We suggest you pick another home'.

result(bad_result) :-
  questionaire(badFengshui, CF1, E),
  larger_than_CF(CF1),
  calculateCF([CF1], 90, CF),
  nl, write('Feng Shui Level: Very Bad '),
  write('(cf '), write(CF), write(')'), nl,
  write(E),nl,
  write('This home is bad!').

% Test: Unknown
result(unknown) :-
  nl, write('Feng Shui Level: Unknown '),
  write('(cf '), write('Unknown'), write(')'), nl,
  write('Sorry. We cannot help you because you have a \c
    a variety of traits.').

% ===========
% Uncertainty
% ===========
calculateCF(CFList, CF, RulesCF) :-
  min_in_list(CFList, Min), !,
  RulesCF is div(Min * CF, 100),
  larger_than_CF(RulesCF).

larger_than_CF(CF):-
  CF > 60.

min_in_list([Min],Min).
min_in_list([H,K|T],M) :-
    H =< K,
    min_in_list([H|T],M).
min_in_list([H,K|T],M) :-
    H > K,
    min_in_list([K|T],M).

% =========
% Questions
% =========

% CF 100
question(tidy) :-
  nl, write('Do you like Furnish/Cleaning/Decorating?'), nl.
question(decorating) :-
  nl, write('Is decoration important to you?'), nl.
question(location) :-
  nl, write('Do you care about your home location?'), nl.
question(position_of_furniture) :-
  nl, write('Is the furniture of the home to your liking?'), nl.
question(brightness_of_house) :-
  nl, write('Is your house painted with bright color?'), nl.
question(most_importance) :-
  nl, write('If given a choice, which most importance criteria of your house?'), nl.
question(north_or_south) :-
  nl, write('Is your kitchen facing north or south?'), nl.
question(mirror_in_hallway) :-
  nl, write('Is there a mirror in your hallway?'), nl.
question(hot_or_not) :-
  nl, write('Is your house usually hot in the afternoon.'), nl.
question(balcony_facing_north) :-
  nl, write('Is your balcony facing north?'), nl.
question(cooking_stove_beside_bathroom) :-
  nl, write('Is your cooking stove beside bathroom?'), nl.
question(bathroom_aligned_with_front_door) :-
  nl, write('Is your bathroom aligned with front door?'), nl.
question(living_room_near_front_door) :-
  nl, write('Is your living room near front door?'), nl.

% CF Unknown
question(decoration_effort) :-
  nl, write('I put in _____ amount of effort into decorating my house.'), nl.
question(imaginatiion) :-
  nl, write('Are you a person of imagination?'), nl.
question(patience) :-
  nl, write('I have _____ amount of patience when choosing a home.'), nl.
question(sensitivity_of_surrounding) :-
  nl, write('I have _____ sensitivity towards the surrounding of my home.'), nl.
question(risk) :-
  nl, write('I like to take risk'), nl.
question(communicating_with_people) :-
  nl, write('Rate 1 to 5, where 1 refers to weak and 5 refers to excellent, '), nl,
  write('How good are you in dealing with people?'), nl.
question(accessibilities) :-
  nl, write('The house have _____ accessibilities to daily goods.'), nl.

% yes tidy
% question(yes_systems) :-
%   nl, write('I am interested in the details of how yes systems or software works.'), nl.
% question(aesthetic) :-
%   nl, write('I prefer to develop aesthetic rather than apply aesthetic.'), nl.

% Question for Engineering
question(playground_nearby) :-
  nl, write('Is there a playground nearby?'), nl.
question(furnish) :-
  nl, write('Do you care about furnishing of the house?'), nl.

% Question for tidy
question(cleaning) :-
  nl, write('Do you like cleaning?'), nl.
question(dusty) :-
  nl, write('Is your house dusty?'), nl.

% Question for vibe
question(noise_nearby) :-
  nl, write('Is it noisy around the house?'), nl.
question(nature_nearby) :-
  nl, write('Is there a good amount of nature nearby?'), nl.

% Question for Arts
question(traffic_congestion) :-
  nl, write('Is there a lot of traffic congestion?'), nl.
question(hospital_nearby) :-
  nl, write('Is there a hospital nearby?'), nl.
question(house_facing_crossroad) :-
  nl, write('Is your house facing a cross road?'), nl.
question(vase_in_living_room) :-
  nl, write('Is there a vase in your living room?'), nl.

% Question for Hospitality
question(sharp_edges) :-
  nl, write('Is there a lot of sharp edges around the house?'), nl.

% ========
% Answers
% ========
% answer(yes) :-
%   write('Yes.').
% answer(no) :-
%   write('No.'), nl.

answer(vibe) :-
  write('Vibe - The surrounding of your house.').
answer(aesthetic) :-
  write('Aesthetic - The looking of your house.').
answer(tidy) :-
  write('Tidy - The tidiness of your house.'), nl.

answer(north) :-
  write('Facing north.').
answer(south) :-
  write('Facing south.'), nl.

answer(house_facing_crossroad) :-
  write('I prefer shooting house_facing_crossroad.').
answer(perform) :-
  write('I prefer vase_in_living_room.'), nl.

answer(yes) :-
  write('Yes.').
answer(no) :-
  write('No.'), nl.

answer(bad) :-
  write('Bad').
answer(notBad) :-
  write('Not bad').
answer(neutral) :-
  write('Neutral').
answer(good) :-
  write('Good').
answer(great) :-
  write('Great'), nl.


% ==========================
% Assign Answer to Questions
% ==========================
tidy(Answer) :-
  progress(tidy, Answer).
tidy(Answer) :-
  \+ progress(tidy, _),
  ask(tidy, Answer, [yes, no]).
decorating(Answer) :-
  progress(decorating, Answer).
decorating(Answer) :-
  \+ progress(decorating, _),
  ask(decorating, Answer, [yes, no]).
cleaning(Answer) :-
  progress(cleaning, Answer).
cleaning(Answer) :-
  \+ progress(cleaning, _),
  ask(cleaning, Answer, [yes, no]).
location(Answer) :-
  progress(location, Answer).
location(Answer) :-
  \+ progress(location, _),
  ask(location, Answer, [yes, no]).
brightness_of_house(Answer) :-
  progress(brightness_of_house, Answer).
brightness_of_house(Answer) :-
  \+ progress(brightness_of_house, _),
  ask(brightness_of_house, Answer, [yes, no]).
position_of_furniture(Answer) :-
  progress(position_of_furniture, Answer).
position_of_furniture(Answer) :-
  \+ progress(position_of_furniture, _),
  ask(position_of_furniture, Answer, [yes, no]).
most_importance(Answer) :-
  progress(most_importance, Answer).
most_importance(Answer) :-
  \+ progress(most_importance, _),
  ask(most_importance, Answer, [vibe, aesthetic, tidy]).
north_or_south(Answer) :-
  progress(north_or_south, Answer).
north_or_south(Answer) :-
  \+ progress(north_or_south, _),
  % ask(north_or_south, Answer, [north, south]).
  ask(north_or_south, Answer, [north, south]).
mirror_in_hallway(Answer) :-
  progress(mirror_in_hallway, Answer).
mirror_in_hallway(Answer) :-
  \+ progress(mirror_in_hallway, _),
  ask(mirror_in_hallway, Answer, [yes, no]).
hot_or_not(Answer) :-
  progress(hot_or_not, Answer).
hot_or_not(Answer) :-
  \+ progress(hot_or_not, _),
  ask(hot_or_not, Answer, [yes, no]).
living_room_near_front_door(Answer) :-
  progress(living_room_near_front_door, Answer).
living_room_near_front_door(Answer) :-
  \+ progress(living_room_near_front_door, _),
  ask(living_room_near_front_door, Answer, [yes, no]).
bathroom_aligned_with_front_door(Answer) :-
  progress(bathroom_aligned_with_front_door, Answer).
bathroom_aligned_with_front_door(Answer) :-
  \+ progress(bathroom_aligned_with_front_door, _),
  ask(bathroom_aligned_with_front_door, Answer, [yes, no]).
balcony_facing_north(Answer) :-
  progress(balcony_facing_north, Answer).
balcony_facing_north(Answer) :-
  \+ progress(balcony_facing_north, _),
  ask(balcony_facing_north, Answer, [yes, no]).

cooking_stove_beside_bathroom(Answer) :-
  progress(cooking_stove_beside_bathroom, Answer).
cooking_stove_beside_bathroom(Answer) :-
  \+ progress(cooking_stove_beside_bathroom, _),
  ask(cooking_stove_beside_bathroom, Answer, [yes, no]).

playground_nearby(Answer) :-
  progress(playground_nearby, Answer).
playground_nearby(Answer) :-
  \+ progress(playground_nearby, _),
  ask(playground_nearby, Answer, [yes, no]).

dusty(Answer) :-
  progress(dusty, Answer).
dusty(Answer) :-
  \+ progress(dusty, _),
  ask(dusty, Answer, [yes, no]).

nature_nearby(Answer) :-
  progress(nature_nearby, Answer).
nature_nearby(Answer) :-
  \+ progress(nature_nearby, _),
  ask(nature_nearby, Answer, [yes, no]).

noise_nearby(Answer) :-
  progress(noise_nearby, Answer).
noise_nearby(Answer) :-
  \+ progress(noise_nearby, _),
  ask(noise_nearby, Answer, [yes, no]).

% Art
traffic_congestion(Answer) :-
  progress(traffic_congestion, Answer).
traffic_congestion(Answer) :-
  \+ progress(traffic_congestion, _),
  ask(traffic_congestion, Answer, [yes, no]).

hospital_nearby(Answer) :-
  progress(hospital_nearby, Answer).
hospital_nearby(Answer) :-
  \+ progress(hospital_nearby, _),
  ask(hospital_nearby, Answer, [yes, no]).

house_facing_crossroad(Answer) :-
  progress(house_facing_crossroad, Answer).
house_facing_crossroad(Answer) :-
  \+ progress(house_facing_crossroad, _),
  ask(house_facing_crossroad, Answer, [yes, no]).

vase_in_living_room(Answer) :-
  progress(vase_in_living_room, Answer).
vase_in_living_room(Answer) :-
  \+ progress(vase_in_living_room, _),
  ask(vase_in_living_room, Answer, [yes, no]).

% Hospitality
sharp_edges(Answer) :-
  progress(sharp_edges, Answer).
sharp_edges(Answer) :-
  \+ progress(sharp_edges, _),
  ask(sharp_edges, Answer, [yes, no]).

decoration_effort(Answer) :-
  progress(decoration_effort, Answer).
decoration_effort(Answer) :-
  \+ progress(decoration_effort, _),
  ask_with_cf(decoration_effort, Answer, [bad, notBad, neutral, good, great]).

imagination(Answer) :-
  progress(imagination, Answer).
imagination(Answer) :-
  \+ progress(imagination, _),
  ask_with_cf(imagination, Answer, [bad, notBad, neutral, good, great]).

patience(Answer) :-
  progress(patience, Answer).
patience(Answer) :-
  \+ progress(patience, _),
  ask_with_cf(patience, Answer, [bad, notBad, neutral, good, great]).

sensitivity_of_surrounding(Answer) :-
  progress(sensitivity_of_surrounding, Answer).
sensitivity_of_surrounding(Answer) :-
  \+ progress(sensitivity_of_surrounding, _),
  ask_with_cf(sensitivity_of_surrounding, Answer, [bad, notBad, neutral, good, great]).

yes_systems(Answer) :-
  progress(yes_systems, Answer).
yes_systems(Answer) :-
  \+ progress(yes_systems, _),
  ask_with_cf(yes_systems, Answer, [bad, notBad, neutral, good, great]).

aesthetic(Answer) :-
  progress(aesthetic, Answer).
aesthetic(Answer) :-
  \+ progress(aesthetic, _),
  ask_with_cf(aesthetic, Answer, [bad, notBad, neutral, good, great]).

risk(Answer) :-
  progress(risk, Answer).
risk(Answer) :-
  \+ progress(risk, _),
  ask_with_cf(risk, Answer, [bad, notBad, neutral, good, great]).

communicating_with_people(Answer) :-
  progress(communicating_with_people, Answer).
communicating_with_people(Answer) :-
  \+ progress(communicating_with_people, _),
  ask_with_cf(communicating_with_people, Answer, [bad, notBad, neutral, good, great]).

accessibilities(Answer) :-
  progress(accessibilities, Answer).
accessibilities(Answer) :-
  \+ progress(accessibilities, _),
  ask_with_cf(accessibilities, Answer, [bad, notBad, neutral, good, great]).
% Outputs a nicely formatted list of answers
% [First|Rest] is the Choices list, Index is the index of First in Choices
answers([], _).
answers([First|Rest], Index) :-
  write(Index), write(' '), answer(First), nl,
  NextIndex is Index + 1,
  answers(Rest, NextIndex).

% Parses an Index and returns a Response representing the "Indexth" element in
% Choices (the [First|Rest] list)
parse(0, [First|_], First).
parse(Index, [_First|Rest], Response) :-
  Index > 0,
  NextIndex is Index - 1,
  parse(NextIndex, Rest, Response).

% Asks the Question to the user and saves the Answer
ask(Question, Answer, Choices) :-
  question(Question),
  answers(Choices, 0),
  read(Index),
  parse(Index, Choices, Response),
  asserta(progress(Question, Response)),
  Response = Answer.

% Asks the Question to the user and saves the Answer
ask_with_cf(Question, Answer, Choices) :-
  question(Question),
  answers(Choices, 1),
  read(Index),
  CF is Index * 20,
  asserta(progress(Question, CF)),
  CF = Answer.
