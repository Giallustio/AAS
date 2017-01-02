/*

_buildings = nearestObjects [getpos player, ["Building"], 8000]; 
 
_useful = []; 
{ 
 if !(count (_x buildingPos -1) isEqualTo 0) then { 
  _useful pushBack _x; 
 }; 
} forEach _buildings;  
 
{ 
 _marker = createmarkerLocal [str(position _x), position _x]; 
 _marker setmarkertypelocal "Dot"; 
 _marker setMarkerTextLocal (TypeOf _x); 
 _marker setMarkerSizeLocal [0.4, 0.4]; 
} foreach _useful;
*/

private ["_pos","_radius","_buildings","_useful"];

_pos       = _this select 0;
_radius    = _this select 1;

_buildings = _pos nearObjects ["Building", _radius];
//_buildings = nearestObjects [_pos, ["Building"], _radius];
 
_useful = []; 
{ 
	if !(count (_x buildingPos -1) isEqualTo 0) then { 
		_useful pushBack _x; 
	}; 
} forEach _buildings;

_useful 