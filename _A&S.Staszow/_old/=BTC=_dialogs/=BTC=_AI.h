class BTC_recruit
{
	idd = 1111;
	movingEnable = 1;
	onLoad = "[1000,BTC_recruitable_units] spawn BTC_Fill_list;";
	objects[] = {};
	class controlsBackground 
	{
		class Main_menu
		{
			idc = -1;
			type = 0;
			style = 48;
			x = 0;
			y = 0;
			w = 1.93;
			h = 1.3;
			colorText[] = {1, 1, 1, 1};
			colorBackground[] = {0,0,0,0};
			text = "\ca\ui\data\ui_mainmenu_background_ca.paa";
			font = "Zeppelin32";
			sizeEx = 0.032;	
		};
	};
	class controls 
	{
		class Close : Button 
		{
			idc = -1;
			text = "Close"; 
			action = "closeDialog 0;";
			x = 0.7;
			y = 0.9;
			default = true;
		};
		class Side_scroll : RscComboBox 
		{
			idc = 1000;
			x = 0.02; 
			y = 0.16;
			w = 0.25; 
			h = 0.04;
			onLBSelChanged = "[1001, format [""%1"", getText (configFile >> ""cfgVehicles"" >> lbText [1000,lbCurSel 1000] >> ""displayName"")]] spawn BTC_ctrlText;_spawn = [] spawn BTC_recruitable_get_cost;[1111,1004] spawn BTC_Get_Group_Composition;";
		};
		class Confirmed : Button 
		{
			idc = -1;
			text = "Confirmed"; 
			action = "[] spawn BTC_spawn_unit;";
			x = 0.011;
			y = 0.8;
			default = true;
		};
		class Display_name : BTC_Text 
		{
			x = 0.015;
			y = 0.13;
			w = 0.55;
			h = 0.2;
			idc = 1001;
			sizeEx = 0.035;
			colorBackground[] = {1, 1, 1, 0};
			colorText[] = {0.543, 0.5742, 0.4102, 1};
			text = "";
		};
		class Cost_text : BTC_Text 
		{
			x = 0.015;
			y = 0.18;
			w = 0.55;
			h = 0.2;
			idc = 1002;
			sizeEx = 0.035;
			colorBackground[] = {1, 1, 1, 0};
			colorText[] = {0.543, 0.5742, 0.4102, 1};
			text = "";
		};
		class Money_text : BTC_Text 
		{
			x = 0.015;
			y = 0.23;
			w = 0.55;
			h = 0.2;
			idc = 1003;
			sizeEx = 0.035;
			colorBackground[] = {1, 1, 1, 0};
			colorText[] = {0.543, 0.5742, 0.4102, 1};
			text = "";
		};
		class Group_Composition_text : BTC_Text 
		{
			x = 0.015;
			y = 0.28;
			w = 0.55;
			h = 0.2;
			sizeEx = 0.035;
			colorBackground[] = {1, 1, 1, 0};
			colorText[] = {0.543, 0.5742, 0.4102, 1};
			text = "Group composition:";
		};
		class Group_Composition : StructuredText
		{
			x = 0.02;
			y = 0.40;
			w = 0.55;
			h = 0.2;
			idc = 1004;
			sizeEx = 0.025;
			colorBackground[] = {1, 1, 1, 0};
			colorText[] = {0.543, 0.5742, 0.4102, 1};
			text = "";
		};
		class Credit : BTC_Text 
		{
			x = 0.02;
			y = 0.9;
			w = 0.55;
			h = 0.2;
			sizeEx = 0.035;
			colorBackground[] = {1, 1, 1, 0};
			colorText[] = {0.543, 0.5742, 0.4102, 1};
			text = "Created by Giallustio";
		};
	};
};