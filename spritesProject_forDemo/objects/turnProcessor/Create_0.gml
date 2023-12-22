/// @description Insert description here
// You can write your code in this editor

// initialize target

// initialize actor

// initialize action

// initialize damage
damage = 0;

// initialize currentSpell
currentSpell = -1;

// initialize spellParams
spellName		= "";
spellCost		= -1;
spellType		= -1;
spellPower		= -1;
spellEffect		= -1;

// perform agility sort
agility_sort(spar.turnGrid);

// get turnNum
turnNum = spar.turnNum;

// use turnNum to get params from turnGrid
activeSprite	= spar.turnGrid[# turnParams.actor,		turnNum];
currentAction	= spar.turnGrid[# turnParams.action,	turnNum];
activeTarget	= spar.turnGrid[# turnParams.target,	turnNum];

// check if currentAction is a spell
if (currentAction >= sparActions.height) {
	currentSpell = currentAction - sparActions.height;
}

// if spell is set, get all spell params
if (currentSpell != -1) {
	spar_spell_load_params();
}