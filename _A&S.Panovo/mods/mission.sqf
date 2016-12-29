/*
	Created by Giallustio

*/

/*
_type_units_n = (paramsArray select 13);

btc_player_side        = independent;
btc_enemy_side         = west;
btc_marker_respawn     = "respawn_guerrila";//format ["respawn_%1",btc_player_side];
btc_marker_respawn_en  = format ["respawn_%1",btc_enemy_side];

btc_custom_loc = [
//EXAMPLE: [[13132.8,3315.07,0.00128174],"NameVillage","Mountain 1",800,800,true]
	[getMarkerPos "loc_1","NameVillage","Sector 1",400,400,true],
	[getMarkerPos "loc_2","NameVillage","Sector 2",500,350,true],
	[getMarkerPos "loc_3","NameVillage","Sector 3",400,400,true],
	[getMarkerPos "loc_4","NameVillage","Sector 4",400,400,true],
	[getMarkerPos "loc_5","NameVillage","Sector 5",400,400,true],
	[getMarkerPos "loc_6","NameVillage","Sector 6",400,400,true]
];
//Var
if (isServer) then {

};
//Mission
btc_startLocations       = ["btc_startLocation_1","btc_startLocation_1","btc_startLocation_1","btc_startLocation_1"];
btc_arty_radios = ["B_LIB_US_Radio"];

//Combat Support

btc_gearObjectType = "LIB_BasicWeaponsBox_US";
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
			"LIB_US_Willys_MB",80
		],
		[
			//"Trucks"
			"LIB_US6_Open",100
		],
		[
			//"APC"
			"LIB_US_M3_Halftrack",200,
			"LIB_US_Scout_M3",150,
			"LIB_US_Scout_M3_FFV",150

		],
		[
			//"Tanks"
			"LIB_M4A3_75",1000
		]
	]
];

btc_enemy_men             = "SoldierWB";
btc_friendly_men          = "SoldierGB";

btc_fortifications = [
	"Gun",
	"MG",
	"MG_low",
	"Trench_Big",
	"Trench_Small1"
];

switch (_type_units_n) do 
{
	case 0://GER
	{
		btc_type_units            = ["LIB_GER_mgunner","LIB_GER_scout_ober_rifleman","LIB_GER_ober_rifleman","LIB_GER_rifleman","LIB_GER_AT_grenadier","LIB_GER_scout_rifleman"];
		btc_type_TL               = "LIB_GER_unterofficer";
		btc_type_crewmen          = "SG_sturmpanzer_crew";
		btc_type_pilots           = "LIB_GER_rifleman";
		btc_type_medic            = "LIB_GER_medic";
		btc_type_sniper           = "LIB_GER_scout_sniper";
		//btc_type_para             = ["Ins_Soldier_1","Ins_Soldier_2","Ins_Soldier_GL","Ins_Soldier_MG","Ins_Soldier_Medic","Ins_Soldier_AT","Ins_Soldier_Sab","Ins_Soldier_AR"];
		btc_type_tanks            = ["LIB_PzKpfwIV_H","LIB_StuG_III_G","LIB_PzKpfwV"];
		btc_type_apc              = ["LIB_SdKfz251","LIB_SdKfz_7","LIB_SdKfz_7_AA","LIB_Kfz1_MG42","LIB_SdKfz251_FFV","LIB_SOV_M3_Halftrack"];
		btc_type_motorized        = ["LIB_Kfz1_MG42","LIB_SdKfz251_FFV","LIB_opelblitz_open_y_camo","LIB_opelblitz_tent_y_camo"];
	};
};

btc_baseComposition       = [["LIB_FlagCarrier_USA",[11.6509,-8.6543,0],0,1,0,[],"","",true,false],["WoodChair",[15.448,-2.60327,0],335.382,1,0,[],"","",true,false], ["WoodChair",[15.2256,-4.61279,0.0124569],221.116,1,0,[],"","",true,false], ["Land_WoodenCrate_01_F",[15.8391,-3.67651,-0.00398684],207.52,1,0,[],"","",true,false],["Land_GerRadio",[15.8296,-4.23169,0],340.583,1,0,[],"","",true,false], ["Land_WW2_Zeltbahn",[-15.2422,-8.02563,0],258.456,1,0,[],"","",true,false],["Land_WW2_Zeltbahn",[-17.6416,1.01904,0],47.3424,1,0,[],"","",true,false],	["Land_tent_east",[17.7727,-1.97852,0],279.868,1,0,[],"","",true,false], ["Land_WW2_BigHBarrier",[9.2146,-17.1284,0],320.415,1,0,[],"","",true,false],["Land_WW2_Zeltbahn",[-18.8896,-5.65161,0],308.298,1,0,[],"","",true,false], ["Land_WW2_BigHBarrier",[-5.16113,19.8381,0],320.415,1,0,[],"","",true,false],["Land_WW2_BigHBarrier",[-22.4038,2.9812,0],107.872,1,0,[],"","",true,false], ["Land_WW2_BigHBarrier",[-20.2666,10.7251,0],107.872,1,0,[],"","",true,false], ["Land_WW2_BigHBarrier",[-7.54028,-22.2471,0.00531387],198.265,1,0,[],"","",true,false], ["Land_WW2_bunker_mg",[-14.7441,-18.1899,0],14.5361,1,0,[],"","",true,false], ["Land_WW2_BigHBarrier",[22.8555,-9.33789,0],288.148,1,0,[],"","",true,false], ["Land_WW2_BigHBarrier",[0.292236,-24.6316,0.0106258],198.265,1,0,[],"","",true,false], ["Land_WW2_bunker_mg",[-16.7686,18.0313,0],107.247,1,0,[],"","",true,false], ["Land_WW2_BigHBarrier",[25.0298,-1.60425,0],288.148,1,0,[],"","",true,false], ["Land_WW2_bunker_mg",[18.7146,-16.3408,0],287.122,1,0,[],"","",true,false], ["Land_WW2_BigHBarrier",[-24.7627,-5.02197,0],107.872,1,0,[],"","",true,false], ["Land_WW2_BigHBarrier",[3.89917,25.8096,0],198.265,1,0,[],"","",true,false], ["Land_WW2_BigHBarrier",[11.6284,23.6194,0],198.265,1,0,[],"","",true,false], ["Land_WW2_BigHBarrier",[27.427,6.3877,0.0102444],288.148,1,0,[],"","",true,false], ["LIB_MG42_Lafette_trench",[-16.7996,-22.802,1.23466],193.621,1,0,[],"","",true,false], ["Land_WW2_BigHBarrier",[8.27905,-27.0452,0],198.265,1,0,[],"","",true,false], ["Land_WW2_bunker_mg",[18.7234,21.0386,0],198.648,1,0,[],"","",true,false], ["Land_WW2_BigHBarrier",[-4.08765,28.2231,0.0106258],198.265,1,0,[],"","",true,false], ["Land_WW2_BigHBarrier",[-22.8979,-17.4646,0],198.265,1,0,[],"","",true,false], ["LIB_MG42_Lafette_trench",[-21.5979,19.5024,1.20499],286.332,1,0,[],"","",true,false], ["LIB_MG42_Lafette_trench",[23.3965,-18.228,1.205],106.207,1,0,[],"","",true,false], ["Land_WW2_BigHBarrier",[-27.0935,-12.8706,0],107.872,1,0,[],"","",true,false], ["Land_WW2_BigHBarrier",[25.9185,18.95,0],198,1,0,[],"","",true,false], ["Land_WW2_BigHBarrier",[-11.9202,30.6077,0.00531387],198.265,1,0,[],"","",true,false], ["Land_WW2_BigHBarrier",[29.7957,14.2249,0.0049324],288.148,1,0,[],"","",true,false],["LIB_MG42_Lafette_trench",[20.6819,25.7844,1.20499],17.7326,1,0,[],"","",true,false],["Land_WW2_BigHBarrier",[16.0083,-29.2354,0],198.265,1,0,[],"","",true,false]];


//Arsenal
call compile preprocessFile "mods\arsenal.sqf";
*/