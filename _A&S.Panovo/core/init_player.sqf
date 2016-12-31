
if (!btc_debug) then {removeAllWeapons player};
[] spawn {
	
	waitUntil {!isNull player};
	
	player setPos getMarkerPos btc_marker_respawn;
	
	player addEventHandler ["Respawn", btc_fnc_eh_playerRespawn];

	//Actions
	[] spawn btc_fnc_actions_init;

	//Dynamic groups
	if (btc_dynamicGroups) then {["InitializePlayer", [player]] call BIS_fnc_dynamicGroups;};
};



//Debug
if (btc_debug) then {
	player allowDamage false;
	onMapSingleClick "player setpos _pos";
	btc_marker_debug_cond = true;
	[] spawn btc_fnc_markerDebug;
	player setVariable ["btc_arty_operator",true];
};