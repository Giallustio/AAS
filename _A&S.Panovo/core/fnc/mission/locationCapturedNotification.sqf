
_name = _this select 0;
_id = _this select 1;

_task = player getVariable str(_id);
_task setTaskState "SUCCEEDED";
["TaskSucceeded",["Task accomplished!",format ["%1 has been captured!",_name]]] call bis_fnc_showNotification;