/// @desc

// make sure mouse object exists
if !(instance_exists(mouse)) {
	instance_create_depth(guiWidth / 2, guiHeight / 2, layer_get_depth(LAYER.mouse), mouse);	
}

// set playerOne and playerTwo
playerOne = player;
playerTwo = global.opponent;

// create sprite lists
allyList	= ds_list_create();
enemyList	= ds_list_create();
spriteList	= ds_list_create();

// create enemyOnline object if this is not an online spar

// if not online, set enemy team and create enemyAI
if (playerTwo.object_index == npc) {
	// set enemy team using roster
	aiOpponent_set_team();

	// create enemyAI
	instance_create_depth(0, 0, layer_get_depth(LAYER.meta), enemyAI);
}

// create all allies and enemies
repeat (4) {
	instance_create_depth(0, 0, layer_get_depth(LAYER.meta), sparAlly);
	instance_create_depth(0, 0, layer_get_depth(LAYER.meta), sparEnemy);
}

// spar phases enum
enum sparPhases {
	initialize,
	select,
	process,
	turnEnd,
	height
}

// initialize spar phase
sparPhase = sparPhases.initialize;

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

// switch global.roomBuilt to true to end transition
global.roomBuilt = true;
