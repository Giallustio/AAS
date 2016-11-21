
private ["_pos","_area","_shape","_type","_marker"];

_name   = _this select 0;
_pos    = _this select 1;
_area   = _this select 2;
_shape  = _this select 3;
_type   = _this select 4;
_brush  = _this select 5;
_color  = _this select 6;
_text   = _this select 7;
	
_marker = createMarker [_name, _pos];
_marker setMarkerSize _area;
_marker setMarkerShape _shape;
_marker setMarkerType _type;
if (_brush != "") then {_marker setMarkerBrush _brush;};
_marker setMarkerColor _color;
_marker setMarkerText _text;

_marker