	
private ["_side","_loc","_radius","_pos","_group","_wp"];

_side   = _this select 0;
_loc    = _this select 1;
_radius = _this select 2;

_pos = [_loc, _radius] call btc_fnc_randomizePos;

_group = createGroup _side;
_group createUnit [btc_type_sniper, _pos, [], 0, "NONE"];

if (btc_AI_setSkill) then {_group call btc_fnc_ai_setSkill;};

_wp = _group addWaypoint [_loc, 0];
_wp setWaypointType "SENTRY";
_wp setWaypointCombatMode "RED";
_wp setWaypointBehaviour "STEALTH";
_wp setWaypointSpeed "FULL";

_group