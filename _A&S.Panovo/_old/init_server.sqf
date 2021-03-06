if (isClass(configFile >> "cfgPatches" >> "ace_main")) then {BTC_ACE = true;publicVariable "BTC_ACE";} else {BTC_ACE = false;publicVariable "BTC_ACE";};
if (BTC_ACE) then
{
	// AI talk
	ace_sys_aitalk_enabled = true;
	publicVariable "ace_sys_aitalk_enabled";
	// vehicle radios
	ace_sys_aitalk_radio_enabled = true;
	publicVariable "ace_sys_aitalk_radio_enabled";
	//Tyres
	ace_sys_repair_default_tyres = true;
	publicVariable "ace_sys_repair_default_tyres";
	//Full repair
	ace_sys_repair_full = true;
	publicVariable "ace_sys_repair_full";
	// enable respawn with weapons
	ace_sys_playerhud_withresp = true;
	publicVariable "ace_sys_playerhud_withresp";
};
if (isClass(configFile >> "cfgPatches" >> "BTC_load_game")) then 
{
	if (BTC_load == 1) then 
	{
		call compile preprocessFileLineNumbers "=BTC=_load_game\=BTC=_load_game.sqf";
		if (count BTC_maxi_array > 0) then {publicVariable "BTC_maxi_array";BTC_can_load_game = true;publicVariable "BTC_can_load_game";};
		[BTC_maxi_array] call BTC_load_game;
	};
};
if (!isNil "BTC_can_load_game" && BTC_load == 1) then
{
	_array = BTC_maxi_array select 0;
	BTC_date = _array select 0;
	BTC_start_location_selected = _array select 1;
	BTC_actual_city = _array select 2;
	BTC_city_array = _array select 3;
	BTC_city_captured = _array select 4;
	BTC_money = _array select 5;
	BTC_type_units_n = _array select 6;
	publicVariable "BTC_maxi_array";publicVariable "BTC_date";publicVariable "BTC_start_location_selected";publicVariable "BTC_actual_city";publicVariable "BTC_city_array";publicVariable "BTC_city_captured";publicVariable "BTC_money";publicVariable "BTC_type_units_n";
};
[BTC_type_units_n] call BTC_get_units_type;
//Date
if (isNil "BTC_can_load_game" || BTC_load == 0) then {setDate [2010, BTC_Month, BTC_Day, BTC_Hour, BTC_Minutes + (time/60)];} else {setDate BTC_date;};
//Terrain
setViewDistance BTC_view_distance;
setTerrainGrid BTC_terrain;
//Choose start location
if (isNil "BTC_can_load_game" || BTC_load == 0) then 
{
	switch (true) do
	{
		case (BTC_base_location == 100) :{BTC_start_location_selected = getMarkerPos (BTC_starts_location select (round (random ((count BTC_starts_location) - 1))));publicVariable "BTC_start_location_selected";};
		case (BTC_base_location != 100) :{BTC_start_location_selected = getMarkerPos (BTC_starts_location select BTC_base_location);publicVariable "BTC_start_location_selected";};
	};
};
"respawn_west" setMarkerPos BTC_start_location_selected;
BTC_coin_module setPos BTC_start_location_selected;
//Create base at start location
if (isNil "BTC_can_load_game" || BTC_load == 0) then {[BTC_start_location_selected, BTC_base_on_load] call BTC_spawn_base;} else {[BTC_start_location_selected, BTC_base_on_load] call BTC_spawn_base;};
_check = [BTC_start_location_selected, [100,100,0,false], [str (BTC_enemy_side), "PRESENT", true], ["this", "{_x setDamage 1;} foreach thisList", ""]] spawn BTC_create_trigger;
//Locations
//Pick user location
_own_locations = nearestObjects [BTC_start_location_selected, ["LocationLogicCityCenter"], 99999];
BTC_locations = [["CityCenter","LocationLogicCityCenter"],[BTC_start_location_selected,99999]] call BIS_fnc_locations;
if (count _own_locations > 0) then {BTC_locations = BTC_locations + _own_locations;};
{_x setVariable ["BTC_captured", 0];} foreach BTC_locations;
if (count BTC_loc_blacklist > 0) then {{_logic = nearestObject [_x, "LocationLogic"];_logic setVariable ["BTC_captured", 1];} foreach BTC_loc_blacklist;};
BTC_max_locations = (count BTC_locations) - (count BTC_loc_blacklist);
if (!isNil "BTC_can_load_game" && BTC_load == 1) then 
{
	if (count BTC_city_array > 0) then {{_logic = nearestObject [_x, "LocationLogic"];_logic setVariable ["BTC_captured", 1];} foreach BTC_city_array;};
};
//Pick the first location
if (isNil "BTC_can_load_game" || BTC_load == 0) then 
{
	switch (true) do
	{
		case (BTC_game_mode == 0) :{_first_loc = [BTC_start_location_selected] call BTC_get_nearest_location;BTC_actual_city = _first_loc;publicVariable "BTC_actual_city";_spawn = [_first_loc] spawn BTC_server_control;};
		case (BTC_game_mode == 1) :{_first_loc = BTC_locations select (round (random ((count BTC_locations) - 1)));BTC_actual_city = _first_loc;publicVariable "BTC_actual_city";_spawn = [_first_loc] spawn BTC_server_control;};
	};
}
else
{
	_logic = nearestObject [BTC_actual_city, "LocationLogic"];
	_spawn = [_logic] spawn BTC_server_control_on_load;
};
//UAV
if (BTC_def_uav == 0) then {[] spawn {sleep 3;{deletevehicle _x} foreach [BTC_UAV_module,BTC_UAV,BTC_UAV_terminal];};} else {BTC_UAV setPos [BTC_start_location_selected select 0,BTC_start_location_selected select 1, 1500];BTC_UAV_terminal setPos [(BTC_start_location_selected select 0) + 16,(BTC_start_location_selected select 1) - 27, 0];};
BTC_UAV setPos [BTC_start_location_selected select 0,BTC_start_location_selected select 1, 1500];BTC_UAV_terminal setPos [(BTC_start_location_selected select 0) + 16,(BTC_start_location_selected select 1) - 27, 0];
//Rebels control
if (BTC_civilian == 1) then {_rebels = [] spawn BTC_rebels;};
if (BTC_param_ied == 1) then {_ieds = [] spawn BTC_ieds_control;};
init_server_done = true;
publicVariable "init_server_done";
if (true) exitWith {};