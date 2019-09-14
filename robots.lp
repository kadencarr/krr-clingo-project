%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% robots.lp
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% sort and object declaration
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% order object with indicated types available
object(node; highway; pickingStation; robot; shelf; product; order).

%initialize state based on input

%init(object(node,'n'),value(at,pair('x','y'))).
node(N, X,Y) :- init(object(node, N), value(at,pair(X,Y))).

%init(object(highway,'h'),value(at,pair('x','y'))).
highway(H, X,Y) :- init(object(highway, H), value(at,pair(X,Y))).

%init(object(pickingStation,'p'),value(at,pair('x','y'))).
pickingStation(P, X,Y) :- init(object(pickingStation, P), value(at,pair(X,Y))).

%init(object(robot,'r'),value(at,pair('x','y'))).
robot(R, X,Y, 0) :- init(object(robot, R), value(at,pair(X,Y))).

%init(object(shelf,'s'),value(at,pair('x','y'))).
shelf(S, X,Y, 0) :- init(object(shelf, S), value(at,pair(X,Y))).

%init(object(product,'i'),value(on,pair('s','u'))).
product(I, S,U) :- init(object(product, I), value(on,pair(S,U))).  % S is the shelf, U is the number of units on the shelf

%init(object(order,'o'),value(line,pair('i','u'))).
order(O, I,U) :- init(object(order, O), value(line,pair(I,U))).  % I is the product, U is the number of units ordered

%init(object(order,'o'),value(pickingStation,'p')).
order(O, P) :- init(object(order, O), value(pickingStation, P)).



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% state constraints
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% each robot has exactly one position at each time step
:- {robot(R, X,Y, T)} != 1, R=1..robotCount, T=0..h.

% no two occupants of the same square
:- robot(R1, X,Y, T), robot(R2, X,Y, T), R1!=R2.

% each robot can only hold one shelf
:- holds(R, S1, T), holds(R, S2, T), S1!=S2.

% if a robot is holding a shelf, the shelf has the same location as the robot
shelf(S, X,Y, T) :- holds(R, S, T).



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% effects and preconditions of actions
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%effect in head, action in body
%form occurs([object], [action], [time step]).

{occurs()}.  % action can occur or not (choice rule)





%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% action constraints
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% robots cannot swap squares
:- robot(R1, X1,Y1, T), robot(R2, X2,Y2, T), robot(R1, X2,Y2, T + 1), robot(R2, X1,Y1, T + 1), R1!=R2.

% robot can't go into a square with a shelf if it's already carrying a shelf
:- robot(R, X1,Y1, T), robot(R, X2,Y2, T + 1), holds(R, S1, T), shelf(S2, X2,Y2, T).


%occurs(object(robot,'r'), putdown,'t').
not holds(R, S, T + 1) :- occurs(object(robot,R), putdown, T), holds(R, S, T).


% can't put something down in a highway square
:- occurs(object(robot,R), putdown, T), robot(R, X,Y, T), highway(H, X,Y).











%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% domain independent axioms
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% everything stays where it was if no movement is indicated (commonsense law of inertia)
robot(R, X,Y, T + 1) :- robot(R, X,Y, T), not not robot(R, X,Y, T + 1), T=0..h-1.
shelf(S, X,Y, T + 1) :- shelf(S, X,Y, T), not not shelf(S, X,Y, T + 1), T=0..h-1.
holds(R, S, T + 1) :- holds(R, S, T), not not holds(R, S, T + 1), T=0..h-1.



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% goal
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%








#show robot/4.