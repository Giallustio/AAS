
btc_loc_active setVariable ["captured",true];
btc_locs_captured = btc_locs_captured + 1;

//Check if finished
//if (btc_locs_captured >= btc_locs_max) then {};


//msg
hint format ["%1 has been captured",btc_loc_active getvariable ["name", "error"]];


//marker
_markers = btc_loc_active getvariable ["markers", ["",""]];
(_markers select 0) setMarkerColor "colorGreen";
deleteMarker (_markers select 1);
//clear

[] call btc_fnc_mission_assignLocation;