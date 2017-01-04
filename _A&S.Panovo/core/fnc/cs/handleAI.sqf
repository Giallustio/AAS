
_subClassId = 71;
_moneyId = 72;
_costId = 73;

_money = btc_money;

switch (_this) do {
	case 0 : {
		//Open
		
		createDialog "btc_combatSupportAI_dialog";
		2 call btc_fnc_cs_handleAI;
		
		ctrlSetText [_moneyId, format ["Budget: %1 $", _money]];

	};
	case 1 : {
		//Confirm

		_type = lbData [_subClassId, lbCurSel _subClassId];

		_id_sub = (btc_recruitableAI find _type) + 1;
		_cost = btc_recruitableAI select _id_sub;
		
		if (btc_money >= _cost) then {		
			closeDialog 0;
			//Create
			/*if (typeOf player isEqualTo btc_role_sl) then {
				[_type, btc_combatSupportPos,0,_cost] remoteExec ["btc_fnc_cs_create", 2];
			} else {
				[0,player,_type,_cost] call btc_fnc_cs_handleAIRequest;
				//Send request
			};*/
		} else {hint "You don't have enough money for it!"};
	};
	case 2 : {
		//Load dlg
		lbClear _subClassId;
		for "_i" from 0 to ((count btc_recruitableAI) - 1) do {
			private ["_class","_display"];
			_class = (btc_recruitableAI select _i);
			if (typeName _class isEqualTo "STRING") then {
				_display = getText (configFile >> "cfgVehicles" >> _class >> "displayName");
				_index = lbAdd [_subClassId,_display];
				lbSetData [_subClassId, _index, _class];
				if (_i == 0) then {lbSetCurSel [_subClassId,_index];};
			};
		};
	}; 
	case 3 : {
		
		_mainClassName = lbText [_mainClassId,lbCurSel _mainClassId];
		_subClassName = lbData [_subClassId, lbCurSel _subClassId];
		_id = (btc_combatSupport select 0) find _mainClassName;
		_subClassArray = (btc_combatSupport select 1) select _id;
		
		_id_sub = (_subClassArray find _subClassName) + 1;
		_cost = _subClassArray select _id_sub;
		ctrlSetText [_costId, format ["Cost: %1 $", _cost]];
	};
};