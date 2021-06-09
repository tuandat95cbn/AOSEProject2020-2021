:- consult("UnityLogic/KBs/UnityLogicAgentAPI.prolog").
add call_drone(Box) && true => [
    act (getDrone, Drone),
    Drone\=false,
    ( 
       not(check_agent_belief(Drone, busy)), 
        add_agent_belief(Drone,busy) 
    ), 
    (
        add_agent_desire(Drone,pickUp(Box)),
        add_agent_belief(Drone,pickUp(Box))
    ),
    stop
].

add recieve(Box) && true =>[
    act destroy(Box),
    act (getManager, GameManager),
    add_agent_desire(GameManager,notify(Box)),
    stop
].