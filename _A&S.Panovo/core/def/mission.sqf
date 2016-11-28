/*
Created by Giallustio

Visit us at: 
http://www.blacktemplars.altervista.org/
*/
btc_version = 0.1;
//Param
/*
	btc_Month           = (paramsArray select 0);
	btc_Day             = (paramsArray select 1);
	btc_Hour            = (paramsArray select 2);
	btc_Minutes         = (paramsArray select 3);
	btc_AI_skill        = (paramsArray select 4)/10;
	btc_view_distance   = (paramsArray select 5);
	btc_terrain         = (paramsArray select 6);
	_type_units_n    = (paramsArray select 7);
	btc_enemy_ratio     = (paramsArray select 8);
	btc_game_mode       = (paramsArray select 9);
	btc_base_location   = (paramsArray select 10);
	btc_enemy_ratio_player    = (paramsArray select 11);
	btc_arty            = (paramsArray select 12);
	btc_arty_player_def = (paramsArray select 13);
	btc_rinf            = (paramsArray select 14);
	btc_marker_desc     = (paramsArray select 15);
	btc_revive          = (paramsArray select 16);
	btc_def_rally_point = (paramsArray select 18);
	if (isServer) then {btc_money = (paramsArray select 19)};
	btc_civilian        = (paramsArray select 20);
	btc_param_ied       = (paramsArray select 21);
	btc_logistic        = (paramsArray select 22);
	btc_def_uav         = (paramsArray select 23);
	btc_def_recruitment = (paramsArray select 24);
	btc_load            = (paramsArray select 25);
	btc_debug           = (paramsArray select 26);
*/

btc_enemy_ratio = 0;
btc_infantry_only = false;

btc_debug = true;
_type_units_n = 0;
btc_loc_radius = 150;
/*
btc_AI_skill = [
	(paramsArray select 16)/10,//general
	(paramsArray select 17)/10,//aimingAccuracy
    (paramsArray select 18)/10,//aimingShake
    (paramsArray select 19)/10,//aimingSpeed
    (paramsArray select 20)/10,//endurance
    (paramsArray select 21)/10,//spotDistance
    (paramsArray select 22)/10,//spotTime
    (paramsArray select 23)/10,//courage
    (paramsArray select 24)/10,//reloadSpeed
    (paramsArray select 25)/10//commanding
];
*/
btc_AI_skill = [
	0/10,//general
	1/10,//aimingAccuracy
    7/10,//aimingShake
    2/10,//aimingSpeed
    7/10,//endurance
    100/10,//spotDistance
    100/10,//spotTime
    5/10,//courage
    20/10,//reloadSpeed
    80/10//commanding
];

btc_player_side        = west;
btc_enemy_side         = east;
btc_marker_respawn     = format ["respawn_%1",btc_player_side];
btc_marker_respawn_en  = format ["respawn_%1",btc_enemy_side];
btc_enemy_ratio_veh    = 4;
btc_enemy_ratio_fant   = 2;
btc_city_bonus         = 500;
btc_loc_blacklist      = [];
//Var
if (isServer) then 
{
	btc_prev_city             = [];
	btc_actual_city           = [];
	btc_next_city             = [];
	btc_city_array            = [];
	btc_city_captured         = 0;
	btc_spawn                 = [];
	//if !(isNil "paramsArray") then {if (isServer) then {btc_money = (paramsArray select 19)};};
	publicVariable "btc_prev_city";publicVariable "btc_actual_city";publicVariable "btc_next_city";publicVariable "btc_city_array";publicVariable "btc_city_captured";publicVariable "btc_money";publicVariable "btc_spawn";
};
//Mission
btc_starts_location       = ["btc_start_location_1","btc_start_location_2","btc_start_location_3","btc_start_location_4","btc_start_location_5","btc_start_location_6"];
btc_base_on_load          = [["FlagCarrierUSA",0,[0,0,0]],["Land_Barrack2_EP1",359.983,[-3.5,8.51465,0.000648499]],["Land_Barrack2_EP1",359.97,[5.72168,8.51758,0.000694275]],["Land_Barrack2_EP1",0.0553766,[-12.4141,8.44141,0.00125885]],["Land_Barrack2_EP1",359.935,[15.2256,8.66602,0.00169373]],["Land_HBarrier_large",359.966,[0.625977,19.6221,-0.00170135]],["Land_HBarrier_large",0.0763401,[-8.12012,19.623,-8.39233e-005]],["Land_HBarrier_large",359.898,[9.33887,19.6348,0.000198364]],["MASH_EP1",179.816,[-23.2471,7.46094,0.0413818]],["Land_HBarrier_large",89.7652,[24.3564,8.14746,-0.000671387]],["Land_HBarrier_large",0.0748278,[-16.873,19.6553,-0.000473022]],["Land_HBarrier_large",359.916,[18.1445,19.6357,-0.000221252]],["US_WarfareBVehicleServicePoint_Base_EP1",270.558,[-3.25879,28.085,-0.000305176]],["Land_HBarrier_large",89.7653,[24.3232,16.9414,-0.000328064]],["Land_HBarrier_large",0.0794629,[-25.6729,19.6563,-0.000427246]],["Land_HBarrier_large",89.765,[-31.4229,8.10742,0.0124741]],["Land_HBarrier_large",89.7651,[24.5781,-22.7129,-0.00173187]],["Land_HBarrier_large",89.765,[-31.4531,16.9033,0.0135269]],["HeliH",359.986,[-3.0166,37.4961,0]],["Land_HBarrier_large",180.159,[4.19336,-37.4531,0.00247192]],["Land_HBarrier_large",89.9297,[-32.1328,-22.3799,0.00868988]],["Land_HBarrier_large",180.186,[12.9961,-37.4492,0.00408936]],["Land_HBarrier_large",89.7651,[24.6084,-31.5059,-0.00177765]],["Land_HBarrier_large",180.156,[-21.0752,-37.3125,0.000648499]],["Land_HBarrier_large",180.182,[21.8115,-37.4727,0.00183105]],["Land_HBarrier_large",89.9297,[-32.126,-31.1729,0.00794983]],["Land_HBarrier_large",180.156,[-29.6846,-37.3711,0.000831604]],["HeliH",0.369505,[-59.6201,12.7549,0]],["HeliH",0.128338,[-59.5518,-29.4307,0]],["HeliH",0.253116,[-80.0361,13.002,0]],["HeliH",0.0872141,[-79.7881,-30.5352,0]],["HeliH",359.996,[-80.3066,-50.1738,0]],["HeliH",0.159076,[-100.719,12.2432,0]],["HeliH",0.0102708,[-100.719,-30.1738,0]]];

//Arty - AI
btc_type_mortar           = "2b14_82mm_TK_EP1";
btc_arty_dispersion       = 60;
btc_arty_salvo            = 2;
//Arty - Player
btc_arty_magazine           = [["HE","SMOKE","ILLUM","WP"],["ARTY_Sh_105_HE","ARTY_SmokeShellWhite","ARTY_Sh_105_ILLUM","ARTY_Sh_105_WP"]];
btc_arty_player_available   = true;
btc_arty_player_reload_time = 300;
btc_arty_player_reloading   = 0;
btc_arty_player_x           = 0;
btc_arty_player_y           = 0;
btc_enemy_ratio_men             = "SoldierEB";
btc_friendly_men          = "SoldierWB";
btc_flag_marker_type      = "Faction_NATO_EP1";
btc_type_rally_point      = "Misc_Backpackheap_EP1";


switch (_type_units_n) do 
{
	case 0://SOV
	{
		btc_type_units            = ["LIB_SOV_smgunner","LIB_SOV_rifleman","LIB_SOV_mgunner"];
		btc_type_TL               = "LIB_SOV_sergeant";
		btc_type_crewmen          = "LIB_SOV_tank_crew";
		btc_type_pilots           = "LIB_SOV_rifleman";
		btc_type_medic            = "LIB_SOV_medic";
		btc_type_sniper           = "LIB_SOV_scout_sniper";
		//btc_type_para             = ["Ins_Soldier_1","Ins_Soldier_2","Ins_Soldier_GL","Ins_Soldier_MG","Ins_Soldier_Medic","Ins_Soldier_AT","Ins_Soldier_Sab","Ins_Soldier_AR"];
		btc_type_tanks            = ["LIB_T34_76","LIB_T34_85"];
		btc_type_apc              = ["LIB_zis5v","LIB_Scout_M3","LIB_Scout_FFV","LIB_US6_Open"];
		btc_type_motorized        = ["LIB_zis5v","LIB_Scout_M3","LIB_Scout_FFV","LIB_US6_Open"];
	};
};
