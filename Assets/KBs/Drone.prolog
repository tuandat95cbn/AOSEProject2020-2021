:- consult("UnityLogic/KBs/UnityLogicAgentAPI.prolog").
belief battery(fully).

add pickUp(Box) && (\+ belief carrying, belief battery(fully) ) => [
    del_belief(pickUp(Box)),
    check_artifact_belief(Box, start(Start)),
    cr takeOff,
    cr goto(Start),
    cr land,
    act pickUp(Box),
    add_belief(carrying),
    cr takeOff,
    check_artifact_belief(Box, start(Start)),
    check_artifact_belief(Box, destination(Destination)),
    check_agent_belief(Start,area(StartArea)),
    check_agent_belief(Destination,area(DestinationArea)),
    act (getLandingZone(StartArea,DestinationArea),LandingZone),
    cr goto(LandingZone),
    cr land,
    act dropDown,
    del_belief(carrying),
    check_artifact_belief(Box, start(Start)),
    check_agent_belief(Start,area(StartArea)),
    act (getRailBot(StartArea),Bot),
    Bot\=false,
    add_agent_desire(Bot,pickUp(Box)),

    (
        del_belief(battery(fully)),
        add_belief(battery(partly))
    ),
    add_desire(idle),
    del_belief(busy),
    stop
].

add pickUp(Box) && (\+ belief carrying,belief battery(partly) ) => [
    del_belief(pickUp(Box)),
    check_artifact_belief(Box, start(Start)),
    cr takeOff,
    cr goto(Start),
    cr land,
    act pickUp(Box),
    add_belief(carrying),
    cr takeOff,
    check_artifact_belief(Box, start(Start)),
    check_artifact_belief(Box, destination(Destination)),
    check_agent_belief(Start,area(StartArea)),
    check_agent_belief(Destination,area(DestinationArea)),
    act (getLandingZone(StartArea,DestinationArea),LandingZone),
    cr goto(LandingZone),
    cr land,
    act dropDown,
    del_belief(carrying),
    check_artifact_belief(Box, start(Start)),
    check_agent_belief(Start,area(StartArea)),
    act (getRailBot(StartArea),Bot),
    Bot\=false,
    add_agent_desire(Bot,pickUp(Box)),
    (
        del_belief(battery(partly))
/*        add_belief(battery(empty)) */
    ),
    cr takeOff,
    act (getChargingStation,Station),
    cr goto(Station),
    cr land,
    add_belief(battery(fully)),
    del_belief(busy),
    stop
].


add delivery(Box) && (\+belief carrying,belief battery(fully)) =>[
    del_belief(delivery(Box)),
    cr takeOff,
    cr goto(Box),
    cr land,
    act pickUp(Box),
    add_belief(carrying),
    check_artifact_belief(Box, destination(Destination)),
    cr takeOff,
    cr goto(Destination),
    cr land,
    cr dropDown,
    del_belief(carrying),
    add_agent_desire(Destination,recieve(Box)),
    (
        del_belief(battery(fully)),
        add_belief(battery(partly))
    ),
    add_desire(idle),
    del_belief(busy),
    stop    
].


add delivery(Box) && (\+belief carrying,belief battery(partly)) =>[
    del_belief(delivery(Box)),
    cr takeOff,
    cr goto(Box),
    cr land,
    act pickUp(Box),
    add_belief(carrying),
    check_artifact_belief(Box, destination(Destination)),
    cr takeOff,
    cr goto(Destination),
    cr land,
    cr dropDown,
    del_belief(carrying),
    add_agent_desire(Destination,recieve(Box)),
    (
        del_belief(battery(partly))
        /*add_belief(battery(empty)) */
    ),
    cr takeOff,
    act (getChargingStation,Station),
    cr goto(Station),
    cr land,
    add_belief(battery(fully)),
    del_belief(busy),
    stop    
].

add idle && (\+ belief pickUp(_) ) =>[
    act printLog("idle"),
    cr takeOff,
    act (getChargingStation,Station),
    cr goto(Station),
    cr land,
    add_belief(battery(fully)),
    stop    
    
].
add idle && (\+belief delivery(_)) =>[
    act printLog("idle"),
    cr takeOff,
    act (getChargingStation,Station),
    cr goto(Station),
    cr land,
    add_belief(battery(fully)),
    stop    
    
].
add idle && (true) =>[
    act printLog("continue"),
    stop    
    
].