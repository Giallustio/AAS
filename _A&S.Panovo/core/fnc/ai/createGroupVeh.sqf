
private ["_side","_spawn_zones","_veh_type","_r_patrol","_zone_array","_zone","_group","_newZone","_veh","_gunner","_commander","_cargo"];

_side        = _this select 0;
_spawn_zones = _this select 1;
_veh_type    = _this select 2;
_r_patrol    = _this select 3;
_zone_array  = selectRandom _spawn_zones;
_zone = _zone_array;

switch (typeName _zone_array) do {
	case "ARRAY" :{_zone = _zone_array;};
	case "STRING":{_zone = getMarkerPos _zone_array;};
	case "OBJECT":{_zone = position _zone_array;};
};
	
_group = createGroup _side;
if (_veh_type == "") then {_veh_type = selectRandom btc_type_vehicles;};

_newZone = [_zone, 50, _r_patrol, 1, 0, 60 * (pi / 180), 0] call BIS_fnc_findSafePos;

_veh = createVehicle [_veh_type, _newZone, [], 0, "NONE"];
btc_type_crewmen createUnit [_zone, _group, "this moveinDriver _veh"];
_gunner = _veh emptyPositions "gunner";
_commander = _veh emptyPositions "commander";
_cargo = (_veh emptyPositions "cargo") - 1;
if (_gunner > 0) then {btc_type_crewmen createUnit [_zone, _group, "this moveinGunner _veh;this assignAsGunner _veh;"];};
if (_commander > 0) then {btc_type_crewmen createUnit [_zone, _group, "this moveinCommander _veh;this assignAsCommander _veh;"];};
if (_cargo > 0) then {
	for "_i" from 0 to _cargo do {
		_unit_type = btc_type_units select (round (random ((count btc_type_units) - 1)));
		_unit_type createUnit [_zone, _group, "this moveinCargo _veh;this assignAsCargo _veh;"];
	};
};

//setAI

if ((random 1) > 0.5) then	{
	_wp = _group addWaypoint [_zone, 0];
	_wp setWaypointType "GUARD";
	_wp setWaypointCombatMode "RED";
	_wp setWaypointBehaviour "AWARE";
	_wp setWaypointSpeed "FULL";
} else {[_group, _zone, _r_patrol] spawn btc_task_patrol;};
