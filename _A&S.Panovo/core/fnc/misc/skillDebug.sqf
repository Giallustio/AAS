switch (_this) do {
	case false : {
		//Media
		_general = 0;
		_aimingAccuracy = 0;
		_aimingShake = 0;
		_aimingSpeed = 0;
		_endurance = 0;
		_spotDistance = 0;
		_spotTime = 0;
		_courage = 0;
		_reloadSpeed 0;
		_commanding = 0;
		_n = 0;
		{
			if !(isPlayer _x) then {
				_general = _general + (_x skillFinal "general");
				_aimingAccuracy = _aimingAccuracy + (_x skillFinal "aimingAccuracy");
				_aimingShake = _aimingShake + (_x skillFinal "aimingShake");
				_aimingSpeed = _aimingSpeed + (_x skillFinal "aimingSpeed");
				_endurance = _endurance + (_x skillFinal "endurance");
				_spotDistance = _spotDistance + (_x skillFinal "spotDistance");
				_spotTime = _spotTime + (_x skillFinal "spotTime");
				_courage = _courage + (_x skillFinal "courage");
				_reloadSpeed _reloadSpeed + (_x skillFinal "reloadSpeed");
				_commanding = _commanding + (_x skillFinal "commanding");
				_n = _n + 1;				
			};
		} foreach allUnits;
		
		diag_log "----------------------------";
		diag_log format ["Numbers of AI: %1", _n];
		diag_log format ["general -> %1", _general / _n];
		diag_log format ["aimingAccuracy -> %1",_aimingAccuracy / _n];
		diag_log format ["aimingShake -> %1",_aimingShake / _n];
		diag_log format ["aimingSpeed -> %1",_aimingSpeed / _n];
		diag_log format ["endurance -> %1",_endurance / _n];
		diag_log format ["spotDistance -> %1",_spotDistance / _n];
		diag_log format ["spotTime -> %1",_spotTime / _n];
		diag_log format ["courage -> %1",_courage / _n];
		diag_log format ["reloadSpeed -> %1",_reloadSpeed / _n];
		diag_log format ["commanding -> %1",_commanding / _n];
		diag_log "----------------------------";		
	};
	case true : {
		//Allunits
		{
			diag_log format ["%1: general -> %2",_x, _x skillFinal "general"];
			diag_log format ["%1: aimingAccuracy -> %2",_x, _x skillFinal "aimingAccuracy"];
			diag_log format ["%1: aimingShake -> %2",_x, _x skillFinal "aimingShake"];
			diag_log format ["%1: aimingSpeed -> %2",_x, _x skillFinal "aimingSpeed"];
			diag_log format ["%1: endurance -> %2",_x, _x skillFinal "endurance"];
			diag_log format ["%1: spotDistance -> %2",_x, _x skillFinal "spotDistance"];
			diag_log format ["%1: spotTime -> %2",_x, _x skillFinal "spotTime"];
			diag_log format ["%1: courage -> %2",_x, _x skillFinal "courage"];
			diag_log format ["%1: reloadSpeed -> %2",_x, _x skillFinal "reloadSpeed"];
			diag_log format ["%1: commanding -> %2",_x, _x skillFinal "commanding"];
			diag_log "----------------------------";
		} foreach allUnits;
	};
};
