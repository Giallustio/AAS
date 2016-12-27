
class btc_arty_dialog
{
	idd = -1;
	movingEnable = 1;
	//onLoad = "[5550,[""HE"",""SMOKE"",""ILLUM"",""WP""]] spawn BTC_Fill_list;[5551,[""W"",""E""]] spawn BTC_Fill_list;[5552,[""N"",""S""]] spawn BTC_Fill_list;[5553,""0""] spawn BTC_ctrlText;[5554,""0""] spawn BTC_ctrlText;";
	objects[] = {};
	class controlsBackground 
	{
		class Main_menu
		{
			idc = -1;
			type = 0;
			style = 48;
			font = "RobotoCondensed";
			x = 0.66625 * safezoneW + safezoneX;
			y = 0.569 * safezoneH + safezoneY;
			w = 0.18 * safezoneW;
			h = 0.25 * safezoneH;
			colorText[] = {1, 1, 1, 1};
			colorBackground[] = {0,0,0,0};
			text = "core\dlg\data\notepad_ca.paa";
			SizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1)";
		};
	};
	class controls {
		class RscText_1001: RscText
		{
			idc = -1;
			text = "Arty type"; //--- ToDo: Localize;
			x = 0.711406 * safezoneW + safezoneX;
			y = 0.599 * safezoneH + safezoneY;
			w = 0.04125 * safezoneW;
			h = 0.055 * safezoneH;
			colorText[] = {0,0,0,1};
		};
		class RscCombo_2100: RscCombo
		{
			idc = 2100;
			x = 0.762969 * safezoneW + safezoneX;
			y = 0.619 * safezoneH + safezoneY;
			w = 0.0464063 * safezoneW;
			h = 0.022 * safezoneH;
			colorText[] = {0,0,0,1};
		};
		class RscText_1002: RscText
		{
			idc = -1;
			text = "N/S"; //--- ToDo: Localize;
			x = 0.711406 * safezoneW + safezoneX;
			y = 0.654 * safezoneH + safezoneY;
			w = 0.04125 * safezoneW;
			h = 0.055 * safezoneH;
			colorText[] = {0,0,0,1};
		};
		class RscText_1003: RscText
		{
			idc = -1;
			text = "W/E"; //--- ToDo: Localize;
			x = 0.711406 * safezoneW + safezoneX;
			y = 0.687 * safezoneH + safezoneY;
			w = 0.04125 * safezoneW;
			h = 0.055 * safezoneH;
			colorText[] = {0,0,0,1};
		};
		class RscEdit_1400: RscEdit
		{
			idc = 2101;
			x = 0.762969 * safezoneW + safezoneX;
			y = 0.676 * safezoneH + safezoneY;
			w = 0.0360937 * safezoneW;
			h = 0.011 * safezoneH;
			colorText[] = {0,0,0,1};
		};
		class RscEdit_1401: RscEdit
		{
			idc = 2102;
			x = 0.762969 * safezoneW + safezoneX;
			y = 0.709 * safezoneH + safezoneY;
			w = 0.0360937 * safezoneW;
			h = 0.011 * safezoneH;
			colorText[] = {0,0,0,1};
		};
		class RscText_1004: RscText
		{
			idc = -1;
			text = "Negative values for South and West"; //--- ToDo: Localize;
			x = 0.711406 * safezoneW + safezoneX;
			y = 0.731 * safezoneH + safezoneY;
			w = 0.103125 * safezoneW;
			h = 0.022 * safezoneH;
			colorText[] = {0,0,0,1};
			SizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.75)";
		};
		class RSCButton_ok: RscButton {
			x = 0.741406 * safezoneW + safezoneX;
			y = 0.761 * safezoneH + safezoneY;
			w = 0.053125 * safezoneW;
			h = 0.022 * safezoneH;
			text = "Confirm";
			action = "1 call btc_fnc_actions_requestArtillery";	
		};
	};
};