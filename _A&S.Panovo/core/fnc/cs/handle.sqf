
_mainClassId = 70;
_subClassId = 71;
_moneyId = 72;
_costId = 73;

_money = btc_money;

switch (_this) do {
	case 0 : {
		//Open
		if (count (nearestObjects [btc_combatSupportPos,["All"],5]) > 1) exitWith {hint "Clear the area before create another object!"};

		_cam = "camera" camCreate (player modelToWorld [0,0,3]);
		showCinemaBorder false;
		_cam camSetTarget btc_combatSupportPos;
		_cam cameraEffect ["internal", "back"];
		_cam camCommit 0;
		
		createDialog "btc_combatSupport_dialog";
		2 call btc_fnc_cs_handle;
		
		ctrlSetText [_moneyId, format ["Budget: %1 $", _money]];
		
		_class = lbData [_subClassId, lbCurSel _subClassId];
		_selected = _class;
		_new = _class createVehicleLocal btc_combatSupportPos;
		while {dialog} do {
			if (_class != lbData [_subClassId, lbCurSel _subClassId]) then {
				deleteVehicle _new; sleep 0.1;
				_class = lbData [_subClassId, lbCurSel _subClassId];
				_selected = _class;
				_new = _class createVehicleLocal btc_combatSupportPos;
				//_new setDir (getDir btc_log_create_obj);
				_new setPos btc_combatSupportPos;
			};
			if !(_money isEqualTo btc_money) then {ctrlSetText [_moneyId, format ["Budget: %1 $", _money]];_money = btc_money;};
			sleep 0.1;
		};
		deleteVehicle _new;
		_cam cameraEffect ["terminate","back"];
		camDestroy _cam;
	};
	case 1 : {
		//Confirm

		_type = lbData [_subClassId, lbCurSel _subClassId];

		_mainClassName = lbText [_mainClassId,lbCurSel _mainClassId];
		_type = lbData [_subClassId, lbCurSel _subClassId];
		_id = (btc_combatSupport select 0) find _mainClassName;
		_subClassArray = (btc_combatSupport select 1) select _id;
		
		_id_sub = (_subClassArray find _type) + 1;
		_cost = _subClassArray select _id_sub;
		
		if (btc_money >= _cost) then {		
			closeDialog 0;
			if (typeOf player isEqualTo btc_role_sl) then {
				[_type, btc_combatSupportPos,0,_cost] remoteExec ["btc_fnc_cs_create", 2];
			} else {
				[0,player,_type,_cost] call btc_fnc_cs_handleRequest;
				//Send request
			};
		} else {hint "You don't have enough money for it!"};
	};
	case 2 : {
		//Load dlg
		lbClear _mainClassId;
		_main_class = btc_combatSupport select 0;
		_sub_class  = btc_combatSupport select 1;
		for "_i" from 0 to ((count _main_class) - 1) do	{
			_lb = lbAdd [_mainClassId,(_main_class select _i)];
			if (_i == 0) then {lbSetCurSel [_mainClassId,_lb];};
		};
		_category = _sub_class select 0;
		lbClear _subClassId;
		for "_i" from 0 to ((count _category) - 1) do {
			private ["_class","_display"];
			_class = (_category select _i);
			if (typeName _class isEqualTo "STRING") then {
				_display = getText (configFile >> "cfgVehicles" >> _class >> "displayName");
				_index = lbAdd [_subClassId,_display];
				lbSetData [_subClassId, _index, _class];
				if (_i == 0) then {lbSetCurSel [_subClassId,_index];};
			};
		};
	}; 
	case 3 : {
		//Change mainClass
		_var = lbText [_mainClassId,lbCurSel _mainClassId];
		_main_class = btc_combatSupport select 0;
		_sub_class  = btc_combatSupport select 1;
		_id = _main_class find _var;
		_category = _sub_class select _id;
		lbClear _subClassId;
		for "_i" from 0 to ((count _category) - 1) do {
			private ["_class","_display","_index"];
			_class = (_category select _i);
			if (typeName _class isEqualTo "STRING") then {
				_display = getText (configFile >> "cfgVehicles" >> _class >> "displayName");
				_index = lbAdd [_subClassId,_display];
				lbSetData [_subClassId, _index, _class];
				if (_i == 0) then {lbSetCurSel [_subClassId,_index];};
			};
		};
	};
	case 4 : {
		
		_mainClassName = lbText [_mainClassId,lbCurSel _mainClassId];
		_subClassName = lbData [_subClassId, lbCurSel _subClassId];
		_id = (btc_combatSupport select 0) find _mainClassName;
		_subClassArray = (btc_combatSupport select 1) select _id;
		
		_id_sub = (_subClassArray find _subClassName) + 1;
		_cost = _subClassArray select _id_sub;
		ctrlSetText [_costId, format ["Cost: %1 $", _cost]];
	};
};