player sideChat "Loading...";
enableSaving [false, false]; 
waituntil {!isnil "bis_fnc_init"};
#include "=BTC=_functions.sqf"
#include "=BTC=_definitions.sqf"
if (BTC_debug == 0) then {disableUserInput true;};
//Init Server
if (isServer) then
{
	call compile preprocessFile "init_server.sqf";
};
waituntil {!isnil "init_server_done"};
//Init Player
if (!isdedicated) then
{
	waitUntil {!isNull player};
	waitUntil {player == player};
	call compile preprocessFile "init_player.sqf";
};
if (BTC_debug == 0) then {disableUserInput false;};
player sideChat "Initialization Complete";
finishMissionInit;