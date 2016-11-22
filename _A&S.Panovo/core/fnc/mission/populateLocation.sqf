_loc_pos = _this select 0;
_loc_x   = _loc_pos select 0;
_loc_y   = _loc_pos select 1;
_loc_2   = [];_zone = [];_fant = 0;_veh = 0;

_players = playersNumber btc_player_side;

//DEFENDERS

_n = ceil (_players / 4);
if (_n > 4) then {_n = 4;};
for "_i" from 0 to _n do
{
	private "_pos";
	_pos = [_loc_pos, 150] call btc_fnc_randomizePos;
	[btc_enemy_side,_pos,0,(2 * round random _n),true,"SENTRY"] call btc_fnc_ai_createGroupInf;
};

//GROUPS

_spawn = [btc_enemy_side,_loc_pos,0,_players] call btc_fnc_ai_createGroupInf;

	if (btc_enemy == 0) then 
	{
		_fant    = (_players * btc_enemy_fant_ratio) + (round (random 2));
		if (_fant > 12) then {_fant = 12;};
	}
	else
	{
		_fant = floor ((random 2) + (4 * btc_enemy));
	};
	for "_i" from 0 to (_fant - 1) do
	{
		_loc_2 = [_loc_x + (random btc_area_size - random btc_area_size), _loc_y + (random btc_area_size - random btc_area_size), 0];
		_zone = [_loc_2, 30, 150, 1, 0, 60 * (pi / 180), 0] call BIS_fnc_findSafePos;
		_spawn = [btc_enemy_side,[_zone],80,2,1] spawn btc_spawn_inf_group;
	};
	if (btc_enemy == 0) then 
	{
		_veh = round (_players / btc_enemy_veh_ratio);
		if (_veh > 4) then {_veh = 4;};
		if (_veh != 0) then {_veh = _veh - 1};
		if (_players < 8) then 
		{
			_random = random 1;
			if (_random > 0.4) then
			{
				for "_i" from 0 to _veh do
				{
					_loc_2 = [_loc_x + (random (btc_area_size / 2) - random (btc_area_size / 2)), _loc_y + (random (btc_area_size / 2) - random (btc_area_size / 2)), 0];
					_zone = [_loc_2, 30, 150, 3, 0, 60 * (pi / 180), 0] call BIS_fnc_findSafePos;
					_spawn = [btc_enemy_side,[_zone],"",150] spawn btc_spawn_veh_group;
				};
			};
		}
		else
		{
			for "_i" from 0 to _veh do
			{
				_loc_2 = [_loc_x + (random (btc_area_size / 2) - random (btc_area_size / 2)), _loc_y + (random (btc_area_size / 2) - random (btc_area_size / 2)), 0];
				_zone = [_loc_2, 30, 150, 3, 0, 60 * (pi / 180), 0] call BIS_fnc_findSafePos;
				_spawn = [btc_enemy_side,[_zone],"",150] spawn btc_spawn_veh_group;
			};
		};	
	}
	else
	{
		_veh = floor (round (random 1) + round(random (2 * btc_enemy)));
		if (_veh > 0) then {_veh = _veh - 1};
		_random = random 1;
		_loc_2  = [];_zone = [];
		for "_i" from 0 to _veh do
		{
			_loc_2 = [_loc_x + (random (btc_area_size / 2) - random (btc_area_size / 2)), _loc_y + (random (btc_area_size / 2) - random (btc_area_size / 2)), 0];
			_zone = [_loc_2, 10, 150, 3, 0, 60 * (pi / 180), 0] call BIS_fnc_findSafePos;
			_spawn = [btc_enemy_side,[_zone],"",150] spawn btc_spawn_veh_group;
		};
	};
	_random = random 1;
	switch (true) do
	{
		case (_random < 0.2) :                 {};
		case (_random >= 0.2 && _random < 0.6):{_spawn = [btc_enemy_side,_loc_pos] spawn btc_spawn_sniper;};
		case (_random >= 0.6 && _random < 1):  {_spawn = [btc_enemy_side,_loc_pos] spawn btc_spawn_sniper;_spawn = [btc_enemy_side,_loc_pos] spawn btc_spawn_sniper;};
	};
	_houses = [_loc_pos] spawn btc_spawn_house_patrols;