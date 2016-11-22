	
private ["_side","","","","","","",""];

_side        = _this select 0;
_spawn_zone  = _this select 1;

_loc_x = _spawn_zone select 0;
_loc_y = _spawn_zone select 1;

_loc_2 = [_loc_x + (random BTC_area_size - random BTC_area_size), _loc_y + (random BTC_area_size - random BTC_area_size), 0];
_zone = [_loc_2, 30, 150, 1, 0, 60 * (pi / 180), 0] call BIS_fnc_findSafePos;

_group = createGroup _side;
_group createUnit [BTC_type_sniper, _zone, [], 0, "NONE"];

_group call btc_fnc_ai_setSkill;

_wp = _group addWaypoint [_zone, 0];
_wp setWaypointType "SENTRY";
_wp setWaypointCombatMode "RED";
_wp setWaypointBehaviour "STEALTH";
_wp setWaypointSpeed "FULL";