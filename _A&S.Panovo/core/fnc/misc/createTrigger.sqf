
private ["_pos","_area","_act","_stat","_trg"];

_pos    = _this select 0;
_area   = _this select 1;
_act    = _this select 2;
_stat   = _this select 3;

_trg = createTrigger ["EmptyDetector", _pos];
_trg setTriggerArea _area;
_trg setTriggerActivation _act;
_trg setTriggerStatements _stat;

_trg