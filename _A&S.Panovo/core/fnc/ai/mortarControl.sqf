	
_pos = _this select 0;	
	
_pos = [_loc, 300] call btc_fnc_randomizePos;
_pos = [_pos, 0, 100, 10, 0, 60 * (pi / 180), 0] call BIS_fnc_findSafePos;

_mortar = objNull;

_return = [_pos,"Mortar"] call btc_fnc_mission_createFortification;	

//If iskindof statics then mortar

//_return
	
//if (btc_debug) then {diag_log format ["btc_fnc_mission_populateLocation defenders %1",_n];};
	
	private ["_mortar","_fired","_targets_list","_mortar"];
	
	_mortar = _this select 0;
	_fired  = false;
	sleep 120;
	while {{Alive _x} count crew _mortar > 0} do {
		{
			if (!_fired && {side _x == BTC_enemy_side}) then {
				_targets_list = leader _x nearTargets 1500;
				if ({_x select 2 == BTC_player_side} count _targets_list > 0) then {
					{if (_x select 2 == BTC_player_side && !_fired && (count (nearestObjects [(_x select 0), [BTC_enemy_men], 100]) == 0) && (_x select 0) distance _mortar < 3500) then {if (BTC_debug == 1) then {hint format ["Get target %1 - %2",_mortar, mapGridPosition (_x select 0)];};[_mortar,_x select 0] spawn BTC_fire_mortar;_fired = true;}} foreach _targets_list;
				};
			};
		} foreach allGroups;
		if (_fired) then {private ["_players"];_players = call BTC_get_players_n;switch (true) do {case (_players < 5) :{sleep 300;};case (_players >= 5 && _players < 10):{sleep 180;};case (_players >= 10):{sleep 120;};};} else {sleep 5;};
		_fired = false;
	};