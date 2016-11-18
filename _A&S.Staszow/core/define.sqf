/*
Created by Giallustio

Visit us at: 
http://www.blacktemplars.altervista.org/
*/
btc_version = 0.1;
//Param
if (isNil "init_server_done") then {init_server_done = false;};
if !(isServer) then {WaitUntil {init_server_done};};
if (isNil "paramsArray") then 
{
	btc_Month           = 7;
	btc_Day             = 24;
	btc_Hour            = 12;
	btc_Minutes         = 00;
	btc_AI_skill        = 0.2;
	btc_view_distance   = 3000;
	btc_terrain         = 50;
	btc_type_units_n    = 4;
	btc_enemy           = 3;
	btc_game_mode       = 0;
	btc_enemy_player    = 1;
	btc_base_location   = 100;
	btc_arty            = 1;
	btc_arty_player_def = 1;
	btc_rinf            = 1;
	btc_marker_desc     = 2;
	btc_revive          = 2;
	btc_def_rally_point = 1;
	if (isServer) then {btc_money = 20000;};
	btc_civilian        = 1;
	btc_param_ied       = 1;
	btc_logistic        = 1;
	btc_def_uav         = 1;
	btc_def_recruitment = 1;
	btc_load            = 0;
	btc_debug           = 1;
} 
else 
{
	btc_Month           = (paramsArray select 0);
	btc_Day             = (paramsArray select 1);
	btc_Hour            = (paramsArray select 2);
	btc_Minutes         = (paramsArray select 3);
	btc_AI_skill        = (paramsArray select 4)/10;
	btc_view_distance   = (paramsArray select 5);
	btc_terrain         = (paramsArray select 6);
	btc_type_units_n    = (paramsArray select 7);
	btc_enemy           = (paramsArray select 8);
	btc_game_mode       = (paramsArray select 9);
	btc_base_location   = (paramsArray select 10);
	btc_enemy_player    = (paramsArray select 11);
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
};

btc_player_side        = west;
btc_enemy_side         = east;
btc_marker_respawn     = format ["respawn_%1",btc_player_side];
btc_marker_respawn_en  = format ["respawn_%1",btc_enemy_side];
btc_enemy_veh_ratio    = 4;
btc_enemy_fant_ratio   = 2;
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
	if !(isNil "paramsArray") then {if (isServer) then {btc_money = (paramsArray select 19)};};
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
btc_enemy_men             = "SoldierEB";
btc_friendly_men          = "SoldierWB";
btc_flag_marker_type      = "Faction_NATO_EP1";
btc_type_rally_point      = "Misc_Backpackheap_EP1";


btc_get_units_type =
{
	_type_units_n = _this select 0;
	switch (_type_units_n) do 
	{
		case 0://Chedaki
		{
			btc_type_units            = ["Ins_Soldier_1","Ins_Soldier_2","Ins_Soldier_GL","Ins_Soldier_MG","Ins_Soldier_Medic","Ins_Soldier_AT","Ins_Soldier_Sab","Ins_Soldier_AR"];
			btc_type_TL               = "Ins_Soldier_CO";
			btc_type_crewmen          = "Ins_Soldier_Crew";
			btc_type_pilots           = "Ins_Soldier_Pilot";
			btc_type_medic            = "Ins_Soldier_Medic";
			btc_type_sniper           = "Ins_Soldier_Sniper";
			btc_type_para             = ["Ins_Soldier_1","Ins_Soldier_2","Ins_Soldier_GL","Ins_Soldier_MG","Ins_Soldier_Medic","Ins_Soldier_AT","Ins_Soldier_Sab","Ins_Soldier_AR"];
			btc_type_vehicles         = ["BMP2_INS","BMP2_HQ_INS","BRDM2_INS","BRDM2_ATGM_INS","T72_INS","ZSU_INS","UAZ_MG_INS","UAZ_SPG9_INS","UAZ_AGS30_INS"];
			btc_type_motorized        = ["BMP2_INS","M113_TK_EP1","BTR90","UralOpen_INS","Ural_INS"];
			btc_type_heli             = ["Mi24_V"];
			btc_type_heli_transport   = ["Mi24_P","Mi17_Ins"];
		};
		case 1://Lingor
		{
			btc_type_units            = ["ibr_arl_mg","ibr_arl_at","ibr_arl_rif","ibr_arl_rif2"];
			btc_type_TL               = "ibr_arl_rif";
			btc_type_crewmen          = "ibr_arl_crew";
			btc_type_pilots           = "ibr_arl_pilot";
			btc_type_medic            = "ibr_arl_medic";
			btc_type_sniper           = "ibr_arl_sniper";
			btc_type_para             = ["ibr_arl_medic","ibr_arl_mg","ibr_arl_at","ibr_arl_rif","ibr_arl_rif2"];
			btc_type_vehicles         = ["BMP2_INS","BMP2_HQ_INS","BRDM2_INS","BRDM2_ATGM_INS","T72_INS","ZSU_INS","UAZ_MG_INS","UAZ_SPG9_INS","UAZ_AGS30_INS"];
			btc_type_motorized        = ["BMP2_INS","M113_TK_EP1","BTR90","UralOpen_INS","Ural_INS"];
			btc_type_heli             = ["Mi24_D_TK_EP1","Mi17_TK_EP1"];
			btc_type_heli_transport   = ["Mi24_D_TK_EP1","Mi17_TK_EP1","UH1H_TK_EP1"];
		};
		case 2://Duala
		{
			btc_type_units            = ["MOL_Soldier_MG","MOL_Soldier_Engineer","MOL_Soldier_Rifleman","MOL_Soldier_Marksman","MOL_Soldier_GL","MOL_Soldier_AR","MOL_Soldier_AT","MOL_Soldier_LAT","MOL_Soldier_HAT","MOL_Soldier_AA"];
			btc_type_TL               = "MOL_Soldier_Officer";
			btc_type_crewmen          = "MOL_Soldier_Crew";
			btc_type_pilots           = "MOL_Soldier_Pilot";
			btc_type_medic            = "MOL_Soldier_Medic";
			btc_type_sniper           = "MOL_Soldier_Sniper";
			btc_type_para             = ["MOL_Soldier_Commando","MOL_Soldier_Commando"];
			btc_type_vehicles         = ["ibr_T55","T72_MOL","ibr_datsun_molblk","BMP2_MOL","ibr_datsun_mol"];
			btc_type_motorized        = ["Ural_MOL","Ural_MOL"];
			btc_type_heli             = ["Mi24_V"];
			btc_type_heli_transport   = ["Mi17_Ins"];
		};
		case 3://RU
		{
			btc_type_units            = ["RU_Soldier_AT","RU_Soldier_MG","RU_Soldier_GL","RU_Soldier_Marksman","RU_Soldier_LAT","RU_Soldier_Medic","RU_Soldier_AA","RU_Soldier_AR","RU_Soldier2","MVD_Soldier_AT","MVD_Soldier_MG","MVD_Soldier_GL","MVD_Soldier"];
			btc_type_TL               = "RU_Soldier_Officer";
			btc_type_crewmen          = "RU_Soldier_Crew";
			btc_type_pilots           = "RU_Soldier_Pilot";
			btc_type_medic            = "RU_Soldier_Medic";
			btc_type_sniper           = "RU_Soldier_Sniper";
			btc_type_para             = ["MVD_Soldier_TL","MVD_Soldier_AT","MVD_Soldier_MG","MVD_Soldier_GL","MVD_Soldier","RUS_Commander","RUS_Soldier1","RUS_Soldier2","RUS_Soldier3","RUS_Soldier_TL"];
			btc_type_vehicles         = ["BMP3","BTR90","BTR90_HQ","2S6M_Tunguska","T72_RU","T90","GAZ_Vodnik","GAZ_Vodnik_HMG","UAZ_AGS30_RU"];
			btc_type_motorized        = ["BMP3","BTR90","BTR90","KamazOpen","Kamaz"];
			btc_type_heli             = ["Ka52","Ka52Black","Mi24_P","Mi24_V","Mi17_rockets_RU"];
			btc_type_heli_transport   = ["Mi24_P","Mi24_V","Mi17_rockets_RU"];
		};
		case 4://TK Army
		{
			btc_type_units            = ["TK_Soldier_AA_EP1","TK_Soldier_AAT_EP1","TK_Soldier_AMG_EP1","TK_Soldier_HAT_EP1","TK_Soldier_AR_EP1","TK_Soldier_Engineer_EP1","TK_Soldier_GL_EP1","TK_Soldier_MG_EP1","TK_Soldier_Medic_EP1","TK_Soldier_Officer_EP1","TK_Soldier_EP1","TK_Soldier_B_EP1","TK_Soldier_LAT_EP1","TK_Soldier_AT_EP1","TK_Soldier_Night_1_EP1","TK_Soldier_Night_2_EP1"];
			btc_type_TL               = "TK_Soldier_Officer_EP1";
			btc_type_crewmen          = "TK_Soldier_Crew_EP1";
			btc_type_pilots           = "TK_Soldier_Pilot_EP1";
			btc_type_medic            = "TK_Soldier_Medic_EP1";
			btc_type_sniper           = "TK_Soldier_SniperH_EP1";
			btc_type_para             = ["TK_Special_Forces_MG_EP1","TK_Special_Forces_EP1","TK_Special_Forces_TL_EP1"];
			btc_type_vehicles         = ["BMP2_TK_EP1","BMP2_HQ_TK_EP1","BRDM2_TK_EP1","BRDM2_ATGM_TK_EP1","BTR60_TK_EP1","M113_TK_EP1","T34_TK_EP1","T55_TK_EP1","T72_TK_EP1","ZSU_TK_EP1","LandRover_MG_TK_EP1","UAZ_MG_TK_EP1","UAZ_AGS30_TK_EP1","LandRover_SPG9_TK_EP1","Ural_ZU23_TK_EP1"];
			btc_type_motorized        = ["V3S_TK_EP1","M113_TK_EP1","V3S_Open_TK_EP1","BMP2_TK_EP1","BTR60_TK_EP1"];
			btc_type_heli             = ["Mi24_D_TK_EP1"];
			btc_type_heli_transport   = ["Mi24_D_TK_EP1","Mi17_TK_EP1","UH1H_TK_EP1"];
		};
		case 5://TK Militia
		{
			btc_type_units            = ["TK_INS_Soldier_AR_EP1","TK_INS_Bonesetter_EP1","TK_INS_Soldier_MG_EP1","TK_INS_Soldier_2_EP1","TK_INS_Soldier_EP1","TK_INS_Soldier_3_EP1","TK_INS_Soldier_AAT_EP1","TK_INS_Soldier_AT_EP1","TK_INS_Soldier_TL_EP1","TK_INS_Soldier_4_EP1","TK_INS_Soldier_AA_EP1"];
			btc_type_TL               = "TK_INS_Warlord_EP1";
			btc_type_crewmen          = "TK_Soldier_Crew_EP1";
			btc_type_pilots           = "TK_Soldier_Pilot_EP1";
			btc_type_medic            = "TK_INS_Bonesetter_EP1";
			btc_type_sniper           = "TK_INS_Soldier_Sniper_EP1";
			btc_type_para             = ["TK_INS_Soldier_AR_EP1","TK_INS_Bonesetter_EP1","TK_INS_Soldier_MG_EP1","TK_INS_Soldier_2_EP1","TK_INS_Soldier_EP1","TK_INS_Soldier_3_EP1","TK_INS_Soldier_AAT_EP1","TK_INS_Soldier_AT_EP1","TK_INS_Soldier_TL_EP1","TK_INS_Soldier_4_EP1","TK_INS_Soldier_AA_EP1","TK_INS_Warlord_EP1"];
			btc_type_vehicles         = ["LandRover_MG_TK_INS_EP1","BTR40_MG_TK_INS_EP1","LandRover_SPG9_TK_INS_EP1"];
			btc_type_motorized        = ["BTR40_TK_INS_EP1","BTR40_MG_TK_INS_EP1","BTR90","UralOpen_INS","Ural_INS"];
			btc_type_heli             = ["Mi24_D_TK_EP1","Mi17_TK_EP1","UH1H_TK_EP1"];
			btc_type_heli_transport   = ["Mi24_D_TK_EP1","Mi17_TK_EP1","UH1H_TK_EP1"];
		};
	};
	true
};