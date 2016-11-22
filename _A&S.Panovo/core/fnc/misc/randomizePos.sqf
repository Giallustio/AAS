private ["_pos","_random_area","_return_pos","_pos_x","_pos_y"];

_pos = _this select 0;
_random_area = _this select 1;

_return_pos = _pos;

_pos_x = _pos select 0;
_pos_y = _pos select 1;

_pos_x = _pos_x + ((random _random_area) - (random _random_area));
_pos_y = _pos_y + ((random _random_area) - (random _random_area));

_return_pos = [_pos_x, _pos_y, 0];

_return_pos