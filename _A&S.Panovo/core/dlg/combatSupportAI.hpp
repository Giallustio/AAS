
class btc_combatSupportAI_dialog {
	idd = -1;
	movingEnable = 1;
	objects[] = {};
	class controlsBackground {};
	class controls {
		class IGUIBack_2200: IGUIBack
		{
			x = 0.314375 * safezoneW + safezoneX;
			y = 0.324 * safezoneH + safezoneY;
			w = 0.134062 * safezoneW;
			h = 0.407 * safezoneH;
		};
		class RscListbox_1500: RscListbox
		{
			idc = 71;
			x = 0.324687 * safezoneW + safezoneX;
			y = 0.379 * safezoneH + safezoneY;
			w = 0.113437 * safezoneW;
			h = 0.22 * safezoneH;
			onLBSelChanged = "3 call btc_fnc_cs_handleAI;";
		};
		class RscText_1000: RscText
		{
			idc = 72;
			text = "Your money:"; //--- ToDo: Localize;
			x = 0.324687 * safezoneW + safezoneX;
			y = 0.61 * safezoneH + safezoneY;
			w = 0.113437 * safezoneW;
			h = 0.022 * safezoneH;
		};
		class RscText_1001: RscText
		{
			idc = 73;
			text = "Cost"; //--- ToDo: Localize;
			x = 0.324687 * safezoneW + safezoneX;
			y = 0.643 * safezoneH + safezoneY;
			w = 0.103125 * safezoneW;
			h = 0.022 * safezoneH;
		};
		class RscButton_1600: RscButton
		{
			x = 0.335 * safezoneW + safezoneX;
			y = 0.676 * safezoneH + safezoneY;
			w = 0.0876563 * safezoneW;
			h = 0.033 * safezoneH;
			text = "Confirm";
			action = "1 call btc_fnc_cs_handleAI;";
		};
	};
};