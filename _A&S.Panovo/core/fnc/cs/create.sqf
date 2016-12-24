private ["_type","_pos","_dir","_cost"];

_type = _this select 0;
_pos = _this select 1;
_dir = _this select 2;
_cost = _this select 3;

if (btc_money >= _cost) then {
	private "_obj";
	btc_money = btc_money - _cost;publicVariable "btc_money";
	_obj = _type createVehicle _pos;
	_obj setDir _dir;
};