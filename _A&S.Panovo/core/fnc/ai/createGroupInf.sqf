
private ["_side","_spawn_zone","_r_patrol","_n_units","_random_n","_wps_type","_n","_group","_wp_type"];

_side        = _this select 0;
_spawn_zone  = _this select 1;
_r_patrol    = _this select 2;
_n_units     = _this select 3;
_random_n    = _this select 4;
_wps_type 	 = _this select 5;

switch (typeName _spawn_zone) do {
	case "ARRAY" :{_spawn_zone = _spawn_zone;};
	case "STRING":{_spawn_zone = getMarkerPos _spawn_zone;};
	case "OBJECT":{_spawn_zone = position _spawn_zone;};
};

_n = 0;
if (_random_n) then {_n = round (random _n_units);} else {_n = _n_units - 1};

_group = createGroup _side;
_group createUnit [btc_type_TL, _spawn_zone, [], 0, "NONE"];
for "_i" from 0 to _n do {
	private "_unit_type";
	_unit_type = selectRandom btc_type_units;
	_group createUnit [_unit_type, _spawn_zone, [], 0, "NONE"];
};

_group createUnit [btc_type_medic, _spawn_zone, [], 0, "NONE"];

_group call btc_fnc_ai_setSkill;

_wp_type = selectRandom _wps_type;

switch (_wp_type) do {
	case "PATROL" : {
		[_group, _spawn_zone, _r_patrol] spawn btc_fnc_ai_taskPatrol;
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