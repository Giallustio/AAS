
if (btc_respawn_onTL) then {
	
	if !(leader (group player) isEqualTo player) then {
		diag_log "TESTING - He's not the leader";
		[] spawn {
			diag_log "TESTING - Wait for the dialog";
			waitUntil {(uiNamespace getVariable ["BIS_RscRespawnControlsMap_shown", false])};
			diag_log "TESTING - Adding resp pos";
			_id = [player, (leader group player), "Team Leader"] call BIS_fnc_addRespawnPosition;
			waitUntil {!dialog};
			diag_log "TESTING - Removing resp pos";
			_id call BIS_fnc_removeRespawnPosition;
		};
	} else {diag_log "TESTING - He's the leader";};
};