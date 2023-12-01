/// @desc

// make sure mouse object exists
if !(instance_exists(mouse)) {
	instance_create_depth(guiWidth / 2, guiHeight / 2, get_layer_depth(LAYER.mouse), mouse);	
}

// set playerOne and playerTwo
playerOne = player;

// create sprite lists
allyList	= ds_list_create();
enemyList	= ds_list_create();
spriteList	= ds_list_create();

switch (global.sparType) {
	case sparTypes.inGame:
		playerTwo = instance_create_depth(x, y, get_layer_depth(LAYER.meta), enemyAI);
	break;
	
	case sparTypes.localMulti:
	break;
	
	case sparTypes.onlineMulti:
	break;
}

// create all allies and enemies
repeat (4) {
	instance_create_depth(0, 0, get_layer_depth(LAYER.meta), sparAlly);
	instance_create_depth(0, 0, get_layer_depth(LAYER.meta), sparEnemy);
}

// spar phases enum
enum sparPhases {
	turnBegin,
	select,
	process,
	turnEnd,
	height
}

// initialize spar phase
sparPhase = sparPhases.turnBegin;

// selection phases enum
enum selectionPhases {
	ally,
	action,
	target,
	height
}

// initialize selectionPhase
selectionPhase = selectionPhases.ally;

// initialize sparReady
sparReady = false;

// initialize sparComplete
sparComplete = false;

// initialize turnCounter
turnCounter = 1;

// initialize winner
winner = noone;

// initialize loser
loser = noone;

// create sparActions enum
enum sparActions {
	attack,
	spell,
	dodge,
	swap,
	rest,
	height
}

// switch global.roomBuilt to true to end transition
global.roomBuilt = true;

// initialize messageX and messageY
messageX = guiWidth / 2;
messageY = (guiHeight / 2) - 11;

// initialize message
msg = "";

// if global.arena is not -1, perform an arena change

// initialize turnGrid
turnGrid = ds_grid_create(3, 8);

#region HOVER MENU POSITION
hoverMenuX			= -1;
hoverMenuY			= -1;
					
hoverMenu_nameX		= -1;
hoverMenu_nameY		= -1;

hoverMenu_alignX	= -1;
hoverMenu_alignY	= -1;

hoverMenu_powerX	= -1;
hoverMenu_powerY	= -1;
					
hoverMenu_resistX	= -1;
hoverMenu_resistY	= -1;
					
hoverMenu_agilityX	= -1;
hoverMenu_agilityY	= -1;
					
hoverMenu_luckX		= -1;
hoverMenu_luckY		= -1;
					
hoverMenu_sizeX		= -1;
hoverMenu_sizeY		= -1;
					
hoverMenu_fireX		= -1;
hoverMenu_fireY		= -1;
					
hoverMenu_waterX	= -1;
hoverMenu_waterY	= -1;
					
hoverMenu_stormX	= -1;
hoverMenu_stormY	= -1;
					
hoverMenu_earthX	= -1;
hoverMenu_earthY	= -1;
#endregion