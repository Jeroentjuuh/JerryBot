:-dynamic task/3,			% Id, Task, Type
	ownMain/3,		% X, Y, Region
	ownBase/4,		% NexusId, X, Y, Region
	naturalExpansion/3,	% X, Y, Region
	naturalChokepoint/4,	% X1, Y1, X2, Y2
	agent/2,		% Id, Agent. This is for linking a ID with a agent.
	mineralField/4,
	mineralFieldWorkers/5,	% MineralFieldId, X, Y, Region, Amount
	mineralPatches/2,
	mineralWorkersRegion/2,	% RegionId, Amount
	base/6,
	chokepoint/6,
	region/5,
	enemyPlayer/2,
	resources/4,
	sendInitialTask/3.	% Used to keep track of probes that still need a initialTask

% Calculate distance between two points
distanceSqrt(X1, Y1, X2, Y2, D) :- D is sqrt((X2 - X1)**2 + (Y2 - Y1)**2).
% Calculate distance between two points, but do not root it (faster)
distance(X1, Y1, X2, Y2, D) :- D is (X2 - X1)**2 + (Y2 - Y1)**2.

bestMineralField(RegionId, MineralFieldId) :-
	ownBase(_, Xb, Yb, RegionId),
	mineralFieldWorkers(MineralFieldId, X1, Y1, RegionId, N1),
	distance(Xb, Yb, X1, Y1, D1),
	\+ (mineralFieldWorkers(_, X2, Y2, RegionId, N2),
		(N2 > N1;
		(N2 == N1, distance(Xb, Yb, X2, Y2, D2), D2 < D1))).