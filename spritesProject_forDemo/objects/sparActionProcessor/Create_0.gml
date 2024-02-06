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

// perform agility sort
agility_sort(spar.turnGrid);

// get turnNum
turnNum = spar.turnNum;

// use turnNum to get params from turnGrid
activeSprite	= spar.turnGrid[# turnParams.actor,		turnNum];
currentAction	= spar.turnGrid[# turnParams.action,	turnNum];
activeTarget	= spar.turnGrid[# turnParams.target,	turnNum];

// check if currentAction is a spell
if action_check_spell() {
	currentSpell = currentAction - sparActions.height;
}

// if spell is set, get all spell params
if (currentSpell >= 0) {
	spar_spell_load_params();
}