
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
_name setMarkerSize _area;
   _name setMarkerShape _shape;
_name setMarkerType _type;
if (_brush != "") then {_name setMarkerBrush _brush;};
_name setMarkerColor _color;
_name setMarkerText _text;