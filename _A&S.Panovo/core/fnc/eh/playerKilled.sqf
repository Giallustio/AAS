
if (btc_respawn_onSL isEqualTo 1 && {!((leader group player) isEqualto player)}) then {
	_id = [player, (leader group player)] call BIS_fnc_addRespawnPosition;
	_id spawn {
		waitUntil {Alive player};
		(_this) call BIS_fnc_removeRespawnPosition;
	};
};