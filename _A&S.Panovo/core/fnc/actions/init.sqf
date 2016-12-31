
sleep 2;//Avoid initialization problems

[] call btc_fnc_actions_addPlayerActions;

_list = (getMarkerPos btc_marker_respawn) nearObjects [btc_gearObjectType, 60];
{_x addAction ["<t color='#ff1111'>Arsenal</t>", "[] spawn BIS_fnc_arsenal;"];} foreach _list;

_list = (getMarkerPos btc_marker_respawn) nearObjects [btc_combatSupportObjectType, 60];
{_x addAction ["<t color='#ff1111'>Request vehicles</t>", "0 spawn btc_fnc_cs_handle;"];} foreach _list;