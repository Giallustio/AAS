private ["_pos","_random_area","_return_pos","_pos_x","_pos_y"];

_pos = _this select 0;
_random_area = _this select 1;

switch (typeName _pos) do {
	case "STRING":{_pos = getMarkerPos _pos;};
	case "OBJECT":{_pos = position _pos;};
};

_return_pos = _pos;

_pos_x = _pos select 0;
_pos_y = _pos select 1;

_pos_x = _pos_x + ((random _random_area) - (random _random_area));
_pos_y = _pos_y + ((random _random_area) - (random _random_area));

_return_pos = [_pos_x, _pos_y, 0];

_return_pos