
_side        = _this select 0;
_spawn_zones = _this select 1;
_r_patrol    = _this select 2;
_n_units     = _this select 3;
_random_n    = _this select 4;
_zone_array  = selectRandom _spawn_zones;
_zone = _zone_array;
switch (typeName _zone_array) do {
	case "ARRAY" :{_zone = _zone_array;};
	case "STRING":{_zone = getMarkerPos _zone_array;};
	case "OBJECT":{_zone = position _zone_array;};
};

_n = 0;
if (_random_n == 1) then {_n = round (random _n_units);} else {_n = _n_units - 1};

_group = createGroup _side;
_group createUnit [BTC_type_TL, _zone, [], 0, "NONE"];
for "_i" from 0 to _n do {
	_unit_type = selectRandom BTC_type_units;
	_group createUnit [_unit_type, _zone, [], 0, "NONE"];
};

_group createUnit [BTC_type_medic, _zone, [], 0, "NONE"];

//SetAI

if ((random 1) > 0.7) then	{
	_wp = _group addWaypoint [_zone, 0];
	_wp setWaypointType "GUARD";
	_wp setWaypointCombatMode "RED";
	_wp setWaypointBehaviour "AWARE";
	_wp setWaypointSpeed "FULL";
} else {[_group, _zone, _r_patrol] spawn BTC_task_patrol;};
