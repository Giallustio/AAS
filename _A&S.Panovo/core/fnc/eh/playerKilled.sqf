
if (btc_respawn_onSL isEqualTo 1 && {!((leader group player) isEqualto player)}) then {
	if (btc_isAce && {(leader group player) getVariable "ACE_isUnconscious"}) exitWith {};
	_id = [player, (leader group player)] call BIS_fnc_addRespawnPosition;
	_id spawn {
		waitUntil {Alive player};
		(_this) call BIS_fnc_removeRespawnPosition;
	};
};