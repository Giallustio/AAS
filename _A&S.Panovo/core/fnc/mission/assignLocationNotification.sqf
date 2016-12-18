
_name = _this select 0;
_id = _this select 1;
_pos = _this select 2;

_task = player createSimpleTask [("Capture " + _name)];
_task setSimpleTaskDescription [("Capture " + _name),("Capture " + _name),("Capture " + _name)];
_task setSimpleTaskDestination _pos;
player setVariable [str(_id),_task];
["TaskAssigned",["New task assigned!",("Capture " + _name)]] call bis_fnc_showNotification;
