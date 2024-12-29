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

// initialize damageMultiplierIndex
damageMultiplierIndex = 0;

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
spellDodgeable	= noone;

// get turnRow
turnRow = spar.turnRow;

// use turnRow to get params from turnGrid
atkrSpotNum		= spar.turnGrid[# SELECTION_PHASES.ALLY,		turnRow];
currentAction	= spar.turnGrid[# SELECTION_PHASES.ACTION,	turnRow];
targSpotNum		= spar.turnGrid[# SELECTION_PHASES.TARGET,	turnRow];

activeSprite	= spar.spriteList[| atkrSpotNum];

if (targSpotNum >= 0)	targetSprite = spar.spriteList[| targSpotNum];
else					targetSprite = activeSprite;

// if action has already been performed, destroy this object
if (currentAction == -1)	instance_destroy(id);

// check if currentAction is a spell
if action_check_spell(currentAction) {
	currentSpell = action_get_spell_id(currentAction);
}

// if spell is set, get all spell params
if (currentSpell >= 0) {
	processor_load_spell_params();
}

enum ACTION_PROCESSOR_STATES {
	FADING_IN,
	CALCULATING,
	WAIT_FOR_FX,
	DISPLAY_MSG,
	APPLY_DAMAGE,
	HEIGHT
}

state = ACTION_PROCESSOR_STATES.FADING_IN;

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

// perform an ability check for action begin
ability_check(ABILITY_TYPES.ACTION_BEGIN);

//		******CALCULATE DAMAGE******	
// if this is a basic attack
if (currentSpell < 0) {
	// calculate damage
	damage = get_physical_damage(activeSprite, targetSprite, BASIC_ATTACK_POWER);
}

// if this is a spell
if (currentSpell >= 0) {
	// calculate physical damage if it's a physical spell
	if (spellType == SPELL_TYPES.PHYSICAL) {
		// check for mechanical target
		spar_check_mechanical_target(targetSprite);
		
		// calculate damage
		damage = get_physical_damage(activeSprite, targetSprite, spellPower);
	}
	// set damage to 0 if it's a trick spell
	else if (spellType == SPELL_TYPES.TRICK) {
		damage = 0;	
	}
	// calculate elemental damage if it's an elemental spell
	else {
		// check for astral caster
		spar_check_astral_caster(activeSprite);
		
		// check for arena effects
		spar_check_arena_effects(spellType);
		
		// check for the natural arena boost
		spar_check_natural_arena_boost(activeSprite);
		
		// check for hum
		spar_check_hum(activeSprite);
		
		// calculate damage
		damage = get_elemental_damage(targetSprite, activeSprite, spellType, spellPower);
	}		
	// calculate psychic damage if it's psychic impact or psychic fissure
	if (currentSpell == SPELLS.PSYCHIC_FISSURE)
	|| (currentSpell == SPELLS.PSYCHIC_IMPACT) {
		damage = get_psychic_damage(activeSprite, targetSprite, spellPower);	
	}
}

spar_check_black_hole_absorb_spell();
spar_check_ball_lightning_absorb_spell();