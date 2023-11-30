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
	meditate,
	height
}

// switch global.roomBuilt to true to end transition
global.roomBuilt = true;
