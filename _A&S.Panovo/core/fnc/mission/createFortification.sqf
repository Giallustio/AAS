/*
btc_fortifications = [
	"Gun",
	"MG",
	"MG_low",
	"Trench_Big",
	"Trench_Small"
];

	Trench_Big1
	Trench_Small1
	Trench_Gun1
	Trench_Mortar
	Trench_Mg2
	Trench_Mg1
	Land_WW2_bunker_gun_mg
	Land_WW2_bunker_gun_r
	Land_WW2_bunker_gun_l
*/
/*
	[getpos this, 20 ] call BIS_fnc_ObjectsGrabber;
	[pos, dir , array] call BIS_fnc_ObjectsMapper; 
[
	["Trench_Gun1",[0,0,0],0,1,0,[],"","",true,false], 
	["LIB_Zis3",[-0.395508,0.946289,0.477712],0,1,0,[],"","",true,false]
]

[
	["Trench_Mg2",[0,0,0],0,1,0,[],"","",true,false], 
	["lib_maxim_m30_base",[-0.594727,0.866211,0.00439215],0,1,0,[],"","",true,false]
]

[
	["Trench_Mg1",[0,0,0],0,1,0,[],"","",true,false], 
	["LIB_Maxim_M30_Trench",[-1.05347,2.98047,1.1068],0,1,0,[],"","",true,false]
]

[
	["LIB_BM37",[0.280762,0.524414,0.0991006],0,1,0,[],"","",true,false], 
	["Trench_Mortar",[0,0,0],0,1,0,[],"","",true,false]
]

*/

_pos = _this select 0;
_type = _this select 1;
_newObjs = [];

if (typeName _type isEqualTo "ARRAY") then {_type = selectrandom _type;};

switch (_type) do {
	case "Mortar" : {_newObjs = [["LIB_BM37",[0.280762,0.524414,0.0991006],0,1,0,[],"","",true,false],["Trench_Mortar",[0,0,0],0,1,0,[],"","",true,false]]};
	case "Trench_Big" : {_newObjs = [["Trench_Big1",[0,0,0],0,1,0,[],"","",true,false]]};
	case "Trench_Small" : {_newObjs = [["Trench_Small1",[0,0,0],0,1,0,[],"","",true,false]]};
	case "Gun" : {_newObjs = [["Trench_Gun1",[0,0,0],0,1,0,[],"","",true,false],["LIB_Zis3",[-0.395508,0.946289,0.477712],0,1,0,[],"","",true,false]]};
	case "MG" : {_newObjs = [["Trench_Mg1",[0,0,0],0,1,0,[],"","",true,false],["LIB_Maxim_M30_Trench",[-1.05347,2.98047,1.1068],0,1,0,[],"","",true,false]]};
	case "MG_low" : {_newObjs = [["Trench_Mg2",[0,0,0],0,1,0,[],"","",true,false],["lib_maxim_m30_base",[-0.594727,0.866211,0.00439215],0,1,0,[],"","",true,false]]};
};

_return = [_pos, (_pos getDir btc_loc_prev) , _newObjs] call btc_fnc_objectsMapper;


{
	if (_x emptyPositions "gunner" > 0) then {
		private ["_group","_unit"];
		_group = createGroup btc_enemy_side;
		_unit = _group createUnit [(selectRandom btc_type_units), getPos _x, [], 0, "NONE"];
		_unit moveinGunner _x;_unit assignAsGunner _x;
		if (btc_AI_setSkill) then {_group call btc_fnc_ai_setSkill;};
	};
	if (count (_x buildingPos -1) > 0) then {
		private "_group";
		_group = createGroup btc_enemy_side;
		{
			if (random 1 > 0.2) then {
				_unit = _group createUnit [(selectRandom btc_type_units), _x, [], 0, "NONE"];
				_unit setUnitPos "UP";
				doStop _unit;
				_unit setDir (_unit getDir btc_loc_prev);
				_unit setPos _x;
			};
		} foreach (_x buildingPos -1);
		_group setBehaviour "AWARE";
		_group setCombatMode "RED";
		if (btc_AI_setSkill) then {_group call btc_fnc_ai_setSkill;};
	};
} foreach _return;

_return