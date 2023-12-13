/// @desc

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

// initialize turnParams
enum turnParams {
	actor,
	action,
	target,
	height
}

// initialize turnGrid
turnGrid = ds_grid_create(turnParams.height, 8);

// initialize sparMsg
sparMsg = "";

// initialize sparMsgX and sparMsgY
sparMsgX = guiWidth / 2;
sparMsgY = guiHeight / 2;

#region HOVER MENU POSITIONS
hoverMenu_nameplateX	= 45;
hoverMenu_nameplateY	= sparMsgY - 8;
						
hoverMenu_alignmentX	= 5;
hoverMenu_alignmentY	= sparMsgY + 3;

hoverMenu_sizeX			= hoverMenu_alignmentX;
hoverMenu_sizeY			= hoverMenu_alignmentY + 7;

hoverMenu_columnOneX	= 111;
hoverMenu_columnTwoX	= hoverMenu_columnOneX + 39;
hoverMenu_columnThreeX	= hoverMenu_columnTwoX + 39;
hoverMenu_columnFourX	= hoverMenu_columnThreeX + 39;

hoverMenu_rowOneY		= sparMsgY - 11
hoverMenu_rowTwoY		= hoverMenu_rowOneY + 7;
hoverMenu_rowThreeY		= hoverMenu_rowTwoY + 7;
hoverMenu_rowFourY		= hoverMenu_rowThreeY + 7;

#endregion

inRangeSprites = ds_list_create();