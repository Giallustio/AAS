
private ["_loc","_radiusx","_radiusy","_marker_flag","_marker_circle"];

_loc = objNull;
if (btc_followOrder) then {
	_loc = btc_locs select btc_locs_captured;
} else {
	if (count _this isEqualTo 0) then {
		if (isNull btc_loc_active) then {
			_loc = [(getMarkerPos btc_marker_respawn)] call btc_fnc_mission_getNearestLocation;
			btc_loc_prev = btc_baseObject;
		} else {
			_loc = [btc_loc_active] call btc_fnc_mission_getNearestLocation;
			btc_loc_prev = btc_loc_active;
		};
	} else {
		_loc = _this select 0;
		if (isNull btc_loc_active) then {btc_loc_prev = btc_baseObject;} else {btc_loc_prev = btc_loc_active;}
	};
};

//Msg
[(_loc getvariable ["name", "error"]),(_loc getvariable ["id", -1]),position _loc] remoteExec ["btc_fnc_mission_assignLocationNotification",0]; 

_radiusx = _loc getVariable ["RadiusX",50];
_radiusy = _loc getVariable ["RadiusY",50];


//Spawn units

[_loc, ((_radiusx + _radiusy)/2)] call btc_fnc_mission_populateLocation;

_marker_flag = [format ["flag_%1",(position _loc)], position _loc,[1,1],"ICON","mil_Flag","","ColorRed","",1] call btc_fnc_createMarker;
_marker_circle = [format ["area_%1",(position _loc)], position _loc,[(_radiusx + btc_loc_radius),(_radiusy + btc_loc_radius)],"ELLIPSE","","","ColorRed","",0.2] call btc_fnc_createMarker;
_loc setvariable ["markers", [_marker_flag,_marker_circle]];

[position _loc, [(_radiusx + btc_loc_radius),(_radiusy + btc_loc_radius),0,false], [str (btc_enemy_side), "PRESENT", false], ["count thisList < 2", "[] call btc_fnc_mission_locationCaptured", ""]] call btc_fnc_createTrigger;


btc_loc_active = _loc;
