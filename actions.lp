
%at each time instant, each robot must have a unique location
:- #count{X,Y : object(robot, R), value(at,pair(X,Y))} != 1, robot(R), T=0..h. 



%occurs(object(robot,'r'),move('dx','dy'),'t').
robot(R, X + dx, Y + dy, T + 1) :- occurs(object(robot,R), move(dx, dy), T).

% shelf moves locations with the robot that's carrying it
shelf(S, X + dx, Y + dy, T + 1) :- occurs(object(robot,R), move(dx, dy), T), holds(R, S, T).

% everything stays where it was if no movement is indicated (commonsense law of inertia)
robot(R, X,Y, T + 1) :- robot(R, X,Y, T), not not robot(R, X,Y, T + 1), T=0..h-1.
shelf(S, X,Y, T + 1) :- shelf(S, X,Y, T), not not shelf(S, X,Y, T + 1), T=0..h-1.
holds(R, S, T + 1) :- holds(R, S, T), not not holds(R, S, T + 1), T=0..h-1.

% can only move to an adjascent square
:- move(DX, DY), |DX| + |DY| != 1.


%occurs(object(robot,'r'),pickup,'t').
holds(R, S, T) :- occurs(object(robot,R), pickup, T), robot(R, X1,Y1, T1), shelf(S, X2,Y2, T2), X1=X2, Y1=Y2, T1=T2.

% can't pick something up that is not in the same square
:- occurs(object(robot,R), pickup, T), shelf(S, X1,Y1), robot(R, X2,Y2, T), |X1 - X2| + |Y1 - Y2| != 0.

%occurs(object(robot,'r'),deliver('o','i','u'),'t').



%occurs(object(robot,'r'),putdown,'t').
not holds(R, S, T + 1) :- occurs(object(robot,R), putdown, T), holds(R, S, T).

% can't put something down if it's not being carried
:- occurs(object(robot,R1), putdown, T1), holds(R2, S, T2), R1=R2, T1=T2.

% can't put something down in a highway square
:- occurs(object(robot,R), putdown, T0), robot(R, X1,Y1, T1), highway(H, X2,Y2), X1=X2, Y1=Y2, T0=T1.








% count the number of moves
%count(T) :- T = #count{T: occurs([something], T)}.

% minimize the number of moves
%#maximize{T : count(T)}.

#show occurs/3.