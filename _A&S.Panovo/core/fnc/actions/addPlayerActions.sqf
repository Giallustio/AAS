
if (btc_arty_player && {(typeOf player isEqualTo btc_role_radio) || (player getVariable ["btc_arty_operator",false])}) then {
	player addaction [("<t color=""#ED2744"">") + ("Request artillery") + "</t>",{(_this select 3) call btc_fnc_actions_requestArtillery},0,0,false,false,"","btc_arty_available"];
};

if ((btc_recruitableAI_def isEqualTo 1 && {typeOf player isEqualTo btc_role_sl})) then {
	player addaction [("<t color=""#ED2744"">") + ("Recruit AI") + "</t>",{0 call btc_fnc_cs_handleAI}];
};
if (btc_recruitableAI_def isEqualTo 2) then {
	player addaction [("<t color=""#ED2744"">") + ("Recruit AI") + "</t>",{0 call btc_fnc_cs_handleAI},0,0,false,false,"","(leader group player) isEqualTo player)"];
};

true