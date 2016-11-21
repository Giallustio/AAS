/////////////////////SERVER\\\\\\\\\\\\\\\\\\\\\
if (isServer) then {
	//AI
	//btc_fnc_ai_find_pos = compile preprocessFile "core\fnc\ai\find_pos.sqf";

	//MISC
	btc_fnc_misc_createMarker = compile preprocessFile "core\fnc\misc\createMarker.sqf";
	btc_fnc_misc_createMarkerLocal = compile preprocessFile "core\fnc\misc\createMarkerLocal.sqf";
	btc_fnc_misc_createTrigger = compile preprocessFile "core\fnc\misc\createTrigger.sqf";

	//MISSION
	btc_fnc_mission_assignLocation = compile preprocessFile "core\fnc\mission\assignLocation.sqf";
	btc_fnc_mission_createLocation = compile preprocessFile "core\fnc\mission\createLocation.sqf";
	btc_fnc_mission_getNearestLocation = compile preprocessFile "core\fnc\mission\getNearestLocation.sqf";
	btc_fnc_mission_initLocations = compile preprocessFile "core\fnc\mission\initLocations.sqf";
	btc_fnc_mission_populateLocation = compile preprocessFile "core\fnc\mission\populateLocation.sqf";
	
};
/////////////////////CLIENT AND SERVER\\\\\\\\\\\\\\\\\\\\\

//COMMON



/////////////////////CLIENT\\\\\\\\\\\\\\\\\\\\\
if (!isDedicated) then {

};