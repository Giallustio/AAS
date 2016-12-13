_loc = _this select 0;
_radius = _this select 1;
_n = 0;
_fant = 0;
_veh = 0;

_players = playersNumber btc_player_side;


//FORTIFICATIONS

for "_i" from 0 to (3 + random 4) do {
	private "_pos";
	_pos = [_loc, 300] call btc_fnc_randomizePos;
	_pos = [_pos, 0, 100, 10, 0, 60 * (pi / 180), 0] call BIS_fnc_findSafePos;
	[_pos,btc_fortifications] call btc_fnc_mission_createFortification;
};

//DEFENDERS

if (btc_enemy_ratio isEqualTo 0) then {
	_n = (_players / 2) + (round (random 2));
	if (_n > 5) then {_fant = 5;};
} else {
	_n = floor ((random 2) + (2 * btc_enemy_ratio));
};
for "_i" from 1 to _n do
{
	private "_pos";
	_pos = [_loc, 150] call btc_fnc_randomizePos;
	[btc_enemy_side,_pos,0,(2 * btc_enemy_ratio_fant),true,["SENTRY"]] call btc_fnc_ai_createGroupInf;
};

if (btc_debug) then {diag_log format ["btc_fnc_mission_populateLocation defenders %1",_n];};

//GROUPS

if (btc_enemy_ratio isEqualTo 0) then {
	_fant = (_players * btc_enemy_ratio_fant) + (round (random 2));
	if (_fant > 12) then {_fant = 12;};
} else {
	_fant = floor ((random 2) + (btc_enemy_ratio_fant * btc_enemy_ratio));
};
for "_i" from 1 to _fant do {
	private ["_pos","_wps"];
	_pos = [_loc, _radius] call btc_fnc_randomizePos;
	_wps = random 1;
	switch (true) do {
		case (_wps < 0.2)               : {[btc_enemy_side,_pos,150,(2 * btc_enemy_ratio_fant),true,["PATROL","GUARD"]] call btc_fnc_ai_createGroupInf;};
		case (_wps >= 0.2 && _wps < 0.35): {[btc_enemy_side,_pos,150,(2 * btc_enemy_ratio_fant),true,["GUARD"]] call btc_fnc_ai_createGroupInf;};
		case (_wps >= 0.35)              : {[btc_enemy_side,_pos,150,(2 * btc_enemy_ratio_fant),true,["PATROL"]] call btc_fnc_ai_createGroupInf;};
	};
};

if (btc_debug) then {diag_log format ["btc_fnc_mission_populateLocation groups %1",_fant];};

_random = random 1;
switch (true) do {
	case (_random < 0.2) :                 {};
	case (_random >= 0.2 && _random < 0.6):{_spawn = [btc_enemy_side,_loc,_radius] call btc_fnc_ai_createSniper;};
	case (_random >= 0.6 && _random < 1):  {_spawn = [btc_enemy_side,_loc,_radius] call btc_fnc_ai_createSniper;_spawn = [btc_enemy_side,_loc,_radius] call btc_fnc_ai_createSniper;};
};

if (btc_debug) then {diag_log format ["btc_fnc_mission_populateLocation snipers (0.2 - 0.6) %1",_random];};

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
					[btc_enemy_side,_pos,btc_type_apc,150,["PATROL","GUARD","SENTRY"]] call btc_fnc_ai_createGroupVeh;
				};
			};
		} else {
			for "_i" from 0 to _veh do {
				private "_pos";
				_pos = [_loc, _radius] call btc_fnc_randomizePos;
				[btc_enemy_side,_pos,btc_type_apc,150,["PATROL","GUARD","SENTRY"]] call btc_fnc_ai_createGroupVeh;
			};
		};	
	} else {
		_veh = floor (round (random 1) + round(random (2 * btc_enemy_ratio)));
		for "_i" from 1 to _veh do {
			private "_pos";
			_pos = [_loc, _radius] call btc_fnc_randomizePos;
			[btc_enemy_side,_pos,btc_type_apc,150,["PATROL","GUARD","SENTRY"]] call btc_fnc_ai_createGroupVeh;
		};
	};
	if (btc_debug) then {diag_log format ["btc_fnc_mission_populateLocation vehicles (0.2 - 0.6) %1",_veh];};
};
