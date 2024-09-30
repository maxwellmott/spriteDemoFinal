create_once(player.x, player.y, LAYER.mouse, mouse);

enum MAIN_MENU_BUTTONS {
	TALISMANS,
	SPELLS,
	CONTACTS,
	TODO_LIST,
	RONIN,
	SETTINGS,
	HEIGHT	
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

var i = 0;	repeat (MAIN_MENU_BUTTONS.HEIGHT) {
	var name		= "";
	var left		= x - 44;
	var right		= x + 44;
	var top			= -1;
	var bottom		= -1;
	var nm			= -1;
	
	switch (i) {
		case MAIN_MENU_BUTTONS.TALISMANS:
			name	= "TALISMANS";
			top		= y - 37;
			bottom	= top + 10;
			nm		= rm_teambuilder;
		break;
		
		case MAIN_MENU_BUTTONS.SPELLS:
			name	= "SPELLS";
			top		= y - 24;
			bottom	= top + 10;
			nm		= rm_spellbookBuilder;
		break;
		
		case MAIN_MENU_BUTTONS.CONTACTS:
			name	= "CONTACTS";
			top		= y - 11;
			bottom	= top + 10;
			nm		= -1;
		break;
		
		case MAIN_MENU_BUTTONS.TODO_LIST:
			name	= "TODO LIST";
			top		= y + 2;
			bottom	= top + 10;
			nm		= -1;
		break;
		
		case MAIN_MENU_BUTTONS.RONIN:
			name	= "RONIN +";
			top		= y + 15;
			bottom	= top + 10;
			nm		= -1;
		break;
		
		case MAIN_MENU_BUTTONS.SETTINGS:
			name	= "SETTINGS";
			top		= y + 28;
			bottom	= top + 10;
			nm		= rm_optionsMenu;
		break;
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