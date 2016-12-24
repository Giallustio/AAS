
[getMarkerPos btc_marker_respawn, 0 , btc_baseComposition] call btc_fnc_objectsMapper;

btc_baseObject = "Land_Ammobox_rounds_F" createVehicle (getMarkerPos btc_marker_respawn);
btc_baseObject hideObjectGlobal true;
btc_baseObject allowDamage false;
btc_baseObject enableSimulation false;

btc_gearObject = btc_gearObjectType createVehicle [((getMarkerPos btc_marker_respawn) select 0) + 10,((getMarkerPos btc_marker_respawn) select 1) - 7,0];
btc_gearObject allowDamage false;
clearWeaponCargoGlobal btc_gearObject;
clearMagazineCargoGlobal btc_gearObject;
[btc_gearObject] remoteExec ["btc_fnc_addArsenal", 0, true]; //Not -2 (SP)

btc_combatSupportObject = btc_combatSupportObjectType createVehicle [((getMarkerPos btc_marker_respawn) select 0) + 26.281,((getMarkerPos btc_marker_respawn) select 1) - 13.697,0];
btc_combatSupportObject setDir 62;
[btc_combatSupportObject] remoteExec ["btc_fnc_cs_addAction", 0, true];

btc_combatSupportPos = btc_combatSupportObject modelToWorld [12,12,0];
publicVariable "btc_combatSupportPos";

["vehiclesPoint",btc_combatSupportPos,[0.85,0.85],"ICON","mil_dot","","ColorBlue","Vehicles point",1] call btc_fnc_createMarker;

[getMarkerPos btc_marker_respawn, [100,100,0,false], [str (btc_enemy_side), "PRESENT", true], ["this", "{_x setDamage 1;} foreach thisList", ""]] call btc_fnc_createTrigger;
