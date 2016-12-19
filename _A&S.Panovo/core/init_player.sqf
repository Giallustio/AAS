/*
if (side player == BTC_player_side) then 
{
	if (!isNil "BTC_can_load_game" && BTC_load == 1) then {waitUntil {!isNil "BTC_maxi_array";};[player,BTC_maxi_array] call BTC_load_game_player;};
	if (isNil "BTC_can_load_game" || BTC_load == 0) then 
	{
		player setPos [(BTC_start_location_selected select 0) + random 10,(BTC_start_location_selected select 1) - random 10,0];
	};
	"respawn_west" setMarkerPos BTC_start_location_selected;
	_marker_base = ["BTC_marker_base",BTC_start_location_selected,[1,1],"ICON",BTC_flag_marker_type,"","Default",""] spawn BTC_create_marker_local;
	[BTC_type_units_n] call BTC_get_units_type;
	//Brief
	_task = [] spawn BTC_jip_task;
	[] execVM "briefing.sqf";
	//Intro
	if (BTC_debug == 1) then {intro_finished = true;} else {_intro = [] spawn BTC_Player_Intro;};
	//Var
	player setvariable ["bis_nocoreconversations",true];
	//Terrain
	setViewDistance BTC_view_distance;
	setTerrainGrid BTC_terrain;
	//Gear
	removeAllWeapons player;
	{if !(player hasWeapon _x) then {player addWeapon _x};} foreach BTC_gear;
	if (BTC_ACE) then 
	{
		{if !(player hasWeapon _x) then {player addWeapon _x};} foreach BTC_ACE_gear;
		_ruck_box = nearestObject [BTC_start_location_selected, "MASH"];
		_ruck_box addAction [("<t color=""#ED2744"">") + ("Take a medic ruck") + "</t>","=BTC=_addAction.sqf",[[],BTC_action_add_backpack], 7, true, false, "", "isNull (unitBackpack player) && !([player] call ACE_fnc_HasRuck)"];
	} 
	else
	{
		//Marker
		switch (BTC_marker_desc) do {case 0:{};case 1:{if (rank player == "CAPTAIN") then {{_marker = createmarkerLocal [_x, [0,0]];_x setmarkertypelocal "Dot";_x setmarkerColorlocal "ColorBlue";_x setMarkerSizeLocal [0.7, 0.7];} foreach BTC_players_string;{_marker = createmarkerLocal [_x, [0,0]];_x setmarkertypelocal "b_inf";_x setmarkerColorlocal "ColorBlue";_x setMarkerSizeLocal [0.7, 0.7];} foreach BTC_groups_string;};};case 2:{{_marker = createmarkerLocal [_x, [0,0]];_x setmarkertypelocal "Dot";_x setmarkerColorlocal "ColorBlue";_x setMarkerSizeLocal [0.7, 0.7];} foreach BTC_players_string;{_marker = createmarkerLocal [_x, [0,0]];_x setmarkertypelocal "b_inf";_x setmarkerColorlocal "ColorBlue";_x setMarkerSizeLocal [0.7, 0.7];} foreach BTC_groups_string;};};
		//EH
		"BTC_spawn" addPublicVariableEventHandler {_var = _this select 1;_param = _var select 0;_code = _var select 1;_handle = _param spawn _code};
		player AddEventHandler ["fired",{call BTC_Fired;}];
		_ruck_box = nearestObject [BTC_start_location_selected, "MASH_EP1"];
		_ruck_box addAction [("<t color=""#ED2744"">") + ("Take a backpack") + "</t>","=BTC=_addAction.sqf",[[],BTC_action_add_backpack], 7, true, false, "", "isNull (unitBackpack player) && secondaryWeapon player == """""];
		_main_loop = [] spawn BTC_Main_Loop;
	};
	switch (BTC_revive) do {case 0:{player AddEventHandler ["killed",{_this spawn BTC_Player_Killed;}];};case 1:{[player] execVM "ais\init_ais.sqf";player AddEventHandler ["killed",{_this spawn BTC_Player_Killed;}];};case 2:{execVM "R3F_revive\revive_init.sqf";};case 3:{[] spawn {while {true} do {_body = player;WaitUntil {sleep 2; !Alive player};titleText ["", "BLACK OUT"];sleep 2;titleText ["", "BLACK FADED"];sleep 3;hideBody _body; sleep 1.5;titleText ["", "BLACK FADED"];deletevehicle _body;titleText ["", "BLACK FADED"];WaitUntil {Alive player};titleText ["", "BLACK IN"];if (BTC_def_rally_point == 1 && !isNil "BTC_rally_point_deployed") then {_rally_point = createdialog "BTC_rally_point";};if (BTC_def_rally_point == 1) then {if (rank player == "CAPTAIN") then {_action = player addaction [("<t color=""#27EE1F"">") + ("Rally point") + "</t>","=BTC=_addAction.sqf",[[],BTC_action_rally_point],0,false,false,"","isNil ""BTC_rally_point_deployed"""];};};if (BTC_arty_player_def == 1 && format ["%1",player getVariable "BTC_arty_operator"] == "1") then {_action = player addaction [("<t color=""#ED2744"">") + ("Request artillery") + "</t>","=BTC=_addAction.sqf",[[],BTC_fnc_arty],0,false,false,"","BTC_arty_player_available"];};switch (BTC_def_recruitment) do {case 0:{};case 1:{if (rank player == "CAPTAIN") then {player addAction [("<t color=""#ED2744"">") + ("Recrutiment") + "</t>","=BTC=_addAction.sqf",[[],BTC_action_recruitment],7,false,false,"","true"];};};case 2:{if (rank player == "CAPTAIN" || rank player == "LIEUTENANT") then {player addAction [("<t color=""#ED2744"">") + ("Recrutiment") + "</t>","=BTC=_addAction.sqf",[[],BTC_action_recruitment],7,false,false,"","true"];};};};};};};};
	//Script
	if (BTC_logistic == 1) then {_logistic = execVM "=BTC=_Logistic\=BTC=_Logistic_Init.sqf";};
	//Action
	if (rank player == "CAPTAIN") then {_spawn = [] spawn BTC_init_coin_module;};
	if (BTC_arty_player_def == 1 && format ["%1",player getVariable "BTC_arty_operator"] == "1") then {_action = player addaction [("<t color=""#ED2744"">") + ("Request artillery") + "</t>","=BTC=_addAction.sqf",[[],BTC_fnc_arty],0,false,false,"","BTC_arty_player_available"];};
	if (BTC_def_rally_point == 1) then {_flag = nearestObject [BTC_start_location_selected, "FlagCarrierCore"];_flag addAction [("<t color=""#ED2744"">") + ("Move to rally point") + "</t>","=BTC=_addAction.sqf",[[],BTC_move_to_rally_point], 7, true, false, "", "!isNil ""BTC_rally_point_deployed"""];};
	if (BTC_def_rally_point == 1) then {if (rank player == "CAPTAIN") then {_action = player addaction [("<t color=""#27EE1F"">") + ("Rally point") + "</t>","=BTC=_addAction.sqf",[[],BTC_action_rally_point],0,false,false,"","isNil ""BTC_rally_point_deployed"""];if (!isNil "BTC_rally_point_deployed" && BTC_def_rally_point == 1) then {_rally_point = nearestObject [player, BTC_type_rally_point];_action = _rally_point addaction [("<t color=""#27EE1F"">") + ("Pick up rally point") + "</t>","=BTC=_addAction.sqf",[[],BTC_action_rally_point],0,false,false,"","rank player == ""CAPTAIN"""];};};};
	player addAction [("<t color=""#ED2744"">") + ("Set view distance") + "</t>","=BTC=_addAction.sqf",[[],BTC_action_view_distance],7,false,false,"","true"];
	switch (BTC_def_recruitment) do {case 0:{};case 1:{if (rank player == "CAPTAIN") then {player addAction [("<t color=""#ED2744"">") + ("Recrutiment") + "</t>","=BTC=_addAction.sqf",[[],BTC_action_recruitment],7,false,false,"","true"];};};case 2:{if (rank player == "CAPTAIN" || rank player == "LIEUTENANT") then {player addAction [("<t color=""#ED2744"">") + ("Recrutiment") + "</t>","=BTC=_addAction.sqf",[[],BTC_action_recruitment],7,false,false,"","true"];};};};
	//Farp
	_marker_farp = createMarkerLocal ["BTC_marker_farp",[(BTC_start_location_selected select 0) + (BTC_farp_base_rel select 0),(BTC_start_location_selected select 1) + (BTC_farp_base_rel select 1), 0]];_marker_farp setMarkerColorLocal "ColorBlue";_marker_farp setMarkerSizeLocal [0.5, 0.5];_marker_farp setMarkerTextLocal "Wrecks repair";_marker_farp setMarkerTypeLocal "b_maint";
};
//Enemy side
if (side player != BTC_player_side) then 
{
	if (BTC_enemy_player == 1) then
	{
		BTC_old_body = player;
		removeAllWeapons player;
		if !(player hasWeapon "ItemMap") then {player addWeapon "ItemMap";};
		onMapSingleClick "_click = [_pos] spawn BTC_on_map_click;";
		_marker = [] spawn BTC_selectable_units;
		_spawn = [] spawn {_msg = "To start playing open the map and select a playable unit with a mouse left click!";hint _msg;sleep 3;hint _msg;};
	}
	else
	{
		_spawn = [] spawn
		{
			player enableSimulation false;
			while {true} do
			{
				titleText ["Enemy side is disabled by param!\nGet back to the lobby and join the other side!", "BLACK FADED"];
				sleep 1;
			};
		};
	};
};
*/
if (!btc_debug) then {removeAllWeapons player};
player setPos getMarkerPos btc_marker_respawn;

//Actions
	//if (BTC_arty_player_def == 1 && format ["%1",player getVariable "BTC_arty_operator"] == "1") then {_action = player addaction [("<t color=""#ED2744"">") + ("Request artillery") + "</t>","=BTC=_addAction.sqf",[[],BTC_fnc_arty],0,false,false,"","BTC_arty_player_available"];};
player addaction [("<t color=""#ED2744"">") + ("Request artillery") + "</t>","btc_fnc_actions_requestArtillery",0,0,false,false,"","true"];
//Dynamic groups
if (btc_dynamicGroups) then {["InitializePlayer", [player]] call BIS_fnc_dynamicGroups;};

//Debug
if (btc_debug) then {player allowDamage false;onMapSingleClick "player setpos _pos";btc_marker_debug_cond = true;_marker = [] spawn btc_fnc_markerDebug;};