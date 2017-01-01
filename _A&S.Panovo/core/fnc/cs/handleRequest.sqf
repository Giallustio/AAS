
switch (_this select 0) do {

//Send request to server: _asker,_type,_money
//While waiting prevent new request, pending status
	case 0 : {
		if !(isNil "btc_cs_isRequestPending") exitWith {hint "A request is already pending!"};
		private ["_asker","_type","_cost"];
		_asker = _this select 1;
		_type = _this select 2;
		_cost = _this select 3;
		btc_cs_isRequestPending = true;
		[1,_asker,_type,_cost] remoteExec ["btc_fnc_cs_handleRequest",2]; 
	};
//Server, find the SL, send request
	case 1 : {
		_sl = objNull;
		{if (typeOf _x isEqualTo btc_role_sl) then {_sl = _x}} foreach playableUnits;
		if (isNull _sl) exitWith {
			[4] remoteExec ["btc_fnc_cs_handleRequest",owner (_this select 1)];
		};
		private ["_asker","_type","_cost"];
		_asker = _this select 1;
		_type = _this select 2;
		_cost = _this select 3;
		[2,_asker,_type,_cost] remoteExec ["btc_fnc_cs_handleRequest",owner _sl];
	};
	case 2 : {
		private ["_asker","_type","_cost","_text","_time"];
		
		_asker = _this select 1;
		_type = _this select 2;
		_cost = _this select 3;
		
		_text = format ["%1 requested a %2. It costs %3 $. Use your scroll wheel actions to accept/refuse his request",name _asker,(getText (configFile >> "cfgVehicles" >> _type >> "displayName")),_cost];
		hint _text;
		["TaskAssigned",["",_text]] call bis_fnc_showNotification;
		
		_time = time + 120;

		_id_1 = player addaction [("<t color=""#ED2744"">") + ("Accept") + "</t>",{btc_cs_request = true;}];
		_id_2 = player addaction [("<t color=""#ED2744"">") + ("Refuse") + "</t>",{btc_cs_request = false;}];
		player setVariable ["cs_action_1",_id_1];
		player setVariable ["cs_action_2",_id_2];
		
		waitUntil {!(isNil "btc_cs_request") || time > _time};

		player removeAction (player getVariable ["cs_action_1",nil]);
		player removeAction (player getVariable ["cs_action_2",nil]);
		player setVariable ["cs_action_1",nil];
		player setVariable ["cs_action_2",nil];
		
		if (time > _time || !(btc_cs_request)) then {
			[3,false] remoteExec ["btc_fnc_cs_handleRequest",owner _asker];
		} else {
			"Your request has been accepted" remoteExec ["hint",owner _asker];
			[_type, btc_combatSupportPos,0,_cost] remoteExec ["btc_fnc_cs_create", 2];
			[3,true] remoteExec ["btc_fnc_cs_handleRequest",owner _asker];
		};
		btc_cs_request = nil;
	};
	case 3 : {
		if (_this select 1) then {hint "Your request has been accepted!"} else {hint "Your request has been refused!";};
		btc_cs_isRequestPending = nil;
	};
	case 4 : {
		hint "No one selected the commander role. Your request can not be processed";
		btc_cs_isRequestPending = nil;
	};
};

