
btc_role_sl = "LIB_GER_oberst";
btc_role_radio = "LIB_GER_radioman";

switch (_this select 0) do {

//Send request to server: _asker,_type,_money
//While waiting prevent new request, pending status
	case 0 : {
		[1,_asker,_type,_cost] remoteExec ["hint",2]; 
	};
//Server, find the SL, send request
	case 1 : {
		_sl = objNull;
		{if (typeOf _x isEqualTo btc_role_sl) then {_sl = _x}} foreach playableUnits;
		if (isNull _sl) exitWith {
			"No one selected the commander role. Your request can not be processed" remoteExec ["hint",owner (_this select 1)];
		};
		[2,_asker,_type,_cost] remoteExec ["hint",owner _sl];
	};
	case 2 : {
		_asker = _this select 1;
		_type = _this select 2;
		_cost = _this select 3;
		
		hint format ["%1 requested a %2. It costs %3 $. Use your scroll wheel actions to accept/refuse his request",name _asker,(getText (configFile >> "cfgVehicles" >> _type >> "displayName")),_money];
		_accpet = {
			player removeAction (player getVariable ["cs_action_1",nil]);
			player removeAction (player getVariable ["cs_action_2",nil]);
			player setVariable ["cs_action_1",nil];
			player setVariable ["cs_action_2",nil];
			[_type, btc_combatSupportPos,0,_cost] remoteExec ["btc_fnc_cs_create", 2];
		};
		
		_time = time + 120;
		
		waitUntil {!(isNil "btc_cs_request") || time > _time};
			
		player removeAction (player getVariable ["cs_action_1",nil]);
		player removeAction (player getVariable ["cs_action_2",nil]);
		player setVariable ["cs_action_1",nil];
		player setVariable ["cs_action_2",nil];
		
		if (time > _time || !(btc_cs_request)) then {
			"Your request has been refused" remoteExec ["hint",owner _asker];
		} else {
			"Your request has been accepted" remoteExec ["hint",owner _asker];
			[_type, btc_combatSupportPos,0,_cost] remoteExec ["btc_fnc_cs_create", 2];
		};
		btc_cs_request = nil;
	};

};








/*
_mainClassId = 70;
_subClassId = 71;
_moneyId = 72;
_costId = 73;

_money = btc_money;

switch (_this) do {
	case 0 : {
		//Open
		if (count (nearestObjects [btc_combatSupportPos,["All"],5]) > 1) exitWith {hint "Clear the area before create another object!"};

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
			[_type, btc_combatSupportPos,0,_cost] remoteExec ["btc_fnc_cs_create", 2];
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