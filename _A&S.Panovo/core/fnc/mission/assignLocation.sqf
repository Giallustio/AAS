
_loc = objNull;

if (count _this isEqualTo 0) then {
	if (isNull btc_loc_active) then {_loc = [(getMarkerPos btc_marker_respawn)] call btc_fnc_mission_getNearestLocation;} else {_loc = [btc_loc_active] call btc_fnc_mission_getNearestLocation;};
} else {_loc = _this select 0};

_radiusx = _loc getVariable ["RadiusX",50];
_radiusy = _loc getVariable ["RadiusY",50];


//Spawn units

[_loc, ((_radiusx + _radiusy)/2)] call btc_fnc_mission_populateLocation;

_marker_flag = [format ["flag_%1",(position _loc)], position _loc,[1,1],"ICON","mil_Flag","","ColorRed","",1] call btc_fnc_createMarker;
_marker_circle = [format ["area_%1",(position _loc)], position _loc,[(_radiusx + btc_loc_radius),(_radiusy + btc_loc_radius)],"ELLIPSE","","","ColorRed","",0.2] call btc_fnc_createMarker;
_loc setvariable ["markers", [_marker_flag,_marker_circle]];

_check = [position _loc, [(_radiusx + btc_loc_radius),(_radiusy + btc_loc_radius),0,false], [str (btc_enemy_side), "PRESENT", false], ["count thisList < 2", "[] call btc_fnc_mission_locationCaptured", ""]] call btc_fnc_createTrigger;


btc_loc_active = _loc;

/*

btc_active_loc = objNull;


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
*/