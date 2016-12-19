
private ["_type","_pos","_id","_mag","_shots"];

_type = _this select 0;
_pos = _this select 1;

_dispersion = 75;
_shots = 5;

//Msg

sleep (30 + random 10);

_id = _type find (btc_arty_magazine select 0);
_mag = (btc_arty_magazine select 1) select _id;

for "_i" from 1 to (_shots) do {
	private "_bullet";
	_bullet = _mag createVehicle [(_pos select 0)+ (random _dispersion - random _dispersion), (_pos select 1)+ random (random _dispersion - random _dispersion), (_pos select 2)+ 100];
	_bullet setvelocity [0,0,-40];
	if !(_type isEqualTo "SMOKE") then {
		private "_sound";
		_sound = selectRandom ["mortar1","mortar2"];
		[_bullet,_sound] remoteExec ["say3d"];
	};
	sleep 3;
};