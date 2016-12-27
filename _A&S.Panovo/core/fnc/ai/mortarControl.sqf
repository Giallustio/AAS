
private ["_pos","_mortar","_return"];

_pos = _this select 0;	
	
_pos = [_pos, 100] call btc_fnc_randomizePos;
_pos = [_pos, 0, 80, 10, 0, 60 * (pi / 180), 0] call BIS_fnc_findSafePos;

_mortar = objNull;
_return = [_pos,"Mortar"] call btc_fnc_mission_createFortification;	
{if (_x isKindOf "StaticMortar") then {_mortar = _x}} foreach _return;

if (btc_debug) then {diag_log format ["btc_fnc_ai_mortarControl spawn %1 at %2",typeOf _mortar,_pos];};

if (isNull _mortar) exitWith {};

private ["_fired","_targets_list"];

sleep 120;

_fired  = false;
while {{Alive _x} count crew _mortar > 0} do {
	_targets_list = [];
	{
		if (!_fired && {side _x isEqualTo btc_enemy_side}) then {
			_targets_list = leader _x nearTargets 1200;
			if ({(_x select 2) isEqualTo btc_player_side} count _targets_list > 0) then {
				{
					if (!_fired && {(_x select 2) isEqualTo btc_player_side} && {(count (nearestObjects [(_x select 0), [btc_enemy_men], 100]) isEqualTo 0)} && {(_x select 0) distance _mortar < 1200} && {(_x select 0) distance (getMarkerPos btc_marker_respawn) > 300}) then {
						if (btc_debug) then {diag_log format ["btc_fnc_ai_mortarControl get target %1 - %2",_mortar, mapGridPosition (_x select 0)];hintSilent format ["btc_fnc_ai_mortarControl get target %1 - %2",_mortar, mapGridPosition (_x select 0)];};
						[_mortar,_x select 0] spawn btc_fnc_ai_mortarFire;
						_fired = true;
					};
				} foreach _targets_list;
			};
		};
	} foreach allGroups;
	if (_fired) then {
		private ["_players"];
		_players = playersNumber btc_player_side;
		switch (true) do {case (_players < 5) :{sleep 300;};case (_players >= 5 && _players < 10):{sleep 180;};case (_players >= 10):{sleep 120;};};
	} else {sleep 5};
	_fired = false;
};

if (btc_debug) then {diag_log "btc_fnc_ai_mortarControl exit loop";};