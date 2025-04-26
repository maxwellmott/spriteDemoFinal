// I guess the only way for me to use gms2's built in animation system is to 
// make the object sprite whatever sprite I want to display. Whatever. I'll have to 
// set these built-ins to whatever values I need when other things like this occur.
sprite_index = spr_sparSwapCloud;
image_speed = 1;

data = ds_map_create();

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

if (instance_exists(onlineEnemy)) {
	playerTwo = onlineEnemy;
	
	with (playerTwo) {
		decode_list(currentTeam, teamList);
	}
}
else {
	playerTwo = instance_create_depth(x, y, get_layer_depth(LAYER.meta), enemyAI);	
}

// set enemy for each player
playerOne.enemy = playerTwo;
playerTwo.enemy = playerOne;

// set player's spellBookGrid and
// decode their teamList
with (player) {
	spellBookList = ds_list_create();
	player_build_spellBookGrid();	
	teamList = ds_list_create();
	decode_list(currentTeam, teamList);
	
		// convert all tokens from string to real
	var i = 0;	repeat (ds_list_size(spellBookList)) {
		// check that the spell is not "-1" or "-4"
		if (spellBookList[| i] != "-1")
		&& (spellBookList[| i] != "-4") {
			// convert from string to real
			spellBookList[| i] = real(spellBookList[| i]);
		}
		
		// increment i
		i++;
	}
}

// create all allies and enemies
repeat (4) {
	instance_create_depth(0, 0, get_layer_depth(LAYER.meta), sparAlly);
	instance_create_depth(0, 0, get_layer_depth(LAYER.meta), sparEnemy);
}

// spar phases enum
enum SPAR_PHASES {
	TURN_BEGIN,
	SELECT,
	PROCESS,
	TURN_END,
	HEIGHT
}

// initialize spar phase
sparPhase = SPAR_PHASES.TURN_BEGIN;

// selection phases enum
enum SELECTION_PHASES {
	PRESELECT,
	ALLY,
	ACTION,	
	TARGET,	
	HEIGHT,	
}

// turn grid enum
enum TURN_GRID {
	ALLY,
	ACTION,
	TARGET,
	LUCK,
	HEIGHT
}

// initialize selectionPhase
selectionPhase = SELECTION_PHASES.PRESELECT;

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

// initialize selectionMsgX and selectionMsgY
selectionMsgX = guiWidth / 2;
selectionMsgY = (guiHeight / 2) - 7;

// initialize selectionMsg
selectionMsg = "";

// set currentArena to global.arena
currentArena = global.arena

// initialize turnGrid	|	ACTIVE SPRITE	|	TARGET SPRITE	|	ACTION	|	LUCK ROLL	|
turnGrid = ds_grid_create(TURN_GRID.LUCK + 1, 8);

// initialize turnMsg
turnMsg = "";

// initialize turnMsgX and turnMsgY
turnMsgX = guiWidth / 2;
turnMsgY = guiHeight / 2;

#region HOVER MENU POSITIONS
hoverMenu_nameplateX	= 45;
hoverMenu_nameplateY	= turnMsgY - 24;
						
hoverMenu_alignmentX	= 5;
hoverMenu_alignmentY	= turnMsgY - 14;

hoverMenu_sizeX			= hoverMenu_alignmentX;
hoverMenu_sizeY			= hoverMenu_alignmentY + 7;

hoverMenu_columnOneX	= 113;
hoverMenu_columnTwoX	= hoverMenu_columnOneX + 39;
hoverMenu_columnThreeX	= hoverMenu_columnTwoX + 39;
hoverMenu_columnFourX	= hoverMenu_columnThreeX + 39;

hoverMenu_rowOneY		= turnMsgY - 27;
hoverMenu_rowTwoY		= hoverMenu_rowOneY + 7;
hoverMenu_rowThreeY		= hoverMenu_rowTwoY + 7;
hoverMenu_rowFourY		= hoverMenu_rowThreeY + 7;

hoverMenu_abilityNameX	= turnMsgX - 91;
hoverMenu_abilityNameY	= turnMsgY - 1;

hoverMenu_abilityDescX	= turnMsgX;
hoverMenu_abilityDescY	= turnMsgY + 13;

#endregion

inRangeSprites = ds_list_create();

// TURNS TILL BLAST | DAMAGE | TARGET PLAYER
timedBlastGrid = ds_grid_create(3, 0);

blastCount = 0;

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

// this variable will be used by the actionProcessor to determine which row from the turnGrid
// should be pulled for the turn
turnRow = -1;

//	|	CASTER	|	TARGET	|
skydiveGrid = ds_grid_create(2, 0);

skydiveCount = 0;

//	|	CASTER	|	TARGET	|
sneakAttackGrid = ds_grid_create(2, 0);

sneakAttackCount = 0;

uiAlpha = 1.0;

if (instance_exists(onlineEnemy)) {

	data = ds_map_create();

	client = network_create_socket(network_socket_udp);	
	network_connect_raw(client, SERVER_ADDRESS, PORT_NUM);

	onlineBuffer = buffer_create(120, buffer_fixed, 120);
}

onlineWaiting = false;

totalSpellCost = 0;

totalSwapCost = 0;

minRestRegen = 0;

nextTurnFinalMP = 0;

preRestFinalMP = 0;
postRestFinalMP = 0;

potentialSwapCost = 0;
potentialSpellCost = 0;

mpCalculated = false;

effectAlertList = ds_list_create();

abilityChecked_priorityCheck = false;

var i = 0;	repeat (ds_list_size(spriteList)) {
	var inst = spriteList[| i];
	
	with (inst) {
		sprite_build_nearby_lists();	
	}

	i++;	
}

turnCancelled = false;

newArena = -1;

global.roomBuilt = true;