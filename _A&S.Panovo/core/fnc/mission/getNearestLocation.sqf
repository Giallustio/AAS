
private ["_loc","_dist","_location"];

_loc  = _this select 0;
_dist = 9999999999;
_location = objNull;

{
	if (!(_loc isEqualTo _x) && {!(_x getVariable ["captured",false])} && {_x distance2D _loc < _dist}) then {_location = _x; _dist = _x distance2D _loc;};
} foreach btc_locs;


_location