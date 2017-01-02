
_loc = _this select 0;

_rx = _loc getVariable ["RadiusX",0];
_ry = _loc getVariable ["RadiusY",0];
_loc setVariable ["allHouses",false];

_radius = (_rx + _ry)/2;
_houses = [_loc,_radius] call btc_fnc_mission_getHouses;

if (count _houses > 0) then	{
	_AImax = 50;
	_AIspawned = 0;		
	
	for "_i" from 0 to (count _houses) do {
		if (_AIspawned >= _AImax) exitWith {};
		_randomHouse = selectRandom _houses;
		_houses = _houses - [_randomHouse];
		
		_group = createGroup BTC_enemy_side;
		{
			{
				if (random 1 > 0.2) then {
					_unit = _group createUnit [(selectRandom btc_type_units), _x, [], 0, "NONE"];
					_unit setUnitPos "UP";
					doStop _unit;
					_unit setPos _x;
					_AIspawned = _AIspawned + 1;
				};
			} foreach (_x buildingPos -1);
			_group setBehaviour "AWARE";
			_group setCombatMode "RED";
			if (btc_AI_setSkill) then {_group call btc_fnc_ai_setSkill;};		
		} foreach (_randomHouse buildingPos -1);
		if (BTC_debug == 1) then {hint format ["fnc_spawn_house_patrols - %1",_n];};
	};
};