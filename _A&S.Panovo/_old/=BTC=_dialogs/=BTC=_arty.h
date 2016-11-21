class BTC_arty_dialog
{
	idd = -1;
	movingEnable = 1;
	onLoad = "[5550,[""HE"",""SMOKE"",""ILLUM"",""WP""]] spawn BTC_Fill_list;[5551,[""W"",""E""]] spawn BTC_Fill_list;[5552,[""N"",""S""]] spawn BTC_Fill_list;[5553,""0""] spawn BTC_ctrlText;[5554,""0""] spawn BTC_ctrlText;";
	objects[] = {};
	class controlsBackground 
	{
		class Main_menu
		{
			idc = -1;
			type = 0;
			style = 48;
			x = 0;
			y = 0.057;//001
			w = 0.5;
			h = 0.4;//85
			colorText[] = {1, 1, 1, 1};
			colorBackground[] = {0,0,0,0};
			text = "\ca\ui\data\ui_mainmenu_background_ca.paa";
			font = "Zeppelin32";
			sizeEx = 0.032;	
		};
	};
	class controls 
	{
		class Confirmed : Button 
		{
			idc = -1;
			text = "Confirmed"; 
			action = "BTC_chosen = true;";
			x = 0;
			y = 0.32;//62
			h = 0.09;
			default = true;
		};
		class Arty_type_T : BTC_Text 
		{
			x = 0;
			y = 0.033;
			w = 0.55;
			h = 0.16;
			sizeEx = 0.035;
			colorBackground[] = {1, 1, 1, 0};
			colorText[] = {0.543, 0.5742, 0.4102, 1};
			text = "Shell type:";
		};
		class Pos_T_1 : BTC_Text 
		{
			x = 0;
			y = 0.11;
			w = 0.55;
			h = 0.08;
			sizeEx = 0.035;
			colorBackground[] = {1, 1, 1, 0};
			colorText[] = {0.543, 0.5742, 0.4102, 1};
			text = "Target location";
		};
		class Pos_T_2 : BTC_Text 
		{
			x = 0;
			y = 0.137;
			w = 0.55;
			h = 0.08;
			sizeEx = 0.035;
			colorBackground[] = {1, 1, 1, 0};
			colorText[] = {0.543, 0.5742, 0.4102, 1};
			text = "from your position:";
		};
		class Pos_T_3 : BTC_Text 
		{
			x = 0;
			y = 0.18;
			w = 0.55;
			h = 0.08;
			sizeEx = 0.035;
			colorBackground[] = {1, 1, 1, 0};
			colorText[] = {0.543, 0.5742, 0.4102, 1};
			text = "x-axis:";
		};
		class Pos_T_4 : BTC_Text 
		{
			x = 0;
			y = 0.23;
			w = 0.55;
			h = 0.08;
			sizeEx = 0.035;
			colorBackground[] = {1, 1, 1, 0};
			colorText[] = {0.543, 0.5742, 0.4102, 1};
			text = "y-axis:";
		};
		class Arty_type_L : RscComboBox 
		{
			idc = 5550;
			x = 0.15; 
			y = 0.1;
			w = 0.1; 
			h = 0.03;
		};
		class E_W : RscComboBox 
		{
			idc = 5551;
			x = 0.08; 
			y = 0.20;
			w = 0.06; 
			h = 0.025;
		};
		class N_S : RscComboBox 
		{
			idc = 5552;
			x = 0.08; 
			y = 0.253;
			w = 0.06; 
			h = 0.025;
		};
		class E_W_Field : RscEdit
		{
			idc = 5553;
			x = 0.15;
			y = 0.202;
			w = 0.1;
			h = 0.03;
		};
		class N_S_Field : RscEdit
		{
			idc = 5554;
			x = 0.15;
			y = 0.252;
			w = 0.1;
			h = 0.03;
		};
	};
};