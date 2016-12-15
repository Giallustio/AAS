
private ["_mortar","_pos","_EH","_shots"];

_mortar = _this select 0;
_pos    = _this select 1;
_EH     = _mortar addEventHandler ["fired", {deletevehicle (nearestobject[_this select 0, _this select 4])}];
(gunner _mortar) lookAt _pos;

_shots = btc_arty_shots + round (random 2 - random 2);

for "_i" from 1 to (_shots) do {
	_mortar setVehicleAmmo 1;
	_mortar fire (weapons _mortar select 0);
	sleep 2;
};
sleep (10 + random 5); 
for "_i" from 1 to (_shots) do {	
	_bullet = btc_arty_ammo createVehicle [(_pos select 0)+ (random btc_arty_dispersion - random btc_arty_dispersion), (_pos select 1)+ random (random btc_arty_dispersion - random btc_arty_dispersion), (_pos select 2)+ 100];
	_bullet setvelocity [0,0,-40];
	_sound = selectRandom ["mortar1","mortar2"];
	[_bullet,_sound] remoteExec ["say3d"]; 
	sleep 3;
};

_mortar setVehicleAmmo 1;
_mortar removeEventHandler ["fired", _EH];