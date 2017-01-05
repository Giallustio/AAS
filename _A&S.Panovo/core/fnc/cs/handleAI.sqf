
_subClassId = 71;
_moneyId = 72;
_costId = 73;

_money = btc_money;

switch (_this) do {
	case 0 : {
		//Open
		if ({!isPlayer _x} count units (group player) > btc_recruitableAI_max) exitWith {hint "You can't recruit more AI"};
		createDialog "btc_combatSupportAI_dialog";
		2 call btc_fnc_cs_handleAI;
		
		ctrlSetText [_moneyId, format ["Budget: %1 $", _money]];

	};
	case 1 : {
		//Confirm

		_type = lbData [_subClassId, lbCurSel _subClassId];

		_id_sub = (btc_recruitableAI_type find _type) + 1;
		_cost = btc_recruitableAI_type select _id_sub;
		
		if (btc_money >= _cost) then {		
			//closeDialog 0;
			_type createUnit [getMarkerPos btc_marker_respawn, group player];
			_display = getText (configFile >> "cfgVehicles" >> _type >> "displayName");
			hint format ["You have recruited a %1 at %2 $",_display,_cost];
			
			if ({!isPlayer _x} count units (group player) > btc_recruitableAI_max) then {closeDialog 0};
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
		for "_i" from 0 to ((count btc_recruitableAI_type) - 1) do {
			private ["_class","_display"];
			_class = (btc_recruitableAI_type select _i);
			if (typeName _class isEqualTo "STRING") then {
				_display = getText (configFile >> "cfgVehicles" >> _class >> "displayName");
				_index = lbAdd [_subClassId,_display];
				lbSetData [_subClassId, _index, _class];
				if (_i == 0) then {lbSetCurSel [_subClassId,_index];};
			};
		};
	}; 
	case 3 : {
		
		_subClassName = lbData [_subClassId, lbCurSel _subClassId];
		
		_id_sub = (btc_recruitableAI_type find _subClassName) + 1;
		_cost = btc_recruitableAI_type select _id_sub;
		ctrlSetText [_costId, format ["Cost: %1 $", _cost]];
	};
};