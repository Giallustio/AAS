class BTC_rally_point
{
	idd = -1;
	movingEnable = 1;
	onLoad = "";
	objects[] = {};
	class controlsBackground 
	{
		class Main_menu
		{
			idc = -1;
			type = 0;
			style = 48;
			x = 0.2;
			y = 0.3;
			w = 1.0;
			h = 0.2;
			colorText[] = {1, 1, 1, 1};
			colorBackground[] = {0,0,0,0};
			text = "\ca\ui\data\ui_mainmenu_background_ca.paa";
			font = "Zeppelin32";
			sizeEx = 0.032;	
		};
	};
	class controls 
	{
		class Move_button : Button 
		{
			idc = -1;
			text = "Yes"; 
			action = "_spawn = [] spawn BTC_move_to_rally_point;";
			x = 0.2;
			y = 0.36;
			default = true;
		};
		class Close : Button 
		{
			idc = -1;
			text = "No"; 
			action = "closeDialog 0;";
			x = 0.45;
			y = 0.36;
			default = true;
		};
		class Move_button_text : BTC_Text 
		{
			x = 0.21;
			y = 0.25;
			w = 0.45;
			h = 0.2;
			sizeEx = 0.035;
			colorBackground[] = {1, 1, 1, 0};
			colorText[] = {0.543, 0.5742, 0.4102, 1};
			text = "Move to Rally Point?";
		};
	};
};