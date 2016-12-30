
if (btc_arty_player && {typeOf player isEqualTo btc_role_radio}) then {
	player addaction [("<t color=""#ED2744"">") + ("Request artillery") + "</t>",{(_this select 3) call btc_fnc_actions_requestArtillery},0,0,false,false,"","btc_arty_available"];
};