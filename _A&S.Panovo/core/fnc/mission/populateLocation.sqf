_loc = _this select 0;
_radius = _this select 1;
_fant = 0;
_veh = 0;

_players = playersNumber btc_player_side;

//DEFENDERS

_n = ceil (_players / 4);
if (_n > 4) then {_n = 4;};
for "_i" from 0 to _n do
{
	private "_pos";
	_pos = [_loc, 150] call btc_fnc_randomizePos;
	[btc_enemy_side,_pos,0,(2 * round random _n),true,["SENTRY"]] call btc_fnc_ai_createGroupInf;
};

//GROUPS

if (btc_enemy_ratio isEqualTo 0) then {
	_fant = (_players * btc_enemy_ratio_fant) + (round (random 2));
	if (_fant > 12) then {_fant = 12;};
} else {
	_fant = floor ((random 2) + (4 * btc_enemy_ratio));
};
for "_i" from 0 to (_fant - 1) do {
	private "_pos";
	_pos = [_loc, _radius] call btc_fnc_randomizePos;
	[btc_enemy_side,_pos,80,(2 * round random _n),true,["SENTRY","GUARD"]] call btc_fnc_ai_createGroupInf;
};

_random = random 1;
switch (true) do {
	case (_random < 0.2) :                 {};
	case (_random >= 0.2 && _random < 0.6):{_spawn = [btc_enemy_side,_loc,_radius] call btc_fnc_ai_createSniper;};
	case (_random >= 0.6 && _random < 1):  {_spawn = [btc_enemy_side,_loc,_radius] call btc_fnc_ai_createSniper;_spawn = [btc_enemy_side,_loc,_radius] call btc_fnc_ai_createSniper;};
};

//_houses = [_loc] call btc_spawn_house_patrols;

/*
	Improve system
	Add apc\tanks
*/

if !(btc_infantry_only) then {
	if (btc_enemy_ratio isEqualTo 0) then {
		_veh = round (_players / btc_enemy_ratio_veh);
		if (_veh > 4) then {_veh = 4;};
		if (_players < 8) then {
			_random = random 1;
			if (_random > 0.4) then {
				for "_i" from 0 to _veh do {
					private "_pos";
					_pos = [_loc, _radius] call btc_fnc_randomizePos;
					_spawn = [btc_enemy_side,_pos,btc_type_apc,150,["PATROL","GUARD","SENTRY"] spawn btc_spawn_veh_group;
				};
			};
		} else {
			for "_i" from 0 to _veh do {
				private "_pos";
				_pos = [_loc, _radius] call btc_fnc_randomizePos;
				_spawn = [btc_enemy_side,_pos,btc_type_apc,150,["PATROL","GUARD","SENTRY"] spawn btc_spawn_veh_group;
			};
		};	
	} else {
		_veh = floor (round (random 1) + round(random (2 * btc_enemy_ratio)));
		for "_i" from 0 to _veh do {
			private "_pos";
			_pos = [_loc, _radius] call btc_fnc_randomizePos;
			_spawn = [btc_enemy_side,_pos,btc_type_apc,150,["PATROL","GUARD","SENTRY"] spawn btc_spawn_veh_group;
		};
	};
};
