	
private ["_grp", "_pos", "_maxDist", "_blacklist"];
	
_grp = _this select 0;
_pos = _this select 1;
_maxDist = _this select 2;

_grp setBehaviour "AWARE";

private ["_prevPos"];
_prevPos = _pos;
for "_i" from 0 to (2 + (floor (random 3))) do {
	private ["_wp", "_newPos"];
	_newPos = [_prevPos, 50, _maxDist, 1, 0, 60 * (pi / 180), 0, _blacklist] call BIS_fnc_findSafePos;
	_prevPos = _newPos;

	_wp = _grp addWaypoint [_newPos, 0];
	_wp setWaypointType "MOVE";
	_wp setWaypointCompletionRadius 20;
	_wp setWaypointCombatMode "RED";

	if (_i == 0) then {
		_wp setWaypointSpeed "LIMITED";
		_wp setWaypointFormation "STAG COLUMN";
		_wp setWaypointCombatMode "RED";
	};
};

private ["_wp"];
_wp = _grp addWaypoint [_pos, 0];
_wp setWaypointType "CYCLE";
_wp setWaypointCompletionRadius 20;

true	