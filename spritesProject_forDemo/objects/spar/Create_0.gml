/// @desc

// I guess the only way for me to use gms2's built in animation system is to 
// make the object sprite whatever sprite I want to display. Whatever. I'll have to 
// set these built-ins to whatever values I need when other things like this occur.
sprite_index = spr_sparSwapCloud;
image_speed = 1;

depth = get_layer_depth(LAYER.ui);

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
		// create ai player
		playerTwo = instance_create_depth(x, y, get_layer_depth(LAYER.meta), enemyAI);
	break;
	
	case sparTypes.localMulti:
	break;
	
	case sparTypes.onlineMulti:
	break;
}

// set enemy for each player
playerOne.enemy = playerTwo;
playerTwo.enemy = playerOne;

// set player's spellBookGrid
with (playerOne) {
	human_build_spellBookGrid();	
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

// initialize selectionMsgX and selectionMsgY
selectionMsgX = guiWidth / 2;
selectionMsgY = (guiHeight / 2) - 11;

// initialize selectionMsg
selectionMsg = "";

// set currentArena to global.arena
currentArena = global.arena

// initialize turnGrid	|	ACTIVE SPRITE	|	TARGET SPRITE	|	ACTION	|	LUCK ROLL	|
turnGrid = ds_grid_create(selectionPhases.height + 1, 8);

// initialize turnMsg
turnMsg = "";

// initialize turnMsgX and turnMsgY
turnMsgX = guiWidth / 2;
turnMsgY = guiHeight / 2;

#region HOVER MENU POSITIONS
hoverMenu_nameplateX	= 45;
hoverMenu_nameplateY	= turnMsgY - 8;
						
hoverMenu_alignmentX	= 5;
hoverMenu_alignmentY	= turnMsgY + 3;

hoverMenu_sizeX			= hoverMenu_alignmentX;
hoverMenu_sizeY			= hoverMenu_alignmentY + 7;

hoverMenu_columnOneX	= 111;
hoverMenu_columnTwoX	= hoverMenu_columnOneX + 39;
hoverMenu_columnThreeX	= hoverMenu_columnTwoX + 39;
hoverMenu_columnFourX	= hoverMenu_columnThreeX + 39;

hoverMenu_rowOneY		= turnMsgY - 11
hoverMenu_rowTwoY		= hoverMenu_rowOneY + 7;
hoverMenu_rowThreeY		= hoverMenu_rowTwoY + 7;
hoverMenu_rowFourY		= hoverMenu_rowThreeY + 7;

#endregion

inRangeSprites = ds_list_create();

// TURNS TILL BLAST | DAMAGE | TARGET PLAYER
timedBlasts = ds_grid_create(3, 0);

blastCount = 0;

playerOneDrawHP = playerOne.currentHP;
playerTwoDrawHP = playerTwo.currentHP;

playerOneDrawMP = playerOne.currentMP;
playerTwoDrawMP = playerTwo.currentMP;

sparMsg	= "";

turnProcessCount = 0;

playerDisplayHP		= playerOne.currentHP;
enemyDisplayHP		= playerTwo.currentHP;

playerDisplayMP		= playerOne.currentMP;
enemyDisplayMP		= playerTwo.currentMP;

hpBarX				= 3;
mpBarX				= 3;

hpBarY				= 3;
mpBarY				= 10;

playerBarSurfaceX	= 112;
playerBarSurfaceY	= 208;

enemyBarSurfaceX	= 144;
enemyBarSurfaceY	= 0;

playerBarSurface	= surface_create(48, 16);
enemyBarSurface		= surface_create(48, 16);

processPhase = PROCESS_PHASES.PREPROCESS;

enum PROCESS_PHASES {
	PREPROCESS,
	SWAP,
	REST,
	DODGE,
	PRIORITY,
	ATTACK,
	END,
	HEIGHT
}