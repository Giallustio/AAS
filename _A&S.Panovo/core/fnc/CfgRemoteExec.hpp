class CfgRemoteExec {        
	class Functions {
		mode = 2;
		jip = 1;
		class btc_fnc_cs_addAction {allowedTargets=0;jip = 1;};
		class btc_fnc_jip {allowedTargets=0;jip = 1;};
		class btc_fnc_addArsenal {allowedTargets=0;jip = 1;};
	};        
// List of script commands allowed to be sent from client via remoteExec
class Commands {
		mode = 2;
		jip = 1;
		class sideChat { allowedTargets=0; jip=1; };
	};
};