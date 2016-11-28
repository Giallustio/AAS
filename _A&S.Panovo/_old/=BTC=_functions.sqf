/*
Created by =BTC= Giallustio
version 1.8
Visit us at: 
http://www.blacktemplars.altervista.org/
07/02/2012
*/
BTC_server_control =
{
	//first loc = obj
	_first_loc = _this select 0;
	BTC_city_clear = false;
	BTC_trigger_rinf = objNull;BTC_trigger_spotted = objNull;
	[position _first_loc] call BTC_city_patrols;
	if (BTC_civilian == 1) then {_civ = [6,position _first_loc] spawn BTC_create_rebels;};
	if (BTC_param_ied == 1) then {_ied = [6,position _first_loc] spawn BTC_create_ieds;};
	_marker = [str (position _first_loc), position _first_loc,[0,0],"ICON","START","","ColorGreen",""] spawn BTC_create_marker;
	_check = [position _first_loc, [BTC_area_size,BTC_area_size,0,false], [str (BTC_enemy_side), "PRESENT", false], ["count thisList < 2", "BTC_city_clear = true;", ""]] spawn BTC_create_trigger;
	if (BTC_ACE) then {[-1, {_this spawn BTC_create_task;}, [position _first_loc]] call CBA_fnc_globalExecute;} else {BTC_spawn = [[position _first_loc], BTC_create_task];publicVariable "BTC_spawn";if (!isDedicated) then {[position _first_loc] spawn BTC_create_task;};};
	BTC_actual_city           = _first_loc;
	BTC_next_city             = [];
	BTC_city_captured = 1;publicVariable "BTC_city_captured";
	WaitUntil {sleep 5; BTC_city_clear};
	BTC_money = BTC_money + BTC_city_bonus;publicVariable "BTC_money";
	_first_loc setVariable ["BTC_captured", 1];
	if (BTC_ACE) then {[-1, {_this spawn BTC_task_completed;}, [position _first_loc]] call CBA_fnc_globalExecute;} else {BTC_spawn = [[position _first_loc], BTC_task_completed];publicVariable "BTC_spawn";if (!isDedicated) then {[position _first_loc] spawn BTC_task_completed;};};
	BTC_city_array = BTC_city_array + [position _first_loc];publicVariable "BTC_city_array";
	_delete = [1,300] spawn BTC_delete_corps;
	//loop after first
	while {BTC_max_locations != BTC_city_captured} do
	{
		private ["_loc"];
		BTC_city_clear = false; 
		BTC_spotted	   = false; 
		_loc = [BTC_actual_city] call BTC_get_nearest_location;  //pick city
		[position _loc] call BTC_city_patrols;                   //spawn units
		if (BTC_arty == 1) then {_mortar = [position _loc] spawn BTC_mortar;}; //spawn mortar
		if (BTC_civilian == 1) then {_civ = [6,position _loc] spawn BTC_create_rebels;};        //spawn civilians
		if (BTC_param_ied == 1) then {_ied = [6,position _loc] spawn BTC_create_ieds;};   //spawn ieds
		BTC_next_city = [_loc] call BTC_get_nearest_location;    //pick city rinf
		_marker = [str (position _loc),position _loc,[0,0],"ICON","START","","ColorGreen",""] spawn BTC_create_marker;
		_check = [position _loc, [BTC_area_size,BTC_area_size,0,false], [str (BTC_enemy_side), "PRESENT", false], ["count thisList < 2", "BTC_city_clear = true;", ""]] spawn BTC_create_trigger;
		if (BTC_rinf == 1) then //control rinf
		{
			if (!isNull BTC_trigger_rinf) then {deleteVehicle BTC_trigger_rinf};if (!isNull BTC_trigger_spotted) then {deleteVehicle BTC_trigger_spotted};
			BTC_trigger_rinf = createTrigger["EmptyDetector", position _loc];
			BTC_trigger_rinf setTriggerArea [(BTC_area_size + 150),(BTC_area_size + 150),0,false];
			BTC_trigger_rinf setTriggerActivation [str (BTC_player_side), "PRESENT", false];
			BTC_trigger_rinf setTriggerStatements ["this && BTC_spotted", "_rinf = [position BTC_next_city] spawn BTC_rinf_control;", ""];
			BTC_trigger_spotted = createTrigger["EmptyDetector", position _loc];
			BTC_trigger_spotted setTriggerArea [(BTC_area_size + 150),(BTC_area_size + 150),0,false];
			BTC_trigger_spotted setTriggerActivation [str (BTC_player_side), (str (BTC_enemy_side) + " D"), false];
			BTC_trigger_spotted setTriggerStatements ["this", "BTC_spotted = true;", ""];
		}; 
		if (BTC_ACE) then {[-1, {_this spawn BTC_create_task;}, [position _first_loc]] call CBA_fnc_globalExecute;} else {BTC_spawn = [[position _loc], BTC_create_task];publicVariable "BTC_spawn";if (!isDedicated) then {[position _loc] spawn BTC_create_task;};};
		BTC_prev_city   = BTC_actual_city;
		BTC_actual_city = _loc;publicVariable "BTC_actual_city";
		WaitUntil {sleep 5; BTC_city_clear};
		BTC_money = BTC_money + BTC_city_bonus;publicVariable "BTC_money";
		[] call BTC_delete_groups;
		BTC_city_captured = BTC_city_captured + 1;publicVariable "BTC_city_captured";
		BTC_next_city = [];
		_loc setVariable ["BTC_captured", 1];
		if (BTC_ACE) then {[-1, {_this spawn BTC_task_completed;}, [position _first_loc]] call CBA_fnc_globalExecute;} else {BTC_spawn = [[position _loc], BTC_task_completed];publicVariable "BTC_spawn";if (!isDedicated) then {[position _loc] spawn BTC_task_completed;};};
		BTC_city_array = BTC_city_array + [position _loc];publicVariable "BTC_city_array";
		sleep 3;
	};
	if (BTC_ACE) then {[-1, {_this spawn BTC_task_completed;}, [position _loc]] call CBA_fnc_globalExecute;} else {BTC_spawn = [[], BTC_outro];publicVariable "BTC_spawn";if (!isDedicated) then {[] spawn BTC_outro;};};
};
BTC_server_control_on_load =
{
	_loc = _this select 0;
	BTC_city_clear = false;
	BTC_trigger_rinf = objNull;BTC_trigger_spotted = objNull;
	BTC_next_city = [_loc] call BTC_get_nearest_location;
	_mortar = nearestObject [position _loc, BTC_type_mortar];
	if (BTC_arty == 1 && !isNull _mortar) then {_mortar_control = [_mortar] spawn BTC_mortar_control;};
	_marker = [str (position _loc),position _loc,[0,0],"ICON","START","","ColorGreen",""] spawn BTC_create_marker;
	_check = [position _loc, [BTC_area_size,BTC_area_size,0,false], [str (BTC_enemy_side), "PRESENT", false], ["count thisList < 2", "BTC_city_clear = true;", ""]] spawn BTC_create_trigger;
	if (BTC_rinf == 1) then {_rinf_ = [position _loc, [(BTC_area_size + 150),(BTC_area_size + 150),0,false], [str (BTC_player_side), "PRESENT", false], ["this", "_rinf = [position BTC_next_city] spawn BTC_rinf_control;", ""]] spawn BTC_create_trigger;}; //control rinf
	BTC_prev_city   = BTC_actual_city;
	BTC_actual_city = _loc;publicVariable "BTC_actual_city";
	WaitUntil {sleep 5; BTC_city_clear};
	_first_loc setVariable ["BTC_captured", 1];
	BTC_money = BTC_money + BTC_city_bonus;publicVariable "BTC_money";
	if (BTC_ACE) then {} else {BTC_spawn = [[position _first_loc], BTC_task_completed];publicVariable "BTC_spawn";if (!isDedicated) then {[position _first_loc] spawn BTC_task_completed;};};
	BTC_city_array = BTC_city_array + [position _first_loc];publicVariable "BTC_city_array";
	_delete = [1,300] spawn BTC_delete_corps;
	while {BTC_max_locations != BTC_city_captured} do
	{
		private ["_loc"];
		BTC_city_clear = false; 
		BTC_spotted	   = false;
		_loc = [BTC_actual_city] call BTC_get_nearest_location;  //pick city
		[position _loc] call BTC_city_patrols;                   //spawn units
		if (BTC_arty == 1) then {_mortar = [position _loc] spawn BTC_mortar;}; //spawn mortar
		if (BTC_civilian == 1) then {_civ = [6,position _loc] spawn BTC_create_rebels;};        //spawn civilians
		if (BTC_param_ied == 1) then {_ied = [6,position _loc] spawn BTC_create_ieds;};   //spawn ieds
		BTC_next_city = [_loc] call BTC_get_nearest_location;    //pick city rinf
		_marker = [str (position _loc),position _loc,[0,0],"ICON","START","","ColorGreen",""] spawn BTC_create_marker;
		_check = [position _loc, [BTC_area_size,BTC_area_size,0,false], [str (BTC_enemy_side), "PRESENT", false], ["count thisList < 2", "BTC_city_clear = true;", ""]] spawn BTC_create_trigger;
		if (BTC_rinf == 1) then //control rinf
		{
			if (!isNull BTC_trigger_rinf) then {deleteVehicle BTC_trigger_rinf};if (!isNull BTC_trigger_spotted) then {deleteVehicle BTC_trigger_spotted};
			BTC_trigger_rinf = createTrigger["EmptyDetector", position _loc];
			BTC_trigger_rinf setTriggerArea [(BTC_area_size + 150),(BTC_area_size + 150),0,false];
			BTC_trigger_rinf setTriggerActivation [str (BTC_player_side), "PRESENT", false];
			BTC_trigger_rinf setTriggerStatements ["this && BTC_spotted", "_rinf = [position BTC_next_city] spawn BTC_rinf_control;", ""];
			BTC_trigger_spotted = createTrigger["EmptyDetector", position _loc];
			BTC_trigger_spotted setTriggerArea [(BTC_area_size + 150),(BTC_area_size + 150),0,false];
			BTC_trigger_spotted setTriggerActivation [str (BTC_player_side), (str (BTC_enemy_side) + " D"), false];
			BTC_trigger_spotted setTriggerStatements ["this", "BTC_spotted = true;", ""];
		}; 
		if (BTC_ACE) then {} else {BTC_spawn = [[position _loc], BTC_create_task];publicVariable "BTC_spawn";if (!isDedicated) then {[position _loc] spawn BTC_create_task;};};
		BTC_prev_city   = BTC_actual_city;
		BTC_actual_city = _loc;publicVariable "BTC_actual_city";
		WaitUntil {sleep 5; BTC_city_clear};
		BTC_money = BTC_money + BTC_city_bonus;publicVariable "BTC_money";
		[] call BTC_delete_groups;
		BTC_city_captured = BTC_city_captured + 1;publicVariable "BTC_city_captured";
		_loc setVariable ["BTC_captured", 1];
		BTC_next_city = [];
		if (BTC_ACE) then {} else {BTC_spawn = [[position _loc], BTC_task_completed];publicVariable "BTC_spawn";if (!isDedicated) then {[position _loc] spawn BTC_task_completed;};};
		BTC_city_array = BTC_city_array + [position _loc];publicVariable "BTC_city_array";
		sleep 3;
	};
	if (BTC_ACE) then {} else {BTC_spawn = [[], BTC_outro];publicVariable "BTC_spawn";if (!isDedicated) then {[] spawn BTC_outro;};};
};
BTC_city_patrols =
{
	_loc_pos = _this select 0;
	_loc_x   = _loc_pos select 0;
	_loc_y   = _loc_pos select 1;
	_loc_2   = [];_zone = [];_fant = 0;_veh = 0;
	_players = call BTC_get_players_n;
	_spawn = [BTC_enemy_side,_loc_pos,_players] spawn BTC_spawn_defender_groups;
	if (BTC_enemy == 0) then 
	{
		_fant    = (_players * btc_enemy_ratio_fant) + (round (random 2));
		if (_fant > 12) then {_fant = 12;};
	}
	else
	{
		_fant = floor ((random 2) + (4 * BTC_enemy));
	};
	for "_i" from 0 to (_fant - 1) do
	{
		_loc_2 = [_loc_x + (random BTC_area_size - random BTC_area_size), _loc_y + (random BTC_area_size - random BTC_area_size), 0];
		_zone = [_loc_2, 30, 150, 1, 0, 60 * (pi / 180), 0] call BIS_fnc_findSafePos;
		_spawn = [BTC_enemy_side,[_zone],80,2,1] spawn BTC_spawn_inf_group;
	};
	if (BTC_enemy == 0) then 
	{
		_veh = round (_players / btc_enemy_ratio_veh);
		if (_veh > 4) then {_veh = 4;};
		if (_veh != 0) then {_veh = _veh - 1};
		if (_players < 8) then 
		{
			_random = random 1;
			if (_random > 0.4) then
			{
				for "_i" from 0 to _veh do
				{
					_loc_2 = [_loc_x + (random (BTC_area_size / 2) - random (BTC_area_size / 2)), _loc_y + (random (BTC_area_size / 2) - random (BTC_area_size / 2)), 0];
					_zone = [_loc_2, 30, 150, 3, 0, 60 * (pi / 180), 0] call BIS_fnc_findSafePos;
					_spawn = [BTC_enemy_side,[_zone],"",150] spawn BTC_spawn_veh_group;
				};
			};
		}
		else
		{
			for "_i" from 0 to _veh do
			{
				_loc_2 = [_loc_x + (random (BTC_area_size / 2) - random (BTC_area_size / 2)), _loc_y + (random (BTC_area_size / 2) - random (BTC_area_size / 2)), 0];
				_zone = [_loc_2, 30, 150, 3, 0, 60 * (pi / 180), 0] call BIS_fnc_findSafePos;
				_spawn = [BTC_enemy_side,[_zone],"",150] spawn BTC_spawn_veh_group;
			};
		};	
	}
	else
	{
		_veh = floor (round (random 1) + round(random (2 * BTC_enemy)));
		if (_veh > 0) then {_veh = _veh - 1};
		_random = random 1;
		_loc_2  = [];_zone = [];
		for "_i" from 0 to _veh do
		{
			_loc_2 = [_loc_x + (random (BTC_area_size / 2) - random (BTC_area_size / 2)), _loc_y + (random (BTC_area_size / 2) - random (BTC_area_size / 2)), 0];
			_zone = [_loc_2, 10, 150, 3, 0, 60 * (pi / 180), 0] call BIS_fnc_findSafePos;
			_spawn = [BTC_enemy_side,[_zone],"",150] spawn BTC_spawn_veh_group;
		};
	};
	_random = random 1;
	switch (true) do
	{
		case (_random < 0.2) :                 {};
		case (_random >= 0.2 && _random < 0.6):{_spawn = [BTC_enemy_side,_loc_pos] spawn BTC_spawn_sniper;};
		case (_random >= 0.6 && _random < 1):  {_spawn = [BTC_enemy_side,_loc_pos] spawn BTC_spawn_sniper;_spawn = [BTC_enemy_side,_loc_pos] spawn BTC_spawn_sniper;};
	};
	_houses = [_loc_pos] spawn BTC_spawn_house_patrols;
};
BTC_rinf_control =
{
	private ["_pos","_players","_random","_n"];
	if (BTC_debug == 1) then {hint "fnc_rinf_control";};
	_pos    = _this select 0;
	while {!(BTC_city_clear)} do
	{
		_players = call BTC_get_players_n;
		_n = 0;
		switch (true) do
		{
			case (_players < 5) :{_n = 600;while {!(BTC_city_clear) && (_n > 0)} do {sleep 1;_n = _n - 1;if (BTC_debug == 1) then {hint format ["fnc_rinf_control wait %1",_n];};};};
			case (_players >= 5 && _players < 10):{_n = 300;while {!(BTC_city_clear) && (_n > 0)} do {sleep 1;_n = _n - 1;};};
			case (_players >= 10):{_n = 240;while {!(BTC_city_clear) && (_n > 0)} do {sleep 1;_n = _n - 1;};};
		};
		_players   = call BTC_get_players_n;
		_defenders = 0;
		switch (true) do
		{
			case (_players < 5) :{_defenders = 30;};
			case (_players >= 5 && _players < 10):{_defenders = 50;};
			case (_players >= 10):{_defenders = 70;};
		};		
		WaitUntil {sleep 2; {Alive _x && side _x == BTC_enemy_side} count (nearestObjects [BTC_actual_city, ["Man"], 2500]) < _defenders || BTC_city_clear};
		_random = random 10;
		if (BTC_debug == 1) then {hint format ["fnc_rinf_control - %1 - %2 - %3",_players,_pos,_random];};
		switch (true) do
		{
			case (_random < 2 && !(BTC_city_clear)) :               {_fant = [BTC_enemy_side,[_pos],BTC_actual_city,10,1] spawn BTC_spawn_rinf_inf;if (BTC_debug == 1) then {diag_log format ["Rinf control fnc -> Inf - %2", mapGridPosition _pos];};};
			case (_random >= 2 && _random < 5 && !(BTC_city_clear)):{_mot  = [BTC_enemy_side,[_pos],"",BTC_actual_city] spawn BTC_spawn_rinf_mot;if (BTC_debug == 1) then {diag_log format ["Rinf control fnc -> Mot - %2", mapGridPosition _pos];};};
			case (_random >= 5 && _random < 8 && !(BTC_city_clear)):{_veh  = [BTC_enemy_side,[_pos],"",BTC_actual_city] spawn BTC_spawn_rinf_veh;if (BTC_debug == 1) then {diag_log format ["Rinf control fnc -> Veh - %2", mapGridPosition _pos];};};
			case (_random >= 8 && _random < 9 && !(BTC_city_clear)):{_para = [BTC_enemy_side,[_pos],"","RANDOM",BTC_actual_city] spawn BTC_spawn_rinf_para;if (BTC_debug == 1) then {diag_log format ["Rinf control fnc -> Para - %2", mapGridPosition _pos];};};
			case (_random >= 9 && !(BTC_city_clear)):               {_heli = [BTC_enemy_side,[_pos],BTC_actual_city,"","SAD",150] spawn BTC_spawn_heli_group;if (BTC_debug == 1) then {diag_log format ["Rinf control fnc -> Heli - %2", mapGridPosition _pos];};};
		};
		_n = 0;
	};
	if (BTC_debug == 1) then {diag_log hint format ["fnc_rinf_control exit [%1]",_pos];};
};
BTC_spawn_house_patrols =
{
	_loc = _this select 0;
	_houses = [_loc,BTC_area_size] call BTC_get_houses;
	if (count _houses > 0) then
	{
		_n = ceil ((count _houses) / 10);
		for "_i" from 0 to _n do
		{
			private ["_group","_unit_type","_house","_patrol"];
			_group = createGroup BTC_enemy_side;
			_unit_type = BTC_type_units select (round (random ((count BTC_type_units) - 1)));
			_group createUnit [_unit_type, [0,0,0], [], 0, "NONE"];	
			_house = _houses select (round (random ((count _houses) - 1)));
			_patrol = [leader _group,_house] spawn BTC_house_patrol;
		};
		if (BTC_debug == 1) then {hint format ["fnc_spawn_house_patrols - %1",_n];};
	};
};
BTC_get_houses = 
{
	_pos       = _this select 0;
	_radius    = _this select 1;
	_buildings = nearestObjects [_pos, ["Building"], _radius];
	_useful    = [];
	{ 
		if (format["%1", _x buildingPos 2] != "[0,0,0]" && damage _x == 0 && !(typeOf _x in BTC_house_not_available)) then
		{ 
			_useful set [count _useful, _x]; 
		}; 
	} forEach _buildings; 
	_useful	
};
BTC_house_patrol =
{
	_unit  = _this select 0;
	_house = _this select 1;
	_n_pos = 0;
	_timeout = time;
	while {format ["%1", _house buildingPos _n_pos] != "[0,0,0]" } do {_n_pos = _n_pos + 1};
	_max_pos = _n_pos;
	_n_pos   = round (random _max_pos);
	group _unit setBehaviour "AWARE";
	group _unit setCombatMode "RED";
	_patrol = (round (random 1));
	_unit setPos (_house buildingPos 0);
	if (_patrol == 1) then
	{
		for "_i" from 0 to (round (random 1)) do
		{		
			private ["_unit_type"];
			_unit_type = BTC_type_units select (round (random ((count BTC_type_units) - 1)));
			(group _unit) createUnit [_unit_type, [0,0,0], [], 0, "NONE"];
		};
		{_x setPos (_house buildingPos 0);} foreach units (group _unit);
		{deleteWaypoint _x;} foreach waypoints (group _unit);
		while {Alive _unit && canStand _unit && canMove _unit} do 
		{
			{_x doMove (_house buildingpos _n_pos);} foreach units (group _unit);
			group _unit setSpeedMode "LIMITED";
			_n_pos = _n_pos + 1;
			if (_n_pos == _max_pos) then {_n_pos = 0;};
			_timeout = time + 50;
			waitUntil {sleep 1; (unitReady _unit || moveToCompleted _unit || moveToFailed _unit || !alive _unit || _timeout < time)};
			doStop _unit;
			sleep 10;
		};	
	}
	else
	{
		_unit setPos (_house buildingPos _n_pos);
		{deleteWaypoint _x;} foreach waypoints (group _unit);
		doStop _unit;
	};
};
BTC_get_players_n =
{
	_n = 0;
	{if (side _x == BTC_player_side) then {_n = _n + 1;};} foreach allunits;
	_n
};
BTC_delete_groups =
{
	{if (count units _x == 0) then {deleteGroup _x};} foreach allGroups;
	true
};
BTC_spawn_base =
{
	_pos = _this select 0;
	_pos_x = _pos select 0;
	_pos_y = _pos select 1;
	_pos_z = _pos select 2;
	_array = _this select 1;
	{
		_type = _x select 0;
		_dir  = _x select 1;
		_rel_pos = _x select 2;
		_rel_x   = _rel_pos select 0;
		_rel_y   = _rel_pos select 1;
		_rel_z   = _rel_pos select 2;
		_pos_obj = [(_pos_x + _rel_x),(_pos_y + _rel_y),(_pos_z + _rel_z)];
		_obj = createVehicle [_type, _pos_obj, [], 0, "NONE"];
		_obj setDir _dir;
		_obj setPos _pos_obj;
	} foreach _array;
	_farp_pos = [];
	_farp_pos_rel_x   = BTC_farp_base_rel select 0;
	_farp_pos_rel_y   = BTC_farp_base_rel select 1;
	_farp_pos_rel_z   = BTC_farp_base_rel select 2;
	_farp_pos = [(_pos_x + _farp_pos_rel_x),(_pos_y + _farp_pos_rel_y),(_pos_z + _farp_pos_rel_z)];
	_spawn_farp = [_farp_pos] spawn BTC_farp;
};
BTC_get_nearest_location =
{
	private ["_array_locations","_locationPos","_dist"];
	_pos  = _this select 0;
	_dist = 9999999999;
	_array_locations = [];
	{if (_x getVariable "BTC_captured" == 0) then {_array_locations = _array_locations + [_x];};} foreach BTC_locations;
	_location = objNull;
	{
		if (_x distance _pos < _dist && _x distance _pos > 50) then {_dist = _x distance _pos;_location = _x;};
	} foreach _array_locations;
	_location
};
BTC_delete_corps =
{
	//_delete = [1,60,15] spawn BTC_delete_corps;
	_repetelly = _this select 0;
	_time      = _this select 1;
	{if (_x isKindOf "Man") then {_spawn = [_x] spawn {sleep 30;hideBody (_this select 0); sleep 1.5;deletevehicle (_this select 0)};};} foreach alldead;
	if (_repetelly == 1) then {sleep _time;_delete = [_repetelly,_time] spawn BTC_delete_corps;};
};
BTC_mortar =
{
	private ["_random","_pos","_group","_newZone","_mortar"];
	_random = random 1;
	if (_random < 0.5) exitWith {};
	_pos = _this select 0;
	_group = createGroup BTC_enemy_side;
	_newZone = [_pos, 1, 200, 1, 0, 60 * (pi / 180), 0] call BIS_fnc_findSafePos;
	_mortar = createVehicle [BTC_type_mortar, _newZone, [], 0, "NONE"];
	BTC_type_crewmen createUnit [_newZone, _group, "this moveinGunner _mortar"];
	_group createUnit [BTC_type_crewmen, _newZone, [], 0, "NONE"];
	_mortar_control = [_mortar] spawn BTC_mortar_control;
};
BTC_mortar_control =
{
	private ["_mortar","_fired","_targets_list","_mortar"];
	if (BTC_debug == 1) then {hint "fnc_mortar_control"};
	_mortar = _this select 0;
	_fired  = false;
	sleep 120;
	while {count crew _mortar > 0} do
	{
		{
			if (side _x == BTC_enemy_side && !_fired) then
			{
				_targets_list = leader _x nearTargets 1500;
				if ({_x select 2 == BTC_player_side} count _targets_list > 0) then
				{
					{if (_x select 2 == BTC_player_side && !_fired && (count (nearestObjects [(_x select 0), [BTC_enemy_men], 100]) == 0) && (_x select 0) distance _mortar < 3500) then {if (BTC_debug == 1) then {hint format ["Get target %1 - %2",_mortar, mapGridPosition (_x select 0)];};[_mortar,_x select 0] spawn BTC_fire_mortar;_fired = true;}} foreach _targets_list;
				};
			};
		} foreach allGroups;
		if (_fired) then {private ["_players"];_players = call BTC_get_players_n;switch (true) do {case (_players < 5) :{sleep 300;};case (_players >= 5 && _players < 10):{sleep 180;};case (_players >= 10):{sleep 120;};};} else {sleep 5;};
		_fired = false;
	};
};
BTC_fire_mortar =
{
	_mortar = _this select 0;
	_pos    = _this select 1;
	_EH     = _mortar addEventHandler ["fired", {deletevehicle (nearestobject[_this select 0, _this select 4])}];
	(gunner _mortar) lookAt _pos;
	for "_i" from 0 to (BTC_arty_salvo - 1) do
	{
		_mortar setVehicleAmmo 1;
		_mortar fire (weapons _mortar select 0);
		sleep 2;
	};
	sleep (10 + random 5); 
	for "_i" from 0 to (BTC_arty_salvo - 1) do
	{	
		_bullet = "ARTY_Sh_81_HE" createVehicle [(_pos select 0)+ (random BTC_arty_dispersion - random BTC_arty_dispersion), (_pos select 1)+ random (random BTC_arty_dispersion - random BTC_arty_dispersion), (_pos select 2)+ 100];  
		sleep 2;
	};
	_mortar setVehicleAmmo 1;
	_mortar removeAllEventHandlers "fired";
};
BTC_spawn_defender_groups =
{
	//_spawn = [east,[pos_1,pos_2],50,7,1] spawn BTC_spawn_inf_group;
	_side        = _this select 0;
	_zone        = _this select 1;
	_players     = _this select 2;
	switch (typeName _zone) do
	{
		case "ARRAY" :{_zone = _zone;};
		case "STRING":{_zone = getMarkerPos _zone;};
		case "OBJECT":{_zone = position _zone;};
	};
	_n = ceil (_players / 4);
	if (_n > 3) then {_n = 3;};
	for "_i" from 0 to _n do
	{
		private ["_group","_pos","_newZone","_unit_type","_wp"];
		_group = createGroup _side;
		_pos = [(_zone select 0) + (random 60 - random 60), (_zone select 1) + (random 60 - random 60), 0];
		_newZone = [_pos, 0, 60, 1, 0, 60 * (pi / 180), 0] call BIS_fnc_findSafePos;
		_group createUnit [BTC_type_TL, _newZone, [], 0, "NONE"];
		for "_i" from 0 to (round random 4) do
		{
			_unit_type = BTC_type_units select (round (random ((count BTC_type_units) - 1)));
			_group createUnit [_unit_type, _newZone, [], 0, "NONE"];
		};
		_group createUnit [BTC_type_medic, _newZone, [], 0, "NONE"];
		if !(isClass(configFile >> "cfgPatches" >> "asr_ai_main")) then {{_x setSkill ["aimingAccuracy", BTC_AI_skill];} foreach units _group;};
		_wp = _group addWaypoint [_newZone, 0];
		_wp setWaypointType "SENTRY";
		_wp setWaypointCombatMode "RED";
		_wp setWaypointBehaviour "AWARE";
		_wp setWaypointSpeed "FULL";	
	};
};
BTC_spawn_sniper =
{
	_side        = _this select 0;
	_spawn_zone  = _this select 1;
	_loc_x = _spawn_zone select 0;
	_loc_y = _spawn_zone select 1;
	_loc_2 = [_loc_x + (random BTC_area_size - random BTC_area_size), _loc_y + (random BTC_area_size - random BTC_area_size), 0];
	_zone = [_loc_2, 30, 150, 1, 0, 60 * (pi / 180), 0] call BIS_fnc_findSafePos;
	_group = createGroup _side;
	_group createUnit [BTC_type_sniper, _zone, [], 0, "NONE"];
	_wp = _group addWaypoint [_zone, 0];
	_wp setWaypointType "SENTRY";
	_wp setWaypointCombatMode "RED";
	_wp setWaypointBehaviour "STEALTH";
	_wp setWaypointSpeed "FULL";
};
BTC_spawn_inf_group =
{
	//_spawn = [east,[pos_1,pos_2],50,7,1] spawn BTC_spawn_inf_group;
	_side        = _this select 0;
	_spawn_zones = _this select 1;
	_r_patrol    = _this select 2;
	_n_units     = _this select 3;
	_random_n    = _this select 4;
	_zone_array  = _spawn_zones select (round (random ((count _spawn_zones) - 1)));
	_zone = _zone_array;
	switch (typeName _zone_array) do
	{
		case "ARRAY" :{_zone = _zone_array;};
		case "STRING":{_zone = getMarkerPos _zone_array;};
		case "OBJECT":{_zone = position _zone_array;};
	};
	_n = 0;
	if (_random_n == 1) then {_n = round (random _n_units);} else {_n = _n_units - 1};
	_group = createGroup _side;
	_group createUnit [BTC_type_TL, _zone, [], 0, "NONE"];
	for "_i" from 0 to _n do
	{
		_unit_type = BTC_type_units select (round (random ((count BTC_type_units) - 1)));
		_group createUnit [_unit_type, _zone, [], 0, "NONE"];
	};
	_group createUnit [BTC_type_medic, _zone, [], 0, "NONE"];
	if !(isClass(configFile >> "cfgPatches" >> "asr_ai_main")) then {{_x setSkill ["aimingAccuracy", BTC_AI_skill];} foreach units _group;};
	_random = random 1;
	if (_random > 0.7) then	{_wp = _group addWaypoint [_zone, 0];_wp setWaypointType "GUARD";_wp setWaypointCombatMode "RED";_wp setWaypointBehaviour "AWARE";_wp setWaypointSpeed "FULL";} else {[_group, _zone, _r_patrol] spawn BTC_task_patrol;};
};
BTC_spawn_veh_group =
{
	//_spawn = [east,[pos_1,pos_2],"",150] spawn BTC_spawn_veh_group;
	_side        = _this select 0;
	_spawn_zones = _this select 1;
	_veh_type    = _this select 2;
	_r_patrol    = _this select 3;
	_zone_array  = _spawn_zones select (round (random ((count _spawn_zones) - 1)));
	_zone = _zone_array;
	switch (typeName _zone_array) do
	{
		case "ARRAY" :{_zone = _zone_array;};
		case "STRING":{_zone = getMarkerPos _zone_array;};
		case "OBJECT":{_zone = position _zone_array;};
	};
	_group = createGroup _side;
	if (_veh_type == "") then {_veh_type = BTC_type_vehicles select (round (random ((count BTC_type_vehicles) - 1)));};
	_newZone = [_zone, 50, _r_patrol, 1, 0, 60 * (pi / 180), 0] call BIS_fnc_findSafePos;
	_veh = createVehicle [_veh_type, _newZone, [], 0, "NONE"];
	BTC_type_crewmen createUnit [_zone, _group, "this moveinDriver _veh"];
	_gunner = _veh emptyPositions "gunner";
	_commander = _veh emptyPositions "commander";
	_cargo = (_veh emptyPositions "cargo") - 1;
	if (_gunner > 0) then {BTC_type_crewmen createUnit [_zone, _group, "this moveinGunner _veh;this assignAsGunner _veh;"];};
	if (_commander > 0) then {BTC_type_crewmen createUnit [_zone, _group, "this moveinCommander _veh;this assignAsCommander _veh;"];};
	if (_cargo > 0) then
	{
		for "_i" from 0 to _cargo do
		{
			_unit_type = BTC_type_units select (round (random ((count BTC_type_units) - 1)));
			_unit_type createUnit [_zone, _group, "this moveinCargo _veh;this assignAsCargo _veh;"];
		};
	};
	if !(isClass(configFile >> "cfgPatches" >> "asr_ai_main")) then {{_x setSkill ["aimingAccuracy", BTC_AI_skill];} foreach units _group;};
	if (_random > 0.5) then	{_wp = _group addWaypoint [_zone, 0];_wp setWaypointType "GUARD";_wp setWaypointCombatMode "RED";_wp setWaypointBehaviour "AWARE";_wp setWaypointSpeed "FULL";} else {[_group, _zone, _r_patrol] spawn BTC_task_patrol;};
};
BTC_create_task =
{
	_loc = _this select 0;
	_tsk = player createSimpleTask [str (_loc)];
	_tsk setSimpleTaskDescription [format ["Advance and secure position <marker name='%2'>%1</marker>", mapGridPosition _loc, _loc], format ["Advance and secure position %1", mapGridPosition _loc], format ["Advance and secure position %1", mapGridPosition _loc]];
	_tsk setSimpleTaskDestination _loc;
	player setCurrentTask _tsk;
	taskhint [format ["Advance and secure position %1", mapGridPosition _loc], [1, 1, 1, 1], "taskNew"];
};
BTC_task_completed =
{
	_pos = _this select 0;
	(currentTask player) setTaskState "Succeeded";
	taskhint [format ["%1 has been secured!", mapGridPosition _pos], [0.600000,0.839215,0.466666,1], "taskDone"];
};
BTC_jip_task = {sleep 10;if (format ["%1",currentTask player] == "No task") then {_task = [position BTC_actual_city] spawn BTC_create_task;{_marker = createmarkerLocal [format ["%1", _x], _x];_tsk = player createSimpleTask [str (_x)];_tsk setSimpleTaskDescription [format ["Advance and secure position <marker name='%2'>%1</marker>", mapGridPosition _x, _x], format ["Advance and secure position %1", mapGridPosition _x], format ["Advance and secure position %1", mapGridPosition _x]];_tsk setSimpleTaskDestination _x;_tsk setTaskState "Succeeded";}foreach BTC_city_array;};};
BTC_create_rebels = 
{
	_value   = _this select 0;
	_loc_pos = _this select 1;
	_loc_x   = _loc_pos select 0;
	_loc_y   = _loc_pos select 1;
	_n       = ceil (random _value);
	for "_i" from 0 to _n do
	{
		private ["_loc_2","_zone"];
		_loc_2 = [_loc_x + (random 100 - random 100), _loc_y + (random 100 - random 100), 0];
		_zone = [_loc_2, 30, 150, 1, 0, 60 * (pi / 180), 0] call BIS_fnc_findSafePos;
		_civ_group = createGroup civilian;
		_unit_type = BTC_type_civilians select (round (random ((count BTC_type_civilians) - 1)));
		_civ       = _civ_group createUnit [_unit_type, _zone, [], 0, "NONE"];
		[_civ_group, _zone, 60] spawn bis_fnc_taskPatrol;
		_random    = random 1;
		if (_random > 0.5) then {_civ setVariable ["BTC_Rebel",1,true];};
		sleep 0.1;
	};
};
BTC_rebels = 
{
	sleep 60;
	while {true} do
	{
		sleep 10;
		_rebels = [];
		{
			if (format ["%1", _x getVariable "BTC_Rebel"] == "1") then {_rebels = _rebels + [_x];};
		} foreach allUnits;
		{if (count (nearestObjects [_x, ["SoldierWB"], 8]) > 0) then {_x addMagazine "8Rnd_9x18_Makarov";_x addMagazine "8Rnd_9x18_Makarov";_x addMagazine "8Rnd_9x18_Makarov";_x addweapon "Makarov";[_x] join hq_red;_x setVariable ["BTC_Rebel",0,true];[_x] join GrpNull;_x doTarget ((nearestObjects [_x, ["SoldierWB"], 8]) select 0);};} foreach _rebels;
		{if (_x distance BTC_actual_city > 3000 && side _x == CIVILIAN) then {deleteVehicle _x;};} foreach allUnits;
	};
};
BTC_create_ieds = 
{
	_n   = _this select 0;
	_pos = _this select 1;
	_random = round (random _n);
	for "_i" from 0 to _random do
	{
		private ["_loc_2","_zone","_ied","_roads"];
		_loc_x = _pos select 0;
		_loc_y = _pos select 1;
		_loc_2 = [_loc_x + (random BTC_area_size - random BTC_area_size), _loc_y + (random BTC_area_size - random BTC_area_size), 0];
		_zone = [_loc_2, 30, 150, 1, 0, 60 * (pi / 180), 0] call BIS_fnc_findSafePos;	
		_type = BTC_type_ied select (round (random ((count BTC_type_ied) - 1)));
		_ied = _type createVehicle _zone;
		_road = random 1;
		if (_road > 0.5) then
		{
			_roads = _ied nearRoads BTC_area_size;
			_random = random 1;
			_obj = _roads select (round (random ((count _roads - 1))));
			_ied_pos = _zone;
			if (_random > 0.5) then {_ied_pos = _obj modelToWorld [3,0,0];} else {_ied_pos = _obj modelToWorld [-3,0,0];};
			_ied setPos _ied_pos;
		};
		_ied setVehicleInit "this addEventHandler [""HandleDamage"", BTC_IED_EH];";ProcessInitCommands;
		//_ied addMPEventHandler ["MPHit", BTC_IED_EH];
		if (BTC_debug == 1) then {_marker = createmarker [format ["%1", _i], position _ied];format ["%1", _i] setmarkertype "Warning";format ["%1", _i] setmarkersize [0.5,0.5];};
	};
};
BTC_IED_EH =
{
	private ["_pos","_type"];
	_pos = getPos (_this select 0);
	_type = BTC_type_expl select (round (random ((count BTC_type_expl) - 1)));
	deletevehicle (_this select 0);
	_bomb = _type createVehicle _pos;
};
BTC_ieds_control = 
{
	while {true} do 
	{
		WaitUntil {sleep 5; (count (nearestObjects [BTC_start_location_selected, BTC_type_ied, 99999]) > 0)};
		sleep 1.5;
		_ieds = nearestObjects [BTC_start_location_selected, BTC_type_ied, 99999];
		{
			if ({side _x == BTC_player_side} count (nearestObjects [getPos _x, [BTC_friendly_men,"Car","Truck","Tank","Wheeled_APC"], 5]) > 0) then {private ["_type"];_type = BTC_type_expl select (round (random ((count BTC_type_expl) - 1)));_bomb = _type createVehicle (getPos _x);deletevehicle _x;};
		} foreach _ieds;
	};
};
BTC_spawn_rinf_inf = 
{
	//_spawn = [east,[pos_1,pos_2],dest,5,1] spawn BTC_spawn_rinf_inf;
	_side        = _this select 0;
	_spawn_zones = _this select 1;
	_dest        = _this select 2;	
	_n_units     = _this select 3;
	_random_n    = _this select 4;
	_zone_array  = _spawn_zones select (round (random ((count _spawn_zones) - 1)));
	_zone = _zone_array;
	switch (typeName _zone_array) do
	{
		case "ARRAY" :{_zone = _zone_array;};
		case "STRING":{_zone = getMarkerPos _zone_array;};
		case "OBJECT":{_zone = position _zone_array;};
	};
	_n = 0;
	if (_random_n == 1) then {_n = round (random _n_units);} else {_n = _n_units - 1};
	_group_rinf = createGroup _side;
	for "_i" from 0 to _n do
	{
		_unit_type = BTC_type_units select (round (random ((count BTC_type_units) - 1)));
		_group_rinf createUnit [_unit_type, _zone, [], 0, "NONE"];
	};
	_wp = _group_rinf addWaypoint [_dest, 60];
	_wp setWaypointType "SAD";
	_wp setWaypointCombatMode "RED";
	_wp setWaypointBehaviour "AWARE";
	_wp setWaypointSpeed "FULL";
	_wp setWaypointFormation "WEDGE";
	_wp_1 = _group_rinf addWaypoint [_dest, 60];
	_wp_1 setWaypointType "CYCLE";
	if !(isClass(configFile >> "cfgPatches" >> "asr_ai_main")) then {{_x setSkill ["aimingAccuracy", BTC_AI_skill];} foreach units _group_rinf;};
};
BTC_spawn_rinf_mot = 
{
	//_mot = [east,[pos_1,pos_2],"",dest] spawn BTC_spawn_rinf_mot;
	_side        = _this select 0;
	_spawn_zones = _this select 1;
	_veh_type    = _this select 2;
	_dest        = _this select 3;
	_zone_array  = _spawn_zones select (round (random ((count _spawn_zones) - 1)));
	_zone = _zone_array;
	switch (typeName _zone_array) do
	{
		case "ARRAY" :{_zone = _zone_array;};
		case "STRING":{_zone = getMarkerPos _zone_array;};
		case "OBJECT":{_zone = position _zone_array;};
	};
	_group = createGroup _side;
	if (_veh_type == "") then {_veh_type = BTC_type_motorized select (round (random ((count BTC_type_motorized) - 1)));};
	_veh = createVehicle [_veh_type, _zone, [], 0, "NONE"];
	_gunner = _veh emptyPositions "gunner";
	_commander = _veh emptyPositions "commander";
	_cargo = (_veh emptyPositions "cargo") - 1;
	BTC_type_crewmen createUnit [_zone, _group, "this moveinDriver _veh;this assignAsDriver _veh;"];
	if (_gunner > 0) then {BTC_type_crewmen createUnit [_zone, _group, "this moveinGunner _veh;this assignAsGunner _veh;"];};
	if (_commander > 0) then {BTC_type_crewmen createUnit [_zone, _group, "this moveinCommander _veh;this assignAsCommander _veh;"];};
	for "_i" from 0 to _cargo do
	{
		_unit_type = BTC_type_units select (round (random ((count BTC_type_units) - 1)));
		_unit_type createUnit [_zone, _group, "this moveinCargo _veh;this assignAsCargo _veh;"];
	};
	_wp = _group addWaypoint [_dest, 60];
	_wp setWaypointType "SAD";
	_wp setWaypointCombatMode "RED";
	_wp setWaypointBehaviour "AWARE";
	_wp setWaypointSpeed "FULL";
	_wp_1 = _group addWaypoint [_dest, 60];
	_wp_1 setWaypointType "CYCLE";
	if !(isClass(configFile >> "cfgPatches" >> "asr_ai_main")) then {{_x setSkill ["aimingAccuracy", BTC_AI_skill];} foreach units _group;};
	WaitUntil {sleep 2; (_veh distance _dest < 200 || !Alive _veh)};
	{if (_x != driver _veh && _x != gunner _veh && _x != commander _veh) then {unassignVehicle _x};} foreach units _group;
	if (_veh isKindOf "Truck") then {{unassignVehicle _x;} foreach units _group;};
};
BTC_spawn_rinf_veh = 
{
	//_spawn = [east,[pos_1,pos_2],"",dest] spawn BTC_spawn_rinf_veh;
	_side        = _this select 0;
	_spawn_zones = _this select 1;
	_veh_type    = _this select 2;
	_dest        = _this select 3;
	_zone_array  = _spawn_zones select (round (random ((count _spawn_zones) - 1)));
	_zone = _zone_array;
	switch (typeName _zone_array) do
	{
		case "ARRAY" :{_zone = _zone_array;};
		case "STRING":{_zone = getMarkerPos _zone_array;};
		case "OBJECT":{_zone = position _zone_array;};
	};
	_group = createGroup _side;
	if (_veh_type == "") then {_veh_type = BTC_type_vehicles select (round (random ((count BTC_type_vehicles) - 1)));};
	_veh = createVehicle [_veh_type, _zone, [], 0, "NONE"];
	BTC_type_crewmen createUnit [_zone, _group, "this moveinDriver _veh"];
	_gunner    = _veh emptyPositions "gunner";
	_commander = _veh emptyPositions "commander";
	_cargo = (_veh emptyPositions "cargo") - 1;
	if (_gunner > 0) then {BTC_type_crewmen createUnit [_zone, _group, "this moveinGunner _veh;this assignAsGunner _veh;"];};
	if (_commander > 0) then {BTC_type_crewmen createUnit [_zone, _group, "this moveinCommander _veh;this assignAsCommander _veh;"];};
	for "_i" from 0 to _cargo do
	{
		_unit_type = BTC_type_units select (round (random ((count BTC_type_units) - 1)));
		_unit_type createUnit [_zone, _group, "this moveinCargo _veh;this assignAsCargo _veh;"];
	};
	_wp = _group addWaypoint [_dest, 60];
	_wp setWaypointType "SAD";
	_wp setWaypointCombatMode "RED";
	_wp setWaypointBehaviour "AWARE";
	_wp setWaypointSpeed "FULL";
	_wp_1 = _group addWaypoint [_dest, 60];
	_wp_1 setWaypointType "CYCLE";
	if !(isClass(configFile >> "cfgPatches" >> "asr_ai_main")) then {{_x setSkill ["aimingAccuracy", BTC_AI_skill];} foreach units _group;};
};
BTC_spawn_rinf_para = 
{
	//_mot = [east,[pos_1,pos_2],"","RANDOM",dest] spawn BTC_spawn_rinf_para;
	_side        = _this select 0;
	_spawn_zones = _this select 1;
	_veh_type    = _this select 2;
	_land        = _this select 3;	
	_dest        = _this select 4;
	_zone_array  = _spawn_zones select (round (random ((count _spawn_zones) - 1)));
	_zone = _zone_array;
	switch (typeName _zone_array) do
	{
		case "ARRAY" :{_zone = _zone_array;};
		case "STRING":{_zone = getMarkerPos _zone_array;};
		case "OBJECT":{_zone = position _zone_array;};
	};
	_group_p = createGroup _side;
	_group_t = createGroup _side;
	if (_veh_type == "") then {_veh_type = BTC_type_heli_transport select (round (random ((count BTC_type_heli_transport) - 1)));};
	_heli = createVehicle [_veh_type, _zone, [], 0, "FLY"];
	_gunner    = _heli emptyPositions "gunner";
	_commander = _heli emptyPositions "commander";
	_cargo     = (_heli emptyPositions "cargo") - 1;
	BTC_type_pilots createUnit [_zone, _group_p, "this moveinDriver _heli;this assignAsDriver _heli;this flyInHeight 100;"];
	if (_gunner > 0) then {BTC_type_pilots createUnit [_zone, _group_p, "this moveinGunner _heli;this assignAsGunner _heli;"];};
	if (_commander > 0) then {BTC_type_pilots createUnit [_zone, _group_p, "this moveinCommander _heli;this assignAsCommander _heli;"];};
	for "_i" from 0 to _cargo do
	{
		_unit_type = BTC_type_para select (round (random ((count BTC_type_para) - 1)));
		_unit_type createUnit [_zone, _group_t, "this moveinCargo _heli;this assignAsCargo _heli;"];
	};
	if !(isClass(configFile >> "cfgPatches" >> "asr_ai_main")) then {{_x setSkill ["aimingAccuracy", BTC_AI_skill];} foreach units _group_t;};
	if (_land == "RANDOM") then {_land_random = ["","LAND"] select (round (random ((count ["","LAND"]) - 1)));_land = _land_random;};
	if (_land == "LAND") then
	{
		_wp_land_1 = _group_p addWaypoint [_dest, 60];
		_wp_land_1 setWaypointType "MOVE";
		WaitUntil {isNull driver _heli || !Alive _heli || _heli distance _dest < 200};
		_heli land "GET OUT";
		WaitUntil {isNull driver _heli || !Alive _heli || getPos _heli select 2 < 4};
		{unassignVehicle _x} forEach units _group_t;commandGetOut units _group_t;
		_wp_land_3 = _group_p addWaypoint [_zone, 60];
		_wp_land_3 setWaypointType "MOVE";

		_wp_land = _group_t addWaypoint [_dest, 60];
		_wp_land setWaypointType "SAD";
		_wp_land setWaypointCombatMode "RED";
		_wp_land setWaypointBehaviour "SAFE";
		_wp_land setWaypointSpeed "FULL";
		_wp_land setWaypointFormation "WEDGE";
		WaitUntil {_heli distance _dest < 500};
	}
	else
	{
		_wp = _group_p addWaypoint [_dest, 60];
		_wp setWaypointType "MOVE";
		_wp setWaypointCombatMode "RED";
		_wp = _group_p addWaypoint [_zone, 60];
		_wp setWaypointType "MOVE";
		_heli flyInHeight 100;
		WaitUntil {_heli distance _dest < 200};
		{
			if !(_x isKindOf BTC_type_pilots) then 
			{
				unassignvehicle _x;
				_x action ["EJECT", _heli];
				sleep 1;
			};
		} foreach units _group_t;
		_wp_land = _group_t addWaypoint [_dest, 60];
		_wp_land setWaypointType "SAD";
		_wp_land setWaypointCombatMode "RED";
		_wp_land setWaypointBehaviour "SAFE";
		_wp_land setWaypointSpeed "FULL";
		_wp_land setWaypointFormation "WEDGE";
	};
	WaitUntil {sleep 1; _heli distance _zone < 400 || !Alive _heli || isNull driver _heli};
	{deleteVehicle _x;} foreach units _group_p;
	deleteVehicle _heli;
};
BTC_spawn_heli_group =
{
	//_spawn = [east,[pos_1,pos_2],dest,"","PATROL",150] spawn BTC_spawn_heli_group;
	//_spawn = [east,[pos_1,pos_2],dest,"Mi24_D_TK_EP1","SAD",150] spawn BTC_spawn_heli_group;
	//_spawn = [east,[pos_1,pos_2],dest,"","GUARD",150] spawn BTC_spawn_heli_group;
	_side        = _this select 0;
	_spawn_zones = _this select 1;
	_dest        = _this select 2;
	_heli_type   = _this select 3;
	_wp_type     = _this select 4;
	_r_patrol    = _this select 5;
	_zone_array  = _spawn_zones select (round (random ((count _spawn_zones) - 1)));
	_zone = _zone_array;
	switch (typeName _zone_array) do
	{
		case "ARRAY" :{_zone = _zone_array;};
		case "STRING":{_zone = getMarkerPos _zone_array;};
		case "OBJECT":{_zone = position _zone_array;};
	};
	_group = createGroup _side;
	if (_heli_type == "") then {_heli_type = BTC_type_heli select (round (random ((count BTC_type_heli) - 1)));};
	_heli = createVehicle [_heli_type, _zone, [], 0, "FLY"];
	BTC_type_pilots createUnit [_zone, _group, "this moveinDriver _heli"];
	BTC_type_pilots createUnit [_zone, _group, "this moveinGunner _heli"];
	if (_wp_type == "PATROL") then 
	{
		[_group, _dest, _r_patrol] spawn BTC_task_patrol;	
	}
	else
	{
		_wp = _group addWaypoint [_dest, _r_patrol];
		_wp setWaypointType _wp_type;
		_wp setWaypointCombatMode "RED";
		_wp setWaypointBehaviour "AWARE";
		_wp setWaypointSpeed "FULL";
		_wp_1 = _group addWaypoint [_dest, _r_patrol];
		_wp_1 setWaypointType "CYCLE";
	};
	if !(isClass(configFile >> "cfgPatches" >> "asr_ai_main")) then {{_x setSkill ["aimingAccuracy", BTC_AI_skill];} foreach units _group;};
};
BTC_Player_Killed = 
{
	private ["_weapon","_ammo","_type_backpack","_weapon_backpack","_ammo_backpack"];
	_body = _this select 0;
	_weapon = weapons _body;
	_ammo = magazines _body;
	_type_backpack = "";
	if !(isNull (unitBackpack _body)) then
	{
		_type_backpack = typeOf unitBackpack _body;
		_weapon_backpack = getWeaponCargo unitBackpack _body;
		_ammo_backpack = getMagazineCargo unitBackpack _body;
	};
	hidebody _body;
	deletevehicle _body;
	titleText ["You are dead!", "BLACK OUT"];
	sleep 2;
	player enableSimulation false;
	for [{_n = 30}, {_n != 0}, {_n = _n - 1}] do
	{
		_msg = format ["You are dead! Waiting %1 seconds to respawn",_n];
		titleText [_msg, "BLACK FADED"];
		sleep 1;
	};
	WaitUntil {Alive player};
	player enableSimulation true;
	if (BTC_arty_player_def == 1 && format ["%1",player getVariable "BTC_arty_operator"] == "1") then {_action = player addaction [("<t color=""#ED2744"">") + ("Request artillery") + "</t>","=BTC=_addAction.sqf",[[],BTC_fnc_arty],1,false,false,"","BTC_arty_player_available"];};
	player addAction [("<t color=""#ED2744"">") + ("Set view distance") + "</t>","=BTC=_addAction.sqf",[[],BTC_action_view_distance],7,false,false,"","true"];
	switch (BTC_def_recruitment) do {case 0:{};case 1:{if (rank player == "CAPTAIN") then {player addAction [("<t color=""#ED2744"">") + ("Recrutiment") + "</t>","=BTC=_addAction.sqf",[[],BTC_action_recruitment],7,false,false,"","true"];};};case 2:{if (rank player == "CAPTAIN" || rank player == "LIEUTENANT") then {player addAction [("<t color=""#ED2744"">") + ("Recrutiment") + "</t>","=BTC=_addAction.sqf",[[],BTC_action_recruitment],7,false,false,"","true"];};};};
	if (BTC_def_rally_point == 1) then {if (rank player == "CAPTAIN") then {_action = player addaction [("<t color=""#27EE1F"">") + ("Rally point") + "</t>","=BTC=_addAction.sqf",[[],BTC_action_rally_point],0,false,false,"","isNil ""BTC_rally_point_deployed"""];};};
	removeallweapons player;
	removeallitems player;
	removeBackpack player;
	{player addMagazine _x;} forEach _ammo;
	{player addWeapon _x;} forEach _weapon;
	if (_type_backpack != "") then
	{
		player addBackPack _type_backpack;
		_backpack = unitBackpack player;
		clearMagazineCargoGlobal (unitBackpack player);
		clearWeaponCargoGlobal (unitBackpack player);
		for "_i" from 0 to (count (_weapon_backpack select 0) - 1) do
		{
			(unitBackpack player) addweaponCargo [(_weapon_backpack select 0) select _i,(_weapon_backpack select 1) select _i];
		};
		for "_i" from 0 to (count _ammo_backpack - 1) do
		{
			(unitBackpack player) addMagazineCargo [(_ammo_backpack select 0) select _i,(_ammo_backpack select 1) select _i];
		};
	};
	player selectWeapon (primaryWeapon player);
	titleText ["", "BLACK IN"];
	if (BTC_def_rally_point == 1 && !isNil "BTC_rally_point_deployed") then {_rally_point = createdialog "BTC_rally_point";};
};
BTC_Marker =
{
	{
		if (Alive _x && isplayer _x) then
		{
			if (leader _x == _x) then
			{
				format ["%1", group _x] setMarkerPosLocal (getpos _x);
				format ["%1", group _x] setMarkerTextLocal format ["%1 (%2)", group _x, name _x];
				format ["%1", _x] setMarkerPosLocal [0,0];
				format ["%1", _x] setMarkerTextLocal "";
				if (group _x == group player) then {format ["%1", group _x] setMarkerColorLocal "ColorGreen";} else {format ["%1", group _x] setMarkerColorLocal "ColorBlue";};
			}
			else
			{
				format ["%1", _x] setMarkerPosLocal (getpos _x);
				format ["%1", _x] setMarkerTextLocal format ["%1", name _x];
				if (group _x == group player) then {format ["%1", _x] setMarkerColorLocal "ColorGreen";} else {format ["%1", _x] setMarkerColorLocal "ColorBlue";};
			};
		}
		else
		{
			format ["%1", _x] setMarkerPosLocal [0,0];
			format ["%1", _x] setMarkerTextLocal "";
		};
	} foreach [s1,s2,s3,s4,s5,s6,s7,s8,s9,s10,s11,s12,s13,s14,s15,s16,s17,s18,s19,s20,s21];
	{
		if (side _x == BTC_player_side) then
		{
			if (count units _x == 0) then
			{
				format ["%1", _x] setMarkerPosLocal [0,0];
				format ["%1", _x] setMarkerTextLocal "";
			};
		};
	} foreach Allgroups;
};
BTC_fired = 
{
	//From Pogoman
	if ((_this select 1) == "M136" || (_this select 1) == "RPG18") then {[] spawn {sleep 0.5;if (player hasweapon "M136") then {player removeWeapon "M136";};if (player hasweapon "RPG18") then {player removeWeapon "RPG18";};};}; 
};
BTC_M136 = 
{
	//From Pogoman
	if (currentWeapon player == "M136" && !("M136" in magazines player)) then 
	{ 
		player removeWeapon "M136"; 
		player addMagazine "M136"; 
		player addWeapon "M136"; 
		player selectWeapon "M136"; 
	}; 
	if (currentWeapon player != "M136" && "M136" in magazines player) then {player removeMagazine "M136";}; 
	if (currentWeapon player == "RPG18" && !("RPG18" in magazines player)) then 
	{ 
		player removeWeapon "RPG18"; 
		player addMagazine "RPG18"; 
		player addWeapon "RPG18"; 
		player selectWeapon "RPG18"; 
	}; 
	if (currentWeapon player != "RPG18" && "RPG18" in magazines player) then {player removeMagazine "RPG18";}; 
}; 
BTC_create_trigger =
{
	private ["_pos","_area","_act","_cond","_stat","_trg"];
	_pos    = _this select 0;
	_area   = _this select 1;
	_act    = _this select 2;
	_stat   = _this select 3;
	_trg = createTrigger["EmptyDetector", _pos];
	_trg setTriggerArea _area;
	_trg setTriggerActivation _act;
	_trg setTriggerStatements _stat;
};
BTC_create_marker =
{
	private ["_pos","_area","_shape","_type","_marker"];
	_name   = _this select 0;
	_pos    = _this select 1;
	_area   = _this select 2;
	_shape  = _this select 3;
	_type   = _this select 4;
	_brush  = _this select 5;
	_color  = _this select 6;
	_text   = _this select 7;
	_marker = createMarker [_name, _pos];
	_name setMarkerSize _area;
    _name setMarkerShape _shape;
	_name setMarkerType _type;
	if (_brush != "") then {_name setMarkerBrush _brush;};
	_name setMarkerColor _color;
	_name setMarkerText _text;
};
BTC_create_marker_local =
{
	private ["_name","_pos","_area","_shape","_type","_marker"];
	_name   = _this select 0;
	_pos    = _this select 1;
	_area   = _this select 2;
	_shape  = _this select 3;
	_type   = _this select 4;
	_brush  = _this select 5;
	_color  = _this select 6;
	_text   = _this select 7;
	_marker = createMarkerLocal [_name, _pos];
	_name setMarkerSizeLocal _area;
    _name setMarkerShapeLocal _shape;
	_name setMarkerTypeLocal _type;
	if (_brush != "") then {_name setMarkerBrushLocal  _brush;};
	_name setMarkerColorLocal _color;
	_name setMarkerTextLocal _text;
	if (count _this > 8) then {_name setMarkerAlphaLocal (_this select 8);};
};
BTC_fill_ammo_box =
{
	_ammo_box   = _this select 0;
	_fill_array = _this select 1;
	_weapon = _fill_array select 0;
	_ammo   = _fill_array select 1;
	ClearWeaponCargoGlobal _ammo_box;
	ClearMagazineCargoGlobal _ammo_box;
	{_ammo_box addWeaponCargoGlobal [(_x select 0),(_x select 1)];} foreach _weapon;
	{_ammo_box addMagazineCargoGlobal [(_x select 0),(_x select 1)];} foreach _ammo;
};
BTC_Player_Intro =
{
	disableSerialization;
	titleRsc ["BTC_intro", "PLAIN"];
	_cam = "camera" camCreate [position player select 0, (position player select 1) - 30, 18];
	_cam camSetTarget player;
	_cam cameraEffect ["internal", "BACK"];
	_cam camSetPos [position player select 0, position player select 1, 2.2];
	_cam camCommit 10;
	[] spawn {sleep 8;[str("=BTC= presents:"), str("=BTC= Advance & Secure")] spawn BIS_fnc_infoText;sleep 6;[str("A mission") , str("by Giallustio")] spawn BIS_fnc_infoText;sleep 10;[format ["%1.%2.%3  %4:%5", (date) select 0,(date) select 1,(date) select 2,(date) select 3,(date) select 4] , format ["Welcome to %1", worldname], format ["%1", name player]] spawn BIS_fnc_infoText;};
	waitUntil {camCommitted _cam};
	titleText ["", "PLAIN"];
	player cameraEffect ["terminate","back"];
	camDestroy _cam;
	hint "=BTC=";
	intro_finished = true;
};
BTC_outro =
{
	cutRsc ["BTC_intro", "PLAIN"];
	_pos_player = getposASL player;
	_x = _pos_player select 0;
	_y = _pos_player select 1;
	_z = (_pos_player select 2) + 2.2;
	_cam = "camera" camCreate [position player select 0, (position player select 1) - 20, 30];
	_cam camSetTarget player;
	_cam cameraEffect ["internal", "BACK"];
	_cam camSetPos [_x,_y,_z];
	_cam camCommit 40;
	titleText ["ENEMY ARMY HAS BEEN DEFEATED! \n MISSION ACCOMPLISHED!!!", "PLAIN"];
	BTC_end = true;
	publicvariable "BTC_end";
	sleep 10;
	forceEnd;
	sleep 2;
	player cameraEffect ["terminate","back"];
	camDestroy _cam;
};
BTC_marker_debug =
{
	_units = allunits;
	{
		if (Alive _x && !isplayer _x && side _x != BTC_player_side) then
		{
			_marker = createmarkerLocal [format ["%1", _x], position _x];
			format ["%1", _x] setmarkertypelocal "Dot";
			format ["%1", _x] setMarkerTextLocal format ["%1", typeOf _x];//typeOf
			format ["%1", _x] setmarkerColorlocal "ColorRed";
			format ["%1", _x] setMarkerSizeLocal [0.7, 0.7];
		}
		else
		{
			format ["%1", _x] setMarkerPosLocal [0,0];
			format ["%1", _x] setMarkerTextLocal "";
			deleteMarker format ["%1", _x];
		};
	} foreach _units;
	sleep 1;
	{deleteMarker format ["%1", _x]} foreach _units;
	_marker = [] spawn BTC_marker_debug;
};
BTC_farp =
{
	_farp_pos = _this select 0;
	_farp_x = _farp_pos select 0;
	_farp_y = _farp_pos select 1;
	_farp_z = _farp_pos select 2;
	_marker_farp = createMarker ["BTC_marker_farp",_farp_pos];_marker_farp setMarkerColor "ColorBlue";_marker_farp setMarkerSize [0.5, 0.5];_marker_farp setMarkerText "Wrecks repair";_marker_farp setMarkerType "b_maint";
	while {true} do
	{
		WaitUntil {sleep 5; (count (nearestObjects [_farp_pos, ["LandVehicle","Air"], 8]) > 0)};
		_veh = nearestObjects [_farp_pos, ["LandVehicle","Air"], 8];
		if (count _veh > 0) then
		{
			{
				sleep 1;
				if ((position _x select 2 < 1) && (speed _x == 0)) then
				{
					_damage = getdammage _x;
					if (_damage == 1) then 
					{
					_type = typeOf _x;
					_dir = getdir _x;
					deletevehicle _x;
					sleep 0.01;
					_new_x = createVehicle [_type, [_farp_x,_farp_y,_farp_z], [], 0, "NONE"];
					_new_x setDir _dir;
					_x lock false;
					sleep 0.01;
					_new_x setdamage 0.8;
					} 
					else 
					{
						_x setdammage (_damage - 0.1);
					};
				};
			} foreach _veh;
			sleep 1;
		};
	};
};
BTC_dlg_view_distance =
{
	sliderSetRange [9999, 500, 10000];
	sliderSetPosition [9999, viewdistance];
	_dist = format ["View distance: %1 m", viewdistance];
	ctrlSetText [9998, _dist];
};
BTC_set_view_distance =
{
	_view_distance = sliderPosition 9999;
	setViewDistance _view_distance;
	closeDialog 0;
};

BTC_Main_Loop = 
{
	while {true} do
	{
		_veh = vehicle player;
		switch (BTC_marker_desc) do {case 0:{};case 1:{if (rank player == "CAPTAIN") then {[] call BTC_Marker;};};case 2:{[] call BTC_Marker;};};
		call BTC_M136;
		sleep 0.1;
	};
};
BTC_task_patrol =
{
	//From BIS module
	private ["_grp", "_pos", "_maxDist", "_blacklist"];
	_grp = _this select 0;
	_pos = _this select 1;
	_maxDist = _this select 2;

	_grp setBehaviour "AWARE";

	private ["_prevPos"];
	_prevPos = _pos;
	for "_i" from 0 to (2 + (floor (random 3))) do
	{
		private ["_wp", "_newPos"];
		_newPos = [_prevPos, 50, _maxDist, 1, 0, 60 * (pi / 180), 0, _blacklist] call BIS_fnc_findSafePos;
		_prevPos = _newPos;

		_wp = _grp addWaypoint [_newPos, 0];
		_wp setWaypointType "MOVE";
		_wp setWaypointCompletionRadius 20;
		_wp setWaypointCombatMode "RED";

		if (_i == 0) then
		{
			_wp setWaypointSpeed "LIMITED";
			_wp setWaypointFormation "STAG COLUMN";
			_wp setWaypointCombatMode "RED";
		};
	};

	private ["_wp"];
	_wp = _grp addWaypoint [_pos, 0];
	_wp setWaypointType "CYCLE";
	_wp setWaypointCompletionRadius 20;

	true	
};
//Recruit
BTC_recruitable_get_cost =
{
	_type = lbText [1000,lbCurSel 1000];
	_n = BTC_recruitable_units find _type;
	[1002, format ["Cost: %1 $", BTC_recruitable_cost select _n]] spawn BTC_ctrlText;
	[1003, format ["Budget: %1 $", BTC_money]] spawn BTC_ctrlText;
};
BTC_Get_Group_Composition = 
{
	_idd      = _this select 0;
	_id       = _this select 1;
	disableSerialization;
	_group = group player;
	_div   = "<br />";
	_comp  = "";
	_type  = "";
	{
		if (_x != vehicle _x && driver vehicle _x == _x) then {_type = format ["%1 (%2)",getText (configFile >> "cfgVehicles" >> TypeOf vehicle _x >> "displayName"),getText (configFile >> "cfgVehicles" >> TypeOf _x >> "displayName")];} else {_type = getText (configFile >> "cfgVehicles" >> TypeOf _x >> "displayName");};
		_comp = _comp + _type + _div;
	} foreach units _group;
	_display = findDisplay _idd;
	_control = _display displayCtrl _id;
	_control ctrlSetStructuredText parseText _comp;
};
BTC_spawn_unit =
{
	_type = lbText [1000,lbCurSel 1000];
	_n = BTC_recruitable_units find _type;
	_cost = BTC_recruitable_cost select _n;
	if (rank player != "CAPTAIN" && count units group player > 5) exitWith {hint "You can't have more than 6 units";};
	if (BTC_money > _cost) then {BTC_money = BTC_money - _cost;publicVariable "BTC_money";(group player) createUnit [_type, BTC_start_location_selected, [], 0, "NONE"];} else {hint "You don't have enough money";};
	[1003, format ["Budget: %1 $", BTC_money]] spawn BTC_ctrlText;
	[1111,1004] spawn BTC_Get_Group_Composition;
	_msg = format ["%1 recruit a %2 for %3 $",name player, getText (configFile >> "cfgVehicles" >> _type >> "displayName"), _cost];
	if (rank player != "CAPTAIN") then {BTC_spawn = [[_msg], BTC_side_chat];publicVariable "BTC_spawn";};
};
//
BTC_side_chat =
{
	_msg  = _this select 0;
	_unit = _this select 1;
	_unit sideChat _msg;
};
BTC_Fill_list = 
{
	_id     = _this select 0;
	_array  = _this select 1;
	lbClear _id;
	{_slot = lbAdd [_id, _x];} foreach _array;
	lbSetCurSel [_id,0];
};
BTC_ctrlText =
{
	_idc  = _this select 0;
	_text = _this select 1;
	ctrlSetText [_idc, _text];
};
BTC_fnc_arty =
{
	_dlg = createDialog "BTC_arty_dialog";
	BTC_chosen = false;
	WaitUntil {!Dialog || (BTC_chosen)};
	if (!BTC_chosen) then {closeDialog 0;};
	if (BTC_chosen) then 
	{
		_type_mission = lbText [5550,lbCurSel 5550];
		_x_direction  = lbText [5551,lbCurSel 5551];
		_y_direction  = lbText [5552,lbCurSel 5552];
		_x_number     = ctrlText 5553;
		_y_number     = ctrlText 5554;
		_actual_pos   = position player;
		_actual_pos_x = _actual_pos select 0;
		_actual_pos_y = _actual_pos select 1;
		_n = 0;
		closeDialog 0;
		_caller = player;
		call compile format ["BTC_arty_player_x = %1;", _x_number];
		call compile format ["BTC_arty_player_y = %1;", _y_number];
		if (typeName BTC_arty_player_x != "SCALAR" || typeName BTC_arty_player_y != "SCALAR") exitWith {hint "Invalid target coordinations";};
		BTC_arty_player_available = false;
		BTC_arty_player_reloading = 0;
		switch (_x_direction) do
		{
			case "E" : {};
			case "W" : {_n = 0 - BTC_arty_player_x;BTC_arty_player_x = _n;};
		};
		switch (_y_direction) do
		{
			case "N" : {};
			case "S" : {_n = 0 - BTC_arty_player_y;BTC_arty_player_y = _n;};
		};
		_msg = format ["Crossroad, this is %1! Requesting artillery support in grid %2! Over", group _caller, mapGridPosition [(_actual_pos_x + BTC_arty_player_x),(_actual_pos_y + BTC_arty_player_y),0]];
		if (BTC_ACE) then {[-1, {_this spawn {(_this select 0) sideChat (_this select 1);};}, [player,_msg]] call CBA_fnc_globalExecute;} else {BTC_spawn = [[_msg,_caller], BTC_side_chat];publicVariable "BTC_spawn";_caller sideChat _msg;};
		sleep 4;
		_msg = format ["Copy %1! Target acquired! calculating firing solution! standing by! Over", group _caller];
		if (BTC_ACE) then {[-1, {_this spawn {[BTC_player_side,"HQ"] sideChat (_this select 0);};}, [_msg]] call CBA_fnc_globalExecute;} else {BTC_spawn = [[_msg,[BTC_player_side,"HQ"]], BTC_side_chat];publicVariable "BTC_spawn";[BTC_player_side,"HQ"] sideChat _msg;};
		_type = BTC_arty_magazine select 0;
		_mags = BTC_arty_magazine select 1;
		_n = _type find _type_mission;
		_mag_selected = _mags select _n;
		sleep 3;
		_msg = "The battery is opening fire! ETA 30 secs! Over";
		if (BTC_ACE) then {[-1, {_this spawn {[BTC_player_side,"HQ"] sideChat (_this select 0);};}, [_msg]] call CBA_fnc_globalExecute;} else {BTC_spawn = [[_msg,[BTC_player_side,"HQ"]], BTC_side_chat];publicVariable "BTC_spawn";[BTC_player_side,"HQ"] sideChat _msg;};
		sleep 30 + random 5;
		_msg = "Splash! Over";
		[side _caller,"HQ"] sideChat _msg;
		if (BTC_ACE) then {[-1, {_this spawn {[BTC_player_side,"HQ"] sideChat (_this select 0);};}, [_msg]] call CBA_fnc_globalExecute;} else {BTC_spawn = [[_msg,[BTC_player_side,"HQ"]], BTC_side_chat];publicVariable "BTC_spawn";[BTC_player_side,"HQ"] sideChat _msg;};	
		_h = 100;
		if (_type_mission == "SMOKE") then {_h = 0;};
		for "_i" from 0 to 5 do
		{
			_bomb = _mag_selected createVehicle [(_actual_pos_x + BTC_arty_player_x) + (random 50 - random 50),(_actual_pos_y + BTC_arty_player_y) + (random 50 - random 50), _h];
			sleep 2;
		};
		sleep 5;
		_msg = "Rounds complete! Artillery is reloading!";
		[side _caller,"HQ"] sideChat _msg;
		if (BTC_ACE) then {[-1, {_this spawn {[BTC_player_side,"HQ"] sideChat (_this select 0);};}, [_msg]] call CBA_fnc_globalExecute;} else {BTC_spawn = [[_msg,[BTC_player_side,"HQ"]], BTC_side_chat];publicVariable "BTC_spawn";[BTC_player_side,"HQ"] sideChat _msg;};
		while {BTC_arty_player_reloading != BTC_arty_player_reload_time} do {sleep 1;BTC_arty_player_reloading = BTC_arty_player_reloading + 1;};
		BTC_arty_player_available = true;
		_msg = "Artillery available!";
		if (BTC_ACE) then {[-1, {_this spawn {[BTC_player_side,"HQ"] sideChat (_this select 0);};}, [_msg]] call CBA_fnc_globalExecute;} else {BTC_spawn = [[_msg,[BTC_player_side,"HQ"]], BTC_side_chat];publicVariable "BTC_spawn";[BTC_player_side,"HQ"] sideChat _msg;};
	};
	BTC_chosen = false;
};
BTC_move_to_rally_point =
{
	closeDialog 0;
	_rally_point = nearestObjects [BTC_start_location_selected, [BTC_type_rally_point], 99999];
	if (count _rally_point == 0) exitWith {hint "Can't move to rally point";};
	titleText ["Moving to Rally Point", "BLACK OUT"];
	sleep 3;
	titleText ["Moving to Rally Point", "BLACK FADED"];
	sleep 2;
	titleText ["", "BLACK IN"];
	_pos = getPos (_rally_point select 0);
	player setpos _pos;
};
BTC_init_coin_module =
{
	BTC_coin_module synchronizeObjectsAdd [player];
	BTC_coin_module setVariable ["BIS_COIN_name", "F.O.B Construction"];
	BTC_coin_module setVariable ["BIS_COIN_funds", ["BTC_money"]];
	BTC_coin_module setVariable ["BIS_COIN_fundsdescription", ["$"]];
	BTC_coin_module setVariable ["BIS_COIN_categories", ["Weapon boxes", "Ammo boxes", "Static Weapons", "Support", "Light Vehicles", "Armour", "Helicopter", "Plane", "Boat"]];
	BTC_coin_module setVariable ["BIS_COIN_areaSize", [150, 50]];
	BTC_coin_module setvariable ["BIS_COIN_actionCondition","false"];
	BTC_coin_module setvariable ["BIS_COIN_rules",[BTC_player_side]];
	if (BTC_ACE) then {BTC_coin_module setVariable ["BIS_COIN_items", BTC_coin_items_ACE];} else {BTC_coin_module setVariable ["BIS_COIN_items", BTC_coin_items];};
	BTC_coin_module setvariable ["BIS_COIN_onconstruct",
	{
		sleep 1;
		_obj = _this select 1;
		if (({_obj isKindOf _x;} count BTC_Draggable) > 0 && typeOf _obj != "USVehicleBox_EP1") then
		{
			_name = getText (configFile >> "cfgVehicles" >> typeof _obj >> "displayName");
			_text_action = "this addAction [" + """" + "<t color=""""#ED2744"""">" + "Drag " + (_name) + "</t>" + """" + ",""=BTC=_Logistic\=BTC=_Cargo_System\=BTC=_Drag.sqf"", """", 7, true, true]";
			_obj setVehicleInit _text_action;ProcessInitCommands;
		};
		if (typeOf _obj == "USVehicleBox_EP1") then 
		{
			ClearWeaponCargoGlobal _obj;
			ClearMagazineCargoGlobal _obj;
			{_obj addWeaponCargoGlobal [_x,50];} foreach BTC_items;
			{_obj addMagazineCargoGlobal [_x,50];} foreach ["Laserbatteries","IRStrobe","IR_Strobe_Marker"];
		};
	}];
	_action = player addaction [("<t color=""#ED2744"">") + ("Costruction menu") + "</t>","ca\modules\coin\data\scripts\coin_interface.sqf",BTC_coin_module,1,false,false,"","true"];
	_flag = nearestObject [BTC_start_location_selected, "FlagCarrierCore"];
	_container = _flag addaction [("<t color=""#ED2744"">") + ("Create container") + "</t>","=BTC=_addAction.sqf",[[],BTC_action_container],0,false,false,"","rank player == ""CAPTAIN"" && count (nearestObjects [BTC_start_location_selected, [""US_WarfareBContructionSite_Base_EP1""], 50000]) == 0"];
	_del_conta = _flag addaction [("<t color=""#ED2744"">") + ("Delete container") + "</t>","=BTC=_addAction.sqf",[[],BTC_action_delete_container],0,false,false,"","rank player == ""CAPTAIN"" && count (nearestObjects [BTC_start_location_selected, [""US_WarfareBContructionSite_Base_EP1""], 50000]) != 0"];
	_containers = nearestObjects [BTC_start_location_selected, ["US_WarfareBContructionSite_Base_EP1"], 999999];
	if (count _containers > 0) then {{_action = _x addaction [("<t color=""#ED2744"">") + ("Mount fob") + "</t>","=BTC=_addAction.sqf",[[],BTC_action_mount_fob],0,false,false,"","rank player == ""CAPTAIN"" && (player distance BTC_start_location_selected) > 300"];} foreach _containers};
	[] spawn
	{
		while {true} do
		{
			WaitUntil {sleep 2; !Alive player};
			WaitUntil {Alive player};
			BTC_coin_module synchronizeObjectsAdd [player];
			_action = player addaction [("<t color=""#ED2744"">") + ("Costruction menu") + "</t>","ca\modules\coin\data\scripts\coin_interface.sqf",BTC_coin_module,1,false,false,"","true"];
			if (BTC_def_rally_point == 1) then {_action = player addaction [("<t color=""#27EE1F"">") + ("Rally point") + "</t>","=BTC=_addAction.sqf",[[],BTC_action_rally_point],0,false,false,"","isNil ""BTC_rally_point_deployed"""];};
		};
	};
};
BTC_move_fob =
{
	[side player,"HQ"] sideChat format ["A new fob has been created in grid %1!", mapGridPosition BTC_start_location_selected];
	_ruck_box = nearestObject [BTC_start_location_selected, "MASH_EP1"];
	_ruck_box addAction [("<t color=""#ED2744"">") + ("Take a backpack") + "</t>","=BTC=_addAction.sqf",[[],BTC_action_add_backpack], 7, true, false, "", "isNull (unitBackpack player) && secondaryWeapon player == """""];
	if (BTC_def_rally_point == 1) then {_flag = nearestObject [BTC_start_location_selected, "FlagCarrierCore"];_flag addAction [("<t color=""#ED2744"">") + ("Move to rally point") + "</t>","=BTC=_addAction.sqf",[[],BTC_move_to_rally_point], 7, true, false, "", "!isNil ""BTC_rally_point_deployed"""];};
	BTC_coin_module setPos BTC_start_location_selected;
	if (rank player == "CAPTAIN") then
	{
		_flag = nearestObject [BTC_start_location_selected, "FlagCarrierCore"];
		_container = _flag addaction [("<t color=""#ED2744"">") + ("Create container") + "</t>","=BTC=_addAction.sqf",[[],BTC_action_container],0,false,false,"","rank player == ""CAPTAIN"" && count (nearestObjects [BTC_start_location_selected, [""US_WarfareBContructionSite_Base_EP1""], 50000]) == 0"];
		_del_conta = _flag addaction [("<t color=""#ED2744"">") + ("Delete container") + "</t>","=BTC=_addAction.sqf",[[],BTC_action_delete_container],0,false,false,"","rank player == ""CAPTAIN"" && count (nearestObjects [BTC_start_location_selected, [""US_WarfareBContructionSite_Base_EP1""], 50000]) != 0"];
	};
	BTC_marker_respawn setMarkerPos BTC_start_location_selected;
	"BTC_marker_base" setMarkerPos BTC_start_location_selected;
};
//Actions
BTC_action_add_backpack =
{
	if (BTC_ACE) then 
	{
		player addWeapon "ACE_Rucksack_MOLLE_ACU";
		_pack = [player, "ACE_Bandage", 10] call ACE_fnc_PackMagazine;
		_pack = [player, "ACE_LargeBandage", 10] call ACE_fnc_PackMagazine;
		_pack = [player, "ACE_Morphine", 10] call ACE_fnc_PackMagazine;
		_pack = [player, "ACE_Epinephrine", 10] call ACE_fnc_PackMagazine;
		_pack = [player, "ACE_Medkit", 10] call ACE_fnc_PackMagazine;
	}
	else
	{
		player addBackpack "CZ_Backpack_Specops_EP1";
		clearMagazineCargoGlobal (unitBackpack player);
		clearWeaponCargoGlobal (unitBackpack player);
	};
};
BTC_action_rally_point =
{
	if (isNil "BTC_rally_point_deployed") then
	{
		BTC_rally_point_deployed = true;publicVariable "BTC_rally_point_deployed";
		_pos = getPosATL player;
		BTC_rally_point = createVehicle [BTC_type_rally_point, _pos, [], 0, "NONE"];
		BTC_rally_point setPosATL _pos;
		_action = BTC_rally_point addaction [("<t color=""#27EE1F"">") + ("Pick up rally point") + "</t>","=BTC=_addAction.sqf",[[],BTC_action_rally_point],0,false,false,"","rank player == ""CAPTAIN"""];
		_marker = createMarker ["BTC_rally_point", position player];
		_marker setMarkerSize [0.6,0.6];
		_marker setMarkerType "End";
		_marker setMarkerColor "ColorGreen";
		_marker setMarkerText "Rally Point";
	}
	else
	{
		if (isNull BTC_rally_point) then {BTC_rally_point = nearestObject [player, BTC_type_rally_point];};
		deleteVehicle BTC_rally_point;
		deleteMarker "BTC_rally_point";
		BTC_rally_point_deployed = nil;publicVariable "BTC_rally_point_deployed";
	};
};
BTC_action_container =
{
	_BTC_container = createVehicle ["US_WarfareBContructionSite_Base_EP1", position player, [], 0, "NONE"];
	_container = _BTC_container addaction [("<t color=""#ED2744"">") + ("Mount fob") + "</t>","=BTC=_addAction.sqf",[[],BTC_action_mount_fob],0,false,false,"","rank player == ""CAPTAIN"" && (player distance BTC_start_location_selected) > 300"];
};
BTC_action_delete_container =
{
	deleteVehicle ((nearestObjects [player, ["US_WarfareBContructionSite_Base_EP1"], 50000]) select 0);
};
BTC_action_mount_fob =
{
	_pos = getPos player;
	BTC_start_location_selected = _pos;publicVariable "BTC_start_location_selected";
	deleteVehicle ((nearestObjects [player, ["US_WarfareBContructionSite_Base_EP1"], 100]) select 0);
	[_pos, BTC_base_on_load] call BTC_spawn_base;
	if (BTC_ACE) then {[-1, {_this spawn BTC_move_fob;}, []] call CBA_fnc_globalExecute;} else {BTC_spawn = [[],BTC_move_fob];publicVariable "BTC_spawn";_spawn = [] spawn BTC_move_fob;};
};
BTC_action_view_distance =
{
	if !(dialog) then{_dlg = createDialog "BTC_view_distance"};
};
BTC_action_recruitment =
{
	if !(dialog) then{_dlg = createDialog "BTC_recruit"};
};
//Enemy player
BTC_on_map_click = 
{
	private ["_man","_pos","_ground_pos","_group"];
	_pos = _this select 0;
	_ground_pos = [_pos select 0, _pos select 1, 0];
	BTC_old_body = player;
	_group = BTC_old_group;
	_man = nearestObjects [_ground_pos, ["Man"], 200];
	{if (side _x == BTC_player_side) then {_man = _man - [_x];};} foreach _man;
	//diag_log text format ["BTC_on_map_click %1 - %2", (_man select 0),_pos];
	if (count _man > 0) then
	{
		BTC_old_group = group (_man select 0);
		addSwitchableUnit (_man select 0);
		setPlayable (_man select 0);
		[(_man select 0)] joinSilent GrpNull;
		selectPlayer (_man select 0);
		if (Alive BTC_old_body) then {[BTC_old_body] joinSilent _group;};
		if (BTC_old_body distance BTC_actual_city > 3000) then {deleteVehicle BTC_old_body};
		{player reveal _x;} forEach (position (_man select 0) nearObjects ["ReammoBox",50]);
		{player reveal _x;} forEach (position (_man select 0) nearObjects ["Misc_Backpackheap",50]);
	};
};
BTC_selectable_units =
{
	private ["_units","_names","_marker","_name"];
	_units = allunits;
	_names = [];
	{
		if (Alive _x && side _x != BTC_player_side) then
		{
			_name = position _x;
			_names = _names + [_name];
			_marker = createmarkerLocal [format ["%1", _name], position _x];
			format ["%1", _name] setmarkertypelocal "Dot";
			format ["%1", _name] setMarkerTextLocal (getText (configFile >> "cfgVehicles" >> TypeOf _x >> "displayName"));
			if (isplayer _x) then {format ["%1", _name] setmarkerColorlocal "ColorBlue";} else {format ["%1", _name] setmarkerColorlocal "ColorRed";};
			format ["%1", _name] setMarkerSizeLocal [0.4, 0.4];
		}
		else
		{
			format ["%1", _name] setMarkerPosLocal [0,0];
			format ["%1", _name] setMarkerTextLocal "";
			deleteMarker format ["%1", _name];
		};
	} foreach _units;
	sleep 0.5;
	{deleteMarker format ["%1", _x]} foreach _names;
	_marker = [] spawn BTC_selectable_units;
};
BTC_save_game =
{
	diag_log text "////////////////////////\\\\\\\\\\\\\\\\\\\\\\\\\\\";
	diag_log text "/////Created by =BTC= Giallustio";
	diag_log text format ["/////version %1", BTC_version];
	diag_log text "/////Visit us at:";
	diag_log text "/////http://www.blacktemplars.altervista.org/";
	diag_log text "/////////////--------SAVING--------\\\\\\\\\\\\\\\\";
	diag_log text "BTC_maxi_array = ";
	diag_log text "[";
	//Mission stuff
	diag_log text "[";
	//date,BTC_start_location_selected,BTC_actual_city,BTC_city_array,BTC_city_captured,BTC_money,BTC_type_units_n
	diag_log text format ["%1,%2,%3,",date,BTC_start_location_selected,position BTC_actual_city];
	diag_log text format ["%1,",BTC_city_array];
	diag_log text format ["%1,%2,%3",BTC_city_captured,BTC_money,BTC_type_units_n];
	diag_log text "],[";
	//Vehicles
	_vehicles = vehicles;
	for "_i" from 0 to (count _vehicles - 1) do
	{
		private ["_array","_wp"];
		_array = [];
		_type = typeOf (_vehicles select _i);
		_pos  = getPos (_vehicles select _i);
		_dir  = getDir (_vehicles select _i);
		_dam  = getDammage (_vehicles select _i);
		_fuel = fuel (_vehicles select _i);
		if (_dam != 1) then
		{
			_ammo_1 = (_vehicles select _i) magazinesTurret [-1];
			_ammo_2 = (_vehicles select _i) magazinesTurret [0];
			_ammo_3 = (_vehicles select _i) magazinesTurret [0,1];
			_ammo_4	= getMagazineCargo (_vehicles select _i);
			_ammo_5 = getWeaponCargo (_vehicles select _i);
			_crew = crew (_vehicles select _i);
			_crew_type = [];
			{if (!isplayer _x && Alive _x) then {_crew_type = _crew_type + [typeOf _x];};} foreach _crew;
			if (!isNull driver (_vehicles select _i)) then {_wp = waypoints (driver (_vehicles select _i));};
			_wp_pos = [];_wp_type = [];_wp_com = [];_wp_beh = [];_wp_form = [];_wp_speed = [];
			for "_i" from 0 to (count _wp - 1) do
			{
				_wp_pos_x   = waypointPosition (_wp select _i);
				_wp_type_x  = waypointType (_wp select _i);
				_wp_com_x   = waypointCombatMode (_wp select _i);
				_wp_beh_x   = waypointBehaviour (_wp select _i);
				_wp_form_x  = waypointFormation (_wp select _i);
				_wp_speed_x = waypointSpeed (_wp select _i);
				_wp_pos  set [_i,_wp_pos_x];
				_wp_type set [_i,_wp_type_x];
				_wp_com  set [_i,_wp_com_x];
				_wp_beh  set [_i,_wp_beh_x];
				_wp_form set [_i,_wp_form_x];
				_wp_speed set [_i,_wp_speed_x];	
			} foreach _wp;
			_box_type = "";_box_ammo_cont = [];_box_weapon_cont = [];
			if (format ["%1", (_vehicles select _i) getVariable "BTC_Veh_Full"] == "1") then {_box_type = (_vehicles select _i) getVariable "BTC_Veh_contenent";_box_ammo_cont = (_vehicles select _i) getVariable "BTC_Veh_ammo";_box_weapon_cont = (_vehicles select _i) getVariable "BTC_Veh_weapon";};
			diag_log text "[";
			diag_log text format ["""%1"",",_type];
			diag_log text format ["%1,",_pos];
			diag_log text format ["%1,",_dir];
			diag_log text format ["%1,",_dam];
			diag_log text format ["%1,",_fuel];
			diag_log text format ["%1,",_crew_type];
			diag_log text format ["[%1,",_ammo_1];
			diag_log text format ["%1,",_ammo_2];
			diag_log text format ["%1,",_ammo_3];
			diag_log text format ["%1,",_ammo_4];
			diag_log text format ["%1],",_ammo_5];
			diag_log text format ["[%1,%2,",_wp_pos,_wp_type];
			diag_log text format ["%1,%2,",_wp_com,_wp_beh];
			diag_log text format ["%1,%2],",_wp_form,_wp_speed];
			diag_log text format ["[""%1""",_box_type];
			diag_log text format ["%1",_box_ammo_cont];
			diag_log text format ["%1]",_box_weapon_cont];
			diag_log text "]";
			if (_i != (count _vehicles - 1)) then {diag_log text ",";};
		};
	};
	diag_log text "],[";
	//units (not players, groups)
	_groups = allGroups;
	_groups_AI = [];
	{
		_units_AI = [];
		{if (vehicle _x == _x && !isPlayer _x) then {_units_AI = _units_AI + [_x];};} foreach units _x;
		if (count _units_AI > 0) then {_groups_AI = _groups_AI + [_x];};
		_units_AI = [];
	} foreach _groups;
	for "_i" from 0 to (count _groups_AI - 1) do
	{
		private ["_units","_units_type","_units_pos","_wp","_wp_pos","_wp_type","_wp_pos_x","_wp_type_x","_wp_com_x","_wp_com","_wp_beh","_wp_beh_x","_wp_form_x","_wp_form","_wp_speed_x","_wp_speed"];
		_group = _groups_AI select _i;
		if (side _group == BTC_enemy_side) then
		{
			_units = units _group;
			_units_type = [];
			{if (vehicle _x == _x) then {_units_type = _units_type + [typeOf _x];};} foreach _units;
			if (count _units_type > 0) then
			{
				if (_i != 0) then {diag_log text ",";};
				_units_pos = [];
				{_units_pos = _units_pos + [getpos _x];} foreach _units;
				_wp = waypoints _group;
				_wp_pos = [];_wp_type = [];_wp_com = [];_wp_beh = [];_wp_form = [];_wp_speed = [];
				for "_i" from 0 to (count _wp - 1) do
				{
					_wp_pos_x   = waypointPosition (_wp select _i);
					_wp_type_x  = waypointType (_wp select _i);
					_wp_com_x   = waypointCombatMode (_wp select _i);
					_wp_beh_x   = waypointBehaviour (_wp select _i);
					_wp_form_x  = waypointFormation (_wp select _i);
					_wp_speed_x = waypointSpeed (_wp select _i);
					_wp_pos  set [_i,_wp_pos_x];
					_wp_type set [_i,_wp_type_x];
					_wp_com  set [_i,_wp_com_x];
					_wp_beh  set [_i,_wp_beh_x];
					_wp_form set [_i,_wp_form_x];
					_wp_speed set [_i,_wp_speed_x];
				} foreach _wp;
				diag_log text "[";
				diag_log text format ["%1,",_units_type];
				diag_log text format ["%1,",_units_pos];
				diag_log text format ["[%1,%2,",_wp_pos,_wp_type];
				diag_log text format ["%1,%2,",_wp_com,_wp_beh];
				diag_log text format ["%1,%2]",_wp_form,_wp_speed];
				diag_log text "]";
			};
		};
	};
	//Ammo
	_boxes_array = nearestObjects [BTC_start_location_selected, ["ReammoBox"], 99999];
	_boxes = [];
	{if (typeOf _x != "WeaponHolder") then {_boxes = _boxes + [_x];};} foreach _boxes_array;
	diag_log text "],[";
	if (count _boxes > 0) then
	{
		for "_i" from 0 to (count _boxes - 1) do
		{
			if (_i != 0) then {diag_log text ",";};
			_box = _boxes select _i;
			_box_type = typeOf _box;
			_box_pos = getpos _box;
			_box_ammo = getMagazineCargo _box;
			_box_weapon = getWeaponCargo _box;
			diag_log text "[";
			diag_log text format ["""%1"",",_box_type];
			diag_log text format ["%1,",_box_pos];
				diag_log text "[[";
				private ["_text_ammo","_ammo_type","_n","_ammo_count"];
				_text_ammo = "";
				_ammo_type = (_box_ammo select 0);
				_ammo_count = (_box_ammo select 1);
				_n = 1;
				for "_i" from 0 to ((count _ammo_type) - 1) do
				{
					if (_text_ammo == "") then {_text_ammo = _text_ammo + str (_ammo_type select _i);} else {_text_ammo = _text_ammo + "," + str (_ammo_type select _i);};
					if (_i > (20 * _n)) then
					{
						_n = _n + 1;
						diag_log text _text_ammo;
						diag_log text ",";
						_text_ammo = "";
					};
				};
				if (_text_ammo != "") then {diag_log text _text_ammo;} else {diag_log text format ["""%1""",_ammo_type select 0];_ammo_count = _ammo_count + [0];};
				diag_log text "],";
			diag_log text format ["%1",_ammo_count];
			diag_log text "],[[";
				private ["_text_weap","_weap_type","_n","_weap_count"];
				_text_weap = "";
				_weap_type = (_box_weapon select 0);
				_weap_count = (_box_weapon select 1);
				_n = 1;
				for "_i" from 0 to ((count _weap_type) - 1) do
				{
					if (_text_weap == "") then {_text_weap = _text_weap + str (_weap_type select _i);} else {_text_weap = _text_weap + "," + str (_weap_type select _i);};
					if (_i > (20 * _n)) then
					{
						_n = _n + 1;
						diag_log text _text_weap;
						diag_log text ",";
						_text_weap = "";
					};
				};
				if (_text_weap != "") then {diag_log text _text_weap;} else {diag_log text format ["""%1""",_weap_type select 0];_weap_count = _weap_count + [0];};
				diag_log text "],";
			diag_log text format ["%1",_weap_count];
			diag_log text "]";
			diag_log text "]";
		};
	};	
	diag_log text "],[";
	//Players
	_players = [];
	{if (isPlayer _x) then {_players = _players + [_x];};} foreach AllUnits;
	_players_ID   = [];
	_players_pos  = [];
	_players_gear = [];
	_players_mag  = [];
	_players_ruck_weapons = [];
	_players_ruck_magazines = [];
	_players_ruck = [];
	for "_i" from 0 to (count _players - 1) do
	{
		private ["_player","_id","_pos","_gear","_mag","_ruck","_ruck_weapons","_ruck_magazines"];
		_player = _players select _i;
		_id   = getPlayerUID _player;
		_pos  = getPosATL _player;
		_gear = weapons _player;
		_mag  = magazines _player;
		if !(isNull (unitBackpack _player)) then
		{
			_ruck = typeOf unitBackpack _player;
			_ruck_weapons = getWeaponCargo unitBackpack _player;
			_ruck_magazines = getMagazineCargo unitBackpack _player;
		}
		else 
		{
			_ruck = "";
			_ruck_weapons = [];
			_ruck_magazines = [];
		};
		_players_ID set [_i,format ["""%1""", _id]];
		_players_pos set [_i,_pos];
		_players_gear set [_i,_gear];
		_players_mag set [_i,_mag];
		_players_ruck_weapons set [_i,_ruck_weapons];
		_players_ruck_magazines set [_i,_ruck_magazines];
		_players_ruck set [_i,_ruck];
	};
	diag_log text "[";
	for "_i" from 0 to (count _players_ID - 1) do
	{
		private ["_text"];
		_text = _players_ID select _i;
		diag_log text format ["%1",_text];
		if (_i != (count _players_ID - 1)) then {diag_log text ",";};
	};
	diag_log text "],[";
	for "_i" from 0 to (count _players_pos - 1) do
	{
		private ["_text"];
		_text = _players_pos select _i;
		diag_log text format ["%1",_text];
		if (_i != (count _players_pos - 1)) then {diag_log text ",";};
	};
	diag_log text "],[";
	for "_i" from 0 to (count _players_gear - 1) do
	{
		private ["_text"];
		_text = _players_gear select _i;
		diag_log text format ["%1",_text];
		if (_i != (count _players_gear - 1)) then {diag_log text ",";};
	};
	diag_log text "],[";
	for "_i" from 0 to (count _players_mag - 1) do
	{
		private ["_text"];
		_text = _players_mag select _i;
		diag_log text format ["%1",_text];
		if (_i != (count _players_mag - 1)) then {diag_log text ",";};
	};
	diag_log text "],[";
	for "_i" from 0 to (count _players_ruck_weapons - 1) do
	{
		private ["_text"];
		_text = _players_ruck_weapons select _i;
		diag_log text format ["%1",_text];
		if (_i != (count _players_ruck_weapons - 1)) then {diag_log text ",";};
	};	
	diag_log text "],[";
	for "_i" from 0 to (count _players_ruck_magazines - 1) do
	{
		private ["_text"];
		_text = _players_ruck_magazines select _i;
		diag_log text format ["%1",_text];
		if (_i != (count _players_ruck_magazines - 1)) then {diag_log text ",";};
	};
	diag_log text "],[";
	for "_i" from 0 to (count _players_ruck - 1) do
	{
		private ["_text"];
		_text = _players_ruck select _i;
		diag_log text format ["""%1""",_text];
		if (_i != (count _players_ruck - 1)) then {diag_log text ",";};
	};	
	diag_log text "]";
	diag_log text "]";
	diag_log text "];";
	diag_log text "/////////////------END ARRAY------\\\\\\\\\\\\\\\\";
	diag_log text "////////////////////////\\\\\\\\\\\\\\\\\\\\\\\\\\\";
};
BTC_load_game =
{
	_array = _this select 0;
	if (isServer) then
	{
		//vehicles
		_veh = _array select 1;
		{
			private ["_new_veh","_cargo_ammo","_cargo_weapon"];
			_pos     = (_x select 1);
			_new_veh = createVehicle [(_x select 0), _pos, [], 0, "NONE"];
			_new_veh setDir (_x select 2);
			_new_veh setDammage (_x select 3);
			_new_veh setFuel (_x select 4);
			_new_veh setVehicleAmmo 0;
			_ammo = _x select 6;
			if (count (_ammo select 0) > 0) then {{_new_veh addMagazineTurret [_x,[-1]];} foreach (_ammo select 0);};
			if (count (_ammo select 1) > 0) then {{_new_veh addMagazineTurret [_x,[0]];} foreach (_ammo select 1);};
			if (count (_ammo select 2) > 0) then {{_new_veh addMagazineTurret [_x,[0,1]];} foreach (_ammo select 2);};
			_cargo_ammo   = (_ammo select 3);
			_cargo_weapon = (_ammo select 4);
			ClearWeaponCargoGlobal _new_veh;
			ClearMagazineCargoGlobal _new_veh;
			for "_i" from 0 to (count (_cargo_weapon select 0) - 1) do
			{
				private ["_type","_n"];
				_type = _cargo_weapon select 0;
				_n    = _cargo_weapon select 1;
				_new_veh addWeaponCargoGlobal [(_type select _i),(_n select _i)];
			};
			for "_i" from 0 to (count (_cargo_ammo select 0) - 1) do
			{
				private ["_type","_n"];
				_type = _cargo_ammo select 0;
				_n    = _cargo_ammo select 1;
				_new_veh addMagazineCargoGlobal [(_type select _i),(_n select _i)];
			};
			if (count (_x select 5) > 0) then
			{
				_group = createGroup BTC_enemy_side;
				{
					_cond = false;
					_driver    = _new_veh emptyPositions "driver";
					_gunner    = _new_veh emptyPositions "gunner";
					_commander = _new_veh emptyPositions "commander";
					_cargo     = (_new_veh emptyPositions "cargo") - 1;
					if (!_cond && _driver > 0) then
					{
						_cond = true;
						_x createUnit [_pos, _group, "this moveinDriver _new_veh;this assignAsDriver _new_veh;"];
					};
					if (!_cond && _gunner > 0) then
					{
						_cond = true;
						_x createUnit [_pos, _group, "this moveingunner _new_veh;this assignAsgunner _new_veh;"];
					};
					if (!_cond && _commander > 0) then
					{
						_cond = true;
						_x createUnit [_pos, _group, "this moveincommander _new_veh;this assignAscommander _new_veh;"];
					};
					if (!_cond && _cargo > 0) then
					{
						_cond = true;
						_x createUnit [_pos, _group, "this moveincargo _new_veh;this assignAscargo _new_veh;"];
					};
					_cond = false;
				} foreach (_x select 5);
				_wp = (_x select 7);
				_wp_pos   = _wp select 0;
				_wp_type  = _wp select 1;
				_wp_com   = _wp select 2;
				_wp_beh   = _wp select 3;
				_wp_form  = _wp select 4;
				_wp_speed = _wp select 5;
				for "_i" from 0 to (count _wp_pos - 1) do
				{
					_new_wp = _group addWaypoint [(_wp_pos select _i), 60];
					_new_wp setWaypointType (_wp_type select _i);
					_new_wp setwaypointCombatMode (_wp_com select _i);
					_new_wp setwaypointBehaviour (_wp_beh select _i);
					_new_wp setwaypointFormation (_wp_form select _i);
					_new_wp setwaypointSpeed (_wp_speed select _i);
				};
			};
			_box_ammo = (_x select 8);
			_box_type = _box_ammo select 0;
			_box_ammo_cont = _box_ammo select 1;
			_box_weapon_cont = _box_ammo select 2;
			if (_box_type != "") then
			{
				_name_obj    = getText (configFile >> "cfgVehicles" >> _box_type >> "displayName");
				_text_action = "this addAction [" + """" + "<t color=""""#ED2744"""">" + "Unload " + (_name_obj) + "</t>" + """" + ",""=BTC=_Logistic\=BTC=_Cargo_System\=BTC=_Unload.sqf"", """", 0, false, true]";
				_new_veh setVariable ["BTC_Veh_contenent",_box_type,true];
				_new_veh setVariable ["BTC_Veh_ammo",_box_ammo_cont,true];
				_new_veh setVariable ["BTC_Veh_weapon",_box_weapon_cont,true];
				_new_veh setVariable ["BTC_Veh_Full",1,true];
				_new_veh setVehicleInit _text_action;ProcessInitCommands;
			};
		} foreach _veh;
		//units
		_units = _array select 2;
		{
			_group = createGroup BTC_enemy_side;
			_array_units = (_x select 0);
			_array_pos   = (_x select 1);
			_wp          = (_x select 2);
			_wp_pos   = _wp select 0;
			_wp_type  = _wp select 1;
			_wp_com   = _wp select 2;
			_wp_beh   = _wp select 3;
			_wp_form  = _wp select 4;
			_wp_speed = _wp select 5;
			for "_i" from 0 to (count _array_units - 1) do
			{
				_group createUnit [(_array_units select _i), (_array_pos select _i), [], 0, "NONE"];
			};
			for "_i" from 0 to (count _wp_pos - 1) do
			{
				_new_wp = _group addWaypoint [(_wp_pos select _i), 60];
				_new_wp setWaypointType (_wp_type select _i);
				_new_wp setwaypointCombatMode (_wp_com select _i);
				_new_wp setwaypointBehaviour (_wp_beh select _i);
				_new_wp setwaypointFormation (_wp_form select _i);
				_new_wp setwaypointSpeed (_wp_speed select _i);
			};
		} foreach _units;
		//Ammo
		_ammo = _array select 3;
		{
			_pos     = (_x select 1);
			_new_box = createVehicle [(_x select 0), _pos, [], 0, "NONE"];
			_ammo_box   = (_x select 2);
			_weapon_box = (_x select 3);
			ClearWeaponCargoGlobal _new_box;
			ClearMagazineCargoGlobal _new_box;
			for "_i" from 0 to (count (_weapon_box select 0) - 1) do
			{
				private ["_type","_n"];
				_type = _weapon_box select 0;
				_n    = _weapon_box select 1;
				if ((_type select _i) != "<null>") then {_new_box addWeaponCargoGlobal [(_type select _i),(_n select _i)];};
			};
			for "_i" from 0 to (count (_ammo_box select 0) - 1) do
			{
				private ["_type","_n"];
				_type = _ammo_box select 0;
				_n    = _ammo_box select 1;
				if ((_type select _i) != "<null>") then {_new_box addMagazineCargoGlobal [(_type select _i),(_n select _i)];};
			};
		} foreach _ammo;
	};
};
BTC_load_game_player =
{
	_player = _this select 0;
	_array = _this select 1;
	if (!isDedicated) then
	{
		//players
		private ["_players"];
		_player  = _this select 0;
		_players = (_array select 4);
		_ids     = _players select 0;
		_posS    = _players select 1;
		_weapons = _players select 2;
		_mags    = _players select 3;
		_rucks_weps = _players select 4;
		_rucks_mags = _players select 5;
		_rucks      = _players select 6;
		_id      = getPlayerUID _player;
		_n       = _ids find _id;
		if (_n == - 1) then {hint "You didn't play in the previous game. You start at the base with the custom loadout";_player setPos BTC_start_location_selected;} else
		{
			_player setPosATL (_posS select _n);
			removeAllWeapons _player;
			removeBackpack player;
			_weapons_player = (_weapons select _n);
			_mags_player = (_mags select _n);
			{_player addMagazine _x} foreach _mags_player;
			_ruck = (_rucks select _n);
			if (_ruck != "") then {_player addBackpack _ruck;};
			{if !(_player hasWeapon _x) then {_player addWeapon _x};} foreach _weapons_player;
			_player selectWeapon (primaryWeapon _player);
			if (_ruck != "") then 
			{
				_backpack = unitBackpack player;
				clearMagazineCargoGlobal (unitBackpack player);
				clearWeaponCargoGlobal (unitBackpack player);
				_ruck_weps = (_rucks_weps select _n);
				_ruck_mags = (_rucks_mags select _n);
				if (count (_ruck_weps select 0) > 0) then 
				{
					for "_i" from 0 to (count (_ruck_weps select 0) - 1) do
					{
						(unitBackpack player) addweaponCargo [(_ruck_weps select 0) select _i,(_ruck_weps select 1) select _i];
					};
				};
				if (count (_ruck_mags select 0) > 0) then 
				{
					for "_i" from 0 to (count (_ruck_mags select 0) - 1) do
					{				
						(unitBackpack player) addMagazineCargo [(_ruck_mags select 0) select _i,(_ruck_mags select 1) select _i];
					};
				};
			};
			_base = BTC_start_location_selected;
			_posS set [_n, _base];
			_players = [] + [_ids] + [_posS] + [_weapons] + [_mags];
			_array set [4,_players];
			publicVariable str(_array);
		};
	};
};