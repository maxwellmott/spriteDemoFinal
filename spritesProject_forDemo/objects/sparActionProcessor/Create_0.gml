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

// get turnRow
turnRow = spar.turnRow;

// use turnRow to get params from turnGrid
activeSprite	= spar.turnGrid[# turnParams.actor,		turnRow];
currentAction	= spar.turnGrid[# turnParams.action,	turnRow];
activeTarget	= spar.turnGrid[# turnParams.target,	turnRow];

// check if currentAction is a spell
if action_check_spell(currentAction) {
	currentSpell = action_get_spell_id(currentAction);
}

// if spell is set, get all spell params
if (currentSpell >= 0) {
	processor_load_spell_params();
}