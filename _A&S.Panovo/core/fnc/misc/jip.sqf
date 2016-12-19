
/*
2016/12/16, 15:39:09 "Client connected"
2016/12/16, 15:39:09 [5.21041e+007,"7xxxxxxxxxxxxxxx1","longbow",false,4]
2016/12/16, 15:39:34  Mission id: 5071d20b183e9580d0ee4f95f413ca18681d6165
2016/12/16, 15:39:34 "Client connected"
2016/12/16, 15:39:34 [2,"","__SERVER__",false,2]
-------------------------
id: Number - unique DirectPlay ID (very large number). It is also the same id used for user placed markers (same as _id param)
uid: String - getPlayerUID of the joining client. The same as Steam ID (same as _uid param)
name: String - profileName of the joining client (same as _name param)
jip: Boolean - didJIP of the joining client (same as _jip param)
owner: Number - owner id of the joining client (same as _owner param)
*/
private ["_jip","_owner"];

_jip = _this select 3;
_owner = _this select 4;

if (_jip) then {
	[(btc_loc_active getvariable ["name", "error"]),(btc_loc_active getvariable ["id", -1]),position btc_loc_active] remoteExec ["btc_fnc_mission_assignLocationNotification",_owner];
};