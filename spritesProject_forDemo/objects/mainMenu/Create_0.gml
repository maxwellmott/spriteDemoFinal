create_once(player.x, player.y, LAYER.mouse, mouse);

// push open soul stone sfx
audio_push_sfx(sfx_openSoulStone);

enum MAIN_MENU_BUTTONS {
	SPAR_SETS,
	CONTACTS,
	TODO_LIST,
	CALENDAR,
	RONIN,
	SETTINGS,
	HEIGHT	
}

// initialize buttonCount
buttonCount = -1;

// check if the player has unlocked ronin+
if (player.leagueRanking >= 0) {
	buttonCount = MAIN_MENU_BUTTONS.HEIGHT;
}
// if the player has not yet unlocked ronin+
else {
	buttonCount = MAIN_MENU_BUTTONS.HEIGHT - 1;
}

textColor = $0ecc2e;

x = camera.x;
y = camera.y;

image_index = 0;
image_speed = 1;

introFinished = false;
outroStarted = false;

buttonNameList		= ds_list_create();

buttonBottomList	= ds_list_create();
buttonTopList		= ds_list_create();
buttonLeftList		= ds_list_create();
buttonRightList		= ds_list_create();

newMenuList			= ds_list_create();

var i = 0;	repeat (buttonCount) {
	var name		= "";
	var left		= x - 44;
	var right		= x + 44;
	var top			= -1;
	var bottom		= -1;
	var nm			= -1;
	
	// switch statement to set parameters if player has unlocked ronin+
	if (player.leagueRanking >= 0) {
		switch (i) {
			case MAIN_MENU_BUTTONS.SPAR_SETS:
				name	= "SPAR SETS";
				top		= y - 37;
				bottom	= top + 10;
				nm		= rm_sparSetsMenu;
			break;
			
			case MAIN_MENU_BUTTONS.CONTACTS:
				name	= "CONTACTS";
				top		= y - 24;
				bottom	= top + 10;
				nm		= rm_contactsMenu;
			break;
			
			case MAIN_MENU_BUTTONS.TODO_LIST:
				name	= "TODO LIST";
				top		= y - 11;
				bottom	= top + 10;
				nm		= rm_todoList;
			break;
			
			case MAIN_MENU_BUTTONS.CALENDAR:
				name	= "CALENDAR";
				top		= y + 2;
				bottom	= top + 10;
				nm		= rm_calendarMenu;
			break;
			
			case MAIN_MENU_BUTTONS.RONIN:
				name	= "RONIN +";
				top		= y + 15;
				bottom	= top + 10;
				nm		= rm_roninMenu;
			break;
			
			case MAIN_MENU_BUTTONS.SETTINGS:
				name	= "SETTINGS";
				top		= y + 28;
				bottom	= top + 10;
				nm		= rm_optionsMenu;
			break;
		}
	}
	// switch statement to set parameters if player has NOT unlocked ronin+
	else {
		switch (i) {
			case MAIN_MENU_BUTTONS.SPAR_SETS:
				name	= "SPAR SETS";
				top		= y - 37;
				bottom	= top + 10;
				nm		= rm_teambuilder;
			break;
			
			case MAIN_MENU_BUTTONS.CONTACTS:
				name	= "CONTACTS";
				top		= y - 24;
				bottom	= top + 10;
				nm		= rm_spellbookBuilder;
			break;
			
			case MAIN_MENU_BUTTONS.TODO_LIST:
				name	= "TODO LIST";
				top		= y - 11;
				bottom	= top + 10;
				nm		= rm_todoList;
			break;
			
			case MAIN_MENU_BUTTONS.CALENDAR:
				name	= "CALENDAR";
				top		= y + 2;
				bottom	= top + 10;
				nm		= -1;
			break;
			
			case MAIN_MENU_BUTTONS.RONIN:
				name	= "SETTINGS";
				top		= y + 15;
				bottom	= top + 10;
				nm		= rm_optionsMenu;
			break;
		}
	}
	
	buttonNameList[| i]		= name;
	
	buttonLeftList[| i]		= left;
	buttonRightList[| i]	= right;
	buttonTopList[| i]		= top;
	buttonBottomList[| i]	= bottom;
	
	newMenuList[| i]		= nm;
	
	i++;
}

selectedButton = 0;

buttonAlpha = 0.0;
shineAlpha = 1.0;

leftSelectorX = x - 51;
rightSelectorX = x + 45;