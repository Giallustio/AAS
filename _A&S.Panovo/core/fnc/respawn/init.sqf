if (btc_respawn_mobile) then {
	btc_respawn_mobileVehicle = btc_respawn_mobileType createVehicle btc_combatSupportPos;
	_id = [btc_player_side, btc_respawn_mobileVehicle, "Mobile respawn"] call BIS_fnc_addRespawnPosition;
	missionNameSpace setVariable ["btc_respawn_mobile",_id];
	btc_respawn_mobileVehicle addEventHandler ["Killed", btc_fnc_respawn_mobileKilled];
};