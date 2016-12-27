
btc_arsenal_weapons = [
	"LIB_P38",
	"LIB_M1908",
	"LIB_FLARE_PISTOL",
	"LIB_MP40",
	"LIB_K98",
	"LIB_K98ZF39",
	"LIB_MP44",
	"LIB_G43",
	"LIB_MG42",
	"LIB_MLMG42",
	"LIB_PzFaust_30m",
	"LIB_RPzB"
];

btc_arsenal_magazines = [
	"lib_nb39",
	"lib_shg24",
	"lib_shg24x7",
	"lib_m39",
	"lib_pwm",
	"LIB_shumine_42_MINE_mag",
	"LIB_SMI_35_MINE_mag",
	"LIB_SMI_35_1_MINE_mag",
	"LIB_STMI_MINE_mag",
	"LIB_TMI_42_MINE_mag",
	"LIB_TM44_MINE_mag",
	"LIB_Ladung_PM_MINE_mag",
	"LIB_Ladung_Small_MINE_mag",
	"LIB_Ladung_Big_MINE_mag",
	"lib_8Rnd_9x19",
	"lib_1Rnd_flare_white",
	"lib_1Rnd_flare_red",
	"lib_1Rnd_flare_green",
	"lib_1Rnd_flare_yellow",
	"LIB_32Rnd_9x19",
	"lib_5Rnd_792x57",
	"lib_30Rnd_792x33",
	"lib_10Rnd_792x57",
	"lib_50Rnd_792x57",
	"lib_250Rnd_792x57",
	"1Rnd_LIB_PzFaust_30m",
	"LIB_1Rnd_RPzB"
];

btc_arsenal_items = [
	"Binocular",
//	"LIB_Binocular_SU",
	"LIB_Binocular_GER",
//	"LIB_Binocular_US",
	"LIB_Toolkit",
	"FirstAidKit",
	"Medikit",
	"ItemWatch",
	"ItemCompass",
	"ItemMap",
	"U_LIB_GER_Tank_crew_private",
	"U_LIB_GER_Tank_crew_unterofficer",
	"U_LIB_GER_Tank_crew_leutnant",
	"U_LIB_GER_Spg_crew_private",
	"U_LIB_GER_Spg_crew_unterofficer",
	"U_LIB_GER_Spg_crew_leutnant",
	"H_LIB_GER_TankOfficerCap",
	"H_LIB_GER_TankPrivateCap",
	"H_LIB_GER_SPGPrivateCap",
	"V_LIB_GER_TankPrivateBelt",
	"U_LIB_GER_Soldier_camo",
	"U_LIB_GER_Pionier",
	"U_LIB_GER_LW_pilot",
	"U_LIB_GER_Officer_camo",
	"U_LIB_GER_Funker",
	"U_LIB_GER_Schutze",
	"U_LIB_GER_Art_schutze",
	"U_LIB_GER_Oberschutze",
	"U_LIB_GER_Gefreiter",
	"U_LIB_GER_Unterofficer",
	"U_LIB_GER_Art_unterofficer",
	"U_LIB_GER_Recruit",
	"U_LIB_GER_Medic",
	"U_LIB_GER_Leutnant",
	"U_LIB_GER_Art_leutnant",
	"U_LIB_GER_Oberleutnant",
	"U_LIB_GER_Hauptmann",
	"U_LIB_GER_Oberst",
	"U_LIB_GER_Scharfschutze",
	"U_LIB_GER_MG_schutze",
	"H_LIB_GER_HelmetCamo",
	"H_LIB_GER_Helmet",
	"H_LIB_GER_OfficerCap",
	"H_LIB_GER_Cap",
	"H_LIB_GER_LW_PilotHelmet",
	"V_LIB_GER_VestMP40",
	"V_LIB_GER_VestSTG",
	"V_LIB_GER_VestKar98",
	"V_LIB_GER_VestG43",
	"V_LIB_GER_SniperBelt",
	"V_LIB_GER_VestMG",
	"V_LIB_GER_VestUnterofficer",
	"V_LIB_GER_FieldOfficer",
	"V_LIB_GER_OfficerVest",
	"V_LIB_GER_OfficerBelt",
	"V_LIB_GER_PrivateBelt"
];

if (btc_isAce) then {
	switch (ace_medical_level) do {
		case 1 : {
			btc_arsenal_items = btc_arsenal_items + [
				"ACE_fieldDressing",
				"ACE_morphine",
				"ACE_epinephrine",
				"ACE_bloodIV",
				"ACE_bloodIV_500",
				"ACE_bloodIV_250",
				"ACE_bodyBag"	
			];		
		};
		case 2 : {
			btc_arsenal_items = btc_arsenal_items + [
				"ACE_fieldDressing",
				"ACE_packingBandage",
				"ACE_elasticBandage",
				"ACE_tourniquet",
				"ACE_morphine",
				"ACE_adenosine",
				"ACE_atropine",
				"ACE_epinephrine",
				"ACE_plasmaIV",
				"ACE_plasmaIV_500",
				"ACE_plasmaIV_250",
				"ACE_salineIV",
				"ACE_salineIV_500",
				"ACE_salineIV_250",
				"ACE_bloodIV",
				"ACE_bloodIV_500",
				"ACE_bloodIV_250",
				"ACE_quikClot",
				"ACE_personalAidKit",
				"ACE_surgicalKit",
				"ACE_bodyBag"	
			];
		};
	};
};

btc_arsenal_backpacks = [
	"B_LIB_GER_A_frame",
	"B_LIB_GER_Radio",
	"B_LIB_GER_Backpack",
	"B_LIB_GER_MedicBackpack",
	"B_LIB_GER_LW_Paradrop",
	"B_LIB_GER_Panzer"
];

/////////////////Do not edit below\\\\\\\\\\\\\\\\\\

if ( count btc_arsenal_weapons isEqualTo 0 ) then {
	[ missionNamespace, true ] call BIS_fnc_addVirtualWeaponCargo;
} else {
	[ missionNamespace, btc_arsenal_weapons ] call BIS_fnc_addVirtualWeaponCargo;
};

if ( count btc_arsenal_magazines isEqualTo 0 ) then {
	[ missionNamespace, true ] call BIS_fnc_addVirtualMagazineCargo;
} else {
	[ missionNamespace, btc_arsenal_magazines ] call BIS_fnc_addVirtualMagazineCargo;
};

if ( count btc_arsenal_items isEqualTo 0 ) then {
	[ missionNamespace, true ] call BIS_fnc_addVirtualItemCargo;
} else {
	[ missionNamespace, btc_arsenal_items ] call BIS_fnc_addVirtualItemCargo;
};

if ( count btc_arsenal_backpacks isEqualTo 0 ) then {
	[ missionNamespace, true ] call BIS_fnc_addVirtualBackpackCargo;
} else {
	[ missionNamespace, btc_arsenal_backpacks ] call BIS_fnc_addVirtualBackpackCargo;
};