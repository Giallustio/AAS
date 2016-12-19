
//If not exitWith? -> move cond to action
/*
	2100 combo arty type
	2101 edit axis x
	2102 edit axis y
*/


switch (_this) do {
	case 0 : {
		//Open menu
		_dlg = createDialog "btc_arty_dialog";
		{lbAdd [2100, _x];} foreach ["HE","SMOKE","ILLUM"];
		lbSetCurSel [2100,0];
		hint "Select the artillery type mission, insert the offset from your position in meters and confirm!";
	};
	case 1 : {
		//Confirm request
		private ["_type","_x_number","_y_number","_pos"];
		_type = lbText [2100,lbCurSel 2100];
		_x_number = ctrlText 2101;
		_y_number = ctrlText 2102;
		closeDialog 0;
		_pos = position player;
		call compile format ["btc_arty_offsetX = %1;", _x_number];
		call compile format ["btc_arty_offsetY = %1;", _y_number];
		if (typeName btc_arty_offsetx != "SCALAR" || typeName btc_arty_offsetY != "SCALAR") exitWith {hint "Invalid target coordinations";};
		
		_pos = [(_pos select 0) + btc_arty_offsetx,(_pos select 1) + btc_arty_offsetY,0];
		
		[_type,_pos] remoteExec ["btc_fnc_actions_fireArtillery",2];
	};
};