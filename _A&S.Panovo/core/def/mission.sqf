/*
	Created by Giallustio

*/
btc_version = 0.1;

//Mods

if (isClass(configFile >> "cfgPatches" >> "ace_main")) then {btc_isAce = true;} else {btc_isAce = false;};

//Param
_p_time = (paramsArray select 0);
_p_acctime = (paramsArray select 1);
//btc_p_load = (paramsArray select 2);
btc_gameMode = (paramsArray select 3);
btc_startLocationID = (paramsArray select 4);
//btc_enemyPlayer = (paramsArray select 5);
btc_arty = [false,true] select (paramsArray select 6);
btc_arty_player = [false,true] select (paramsArray select 7);
    //btc_p_rallypoint
    //btc_p_redeploy 
    //btc_p_respawnOnTL
	//btc_p_dynamicGroups
btc_dynamicGroups = [false,true] select (paramsArray select 11);
    //btc_p_recruitment
_type_units_n = (paramsArray select 13);
btc_enemy_ratio = (paramsArray select 14);
btc_infantryOnly = [false,true] select (paramsArray select 15);
//btc_p_rinf
_revive = (paramsArray select 17);
_p_med_level = (paramsArray select 18);
_p_adv_wounds = [false,true] select (paramsArray select 19);
_p_rev = (paramsArray select 20);
btc_AI_setSkill = [false,true] select (paramsArray select 21);

btc_debug = [false,true] select (paramsArray select 32);
if !(isMultiplayer) then {btc_debug = true};


if (!(btc_isAce) && _revive isEqualTo 2) then {_revive = 1;};


btc_AI_skill = [
	(paramsArray select 22)/10,//general
	(paramsArray select 23)/10,//aimingAccuracy
    (paramsArray select 24)/10,//aimingShake
    (paramsArray select 25)/10,//aimingSpeed
    (paramsArray select 26)/10,//endurance
    (paramsArray select 27)/10,//spotDistance
    (paramsArray select 28)/10,//spotTime
    (paramsArray select 29)/10,//courage
    (paramsArray select 30)/10,//reloadSpeed
    (paramsArray select 31)/10//commanding
];

btc_player_side        = west;
btc_enemy_side         = east;
btc_marker_respawn     = format ["respawn_%1",btc_player_side];
btc_marker_respawn_en  = format ["respawn_%1",btc_enemy_side];
btc_enemy_ratio_veh    = 4;
switch (btc_enemy_ratio) do {
	case 0: {btc_enemy_ratio_fant = 2};
	case 1: {btc_enemy_ratio_fant = 1};
	case 2: {btc_enemy_ratio_fant = 2};
	case 3: {btc_enemy_ratio_fant = 3};
};

btc_money = 99999;
btc_bonus_city = 500;
btc_loc_blacklist = [];
//Var
if (isServer) then {

	setDate [1944, 3, 25, _p_time, 0];
	setTimeMultiplier _p_acctime;
	
	btc_loc_radius = 150;
	btc_prev_city             = [];
	btc_actual_city           = [];
	btc_next_city             = [];
	btc_city_array            = [];
	btc_city_captured         = 0;
	btc_spawn                 = [];
	
	//Pub var
	btc_arty_available = true;publicVariable "btc_arty_available";
	
	
};
//Mission
btc_startLocations       = ["btc_startLocation_1","btc_startLocation_2","btc_startLocation_3","btc_startLocation_4"];
//btc_base_on_load          = [["FlagCarrierUSA",0,[0,0,0]],["Land_Barrack2_EP1",359.983,[-3.5,8.51465,0.000648499]],["Land_Barrack2_EP1",359.97,[5.72168,8.51758,0.000694275]],["Land_Barrack2_EP1",0.0553766,[-12.4141,8.44141,0.00125885]],["Land_Barrack2_EP1",359.935,[15.2256,8.66602,0.00169373]],["Land_HBarrier_large",359.966,[0.625977,19.6221,-0.00170135]],["Land_HBarrier_large",0.0763401,[-8.12012,19.623,-8.39233e-005]],["Land_HBarrier_large",359.898,[9.33887,19.6348,0.000198364]],["MASH_EP1",179.816,[-23.2471,7.46094,0.0413818]],["Land_HBarrier_large",89.7652,[24.3564,8.14746,-0.000671387]],["Land_HBarrier_large",0.0748278,[-16.873,19.6553,-0.000473022]],["Land_HBarrier_large",359.916,[18.1445,19.6357,-0.000221252]],["US_WarfareBVehicleServicePoint_Base_EP1",270.558,[-3.25879,28.085,-0.000305176]],["Land_HBarrier_large",89.7653,[24.3232,16.9414,-0.000328064]],["Land_HBarrier_large",0.0794629,[-25.6729,19.6563,-0.000427246]],["Land_HBarrier_large",89.765,[-31.4229,8.10742,0.0124741]],["Land_HBarrier_large",89.7651,[24.5781,-22.7129,-0.00173187]],["Land_HBarrier_large",89.765,[-31.4531,16.9033,0.0135269]],["HeliH",359.986,[-3.0166,37.4961,0]],["Land_HBarrier_large",180.159,[4.19336,-37.4531,0.00247192]],["Land_HBarrier_large",89.9297,[-32.1328,-22.3799,0.00868988]],["Land_HBarrier_large",180.186,[12.9961,-37.4492,0.00408936]],["Land_HBarrier_large",89.7651,[24.6084,-31.5059,-0.00177765]],["Land_HBarrier_large",180.156,[-21.0752,-37.3125,0.000648499]],["Land_HBarrier_large",180.182,[21.8115,-37.4727,0.00183105]],["Land_HBarrier_large",89.9297,[-32.126,-31.1729,0.00794983]],["Land_HBarrier_large",180.156,[-29.6846,-37.3711,0.000831604]],["HeliH",0.369505,[-59.6201,12.7549,0]],["HeliH",0.128338,[-59.5518,-29.4307,0]],["HeliH",0.253116,[-80.0361,13.002,0]],["HeliH",0.0872141,[-79.7881,-30.5352,0]],["HeliH",359.996,[-80.3066,-50.1738,0]],["HeliH",0.159076,[-100.719,12.2432,0]],["HeliH",0.0102708,[-100.719,-30.1738,0]]];
btc_baseComposition       = [["LIB_FlagCarrier_GER",[11.6509,-8.6543,0],0,1,0,[],"","",true,false],["WoodChair",[15.448,-2.60327,0],335.382,1,0,[],"","",true,false], ["WoodChair",[15.2256,-4.61279,0.0124569],221.116,1,0,[],"","",true,false], ["Land_WoodenCrate_01_F",[15.8391,-3.67651,-0.00398684],207.52,1,0,[],"","",true,false],["Land_GerRadio",[15.8296,-4.23169,0],340.583,1,0,[],"","",true,false], ["Land_WW2_Zeltbahn",[-15.2422,-8.02563,0],258.456,1,0,[],"","",true,false],["Land_WW2_Zeltbahn",[-17.6416,1.01904,0],47.3424,1,0,[],"","",true,false],	["Land_tent_east",[17.7727,-1.97852,0],279.868,1,0,[],"","",true,false], ["Land_WW2_BigHBarrier",[9.2146,-17.1284,0],320.415,1,0,[],"","",true,false],["Land_WW2_Zeltbahn",[-18.8896,-5.65161,0],308.298,1,0,[],"","",true,false], ["Land_WW2_BigHBarrier",[-5.16113,19.8381,0],320.415,1,0,[],"","",true,false],["Land_WW2_BigHBarrier",[-22.4038,2.9812,0],107.872,1,0,[],"","",true,false], ["Land_WW2_BigHBarrier",[-20.2666,10.7251,0],107.872,1,0,[],"","",true,false], ["Land_WW2_BigHBarrier",[-7.54028,-22.2471,0.00531387],198.265,1,0,[],"","",true,false], ["Land_WW2_bunker_mg",[-14.7441,-18.1899,0],14.5361,1,0,[],"","",true,false], ["Land_WW2_BigHBarrier",[22.8555,-9.33789,0],288.148,1,0,[],"","",true,false], ["Land_WW2_BigHBarrier",[0.292236,-24.6316,0.0106258],198.265,1,0,[],"","",true,false], ["Land_WW2_bunker_mg",[-16.7686,18.0313,0],107.247,1,0,[],"","",true,false], ["Land_WW2_BigHBarrier",[25.0298,-1.60425,0],288.148,1,0,[],"","",true,false], ["Land_WW2_bunker_mg",[18.7146,-16.3408,0],287.122,1,0,[],"","",true,false], ["Land_WW2_BigHBarrier",[-24.7627,-5.02197,0],107.872,1,0,[],"","",true,false], ["Land_WW2_BigHBarrier",[3.89917,25.8096,0],198.265,1,0,[],"","",true,false], ["Land_WW2_BigHBarrier",[11.6284,23.6194,0],198.265,1,0,[],"","",true,false], ["Land_WW2_BigHBarrier",[27.427,6.3877,0.0102444],288.148,1,0,[],"","",true,false], ["LIB_MG42_Lafette_trench",[-16.7996,-22.802,1.23466],193.621,1,0,[],"","",true,false], ["Land_WW2_BigHBarrier",[8.27905,-27.0452,0],198.265,1,0,[],"","",true,false], ["Land_WW2_bunker_mg",[18.7234,21.0386,0],198.648,1,0,[],"","",true,false], ["Land_WW2_BigHBarrier",[-4.08765,28.2231,0.0106258],198.265,1,0,[],"","",true,false], ["Land_WW2_BigHBarrier",[-22.8979,-17.4646,0],198.265,1,0,[],"","",true,false], ["LIB_MG42_Lafette_trench",[-21.5979,19.5024,1.20499],286.332,1,0,[],"","",true,false], ["LIB_MG42_Lafette_trench",[23.3965,-18.228,1.205],106.207,1,0,[],"","",true,false], ["Land_WW2_BigHBarrier",[-27.0935,-12.8706,0],107.872,1,0,[],"","",true,false], ["Land_WW2_BigHBarrier",[25.9185,18.95,0],198,1,0,[],"","",true,false], ["Land_WW2_BigHBarrier",[-11.9202,30.6077,0.00531387],198.265,1,0,[],"","",true,false], ["Land_WW2_BigHBarrier",[29.7957,14.2249,0.0049324],288.148,1,0,[],"","",true,false],["LIB_MG42_Lafette_trench",[20.6819,25.7844,1.20499],17.7326,1,0,[],"","",true,false],["Land_WW2_BigHBarrier",[16.0083,-29.2354,0],198.265,1,0,[],"","",true,false]];


//Arty - AI
btc_arty_dispersion       = 60;
btc_arty_shots            = 2;
btc_arty_ammo             = "ARTY_LIB_Sh_81_HE";
//Arty - Player
btc_arty_magazine           = [["HE","SMOKE","ILLUM","WP"],["Sh_125mm_HE","ARTY_SmokeShellWhite","ARTY_Sh_105_ILLUM","ARTY_Sh_105_WP"]];
btc_arty_available = true;
btc_arty_reloadTime = 300;
btc_arty_offsetX = 0;
btc_arty_offsetY = 0;
btc_arty_radios = ["B_LIB_GER_Radio","B_LIB_SOV_RA_Radio"];

//Combat Support

btc_gearObjectType = "LIB_WeaponsBox_Big_GER";
btc_combatSupportObjectType = "LIB_Static_opelblitz_radio";
btc_combatSupport =
[
	[
		"Cars",
		"Trucks",
		"APC",
		"Tanks"
	],
	[
		[
			//"Cars"
			"LIB_Kfz1",100,
			"LIB_Kfz1_MG42",100
		],
		[
			//"Trucks"
			"LIB_opelblitz_open_y_camo",100,
			"LIB_opelblitz_tent_y_camo",100,
			"LIB_opelblitz_ammo",100,
			"LIB_opelblitz_fuel",100,
			"LIB_opelblitz_parm",100
		],
		[
			//"APC"
			"LIB_SdKfz251",100,
			"LIB_SdKfz_7",100,
			"LIB_SdKfz_7_AA",100,
			"LIB_SdKfz251_FFV",100

		],
		[
			//"Tanks"
			"LIB_PzKpfwIV_H",100,
			"LIB_StuG_III_G",100,
			"LIB_PzKpfwV",100
		]
	]
];

btc_enemy_men             = "SoldierEB";
btc_friendly_men          = "SoldierWB";
btc_flag_marker_type      = "Faction_NATO_EP1";
btc_type_rally_point      = "Misc_Backpackheap_EP1";

btc_fortifications = [
	"Gun",
	"MG",
	"MG_low",
	"Trench_Big",
	"Trench_Small1"
];

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
		btc_type_apc              = ["LIB_Scout_M3","LIB_Scout_M3_FFV","LIB_SdKfz251_captured_FFV","LIB_SdKfz251_captured","LIB_SOV_M3_Halftrack"];
		btc_type_motorized        = ["LIB_zis5v","LIB_Scout_M3","LIB_Scout_M3_FFV","LIB_SdKfz251_captured_FFV","LIB_SdKfz251_captured","LIB_SOV_M3_Halftrack","LIB_US6_Open"];
	};
};

//Revive
switch (_revive) do {
	case 0: {};
	case 1: {
		//BI
		//missionNamespace setVariable ["bis_reviveParam_mode", 1];
		bis_reviveParam_mode = 1;
		//missionNamespace setVariable ["bis_reviveParam_unconsciousStateMode", 2];
		bis_reviveParam_unconsciousStateMode = 2;
		//missionNamespace setVariable ["bis_reviveParam_requiredTrait", 0];
		bis_reviveParam_requiredTrait = 0;
		//missionNamespace setVariable ["bis_reviveParam_requiredItems", 2];
		bis_reviveParam_requiredItems = 2;
		//missionNamespace setVariable ["ReviveRequiredItemsFakConsumed", 0];
		ReviveRequiredItemsFakConsumed = 0;
		//missionNamespace setVariable ["bis_reviveParam_duration", 10];
		bis_reviveParam_duration = 10;
		//missionNamespace setVariable ["bis_reviveParam_medicSpeedMultiplier", 2];
		bis_reviveParam_medicSpeedMultiplier = 2;
		//missionNamespace setVariable ["bis_reviveParam_forceRespawnDuration", 3];
		bis_reviveParam_forceRespawnDuration = 3;
		//missionNamespace setVariable ["bis_reviveParam_bleedOutDuration", _p_rev];
		bis_reviveParam_bleedOutDuration = _p_rev;
	};
	case 2: {
		//ACE
		ace_medical_level = _p_med_level;
		ace_medical_enableRevive = 1;
		ace_medical_preventInstaDeath = true;
		ace_medical_enableFor = 1;
		ace_medical_enableAdvancedWounds = _p_adv_wounds;
		ace_medical_maxReviveTime = _p_rev;
	};
};

//Arsenal
call compile preprocessFile "core\def\arsenal.sqf";