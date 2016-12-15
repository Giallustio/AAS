	
_pos = _this select 0;	
	
_pos = [_loc, 300] call btc_fnc_randomizePos;
_pos = [_pos, 0, 100, 10, 0, 60 * (pi / 180), 0] call BIS_fnc_findSafePos;

_mortar = objNull;

_return = [_pos,"Mortar"] call btc_fnc_mission_createFortification;	

//If iskindof statics then mortar

//_return

/*
might be useful
[quote name='Larrow']Trouble with that script from TacticalGamer is that it is only setup to spot playableunits (players or AI in a player slot).

Ive made a quick rewrite of the script , you can now pass it the Spotter and an array of artillery units. ( I was bored and seemed like something interesting to do for an hour)
Side to attack is automatically anyone that is unfriendly to the spotter.
Spotted units can be any unit not just players
Placed a few checks in the script to make sure spotter is a man and that artillery units are artillery units :/
Could be taken further allowing specifying number of rounds and firing/reload delays.

[php]//////////////////////////////////
// _nul = [ UNIT, [mortar1, mortar2] ] exeVM "mortar_spotter.sqf;
//
// UNIT - a valid unit to serve as the artillery spotter
// [mortar1, .. ] - an array of artillary units
//////////////////
//Rewritten from original concept by Unkl on the TacticalGamer forum http://www.tacticalgamer.com/script-bin/194107-arma-3-enemy-mortar-team-script.html
/////

private ["_spotter","_mortars","_sideToAttack","_targets"];

_spotter = [_this, 0, objNull, [objNull] ] call BIS_fnc_param;
_mortars = [_this, 1, [], [[]] ] call BIS_fnc_param;

if ( isNull _spotter || { !((typeOf _spotter) isKindOf "MAN") } ) then { "You must supply a unit for the spotter" call BIS_fnc_error; };
if ( count _mortars < 1 ) then { "You must supply atleast one mortar" call BIS_fnc_error; };
{
if ( !( "Artillery" in (getArray (configfile >> "CfgVehicles" >> typeOf _x >> "availableForSupportTypes")) ) ) then {
(format ["Mortar %1 is not a valid Artillary support unit",_forEachIndex]) call BIS_fnc_error;
};
}forEach _mortars;

_sideToAttack = [];
{
if (_x getFriend (side _spotter) < 0.6 ) then {
_sideToAttack set [count _sideToAttack, _x];
};
}forEach [opfor,west,independent];

while { { alive _x; }count _mortars > 0 } do {

_targets = [];
{
if (side _x in _sideToAttack && { alive _x && _spotter knowsAbout _x > 1 } ) then {
_targets set [count _targets, _x];
};
} forEach allUnits;


if (count _targets > 0) then {

_chosenTarget = _targets select (floor (random (count _targets)));

{
if (alive _x) then {
_x commandArtilleryFire [getPos _chosenTarget, (magazines _x) select 0, floor (random 6)+1];
sleep 15;
};
}forEach _mortars;
sleep ((floor random 30) + 45);

};

sleep 10;
};
*/
	
//if (btc_debug) then {diag_log format ["btc_fnc_mission_populateLocation defenders %1",_n];};
	
	private ["_mortar","_fired","_targets_list","_mortar"];
	
	_mortar = _this select 0;
	_fired  = false;
	sleep 120;
	while {{Alive _x} count crew _mortar > 0} do {
		{
			if (!_fired && {side _x == BTC_enemy_side}) then {
				_targets_list = leader _x nearTargets 1500;
				if ({_x select 2 == BTC_player_side} count _targets_list > 0) then {
					{if (_x select 2 == BTC_player_side && !_fired && (count (nearestObjects [(_x select 0), [BTC_enemy_men], 100]) == 0) && (_x select 0) distance _mortar < 3500) then {if (BTC_debug == 1) then {hint format ["Get target %1 - %2",_mortar, mapGridPosition (_x select 0)];};[_mortar,_x select 0] spawn BTC_fire_mortar;_fired = true;}} foreach _targets_list;
				};
			};
		} foreach allGroups;
		if (_fired) then {private ["_players"];_players = call BTC_get_players_n;switch (true) do {case (_players < 5) :{sleep 300;};case (_players >= 5 && _players < 10):{sleep 180;};case (_players >= 10):{sleep 120;};};} else {sleep 5;};
		_fired = false;
	};