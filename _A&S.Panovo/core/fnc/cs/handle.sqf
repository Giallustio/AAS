
_mainClassId = _mainClassId;
_subClassId = _subClassId;

switch (_this) do {
	case 0 : {
		//Open
		if (count (nearestObjects [[definedPos],["All"],5]) > 1) exitWith {hint "Clear the area before create another object!"};
		
		disableSerialization;
		closeDialog 0;
		createDialog "btc_log_dlg_create";
		3 call btc_fnc_cs_handle;//Put in dlg
		
		_class = lbData [_subClassId, lbCurSel _subClassId];
		_selected = _class;
		_new = _class createVehicleLocal definedPos;
		while {dialog} do {
			//if (_class != lbData [_subClassId, 1]) then
			if (_class != lbData [_subClassId, lbCurSel _subClassId]) then {
				deleteVehicle _new; sleep 0.1;
				_class = lbData [_subClassId, lbCurSel _subClassId];
				//_class = lbText [_subClassId,lbCurSel _subClassId];
				_selected = _class;
				_new = _class createVehicleLocal definedPos;
				//_new setDir (getDir btc_log_create_obj);
				_new setPos definedPos;
			};
			sleep 0.1;
		};
		deleteVehicle _new;
	};
	case 1 : {
		//Confirm
		//If you have money
		_type = lbData [_subClassId, lbCurSel _subClassId];
		closeDialog 0;
		[_type, definedPos] remoteExec ["createVehicle", 2];
	};
	case 2 : {
		//Load listbox
		lbClear _mainClassId;
		_main_class = btc_construction_array select 0;
		_sub_class  = btc_construction_array select 1;
		for "_i" from 0 to ((count _main_class) - 1) do	{
			_lb = lbAdd [_mainClassId,(_main_class select _i)];if (_i == 0) then {lbSetCurSel [_mainClassId,_lb];};
		};
		_category = _sub_class select 0;
		lbClear _subClassId;
		for "_i" from 0 to ((count _category) - 1) do {
			private ["_class","_display"];
			_class = (_category select _i);
			_display = getText (configFile >> "cfgVehicles" >> _class >> "displayName");
			//_lb = lbAdd [_subClassId,_display];
			//lbSetData [_subClassId, _i, _class];
			_index = lbAdd [_subClassId,_display];
			lbSetData [_subClassId, _index, _class];
			if (_i == 0) then {lbSetCurSel [_subClassId,_index];};
		};
	};
	case 3 : {
		//Change target
		_var = lbText [_mainClassId,lbCurSel _mainClassId];
		_main_class = btc_construction_array select 0;
		_sub_class  = btc_construction_array select 1;
		_id = _main_class find _var;
		_category = _sub_class select _id;
		lbClear _subClassId;
		for "_i" from 0 to ((count _category) - 1) do {
			private ["_class","_display","_index"];
			_class = (_category select _i);
			_display = getText (configFile >> "cfgVehicles" >> _class >> "displayName");
			//_lb = lbAdd [_subClassId,_display];
			_index = lbAdd [_subClassId,_display];
			lbSetData [_subClassId, _index, _class];
			if (_i == 0) then {lbSetCurSel [_subClassId,_index];};
		};
	};

};

true