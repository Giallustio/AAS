
private ["_loc","_radius","_allHouses","_houses","_used","_AImax","_AIspawned"];

_loc = _this select 0;
_radius = _this select 1;

_allHouses = _loc setVariable ["allHouses",false];

_houses = [_loc,_radius] call btc_fnc_mission_getHouses;
_used = 0;
if (count _houses > 0) then	{
	_AImax = 50;
	_AIspawned = 0;		
	_randomHouse = objNull;
	
	for "_i" from 0 to (count _houses) do {
		private ["_randomHouse","_group"];
		if (!_allHouses && {_AIspawned >= _AImax}) exitWith {};
		_randomHouse = selectRandom _houses;
		_houses = _houses - [_randomHouse];
		_used = _used + 1;
		_group = createGroup btc_enemy_side;
		{
			if (random 1 > 0.2) then {
				private ["_unit"];
				_unit = _group createUnit [(selectRandom btc_type_units), _x, [], 0, "NONE"];
				_unit setUnitPos "UP";
				doStop _unit;
				_unit setPos _x;
				_AIspawned = _AIspawned + 1;
			};
			_group setBehaviour "AWARE";
			_group setCombatMode "RED";
			if (btc_AI_setSkill) then {_group call btc_fnc_ai_setSkill;};		
		} foreach (_randomHouse buildingPos -1);
	};
};
if (btc_debug) then {diag_log format ["fnc_mission_fillHouses - H %1 AI %2",_used,_AIspawned];};