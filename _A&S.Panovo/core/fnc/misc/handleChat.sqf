
switch (_this select 0) do {
	case 0 : {
		(_this select 1) sideChat format ["HQ, this is %1! Requesting artillery support in grid %2! Over", (_this select 1), mapGridPosition (_this select 2)];
	};
	case 1 : {
		[btc_player_side,"HQ"] sideChat "Target acquired! The battery is opening fire!";
	};
	case 2 : {
		[btc_player_side,"HQ"] sideChat "Artillery is available again!";
	};
};