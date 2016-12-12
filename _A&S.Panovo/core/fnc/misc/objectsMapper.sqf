/*
	File: objectMapper.sqf
	Author: Joris-Jan van 't Land

	Description:
	Takes an array of data about a dynamic object template and creates the objects.

	Parameter(s):
	_this select 0: position of the template - Array [X, Y, Z]
	_this select 1: azimuth of the template in degrees - Number 
	_this select 2: objects for the template - Array / composition class - String / tag list - Array
	_this select 3: (optional) randomizer value (how much chance each object has of being created. 0.0 is 100% chance) - Number

	Returns:
	Created objects (Array)
*/

private ["_pos", "_azi", "_objs", "_rdm"];
_pos = _this select 0;
_azi = _this select 1;
_objs = _this select 2;

private ["_newObjs"];

_newObjs = [];

private ["_posX", "_posY"];
_posX = _pos select 0;
_posY = _pos select 1;

//Function to multiply a [2, 2] matrix by a [2, 1] matrix
private ["_multiplyMatrixFunc"];
_multiplyMatrixFunc = {
	private ["_array1", "_array2", "_result"];
	_array1 = _this select 0;
	_array2 = _this select 1;

	_result = [
		(((_array1 select 0) select 0) * (_array2 select 0)) + (((_array1 select 0) select 1) * (_array2 select 1)),
		(((_array1 select 1) select 0) * (_array2 select 0)) + (((_array1 select 1) select 1) * (_array2 select 1))
	];

	_result
};

{
	private ["_type", "_relPos", "_azimuth", "_fuel", "_damage", "_orientation", "_varName", "_init", "_simulation", "_ASL", "_newObj"];
	_type = _x select 0;
	_relPos = _x select 1;
	_azimuth = _x select 2;

	//Optionally map certain features for backwards compatibility
	if ((count _x) > 3) then {_fuel = _x select 3};
	if ((count _x) > 4) then {_damage = _x select 4};
	if ((count _x) > 5) then {_orientation = _x select 5};
	if ((count _x) > 6) then {_varName = _x select 6};
	if ((count _x) > 7) then {_init = _x select 7};
	if ((count _x) > 8) then {_simulation = _x select 8};
	if ((count _x) > 9) then {_ASL = _x select 9};
	if (isNil "_ASL") then {_ASL = false;};
	
	//Rotate the relative position using a rotation matrix
	private ["_rotMatrix", "_newRelPos", "_newPos"];
	_rotMatrix = [
		[cos _azi, sin _azi],
		[-(sin _azi), cos _azi]
	];
	_newRelPos = [_rotMatrix, _relPos] call _multiplyMatrixFunc;
	
	//Backwards compatability causes for height to be optional
	private ["_z"];
	if ((count _relPos) > 2) then {_z = _relPos select 2} else {_z = 0};
	
	_newPos = [_posX + (_newRelPos select 0), _posY + (_newRelPos select 1), _z];

	//Create the object and make sure it's in the correct location
	_newObj = _type createVehicle _newPos;
	_newObj setDir (_azi + _azimuth);
	if (!_ASL) then {_newObj setPos _newPos;} else {_newObj setPosASL _newPos; _newObj setVariable ["BIS_DynO_ASL", true];};

	//If fuel and damage were grabbed, map them
	if (!isNil "_fuel") then {_newObj setFuel _fuel};
	if (!isNil "_damage") then {_newObj setDamage _damage;};
	if (!isNil "_orientation") then {
		if ((count _orientation) > 0) then {
			([_newObj] + _orientation) call BIS_fnc_setPitchBank;
		};
	};
	if (!isNil "_varName") then {
		if (_varName != "") then {
			_newObj setVehicleVarName _varName;
			call (compile (_varName + " = _newObj;"));
		};
	};
	if (!isNil "_init") then {_newObj call (compile ("this = _this; " + _init));}; //TODO: remove defining this hotfix?
	if (!isNil "_simulation") then {_newObj enableSimulation _simulation; _newObj setVariable ["BIS_DynO_simulation", _simulation];};
	
	_newObjs = _newObjs + [_newObj];
} forEach _objs;

_newObjs