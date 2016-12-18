
btc_loc_active setVariable ["captured",true];
btc_locs_captured = btc_locs_captured + 1;

//Check if finished
//if (btc_locs_captured >= btc_locs_max) then {};


//msg
[(btc_loc_active getvariable ["name", "error"]),(btc_loc_active getvariable ["id", -1])] remoteExec ["btc_fnc_mission_locationCapturedNotification",0]; 

//marker
_markers = btc_loc_active getvariable ["markers", ["",""]];
(_markers select 0) setMarkerColor "colorGreen";
deleteMarker (_markers select 1);
//clear

[] call btc_fnc_mission_assignLocation;