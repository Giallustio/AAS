
private ["_side","_spawn_zones","_veh_type","_r_patrol","_zone_array","_zone","_group","_newZone","_veh","_gunner","_commander","_cargo"];

_side        = _this select 0;
_spawn_zone  = _this select 1;
_veh_type    = _this select 2;
_r_patrol    = _this select 3;
_wps_type    = _this select 4;

switch (typeName _spawn_zone) do {
	case "ARRAY" :{_spawn_zone = _spawn_zone;};
	case "STRING":{_spawn_zone = getMarkerPos _spawn_zone;};
	case "OBJECT":{_spawn_zone = position _spawn_zone;};
};

_group = createGroup _side;
_veh_type = selectRandom _veh_type;

_newZone = [_spawn_zone, 50, _r_patrol, 1, 0, 60 * (pi / 180), 0] call BIS_fnc_findSafePos;

_veh = createVehicle [_veh_type, _newZone, [], 0, "NONE"];
btc_type_crewmen createUnit [_spawn_zone, _group, "this moveinDriver _veh"];
_gunner = _veh emptyPositions "gunner";
_commander = _veh emptyPositions "commander";
_cargo = (_veh emptyPositions "cargo") - 1;
if (_gunner > 0) then {btc_type_crewmen createUnit [_spawn_zone, _group, "this moveinGunner _veh;this assignAsGunner _veh;"];};
if (_commander > 0) then {btc_type_crewmen createUnit [_spawn_zone, _group, "this moveinCommander _veh;this assignAsCommander _veh;"];};
if (_cargo > 0) then {
	for "_i" from 0 to _cargo do {
		_unit_type = selectRandom btc_type_units;
		_unit_type createUnit [_spawn_zone, _group, "this moveinCargo _veh;this assignAsCargo _veh;"];
	};
};

if (btc_AI_setSkill) then {_group call btc_fnc_ai_setSkill;};

_wp_type = selectRandom _wps_type;

switch (_wp_type) do {
	case "PATROL" : {
		[_group, _spawn_zone, _r_patrol, "AWARE"] spawn btc_fnc_ai_taskPatrol;
	};
	case "GUARD": {
		_wp = _group addWaypoint [_spawn_zone, 0];
		_wp setWaypointType "GUARD";
		_wp setWaypointCombatMode "RED";
		_wp setWaypointBehaviour "AWARE";
		_wp setWaypointSpeed "FULL";		
	};
	case "SENTRY": {
		_wp = _group addWaypoint [_spawn_zone, 0];
		_wp setWaypointType "SENTRY";
		_wp setWaypointCombatMode "RED";
		_wp setWaypointBehaviour "AWARE";
		_wp setWaypointSpeed "FULL";			
	};
};

_group
