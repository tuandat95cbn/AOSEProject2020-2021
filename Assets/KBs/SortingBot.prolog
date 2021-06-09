:- consult("UnityLogic/KBs/UnityLogicAgentAPI.prolog").
belief battery(fully).
add pickUp(Box) && (belief battery(fully)) =>[
    add_belief(busy),
    cr goto(Box),
    act pickUp(Box),
    check_artifact_belief(Box, destination(Destination)),
    check_agent_belief(Destination,area(DestinationArea)),
    act (getExchangeArea(DestinationArea),ExchangeArea),
    cr goto(ExchangeArea),
    act dropDown(ExchangeArea),
    act (getRailBot(DestinationArea),Bot),
    Bot\=false,
    /*(*/
    /*    not(check_agent_belief(Bot,busy)), */
    /*    add_agent_belief(Bot,busy) */
    /*), */
    add_agent_desire(Bot,delivery(Box)),
    del_belief(busy),
    (
        del_belief(battery(fully)),
        add_belief(battery(partly))
    ),
    stop
].


add pickUp(Box) && (belief battery(partly)) =>[
    add_belief(busy),
    cr goto(Box),
    act pickUp(Box),
    check_artifact_belief(Box, destination(Destination)),
    check_agent_belief(Destination,area(DestinationArea)),
    act (getExchangeArea(DestinationArea),ExchangeArea),
    cr goto(ExchangeArea),
    act dropDown(ExchangeArea),
    act (getRailBot(DestinationArea),Bot),
    Bot\=false,
    /*(*/
    /*    not(check_agent_belief(Bot,busy)), */
    /*    add_agent_belief(Bot,busy) */
    /*), */
    add_agent_desire(Bot,delivery(Box)),
    del_belief(busy),
    (
        del_belief(battery(partly)),
        add_belief(battery(empty))
    ),
    act (getChargingStation,Station),
    cr goto(Station),
    add_belief(battery(fully)),
    stop
].

add recharge && true => [
    act (getChargingStation,Station),
    cr goto(Station),
    add_belief(battery(fully)),
    stop
].
