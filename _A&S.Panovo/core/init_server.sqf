
if (btc_isAce) then
{

};


if (btc_startLocationID > 99) then {
	btc_marker_respawn setMarkerPos (getMarkerPos (selectRandom btc_startLocations));
} else {
	btc_marker_respawn setMarkerPos (getMarkerPos (btc_startLocations select btc_startLocationID));
};

call btc_fnc_mission_createBase;

//Locations
//Pick user location
call btc_fnc_mission_initLocations;
/*
	edit the functions to support:
		- custom locations
			(maps locations + custom locations)
		- fixed mission locations
			(fixed locations only)
*/

btc_locs_max = count btc_locs;
btc_loc_active = objNull;
btc_loc_prev = objNull;
btc_locs_captured = 0;

[] call btc_fnc_mission_assignLocation;

addMissionEventHandler ["PlayerConnected",btc_fnc_jip];

//Dynamic groups
if (btc_dynamicGroups) then {["Initialize"] call BIS_fnc_dynamicGroups;};