/////////////////////SERVER\\\\\\\\\\\\\\\\\\\\\
if (isServer) then {
	//AI
	btc_fnc_ai_createGroupInf = compile preprocessFile "core\fnc\ai\createGroupInf.sqf";
	btc_fnc_ai_createGroupVeh = compile preprocessFile "core\fnc\ai\createGroupVeh.sqf";
	btc_fnc_ai_createSniper = compile preprocessFile "core\fnc\ai\createSniper.sqf";
	btc_fnc_ai_setSkill = compile preprocessFile "core\fnc\ai\setSkill.sqf";
	btc_fnc_ai_taskPatrol = compile preprocessFile "core\fnc\ai\taskPatrol.sqf";

	//MISC
	btc_fnc_createMarker = compile preprocessFile "core\fnc\misc\createMarker.sqf";
	btc_fnc_createMarkerLocal = compile preprocessFile "core\fnc\misc\createMarkerLocal.sqf";
	btc_fnc_createTrigger = compile preprocessFile "core\fnc\misc\createTrigger.sqf";
	btc_fnc_markerDebug = compile preprocessFile "core\fnc\misc\markerDebug.sqf";
	btc_fnc_objectsMapper = compile preprocessFile "core\fnc\misc\objectsMapper.sqf";
	btc_fnc_randomizePos = compile preprocessFile "core\fnc\misc\randomizePos.sqf";

	//MISSION
	btc_fnc_mission_assignLocation = compile preprocessFile "core\fnc\mission\assignLocation.sqf";
	btc_fnc_mission_createBase = compile preprocessFile "core\fnc\mission\createBase.sqf";
	btc_fnc_mission_createFortification = compile preprocessFile "core\fnc\mission\createFortification.sqf";
	btc_fnc_mission_createLocation = compile preprocessFile "core\fnc\mission\createLocation.sqf";
	btc_fnc_mission_getNearestLocation = compile preprocessFile "core\fnc\mission\getNearestLocation.sqf";
	btc_fnc_mission_initLocations = compile preprocessFile "core\fnc\mission\initLocations.sqf";
	btc_fnc_mission_locationCaptured = compile preprocessFile "core\fnc\mission\locationCaptured.sqf";
	btc_fnc_mission_populateLocation = compile preprocessFile "core\fnc\mission\populateLocation.sqf";
	
};
/////////////////////CLIENT AND SERVER\\\\\\\\\\\\\\\\\\\\\

//COMMON
btc_fnc_addArsenal = compile preprocessFile "core\fnc\misc\addArsenal.sqf";


/////////////////////CLIENT\\\\\\\\\\\\\\\\\\\\\
if (!isDedicated) then {

};