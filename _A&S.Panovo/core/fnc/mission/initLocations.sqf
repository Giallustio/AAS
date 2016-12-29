
private ["_locations","_cities"];

_locations = configfile >> "cfgworlds" >> worldname >> "names";

_cities = ["NameVillage","NameCity","NameCityCapital","NameLocal","Hill","NameMarine"];//
btc_locs = [];

if !(btc_customLocOnly) then {
	for "_i" from 0 to (count _locations - 1) do {
		private ["_current","_type"];
		_current = _locations select _i;

		_type = gettext(_current >> "type");
		if (_type in _cities) then {
			private ["_id","_city","_position","_name","_position","_radius_x","_radius_y","_has_en","_trigger"];
			_id = count btc_locs;
			_position = getarray(_current >> "position");
			_name = getText(_current >> "name");
			_radius_x = getNumber(_current >> "RadiusA");
			_radius_y = getNumber(_current >> "RadiusB");

			if (btc_loc_blacklist find _name >= 0) exitWith {};

			if (_position distance getMarkerPos btc_marker_respawn < btc_safeArea) exitWith {};

			_city = "Land_Ammobox_rounds_F" createVehicle _position;
			_city hideObjectGlobal true;
			_city allowDamage false;
			_city enableSimulation false;
			
			_city setVariable ["id",_id];
			_city setVariable ["captured",false];
			_city setVariable ["name",_name];
			_city setVariable ["RadiusX",_radius_x];
			_city setVariable ["RadiusY",_radius_y];
			

			btc_locs set [_id,_city];

			if (btc_debug) then	{
				private ["_marker"];
				_marker = createmarker [format ["loc_%1",_id],_position];
				_marker setMarkerShape "ELLIPSE";
				_marker setMarkerBrush "SolidBorder";
				_marker setMarkerSize [(_radius_x+_radius_y) + btc_loc_radius, (_radius_x+_radius_y) + btc_loc_radius];
				_marker setMarkerAlpha 0.3;
				//_marker setmarkertype "mil_dot";
				_marker setmarkercolor "colorRed";
				//_marker setmarkeralpha 0.5;
				_marke = createmarker [format ["locn_%1",_id],_position];
				_marke setmarkertype "mil_dot";
				_marke setmarkertext format ["loc_%3 %1 %2",_name,_type,_id];
			};
		};
	};
};

if !(isNil "btc_custom_loc") then {
	{_x call btc_fnc_mission_createLocation} foreach btc_custom_loc;
};