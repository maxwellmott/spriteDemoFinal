/// @description Insert description here
// You can write your code in this editor

// initialize targetSprite
targetSprite = noone;

// initialize activeSprite
activeSprite = noone;

// initialize currentAction
currentAction = noone;

// initialize dodgeSuccess
dodgeSuccess = false;

// initialize damage
damage = 0;

// initialize currentSpell
currentSpell = noone;

// initialize spellParams
spellName		= "";
spellCost		= noone;
spellType		= noone;
spellPower		= noone;
spellEffect		= noone;

// get turnRow
turnRow = spar.turnRow;

// use turnRow to get params from turnGrid
atkrSpotNum		= spar.turnGrid[# selectionPhases.ally,		turnRow];
currentAction	= spar.turnGrid[# selectionPhases.action,	turnRow];
targSpotNum		= spar.turnGrid[# selectionPhases.target,	turnRow];

activeSprite	= spar.spriteList[| atkrSpotNum];

if (targSpotNum >= 0)	targetSprite = spar.spriteList[| targSpotNum];
else					targetSprite = activeSprite;

// check if currentAction is a spell
if action_check_spell(currentAction) {
	currentSpell = action_get_spell_id(currentAction);
}

// if spell is set, get all spell params
if (currentSpell >= 0) {
	processor_load_spell_params();
}

enum ACTION_PROCESSOR_STATES {
	ANNOUNCING,
	FADING_IN,
	CALCULATING,
	WAIT_FOR_FX,
	DISPLAY_MSG,
	INPUT_PAUSE,
	HEIGHT
}

state = ACTION_PROCESSOR_STATES.ANNOUNCING;

if (currentSpell >= 0) {
	spar.turnMsg = activeSprite.name + " is preparing to cast a spell";
}
else {
	spar.turnMsg = activeSprite.name + " is preparing to make an attack";	
}

dodgeStarted = false;
dodgeStopped = false;
dodgeFrameCount = 3;

shadeAlpha = 0.0;

shadeAlphaMax = 0.9;

spellFailed = false;