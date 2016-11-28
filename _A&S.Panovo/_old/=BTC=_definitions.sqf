/*
Created by =BTC= Giallustio

Visit us at: 
http://www.blacktemplars.altervista.org/
*/
BTC_version = 1.8;
//Param
if (isNil "init_server_done") then {init_server_done = false;};
if !(isServer) then {WaitUntil {init_server_done};};
if (isNil "paramsArray") then 
{
	BTC_Month           = 7;
	BTC_Day             = 24;
	BTC_Hour            = 12;
	BTC_Minutes         = 00;
	BTC_AI_skill        = 0.2;
	BTC_view_distance   = 3000;
	BTC_terrain         = 50;
	BTC_type_units_n    = 4;
	BTC_enemy           = 3;
	BTC_game_mode       = 0;
	BTC_enemy_player    = 1;
	BTC_base_location   = 100;
	BTC_arty            = 1;
	BTC_arty_player_def = 1;
	BTC_rinf            = 1;
	BTC_marker_desc     = 2;
	BTC_revive          = 2;
	BTC_def_rally_point = 1;
	if (isServer) then {BTC_money = 20000;};
	BTC_civilian        = 1;
	BTC_param_ied       = 1;
	BTC_logistic        = 1;
	BTC_def_uav         = 1;
	BTC_def_recruitment = 1;
	BTC_load            = 0;
	BTC_debug           = 1;
} 
else 
{
	BTC_Month           = (paramsArray select 0);
	BTC_Day             = (paramsArray select 1);
	BTC_Hour            = (paramsArray select 2);
	BTC_Minutes         = (paramsArray select 3);
	BTC_AI_skill        = (paramsArray select 4)/10;
	BTC_view_distance   = (paramsArray select 5);
	BTC_terrain         = (paramsArray select 6);
	BTC_type_units_n    = (paramsArray select 7);
	BTC_enemy           = (paramsArray select 8);
	BTC_game_mode       = (paramsArray select 9);
	BTC_base_location   = (paramsArray select 10);
	BTC_enemy_player    = (paramsArray select 11);
	BTC_arty            = (paramsArray select 12);
	BTC_arty_player_def = (paramsArray select 13);
	BTC_rinf            = (paramsArray select 14);
	BTC_marker_desc     = (paramsArray select 15);
	BTC_revive          = (paramsArray select 16);
	BTC_def_rally_point = (paramsArray select 18);
	if (isServer) then {BTC_money = (paramsArray select 19)};
	BTC_civilian        = (paramsArray select 20);
	BTC_param_ied       = (paramsArray select 21);
	BTC_logistic        = (paramsArray select 22);
	BTC_def_uav         = (paramsArray select 23);
	BTC_def_recruitment = (paramsArray select 24);
	BTC_load            = (paramsArray select 25);
	BTC_debug           = (paramsArray select 26);
};
infjury_factor = 3;
BTC_player_side        = west;
BTC_enemy_side         = east;
BTC_marker_respawn     = format ["respawn_%1",BTC_player_side];
BTC_marker_respawn_en  = format ["respawn_%1",BTC_enemy_side];
btc_enemy_ratio_veh    = 4;
btc_enemy_ratio_fant   = 2;
BTC_city_bonus         = 500;
BTC_loc_blacklist      = [];
//Var
if (isServer) then 
{
	BTC_prev_city             = [];
	BTC_actual_city           = [];
	BTC_next_city             = [];
	BTC_city_array            = [];
	BTC_city_captured         = 0;
	BTC_spawn                 = [];
	if !(isNil "paramsArray") then {if (isServer) then {BTC_money = (paramsArray select 19)};};
	publicVariable "BTC_prev_city";publicVariable "BTC_actual_city";publicVariable "BTC_next_city";publicVariable "BTC_city_array";publicVariable "BTC_city_captured";publicVariable "BTC_money";publicVariable "BTC_spawn";
};
//Mission
BTC_starts_location       = ["BTC_start_location_1","BTC_start_location_2","BTC_start_location_3","BTC_start_location_4","BTC_start_location_5","BTC_start_location_6"];
BTC_base_on_load          = [["FlagCarrierUSA",0,[0,0,0]],["Land_Barrack2_EP1",359.983,[-3.5,8.51465,0.000648499]],["Land_Barrack2_EP1",359.97,[5.72168,8.51758,0.000694275]],["Land_Barrack2_EP1",0.0553766,[-12.4141,8.44141,0.00125885]],["Land_Barrack2_EP1",359.935,[15.2256,8.66602,0.00169373]],["Land_HBarrier_large",359.966,[0.625977,19.6221,-0.00170135]],["Land_HBarrier_large",0.0763401,[-8.12012,19.623,-8.39233e-005]],["Land_HBarrier_large",359.898,[9.33887,19.6348,0.000198364]],["MASH_EP1",179.816,[-23.2471,7.46094,0.0413818]],["Land_HBarrier_large",89.7652,[24.3564,8.14746,-0.000671387]],["Land_HBarrier_large",0.0748278,[-16.873,19.6553,-0.000473022]],["Land_HBarrier_large",359.916,[18.1445,19.6357,-0.000221252]],["US_WarfareBVehicleServicePoint_Base_EP1",270.558,[-3.25879,28.085,-0.000305176]],["Land_HBarrier_large",89.7653,[24.3232,16.9414,-0.000328064]],["Land_HBarrier_large",0.0794629,[-25.6729,19.6563,-0.000427246]],["Land_HBarrier_large",89.765,[-31.4229,8.10742,0.0124741]],["Land_HBarrier_large",89.7651,[24.5781,-22.7129,-0.00173187]],["Land_HBarrier_large",89.765,[-31.4531,16.9033,0.0135269]],["HeliH",359.986,[-3.0166,37.4961,0]],["Land_HBarrier_large",180.159,[4.19336,-37.4531,0.00247192]],["Land_HBarrier_large",89.9297,[-32.1328,-22.3799,0.00868988]],["Land_HBarrier_large",180.186,[12.9961,-37.4492,0.00408936]],["Land_HBarrier_large",89.7651,[24.6084,-31.5059,-0.00177765]],["Land_HBarrier_large",180.156,[-21.0752,-37.3125,0.000648499]],["Land_HBarrier_large",180.182,[21.8115,-37.4727,0.00183105]],["Land_HBarrier_large",89.9297,[-32.126,-31.1729,0.00794983]],["Land_HBarrier_large",180.156,[-29.6846,-37.3711,0.000831604]],["HeliH",0.369505,[-59.6201,12.7549,0]],["HeliH",0.128338,[-59.5518,-29.4307,0]],["HeliH",0.253116,[-80.0361,13.002,0]],["HeliH",0.0872141,[-79.7881,-30.5352,0]],["HeliH",359.996,[-80.3066,-50.1738,0]],["HeliH",0.159076,[-100.719,12.2432,0]],["HeliH",0.0102708,[-100.719,-30.1738,0]]];
BTC_farp_base_rel         = [-3.0166,37.4961,0];
BTC_area_size             = 350;
//Arty - AI
BTC_type_mortar           = "2b14_82mm_TK_EP1";
BTC_arty_dispersion       = 60;
BTC_arty_salvo            = 2;
//Arty - Player
BTC_arty_magazine           = [["HE","SMOKE","ILLUM","WP"],["ARTY_Sh_105_HE","ARTY_SmokeShellWhite","ARTY_Sh_105_ILLUM","ARTY_Sh_105_WP"]];
BTC_arty_player_available   = true;
BTC_arty_player_reload_time = 300;
BTC_arty_player_reloading   = 0;
BTC_arty_player_x           = 0;
BTC_arty_player_y           = 0;
BTC_enemy_men             = "SoldierEB";
BTC_friendly_men          = "SoldierWB";
BTC_flag_marker_type      = "Faction_NATO_EP1";
BTC_type_rally_point      = "Misc_Backpackheap_EP1";
//Var
if (BTC_load == 0) then {BTC_maxi_array = [[],[],[],[],[]];};
BTC_players_string        = ["s1","s2","s3","s4","s5","s6","s7","s8","s9","s10","s11","s12","s13","s14","s15","s16","s17","s18","s19","s20","s21"];
BTC_groups_string         = ["B Alpha", "B Bravo", "B Charlie", "B Delta", "B Echo", "B Foxtrot"];
//Units
BTC_lift_pilot            = ["US_Soldier_Pilot_EP1"];
BTC_recruitable_units     = ["US_Soldier_EP1","US_Soldier_Engineer_EP1","US_Soldier_Medic_EP1","US_Soldier_LAT_EP1","US_Soldier_AT_EP1","US_Soldier_AAT_EP1","US_Soldier_HAT_EP1","US_Soldier_AHAT_EP1","US_Soldier_GL_EP1","US_Soldier_MG_EP1","US_Soldier_AMG_EP1","US_Soldier_AR_EP1","US_Soldier_AA_EP1","US_Soldier_Marksman_EP1","US_Soldier_Sniper_EP1","US_Soldier_Spotter_EP1","US_Soldier_Pilot_EP1","US_Soldier_Crew_EP1"];
BTC_recruitable_cost      = [25,50,50,80,100,50,250,50,50,80,50,80,100,80,150,60,25,25];
BTC_house_not_available   = ["Land_Mil_hangar_EP1", "Land_Mil_ControlTower_EP1", "Land_Mil_Guardhouse_EP1", "Land_Mil_Repair_center_EP1","Land_Mil_Barracks_i_EP1","Land_A_Minaret_EP1","Land_Ind_Coltan_Main_EP1"];
//Gear
BTC_gear                  = ["ItemGPS","ItemCompass","ItemMap","ItemRadio","ItemWatch"];
BTC_ACE_gear              = ["ACE_Earplugs","ItemGPS","ACE_GlassesLHD_glasses"];
//Type
BTC_type_ied              = ["Land_IED_v1_PMC","Land_IED_v2_PMC","Land_IED_v3_PMC","Land_IED_v4_PMC"];
BTC_type_expl             = ["ARTY_Sh_105_HE","ARTY_Sh_81_HE","B_30mm_HE"];
BTC_type_civilians        = ["TK_CIV_Takistani01_EP1","TK_CIV_Takistani02_EP1","TK_CIV_Takistani03_EP1","TK_CIV_Takistani04_EP1","TK_CIV_Takistani05_EP1","TK_CIV_Takistani06_EP1","TK_CIV_Worker02_EP1","TK_CIV_Worker01_EP1"];
BTC_type_compositions     = ["citybase01","citybase02","citybase03","citybase04","smallbase"];
BTC_items      = ["Binocular_Vector","Binocular","Laserdesignator","NVGoggles","ItemCompass","ItemGPS","ItemMap","ItemRadio","ItemWatch"];
BTC_coin_items =
[
		//Ammo
 
	["ACRE_Radiobox","Weapon boxes",25,"Radio Box (Acre)"],
	["USVehicleBox_EP1","Weapon boxes",25,"Items Box"],
	
	["USBasicWeapons_EP1","Weapon boxes",50,"US"],
	["USBasicWeaponsBox","Weapon boxes",50,"USMC"],
	["GERBasicWeapons_EP1","Weapon boxes",50,"GER"],
	["BAF_BasicWeapons","Weapon boxes",50,"BAF"],
	["USSpecialWeapons_EP1","Weapon boxes",50,"Special Weapon US"],
	["USSpecialWeaponsBox","Weapon boxes",50,"Special Weapon USMC"],
	["USLaunchers_EP1","Weapon boxes",50,"Launchers US"],
	["USLaunchersBox","Weapon boxes",50,"Launchers USMC"],
	["BAF_Launchers","Weapon boxes",50,"Launchers BAF"],
	
	["BAF_BasicAmmunitionBox","Ammo boxes",50,"BAF"],
	["USBasicAmmunitionBox","Ammo boxes",50,"USMC"],
	["USBasicAmmunitionBox_EP1","Ammo boxes",50,"US"],
	
	["USOrdnanceBox_EP1","Ammo boxes",50,"Ordnance Box"],
	    //Armour
	["M1A1_US_DES_EP1","Armour",4000,"M1A2"],
	["M1A2_US_TUSK_MG_EP1","Armour",5000,"M1A2 Tusk"],
	["M2A2_EP1","Armour",3000,"M2A2"],
	["M2A3_EP1","Armour",3500,"M2A3"],
	["M6_EP1","Armour",2200,"M6"],
	["MLRS_DES_EP1","Armour",15000,"MLRS"],
		//Support
	["HMMWV_Ambulance_DES_EP1","Support",200,"HMMWV Ambulance"],
	["MtvrReammo_DES_EP1","Support",200,"Mtvr Reammo"],
	["MtvrRefuel_DES_EP1","Support",200,"Mtvr Refuel"],
	["MtvrRepair_DES_EP1","Support",200,"Mtvr Repair"],
	["MASH_EP1","Support",100,"Mash Tent"],
	["M1133_MEV_EP1","Support",300,"M1133 MEV"],
	["UH60M_MEV_EP1","Support",500,"UH60M MEV"],
	    //Light Vehicles
	["ATV_US_EP1","Light Vehicles",50,"ATV"],
	["MTVR_DES_EP1","Light Vehicles",100,"MTVR"],
	["HMMWV_DES_EP1","Light Vehicles",150,"HMMWV"],
	["HMMWV_MK19_DES_EP1","Light Vehicles",250,"HMMWV MK19"],
	["HMMWV_TOW_DES_EP1","Light Vehicles",300,"HMMWV TOW"],
	["HMMWV_M998_crows_M2_DES_EP1","Light Vehicles",400,"HMMWV CROWS M2"],
	["HMMWV_M998_crows_MK19_DES_EP1","Light Vehicles",500,"HMMWV CROWS MK19"],
	["HMMWV_M1151_M2_DES_EP1","Light Vehicles",250,"HMMWV M1151 M2"],
	["HMMWV_M998A2_SOV_DES_EP1","Light Vehicles",250,"HMMWV SOV"],
	["HMMWV_Avenger_DES_EP1","Light Vehicles",500,"HMMWV Avenger"],
	["M1126_ICV_M2_EP1","Light Vehicles",1500,"Stryker M2"],
	["M1126_ICV_mk19_EP1","Light Vehicles",2000,"Stryker MK19"],
	["M1129_MC_EP1","Light Vehicles",2500,"Stryker MC"],
	["M1128_MGS_EP1","Light Vehicles",2800,"Stryker MGS"],
	["LAV25","Light Vehicles",2200,"LAV25"],
	["AAV","Light Vehicles",2500,"AAV"],
		//Static Weapons
	["M2StaticMG_US_EP1","Static Weapons",50,"M2 tripod"],
	["M2HD_mini_TriPod_US_EP1","Static Weapons",50,"M2 mini tripod"],
	["MK19_TriPod_US_EP1","Static Weapons",80,"MK19 Grenade Launcher"],
	["TOW_TriPod_US_EP1","Static Weapons",150,"TOW tripod"],
	["Stinger_Pod_US_EP1","Static Weapons",150,"Stinger tripod"],
	["M252_US_EP1","Static Weapons",500,"82mm Mortars"],
	["M119_US_EP1","Static Weapons",5000,"M119 Canon"],
		//Helicopter
	["MH6J_EP1","Helicopter",800,"MH6J"],
	["AH6J_EP1","Helicopter",1000,"AH6J"],
	["UH1Y","Helicopter",2000,"UH1Y Venom"],
	["UH60M_EP1","Helicopter",1000,"UH60M"],
	["CH_47F_EP1","Helicopter",2000,"CH 47F"],
	["AH64D_EP1","Helicopter",8000,"AH64D"],
		//Plane
	["A10_US_EP1","Plane",10000,"A 10"],
		//Boat
	["Zodiac","Boat",200,"CRRC"],
	["RHIB","Boat",500,"RHIB"],
	["RHIB2Turret","Boat",800,"RHIB MK 19"]
];
BTC_coin_items_ACE =
[
		//Ammo
 
	["ACE_RuckBox","Weapon boxes",25,"Ruck Box"],
	["ACE_RopeBox","Weapon boxes",25,"Ropes Box"],
	["ACRE_Radiobox","Weapon boxes",25,"Radio Box (Acre)"],

	["ACE_WeaponBox_BIS_US","Weapon boxes",50,"US"],
	["ACE_WeaponBox_USMC","Weapon boxes",50,"USMC"],
	["ACE_WeaponBox_BIS_GER","Weapon boxes",50,"GER"],
	["ACE_WeaponBox_BIS_BAF","Weapon boxes",50,"BAF"],
	
	["ACE_WeaponBox_Launchers_BIS_US","Weapon boxes",50,"AT US"],
	["ACE_WeaponBox_Launchers_USMC","Weapon boxes",50,"AT USMC"],
	["ACE_WeaponBox_Launchers_BIS_GER","Weapon boxes",50,"AT GER"],
	["ACE_WeaponBox_Launchers_BIS_BAF","Weapon boxes",50,"AT BAF"],
	
	["ACE_Tbox_556x45STANAG","Ammo boxes",25,"Transport Box US"],
	["USBasicAmmunitionBox","Ammo boxes",50,"USMC (V)"],
	["USBasicAmmunitionBox_EP1","Ammo boxes",50,"US (V)"],
	["ACE_MagazineBox_BIS_GER","Ammo boxes",50,"Box GER"],
	["ACE_MagazineBox_BIS_BAF","Ammo boxes",50,"Box BAF"],
	["ACE_MagazineBox_USMC","Ammo boxes",50,"Box USMC"],
	["ACE_MagazineBox_BIS_US","Ammo boxes",50,"Box US"],
	
	["ACE_MagazineBox_Launchers_USMC","Ammo boxes",50,"AT USMC"], 
	["ACE_MagazineBox_Launchers_BIS_US","Ammo boxes",50,"AT US"],
	
	["ACE_BandageBoxWest","Ammo boxes",50,"Bandage Box"],
	["ACE_OrdnanceBox_BIS_US","Ammo boxes",50,"Ordnance Box"],
	["ACE_Tbox_Mortar_60mmHE","Ammo boxes",20,"60mmHE Box"],
	["ACE_Tbox_Mortar_60mmIL","Ammo boxes",20,"60mmIL Box"],
	["ACE_Tbox_Mortar_60mmWP","Ammo boxes",20,"60mmWP Box"],
	["ACE_Tbox_Mortar_81mmHE","Ammo boxes",40,"81mmHE Box"],
	["ACE_Tbox_Mortar_81mmIL","Ammo boxes",40,"81mmIL Box"],
	["ACE_Tbox_Mortar_81mmWP","Ammo boxes",40,"81mmWP Box"],
	["ace_sys_weapons_magicbox","Ammo boxes",100,"Magic Box"],
	    //Armour
	["M1A1_US_DES_EP1","Armour",4000,"M1A2"],
	["M1A2_US_TUSK_MG_EP1","Armour",5000,"M1A2 Tusk"],
	["M2A2_EP1","Armour",3000,"M2A2"],
	["M2A3_EP1","Armour",3500,"M2A3"],
	["M6_EP1","Armour",2200,"M6"],
		//Support
	["HMMWV_Ambulance_DES_EP1","Support",200,"HMMWV Ambulance"],
	["ACE_MTVRReammo_DES_EP1","Support",200,"Mtvr Reammo"],
	["ACE_MTVRRefuel_DES_EP1","Support",200,"Mtvr Refuel"],
	["ACE_MTVRRepair_DES_EP1","Support",200,"Mtvr Repair"],
	["MASH_EP1","Support",100,"Mash Tent"],
	["M1133_MEV_EP1","Support",300,"M1133 MEV"],
	["UH60M_MEV_EP1","Support",500,"UH60M MEV"],
	    //Light Vehicles
	["ATV_US_EP1","Light Vehicles",50,"ATV"],
	["MTVR_DES_EP1","Light Vehicles",100,"MTVR"],
	["HMMWV_DES_EP1","Light Vehicles",150,"HMMWV"],
	["HMMWV_MK19_DES_EP1","Light Vehicles",250,"HMMWV MK19"],
	["HMMWV_TOW_DES_EP1","Light Vehicles",300,"HMMWV TOW"],
	["HMMWV_M998_crows_M2_DES_EP1","Light Vehicles",400,"HMMWV CROWS M2"],
	["HMMWV_M998_crows_MK19_DES_EP1","Light Vehicles",500,"HMMWV CROWS MK19"],
	["HMMWV_M1151_M2_DES_EP1","Light Vehicles",250,"HMMWV M1151 M2"],
	["HMMWV_M998A2_SOV_DES_EP1","Light Vehicles",250,"HMMWV SOV"],
	["HMMWV_Avenger_DES_EP1","Light Vehicles",500,"HMMWV Avenger"],
	["M1126_ICV_M2_EP1","Light Vehicles",1500,"Stryker M2"],
	["M1126_ICV_mk19_EP1","Light Vehicles",2000,"Stryker MK19"],
	["M1129_MC_EP1","Light Vehicles",2500,"Stryker MC"],
	["M1128_MGS_EP1","Light Vehicles",2800,"Stryker MGS"],
	["LAV25","Light Vehicles",2200,"LAV25"],
	["AAV","Light Vehicles",2500,"AAV"],
		//Static Weapons
	["M2StaticMG_US_EP1","Static Weapons",50,"M2 tripod"],
	["M2HD_mini_TriPod_US_EP1","Static Weapons",50,"M2 mini tripod"],
	["MK19_TriPod_US_EP1","Static Weapons",80,"MK19 Grenade Launcher"],
	["TOW_TriPod_US_EP1","Static Weapons",150,"TOW tripod"],
	["Stinger_Pod_US_EP1","Static Weapons",150,"Stinger tripod"],
	["ACE_M224","Static Weapons",250,"60mm Mortars"],
	["M252_US_EP1","Static Weapons",500,"82mm Mortars"],
	["M119_US_EP1","Static Weapons",5000,"M119 Canon"],
		//Helicopter
	["MH6J_EP1","Helicopter",800,"MH6J"],
	["AH6J_EP1","Helicopter",1000,"AH6J"],
	["UH1Y","Helicopter",2000,"UH1Y Venom"],
	["UH60M_EP1","Helicopter",1000,"UH60M"],
	["CH_47F_EP1","Helicopter",2000,"CH 47F"],
	["AH64D_EP1","Helicopter",8000,"AH64D"],
		//Plane
	["A10_US_EP1","Plane",10000,"A 10"],
		//Boat
	["Zodiac","Boat",200,"CRRC"],
	["RHIB","Boat",500,"RHIB"],
	["RHIB2Turret","Boat",800,"RHIB MK 19"]
];
BTC_get_units_type =
{
	_type_units_n = _this select 0;
	switch (_type_units_n) do 
	{
		case 0://Chedaki
		{
			BTC_type_units            = ["Ins_Soldier_1","Ins_Soldier_2","Ins_Soldier_GL","Ins_Soldier_MG","Ins_Soldier_Medic","Ins_Soldier_AT","Ins_Soldier_Sab","Ins_Soldier_AR"];
			BTC_type_TL               = "Ins_Soldier_CO";
			BTC_type_crewmen          = "Ins_Soldier_Crew";
			BTC_type_pilots           = "Ins_Soldier_Pilot";
			BTC_type_medic            = "Ins_Soldier_Medic";
			BTC_type_sniper           = "Ins_Soldier_Sniper";
			BTC_type_para             = ["Ins_Soldier_1","Ins_Soldier_2","Ins_Soldier_GL","Ins_Soldier_MG","Ins_Soldier_Medic","Ins_Soldier_AT","Ins_Soldier_Sab","Ins_Soldier_AR"];
			BTC_type_vehicles         = ["BMP2_INS","BMP2_HQ_INS","BRDM2_INS","BRDM2_ATGM_INS","T72_INS","ZSU_INS","UAZ_MG_INS","UAZ_SPG9_INS","UAZ_AGS30_INS"];
			BTC_type_motorized        = ["BMP2_INS","M113_TK_EP1","BTR90","UralOpen_INS","Ural_INS"];
			BTC_type_heli             = ["Mi24_V"];
			BTC_type_heli_transport   = ["Mi24_P","Mi17_Ins"];
		};
		case 1://Lingor
		{
			BTC_type_units            = ["ibr_arl_mg","ibr_arl_at","ibr_arl_rif","ibr_arl_rif2"];
			BTC_type_TL               = "ibr_arl_rif";
			BTC_type_crewmen          = "ibr_arl_crew";
			BTC_type_pilots           = "ibr_arl_pilot";
			BTC_type_medic            = "ibr_arl_medic";
			BTC_type_sniper           = "ibr_arl_sniper";
			BTC_type_para             = ["ibr_arl_medic","ibr_arl_mg","ibr_arl_at","ibr_arl_rif","ibr_arl_rif2"];
			BTC_type_vehicles         = ["BMP2_INS","BMP2_HQ_INS","BRDM2_INS","BRDM2_ATGM_INS","T72_INS","ZSU_INS","UAZ_MG_INS","UAZ_SPG9_INS","UAZ_AGS30_INS"];
			BTC_type_motorized        = ["BMP2_INS","M113_TK_EP1","BTR90","UralOpen_INS","Ural_INS"];
			BTC_type_heli             = ["Mi24_D_TK_EP1","Mi17_TK_EP1"];
			BTC_type_heli_transport   = ["Mi24_D_TK_EP1","Mi17_TK_EP1","UH1H_TK_EP1"];
		};
		case 2://Duala
		{
			BTC_type_units            = ["MOL_Soldier_MG","MOL_Soldier_Engineer","MOL_Soldier_Rifleman","MOL_Soldier_Marksman","MOL_Soldier_GL","MOL_Soldier_AR","MOL_Soldier_AT","MOL_Soldier_LAT","MOL_Soldier_HAT","MOL_Soldier_AA"];
			BTC_type_TL               = "MOL_Soldier_Officer";
			BTC_type_crewmen          = "MOL_Soldier_Crew";
			BTC_type_pilots           = "MOL_Soldier_Pilot";
			BTC_type_medic            = "MOL_Soldier_Medic";
			BTC_type_sniper           = "MOL_Soldier_Sniper";
			BTC_type_para             = ["MOL_Soldier_Commando","MOL_Soldier_Commando"];
			BTC_type_vehicles         = ["ibr_T55","T72_MOL","ibr_datsun_molblk","BMP2_MOL","ibr_datsun_mol"];
			BTC_type_motorized        = ["Ural_MOL","Ural_MOL"];
			BTC_type_heli             = ["Mi24_V"];
			BTC_type_heli_transport   = ["Mi17_Ins"];
		};
		case 3://RU
		{
			BTC_type_units            = ["RU_Soldier_AT","RU_Soldier_MG","RU_Soldier_GL","RU_Soldier_Marksman","RU_Soldier_LAT","RU_Soldier_Medic","RU_Soldier_AA","RU_Soldier_AR","RU_Soldier2","MVD_Soldier_AT","MVD_Soldier_MG","MVD_Soldier_GL","MVD_Soldier"];
			BTC_type_TL               = "RU_Soldier_Officer";
			BTC_type_crewmen          = "RU_Soldier_Crew";
			BTC_type_pilots           = "RU_Soldier_Pilot";
			BTC_type_medic            = "RU_Soldier_Medic";
			BTC_type_sniper           = "RU_Soldier_Sniper";
			BTC_type_para             = ["MVD_Soldier_TL","MVD_Soldier_AT","MVD_Soldier_MG","MVD_Soldier_GL","MVD_Soldier","RUS_Commander","RUS_Soldier1","RUS_Soldier2","RUS_Soldier3","RUS_Soldier_TL"];
			BTC_type_vehicles         = ["BMP3","BTR90","BTR90_HQ","2S6M_Tunguska","T72_RU","T90","GAZ_Vodnik","GAZ_Vodnik_HMG","UAZ_AGS30_RU"];
			BTC_type_motorized        = ["BMP3","BTR90","BTR90","KamazOpen","Kamaz"];
			BTC_type_heli             = ["Ka52","Ka52Black","Mi24_P","Mi24_V","Mi17_rockets_RU"];
			BTC_type_heli_transport   = ["Mi24_P","Mi24_V","Mi17_rockets_RU"];
		};
		case 4://TK Army
		{
			BTC_type_units            = ["TK_Soldier_AA_EP1","TK_Soldier_AAT_EP1","TK_Soldier_AMG_EP1","TK_Soldier_HAT_EP1","TK_Soldier_AR_EP1","TK_Soldier_Engineer_EP1","TK_Soldier_GL_EP1","TK_Soldier_MG_EP1","TK_Soldier_Medic_EP1","TK_Soldier_Officer_EP1","TK_Soldier_EP1","TK_Soldier_B_EP1","TK_Soldier_LAT_EP1","TK_Soldier_AT_EP1","TK_Soldier_Night_1_EP1","TK_Soldier_Night_2_EP1"];
			BTC_type_TL               = "TK_Soldier_Officer_EP1";
			BTC_type_crewmen          = "TK_Soldier_Crew_EP1";
			BTC_type_pilots           = "TK_Soldier_Pilot_EP1";
			BTC_type_medic            = "TK_Soldier_Medic_EP1";
			BTC_type_sniper           = "TK_Soldier_SniperH_EP1";
			BTC_type_para             = ["TK_Special_Forces_MG_EP1","TK_Special_Forces_EP1","TK_Special_Forces_TL_EP1"];
			BTC_type_vehicles         = ["BMP2_TK_EP1","BMP2_HQ_TK_EP1","BRDM2_TK_EP1","BRDM2_ATGM_TK_EP1","BTR60_TK_EP1","M113_TK_EP1","T34_TK_EP1","T55_TK_EP1","T72_TK_EP1","ZSU_TK_EP1","LandRover_MG_TK_EP1","UAZ_MG_TK_EP1","UAZ_AGS30_TK_EP1","LandRover_SPG9_TK_EP1","Ural_ZU23_TK_EP1"];
			BTC_type_motorized        = ["V3S_TK_EP1","M113_TK_EP1","V3S_Open_TK_EP1","BMP2_TK_EP1","BTR60_TK_EP1"];
			BTC_type_heli             = ["Mi24_D_TK_EP1"];
			BTC_type_heli_transport   = ["Mi24_D_TK_EP1","Mi17_TK_EP1","UH1H_TK_EP1"];
		};
		case 5://TK Militia
		{
			BTC_type_units            = ["TK_INS_Soldier_AR_EP1","TK_INS_Bonesetter_EP1","TK_INS_Soldier_MG_EP1","TK_INS_Soldier_2_EP1","TK_INS_Soldier_EP1","TK_INS_Soldier_3_EP1","TK_INS_Soldier_AAT_EP1","TK_INS_Soldier_AT_EP1","TK_INS_Soldier_TL_EP1","TK_INS_Soldier_4_EP1","TK_INS_Soldier_AA_EP1"];
			BTC_type_TL               = "TK_INS_Warlord_EP1";
			BTC_type_crewmen          = "TK_Soldier_Crew_EP1";
			BTC_type_pilots           = "TK_Soldier_Pilot_EP1";
			BTC_type_medic            = "TK_INS_Bonesetter_EP1";
			BTC_type_sniper           = "TK_INS_Soldier_Sniper_EP1";
			BTC_type_para             = ["TK_INS_Soldier_AR_EP1","TK_INS_Bonesetter_EP1","TK_INS_Soldier_MG_EP1","TK_INS_Soldier_2_EP1","TK_INS_Soldier_EP1","TK_INS_Soldier_3_EP1","TK_INS_Soldier_AAT_EP1","TK_INS_Soldier_AT_EP1","TK_INS_Soldier_TL_EP1","TK_INS_Soldier_4_EP1","TK_INS_Soldier_AA_EP1","TK_INS_Warlord_EP1"];
			BTC_type_vehicles         = ["LandRover_MG_TK_INS_EP1","BTR40_MG_TK_INS_EP1","LandRover_SPG9_TK_INS_EP1"];
			BTC_type_motorized        = ["BTR40_TK_INS_EP1","BTR40_MG_TK_INS_EP1","BTR90","UralOpen_INS","Ural_INS"];
			BTC_type_heli             = ["Mi24_D_TK_EP1","Mi17_TK_EP1","UH1H_TK_EP1"];
			BTC_type_heli_transport   = ["Mi24_D_TK_EP1","Mi17_TK_EP1","UH1H_TK_EP1"];
		};
	};
	true
};