:- consult("UnityLogic/KBs/UnityLogicAgentAPI.prolog").
add pickUp(Box) && true =>[
    add_belief(busy),
    check_artifact_belief(Box, start(Start)),
    check_artifact_belief(Box, destination(Destination)),
    check_agent_belief(Start,area(StartArea)),
    check_agent_belief(Destination,area(DestinationArea)),
    StartArea\=DestinationArea,
    cr goto(Box),
    act pickUp(Box),
    act (getExchangeArea,ExchangeArea),
    cr goto(ExchangeArea),
    act dropDown(ExchangeArea),
    act (getSortingBot,Bot),
    Bot\=false,
    add_agent_desire(Bot,pickUp(Box)),
    act (getChargingStation,Station),
    cr goto(Station),
    del_belief(busy),
    stop
].


add pickUp(Box) && true => [
    check_artifact_belief(Box, start(Start)),
    check_artifact_belief(Box, destination(Destination)),
    check_agent_belief(Start,area(StartArea)),
    check_agent_belief(Destination,area(DestinationArea)),
    StartArea=DestinationArea,
    add_desire(delivery(Box)),
    stop
].
add delivery(Box) && true =>[
    add_belief(busy),
    cr goto(Box),
    act pickUp(Box),
    check_artifact_belief(Box, start(Start)),
    check_agent_belief(Start,area(StartArea)),
    act (getArea(StartArea),Platform),
    cr goto(Platform),
    act dropDown(Platform),
    add_desire(call_drone(Box)),
    act (getChargingStation,Station),
    cr goto(Station),
    del_belief(busy),
    stop
].

add call_drone(Box) && true => [
    act (getDrone,Drone),
    Drone\=false,
   ( 
       not(check_agent_belief(Drone,busy)), 
        add_agent_belief(Drone,busy) 
    ), 
    (
        add_agent_desire(Drone,delivery(Box)),
        add_agent_belief(Drone,delivery(Box))
    ),
    stop
].