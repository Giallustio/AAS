
private ["_position","_type","_name","_radius_x","_radius_y","_id","_city"];

_position = _this select 0;
_type = _this select 1;
_name = _this select 2;
_radius_x = _this select 3;
_radius_y = _this select 4;

_id = count btc_locs;

_city = "Land_Ammobox_rounds_F" createVehicle _position;
_city hideObjectGlobal true;
_city allowDamage false;
_city enableSimulation false;
_city setVariable ["id",_id];
_city setVariable ["captured",false];
_city setVariable ["name",_name];
_city setVariable ["RadiusX",_radius_x];
_city setVariable ["RadiusY",_radius_y];

btc_locs set [_id,_city];

if (btc_debug) then	{//_debug
	private ["_marker"];
	_marker = createmarker [format ["loc_%1",_id],_position];
	_marker setMarkerShape "ELLIPSE";
	_marker setMarkerBrush "SolidBorder";
	_marker setMarkerSize [(_radius_x+_radius_y) + btc_city_radius, (_radius_x+_radius_y) + btc_city_radius];
	_marker setMarkerAlpha 0.3;
	_marker setmarkercolor "colorRed";
	_marker = createmarker [format ["locn_%1",_id],_position];
	_marker setmarkertype "mil_dot";
	_marker setmarkertext format ["loc_%3 %1 %2",_name,_type,_id];
};

_city 