:- consult("UnityLogic/KBs/UnityLogicAgentAPI.prolog").

desire generateBoxes.

add generateBoxes && true =>
[
	add_desire(createBox(1,1,8)),
	add_desire(createBox(2,7,0)),
	add_desire(createBox(3,2,3)),
	add_desire(createBox(4,4,5)),
	add_desire(createBox(5,5,2)),
	add_desire(createBox(6,3,0)),
	add_desire(wait(15)),
	add_desire(createBox(7,7,8)),
	add_desire(createBox(8,8,4)),
	add_desire(createBox(9,3,2)),
	add_desire(createBox(10,1,0)),
	add_desire(wait(15)),
	add_desire(createBox(11,1,8)),
	add_desire(createBox(12,7,0)),
	add_desire(createBox(13,2,3)),
	add_desire(createBox(14,4,5)),
	add_desire(createBox(15,5,2)),
	add_desire(createBox(16,3,0)),
	add_desire(wait(15)),
	add_desire(createBox(17,7,8)),
	add_desire(createBox(18,8,4)),
	add_desire(createBox(19,3,2)),
	add_desire(createBox(20,1,0)),
	add_desire(wait(15)),
	add_desire(createBox(21,1,8)),
	add_desire(createBox(22,7,0)),
	add_desire(createBox(23,2,3)),
	add_desire(createBox(24,4,5)),
	add_desire(createBox(25,5,2)),	
	stop
].

add createBox(Index,StartIndex, DestIndex) && true =>
[
	act printLog("createBox"),
	act (getArea(StartIndex), S),
	act (getArea(DestIndex), D),
	act (spawnBox(S, D), B),

	add_artifact_belief(B, start(S)),
	add_artifact_belief(B, destination(D)),

	add_agent_desire(S, call_drone(B)),

	stop
].

add wait(Seconds) && true =>
[
	cr waitForSeconds(Seconds),
	stop
].

add notify(Box) && true => [
	act notify,
	stop
].