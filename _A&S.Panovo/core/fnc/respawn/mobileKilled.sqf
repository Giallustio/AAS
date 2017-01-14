
_id = missionNameSpace getVariable "btc_respawn_mobile";
_id call BIS_fnc_removeRespawnPosition;

[] spawn {
	sleep 30;
	btc_respawn_mobileVehicle = btc_respawn_mobileType createVehicle btc_combatSupportPos;
	_id = [btc_player_side, btc_respawn_mobileVehicle, "Mobile respawn"] call BIS_fnc_addRespawnPosition;
	missionNameSpace setVariable ["btc_respawn_mobile",_id];
};