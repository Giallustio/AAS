
private ["_name","_pos","_area","_shape","_type","_marker","_alpha"];

_name   = _this select 0;
_pos    = _this select 1;
_area   = _this select 2;
_shape  = _this select 3;
_type   = _this select 4;
_brush  = _this select 5;
_color  = _this select 6;
_text   = _this select 7;
_alpha  = _this select 8;
	
_marker = createMarkerLocal [_name, _pos];
_name setMarkerSizeLocal _area;
   _name setMarkerShapeLocal _shape;
_name setMarkerTypeLocal _type;
if (_brush != "") then {_name setMarkerBrushLocal  _brush;};
_name setMarkerColorLocal _color;
_name setMarkerTextLocal _text;
_name setMarkerAlphaLocal _alpha;