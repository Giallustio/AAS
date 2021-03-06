
enableSaving [false, false]; 

call compile preprocessFile "core\def\mission.sqf";
call compile preprocessFile "mods\mission.sqf";

call compile preprocessFile "core\fnc\compile.sqf";

if (isServer) then {
	call compile preprocessFile "core\init_server.sqf";
};

//call compile preprocessFile "core\init_common.sqf";

if (!isDedicated) then {
	call compile preprocessFile "core\init_player.sqf";
};

diag_log format ["Advance & Secure version: %1",btc_version];