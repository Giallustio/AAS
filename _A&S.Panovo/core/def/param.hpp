class Params {
    class btc_p_time {
	//paramsArray[0]
        title = "Set the start time:";
		values[]={1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24}; 
		texts[]={"1","2","3","4","5","6","7","8","9","10","11","12","13","14","15","16","17","18","19","20","21","22","23","24"}; 
		default = 12; 
	};
    class btc_p_acctime {
	//paramsArray[1]
        title = "Acceleration time multiplier:";
		values[]={1,2,3,4,5,6,7,8,9,10,11,12}; 
		texts[]={"1","2","3","4","5","6","7","8","9","10","11","12"}; 
		default = 5; 
	};
	class btc_p_load {
    //paramsArray[2]
        title = "Load the savegame (if available)";
        values[]={0,1}; 
        texts[]={"No","Yes"}; 
        default = 1; 
    };
    class btc_p_gameMode {
	//paramsArray[3]
        title = "Game mode?";
        values[] = {0, 1};
        texts[] = {"A&S classic", "A&S random first location"};
        default = 0;
	};	
    class btc_p_baseLocation {
	//paramsArray[4]
        title = "Base location?";
        values[] = {0, 1, 2, 3, 4, 5, 100};
        texts[] = {"Chaman", "Loy Manara Airport", "Rasman Airport", "Nur", "West of Tumurkalay", "Par-e Siah Oilfield", "Random"};
        default = 100;
	};
	class btc_p_enemyPlayer {
	//paramsArray[5]
        title = "Game mode type?";
        values[] = {0, 1, 2};
        texts[] = {"PVE", "PVP (4:1 ratio)", "PVP (No ratio"};
        default = 0;
	};
    class btc_p_arty {
	//paramsArray[6]
        title = "Enemy artillery?";
        values[] = {0, 1};
        texts[] = {"No", "Yes"};
        default = 1;
	};
    class btc_p_player_arty {
	//paramsArray[7]
        title = "Artillery support?";
        values[] = {0, 1};
        texts[] = {"No", "Yes"};
        default = 1;
	};
    class btc_p_rallypoint {
	//paramsArray[8]
        title = "Rally Point?";
		values[]={0,1}; 
		texts[]={"No","Yes"}; 
		default = 1; 
	};
    class btc_p_redeploy {
	//paramsArray[9]
        title = "Allow re-deploy?";
		values[]={0,1}; 
		texts[]={"No","Yes"}; 
		default = 1; 
	};
    class btc_p_respawnOnTL {
	//paramsArray[10]
        title = "Respawn on TL?";
		values[]={0,1}; 
		texts[]={"No","Yes"}; 
		default = 1; 
	};
	class btc_p_dynamicGroups {
	//paramsArray[11]
        title = "Dynamic Groups?";
		values[]={0,1}; 
		texts[]={"No","Yes"}; 
		default = 1; 
	};
    class btc_p_recruitment {
	//paramsArray[12]
        title = "AI recruitment?";
        values[] = {0, 1, 2};
        texts[] = {"No", "Only SL", "All TLs"};
        default = 1;
	};
	class btc_p_en {
	//paramsArray[13]
        title = "Enemy type:";
		values[]={0}; 
		texts[]={"USSR"}; 
		default = 0; 
	};
    class btc_p_en_ratio {
	// paramsArray[14]
        title = "Enemy ratio?";
        values[] = {0,1,2,3};
        texts[] = {"Balanced","Low","Medium","High"};
        default = 0;
    };
    class btc_p_en_infantryOnly {
	// paramsArray[15]
        title = "Infantry only?";
        values[] = {0,1};
        texts[] = {"No","Yes"};
        default = 0;
    };
    class btc_p_rinf {
	//paramsArray[16]
        title = "Enemy reinforcement?";
        values[] = {0, 1};
        texts[] = {"No", "Yes"};
        default = 1;
	};
	class btc_p_med_sys {
	//paramsArray[17]
		title = "Medic system";
		values[] = {0,1,2};
		texts[] = {"No","BI","ACE"};
		default = 1;
	};
	class btc_p_med_level {
		//paramsArray[18]
	   title = "Medical Level (ACE)";
	   values[] = {1,2};
	   texts[] = {"Basic","Advanced"};
	   default = 1;
	};
	class btc_p_adv_wounds {
		//paramsArray[19]
	   title = "Advanced Wounds";
	   values[] = {0,1};
	   texts[] = {"Off","On"};
	   default = 1;
	};
	class btc_p_rev {
    //paramsArray[20]
        title = "Revive time:";
        values[]={0,60,120,180,240,300,600,900,1200,999999}; 
        texts[]={"0","60","120","180","240","300","600","900","1200","999999"}; 
        default = 600; 
    };
    class btc_p_set_skill {
	//paramsArray[21]
        title = "Set skill?";
		values[]={0,1}; 
		texts[]={"No","Yes"}; 
		default = 1; 
	};
    class btc_p_set_skill_general {
	//paramsArray[22]
        title = "Set skill: general";
		values[]={0,1,2,3,4,5,6,7,8,9,10,20,30,40,50,60,70,80,90,100}; 
		texts[]={"0","0.1","0.2","0.3","0.4","0.5","0.6","0.7","0.8","0.9","1","2","3","4","5","6","7","8","9","10"}; 
		default = 0; 
	};
    class btc_p_set_skill_aimingAccuracy {
	//paramsArray[23]
        title = "Set skill: aimingAccuracy";
		values[]={0,1,2,3,4,5,6,7,8,9,10,20,30,40,50,60,70,80,90,100}; 
		texts[]={"0","0.1","0.2","0.3","0.4","0.5","0.6","0.7","0.8","0.9","1","2","3","4","5","6","7","8","9","10"}; 
		default = 1; 
	};
    class btc_p_set_skill_aimingShake {
	//paramsArray[24]
        title = "Set skill: aimingShake";
		values[]={0,1,2,3,4,5,6,7,8,9,10,20,30,40,50,60,70,80,90,100}; 
		texts[]={"0","0.1","0.2","0.3","0.4","0.5","0.6","0.7","0.8","0.9","1","2","3","4","5","6","7","8","9","10"}; 
		default = 7; 
	};
    class btc_p_set_skill_aimingSpeed {
	//paramsArray[25]
        title = "Set skill: aimingSpeed";
		values[]={0,1,2,3,4,5,6,7,8,9,10,20,30,40,50,60,70,80,90,100}; 
		texts[]={"0","0.1","0.2","0.3","0.4","0.5","0.6","0.7","0.8","0.9","1","2","3","4","5","6","7","8","9","10"}; 
		default = 2; 
	};
    class btc_p_set_skill_endurance {
	//paramsArray[26]
        title = "Set skill: endurance";
		values[]={0,1,2,3,4,5,6,7,8,9,10,20,30,40,50,60,70,80,90,100}; 
		texts[]={"0","0.1","0.2","0.3","0.4","0.5","0.6","0.7","0.8","0.9","1","2","3","4","5","6","7","8","9","10"}; 
		default = 7; 
	};
    class btc_p_set_skill_spotDistance {
	//paramsArray[27]
        title = "Set skill: spotDistance";
		values[]={0,1,2,3,4,5,6,7,8,9,10,20,30,40,50,60,70,80,90,100}; 
		texts[]={"0","0.1","0.2","0.3","0.4","0.5","0.6","0.7","0.8","0.9","1","2","3","4","5","6","7","8","9","10"}; 
		default = 100; 
	};
    class btc_p_set_skill_spotTime {
	//paramsArray[28]
        title = "Set skill: spotTime";
		values[]={0,1,2,3,4,5,6,7,8,9,10,20,30,40,50,60,70,80,90,100}; 
		texts[]={"0","0.1","0.2","0.3","0.4","0.5","0.6","0.7","0.8","0.9","1","2","3","4","5","6","7","8","9","10"}; 
		default = 100; 
	};
    class btc_p_set_skill_courage {
	//paramsArray[29]
        title = "Set skill: courage";
		values[]={0,1,2,3,4,5,6,7,8,9,10,20,30,40,50,60,70,80,90,100}; 
		texts[]={"0","0.1","0.2","0.3","0.4","0.5","0.6","0.7","0.8","0.9","1","2","3","4","5","6","7","8","9","10"}; 
		default = 1; 
	};
    class btc_p_set_skill_reloadSpeed {
	//paramsArray[30]
        title = "Set skill: reloadSpeed";
		values[]={0,1,2,3,4,5,6,7,8,9,10,20,30,40,50,60,70,80,90,100}; 
		texts[]={"0","0.1","0.2","0.3","0.4","0.5","0.6","0.7","0.8","0.9","1","2","3","4","5","6","7","8","9","10"}; 
		default = 20; 
	};
    class btc_p_set_skill_commanding {
	//paramsArray[31]
        title = "Set skill: commanding";
		values[]={0,1,2,3,4,5,6,7,8,9,10,20,30,40,50,60,70,80,90,100}; 
		texts[]={"0","0.1","0.2","0.3","0.4","0.5","0.6","0.7","0.8","0.9","1","2","3","4","5","6","7","8","9","10"}; 
		default = 80; 
	};
    class btc_p_debug {
	//paramsArray[32]
        title = "Debug:";
		values[]={0,1,2}; 
		texts[]={"No","Yes", "Log only"}; 
		default = 0; 
	};
};
