
sleep 1;//Avoid initialization problems

if (btc_arty_player && player getVariable ["btc_arty_operator",false]) then {
	player addaction [("<t color=""#ED2744"">") + ("Request artillery") + "</t>",{(_this select 3) call btc_fnc_actions_requestArtillery},0,0,false,false,"","btc_arty_available"];
};

_list = (getMarkerPos btc_marker_respawn) nearObjects [btc_gearObjectType, 60];
{_x addAction ["<t color='#ff1111'>Arsenal</t>", "[] spawn BIS_fnc_arsenal;"];} foreach _list;

_list = (getMarkerPos btc_marker_respawn) nearObjects [btc_combatSupportObjectType, 60];
{_x addAction ["<t color='#ff1111'>Request vehicles</t>", "0 spawn btc_fnc_cs_handle;"];} foreach _list;