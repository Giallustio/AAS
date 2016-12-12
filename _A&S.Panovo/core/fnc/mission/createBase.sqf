
[getMarkerPos btc_marker_respawn, 0 , btc_baseComposition] call btc_fnc_objectsMapper;

btc_baseObject = "Land_Ammobox_rounds_F" createVehicle (getMarkerPos btc_marker_respawn);
btc_baseObject hideObjectGlobal true;
btc_baseObject allowDamage false;
btc_baseObject enableSimulation false;

btc_gearObject = "LIB_WeaponsBox_Big_GER" createVehicle
btc_gearObject allowDamage false;
clearWeaponCargoGlobal btc_gearObject;
clearMagazineCargoGlobal btc_gearObject;
[btc_gear_object] remoteExec ["btc_fnc_addArsenal", -2, true]; 

[getMarkerPos btc_marker_respawn, [100,100,0,false], [str (btc_enemy_side), "PRESENT", true], ["this", "{_x setDamage 1;} foreach thisList", ""]] spawn btc_fnc_createTrigger;
