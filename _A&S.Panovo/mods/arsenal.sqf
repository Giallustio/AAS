/*
//Remove applied
[ missionNamespace, btc_arsenal_weapons ] call BIS_fnc_removeVirtualWeaponCargo;
[ missionNamespace, btc_arsenal_magazines ] call BIS_fnc_removeVirtualMagazineCargo;
[ missionNamespace, btc_arsenal_items ] call BIS_fnc_removeVirtualItemCargo;
[ missionNamespace, btc_arsenal_backpacks ] call BIS_fnc_removeVirtualBackpackCargo;

btc_arsenal_weapons = [
	"LIB_M1_Garand",
	"LIB_M1_Carbine",
	"LIB_M1918A2_BAR",
	"LIB_M1903A4_Springfield",
	"LIB_M1A1_Bazooka",
	"LIB_M1A1_Thompson",
	"LIB_Colt_M1911",
	"LIB_FLARE_PISTOL"
];

btc_arsenal_magazines = [
	"LIB_US_M18",
	"LIB_US_M18_Red",
	"LIB_US_M18_Green",
	"LIB_US_M18_Yellow",
	"LIB_7Rnd_45ACP",
	"LIB_30Rnd_45ACP",
	"LIB_8Rnd_762x63",
	"LIB_15Rnd_762x33",
	"LIB_20Rnd_762x63",
	"LIB_5Rnd_762x63",
	"LIB_1Rnd_60mm_M6",
	"lib_1Rnd_flare_white",
	"lib_1Rnd_flare_red",
	"lib_1Rnd_flare_green",
	"lib_1Rnd_flare_yellow"
];

btc_arsenal_items = [
	"Binocular",
//	"LIB_Binocular_SU",
//	"LIB_Binocular_GER",
	"LIB_Binocular_US",
	"LIB_Toolkit",
	"FirstAidKit",
	"Medikit",
	"ItemWatch",
	"ItemCompass",
	"ItemMap",
	"U_LIB_US_Private",
	"U_LIB_US_Private_1st",
	"U_LIB_US_Corp",
	"U_LIB_US_Sergant",
	"U_LIB_US_Snipe",
	"U_LIB_US_Eng",
	"U_LIB_US_Med",
	"U_LIB_US_Off",
	"U_LIB_US_Cap",
	
	"H_LIB_US_Helmet",
	"H_LIB_US_Helmet_Net",
	"H_LIB_US_Helmet_Med",
	"H_LIB_US_Helmet_Cap",
	"H_LIB_US_Helmet_First_lieutenant",
	"H_LIB_US_Helmet_Second_lieutenant",
	"H_LIB_US_Helmet_Tank",
	
	"V_LIB_US_Vest_Bar",
	"V_LIB_US_Vest_Asst_MG",
	"V_LIB_US_Vest_Carbine",
	"V_LIB_US_Vest_Carbine_eng",
	"V_LIB_US_Vest_Carbine_nco",
	"V_LIB_US_Vest_Garand",
	"V_LIB_US_Vest_Grenadier",
	"V_LIB_US_Vest_Medic",
	"V_LIB_US_Vest_Medic2",
	"V_LIB_US_Vest_Thompson",
	"V_LIB_US_Vest_Thompson_nco",
	"V_LIB_US_Vest_45"
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
	"B_LIB_US_Bag",
	"B_LIB_US_Radio"
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
*/