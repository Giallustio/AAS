	_mortar = _this select 0;
	_pos    = _this select 1;
	_EH     = _mortar addEventHandler ["fired", {deletevehicle (nearestobject[_this select 0, _this select 4])}];
	(gunner _mortar) lookAt _pos;
	for "_i" from 0 to (BTC_arty_salvo - 1) do
	{
		_mortar setVehicleAmmo 1;
		_mortar fire (weapons _mortar select 0);
		sleep 2;
	};
	sleep (10 + random 5); 
	for "_i" from 0 to (BTC_arty_salvo - 1) do
	{	
		_bullet = "ARTY_Sh_81_HE" createVehicle [(_pos select 0)+ (random BTC_arty_dispersion - random BTC_arty_dispersion), (_pos select 1)+ random (random BTC_arty_dispersion - random BTC_arty_dispersion), (_pos select 2)+ 100];  
		sleep 2;
	};
	_mortar setVehicleAmmo 1;
	_mortar removeAllEventHandlers "fired";