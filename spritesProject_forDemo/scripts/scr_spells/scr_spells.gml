// set legal spell count
#macro	SPELLMAX				8
#macro	BASIC_ATTACK_POWER		75
//
#macro AMANDS_BLAST		400

// this variable can be used to store the instance id of the player
// being targeted by a spell such as lady solanus grace. This will be
// checked in the draw event of the spar object to see how sprites should
// be drawn during the spellFX animation.
global.spellTargetTeam = -4;

// spell ids enum
enum SPELLS {
	SOLAR_FLARE,
	TIDAL_FORCE,
	NEBULA_STORM,
	TECTONIC_SHIFT,
	FIREBALL,
	HOLY_WATER,
	SHOCK,
	DECAY,
	EXPEL_FORCE,
	LADY_SOLANUS_GRACE,
	TYPHOON,
	HEALING_LIGHT,
	RUBURS_WATER_CANNON,
	RUBURS_GRAPPLE,
	LUSIAS_HARVEST_SPELL,
	WATERLOG,
	AIR_PRESSURE,
	SUPERBLOOM,
	RAPID_STRIKE,
	LOOMING_DANGER,
	INTERCEPT,
	STEAM_BATH,
	UNDERTOW,
	EMPATHIZE,
	HELLFIRE,
	BALL_LIGHTNING,
	QUICKSAND,
	LORD_MOGRADTHS_RAGE,
	DRAIN_LIFEFORCE,
	PYROKINESIS,
	DOWNPOUR,
	ARC_BLAST,
	HIKAMS_WINTER_SPELL,
	OSMOSIS,
	FLASH_FREEZE,
	LANDSLIDE,
	AMANDS_ENERGY_BLAST,
	SHIFT_PERSPECTIVE,
	PSYCHIC_IMPACT,
	TREMOR,
	SKYDIVE,
	DESTRUCTIVE_BLOW,
	PURIFYING_FLAME,
	JABULS_FIGHT_SONG,
	NOXIOUS_FUMES,
	CRECIAS_CRYSTAL_SPIKES,
	PSYCHIC_FISSURE,
	REARRANGE,
	SNEAK_ATTACK,
	DEFLECTIVE_SHIELD,
	DIONS_PARRY,
	DIONS_GAMBLING_BLAST,
	DIONS_BARTER_TRICK,
	MAGNETIC_PULSE,
	BURN_OUT,
	STINKBOMB,
	WIND_SLICE,
	CHANNEL_ESSENCE,
	SPHERAS_CURSE,
	CRECIAS_CRYSTAL_WIND,
	LAVA_SPIRE,
	ENDLESS_RIVER,
	CLOUD_BREAK,
	TELEKINETIC_BLAST,
	KNOCK_OVER,
	FULL_THRUST,
	VOLCANIC_ERUPTION,
	BROADCAST_DATA,
	COLLAPSE_SPACE,
	EXPAND_TIME,
	SPHERAS_DEMISE,
	TIME_LOOP,
	ERADICATE,
	DARK_DEAL,
	HAIL_SPHERA,
	HEIGHT
}
	
// spell params enum
enum SPELL_PARAMS {
	ID,
	NAME,
	DESCRIPTION,
	LORE,
	TYPE,
	POWER,
	COST,
	RANGE,
	EFFECT,
	DODGEABLE,
	BYPASS_DODGE,
	BYPASS_FAILURE,
	BYPASS_RANGE,
	HEIGHT
}

#region BUILD PRIORITY SPELLS LIST
	var priorityList = ds_list_create();
	
	// populate priority list
	ds_list_add(priorityList,	SPELLS.SHOCK,		SPELLS.RAPID_STRIKE,		SPELLS.FLASH_FREEZE,	SPELLS.SNEAK_ATTACK,
								SPELLS.SKYDIVE,		SPELLS.DEFLECTIVE_SHIELD,	SPELLS.DIONS_PARRY,		SPELLS.BROADCAST_DATA,
								SPELLS.EXPAND_TIME,	SPELLS.TIME_LOOP,			SPELLS.ERADICATE);
								
	// encode priority list
	global.prioritySpellList = encode_list(priorityList);
	
	// delete temp list
	ds_list_destroy(priorityList);

#endregion

#region BUILD ANCIENT SPELLS LIST
	var ancientList = ds_list_create();
	
	// populate ancientList
	ds_list_add(ancientList,	SPELLS.BROADCAST_DATA,	SPELLS.COLLAPSE_SPACE,	SPELLS.EXPAND_TIME,		SPELLS.SPHERAS_DEMISE,
								SPELLS.TIME_LOOP,		SPELLS.ERADICATE,		SPELLS.SOLAR_FLARE,		SPELLS.TIDAL_FORCE,
								SPELLS.NEBULA_STORM,	SPELLS.TECTONIC_SHIFT);
	
	// encode ancient list
	global.ancientSpellList = encode_list(ancientList);
	
	// delete temp list
	ds_list_destroy(ancientList);
	
#endregion

// declare spell types
enum SPELL_TYPES {
	FIRE,
	WATER,
	STORM,
	EARTH,
	PHYSICAL,
	TRICK,
	HEIGHT
}

// get all text from spell csv
var textGrid = load_csv("SPELLS_ENGLISH.csv");

// create spell grid
global.spellGrid = ds_grid_create(SPELL_PARAMS.HEIGHT, SPELLS.HEIGHT);

// spell grid function

function master_grid_add_spell(_ID) {
	var i = 0;	repeat (SPELL_PARAMS.HEIGHT) {
		global.spellGrid[# i, _ID] = argument[i];
		
		i++;
	}
}

#region SPELL FUNCTIONS

///@desc SPELL FUNCTION: grants curse of the warrior to all enemies
function solar_flare() {
	// get target's team
	var t = targetSprite.team;
	
	// push spar effect and target team to alert list
	spar_effect_push_alert(SPAR_EFFECTS.BESTOW_MINDSET_TEAM, t, MINDSETS.WARRIOR_CURSE);
}

///@desc SPELL FUNCTION: forces the target to swap (dodgeable)
function tidal_force() {
	if !(sparActionProcessor.dodgeSuccess) {
		var t = targetSprite.team;
		
		spar_effect_push_alert(SPAR_EFFECTS.FORCE_SWAP_TEAM, t);
	}	
}

///@desc SPELL FUNCTION: hexes all enemies
function nebula_storm() {
	// get target's team
	var t = targetSprite.team;

	spar_effect_push_alert(SPAR_EFFECTS.SET_HEXED_TEAM, t);
}

///@desc SPELL FUNCTION: binds all enemies
function tectonic_shift() {
	// get target's team
	var t = targetSprite.team;

	spar_effect_push_alert(SPAR_EFFECTS.SET_BOUND_TEAM, t);	
}

///@desc SPELL FUNCTION: no effect
function fireball() {
	// maybe uhh delete this uhh function
}

///@desc SPELL FUNCTION: deals extra damage if the sprite is of type: ASTRAL
function holy_water() {
	if !(dodgeSuccess) {
		if (targetSprite.currentAlign == ALIGNMENTS.ASTRAL) {
			damage = round(damage * 1.5);
			spar_effect_push_alert(SPAR_EFFECTS.INCREASE_DAMAGE_ASTRAL, activeSprite);
		}
	}
}

///@desc SPELL FUNCTION: binds target (dodgeable)
function shock() {
	if !(dodgeSuccess) {
		var t = targetSprite;
		
		spar_effect_push_alert(SPAR_EFFECTS.SET_BOUND, t)
	}
}

///@desc SPELL FUNCTION: restores half of health depleted (dodgeable)
function decay() {
	if !(dodgeSuccess) {
		var t = activeSprite.team;
		var d = round(damage / 2);
		
		spar_effect_push_alert(SPAR_EFFECTS.DRAIN_HEALTH, t, d);
	}
}

///@desc SPELL FUNCTION: no effect
function expel_force() {
	// no effect
}

///@desc SPELL FUNCTION: partially restores team and grants all allies blessing of the tree
function lady_solanus_grace() {
	// get caster's team
	var t = activeSprite.team;
	
	global.spellTargetTeam = t;
	
	if (t.currentHP != MAX_HP) {
		spar_effect_push_alert(SPAR_EFFECTS.RESTORE_HP, t, 300);
	}
	
	spar_effect_push_alert(SPAR_EFFECTS.BESTOW_MINDSET_TEAM, t, MINDSETS.TREE_BLESS);
}

///@desc SPELL FUNCTION: grants target curse of the tree (dodgeable)
function typhoon() {
	if !(dodgeSuccess) {
		var t = targetSprite;
		
		spar_effect_push_alert(SPAR_EFFECTS.BESTOW_MINDSET, t, MINDSETS.TREE_CURSE);
	}
}

///@desc SPELL FUNCTION: fully heals the caster's team and make's caster INVULNERABLE
function healing_light() {	
	var c = activeSprite;
	var t = activeSprite.team;
	var a = 250;
	
	if (t.currentHP == MAX_HP) {
		sparActionProcessor.spellFailed = true;
		return -1;
	}
	
	spar_effect_push_alert(SPAR_EFFECTS.SET_INVULNERABLE, c);
	spar_effect_push_alert(SPAR_EFFECTS.RESTORE_HP, t, a);
}

///@desc SPELL FUNCTION: no effect
function ruburs_water_cannon() {
	// no effect
}

///@desc SPELL FUNCTION: binds the target (dodgeable)
function ruburs_grapple() {
	var t = targetSprite;
	
	spar_effect_push_alert(SPAR_EFFECTS.SET_BOUND, t)
}

///@desc SPELL FUNCTION: changes arena to forest
function lusias_harvest_spell() {
	spar_effect_push_alert(SPAR_EFFECTS.ARENA_CHANGE_FOREST);
}

///@desc SPELL FUNCTION: grants target the curse of the tree
function waterlog() {
	var t = targetSprite;
	
	spar_effect_push_alert(SPAR_EFFECTS.BESTOW_MINDSET, t, MINDSETS.TREE_CURSE);
}

///@desc SPELL FUNCTION: grants target and all nearby enemies the curse of the tree
function air_pressure() {
	var t = targetSprite;
	
	spar_effect_push_alert(SPAR_EFFECTS.BESTOW_MINDSET, t, MINDSETS.IMP_CURSE);
	spar_effect_push_alert(SPAR_EFFECTS.BESTOW_MINDSET_NEARBY_ALLIES, t, MINDSETS.IMP_CURSE);
}

///@desc SPELL FUNCTION: removes all curses and hindrances from caster's side of the field and 
/// grants all the blessing of the tree
function superbloom() {
	var t = activeSprite.team;
	
	spar_effect_push_alert(SPAR_EFFECTS.CLEAR_TEAM_HINDRANCES, t);
	spar_effect_push_alert(SPAR_EFFECTS.SHIFT_CURSE_TEAM, t);
}

///@desc SPELL FUNCTION: this spell strikes first. it's id will be on a list of priority moves
function rapid_strike() {
	// the ID of this spell is on a list of "prioritySpells"
}

///@desc SPELL FUNCTION: this spell starts a timer for an Energy Blast on the
/// target's team.
function looming_danger() {	
	var c = 2;
	var p = 500;
	var t = targetSprite.team;
	
	spar_effect_push_alert(SPAR_EFFECTS.GRID_ADD_TIMED_BLAST, c, p, t);
}

///@desc SPELL FUNCTION: caster takes target's place in any spells targeting
/// them this turn.
function intercept() {
	// get caster
	var c = activeSprite;
	
	// get target
	var t = targetSprite;
	
	spar_effect_push_alert(SPAR_EFFECTS.REPLACE_TARGET, c, t);
}

///@desc SPELL FUNCTION: removes all hindrances on the caster's side and sets rust on the
/// target's side
function steam_bath() {
	// get the caster
	var c = activeSprite;
	
	// get the caster's team
	var t = c.team;
	
	spar_effect_push_alert(SPAR_EFFECTS.CLEAR_TEAM_HINDRANCES, t);
	
	spar_effect_push_alert(SPAR_EFFECTS.SET_RUST, targetSprite.team);
}

///@desc SPELL FUNCTION: grants target curse of the imp
function undertow() {
	var t = targetSprite;
	
	spar_effect_push_alert(SPAR_EFFECTS.BESTOW_MINDSET, t, MINDSETS.IMP_CURSE);
}

///@desc SPELL FUNCTION: adopts target's mindset and fully heals target or caster's team
/// depending on whether the mindset in question is a blessing or a curse. (dodgeable)
function empathize() {
	// store target and caster in locals
	var t = targetSprite;
	var c = activeSprite;
	
	// check if target has an altered mindset
	if (t.mindset != 0) {
		// copy mindset
		spar_effect_push_alert(SPAR_EFFECTS.BESTOW_MINDSET, c, t.mindset);
		
		// if curse, fully heal target team
		if (t.mindset < 0) {
			spar_effect_push_alert(SPAR_EFFECTS.FULLY_RESTORE_HP, t.team);
		}
		
		// if blessing, fully heal caster's team
		if (t.mindset > 0) {
			spar_effect_push_alert(SPAR_EFFECTS.FULLY_RESTORE_HP, c.team);
		}
	}
}

///@desc SPELL FUNCTION: hexes enemy team and caster
function hellfire() {
	var c = activeSprite;
	var t = targetSprite.team;
	
	spar_effect_push_alert(SPAR_EFFECTS.SET_HEXED, c);
	spar_effect_push_alert(SPAR_EFFECTS.SET_HEXED_TEAM, t);
}

///@desc SPELL FUNCTION: this spell sets the ballLightningActive variable to true
/// for the casting sprite. Until the end of the turn, all storm spells are negated
/// and absorbed by the ball lightning. Each absorbed spell adds to the power of the
/// spell, the damage of which is calculated at the end of the turn. This spell is also
/// a priority spell.
function ball_lightning() {
	var c = activeSprite;
	var t = targetSprite;
	
	spar_effect_push_alert(SPAR_EFFECTS.BALL_LIGHTNING_SET_ACTIVE, c, t);
}

///@desc SPELL FUNCTION: binds the target
function quicksand() {
	// store targetSprite
	var t = targetSprite;
	
	spar_effect_push_alert(SPAR_EFFECTS.SET_BOUND, t);
}

///@desc SPELL FUNCTION: hexes and binds all enemies
function lord_mogradths_rage() {
	var t = targetSprite.team;
	
	spar_effect_push_alert(SPAR_EFFECTS.SET_HEXED_TEAM, t);
	spar_effect_push_alert(SPAR_EFFECTS.SET_BOUND_TEAM, t);
}

///@desc SPELL FUNCTION: restores half of the health depleted from target (dodgeable)
function drain_lifeforce() {
	var t = activeSprite.team;
	var d = round(damage / 2);
	
	spar_effect_push_alert(SPAR_EFFECTS.DRAIN_HEALTH, t, d);
}

///@desc SPELL FUNCTION: deals a fraction of the damage to the caster
function pyrokinesis() {
	var t = activeSprite.team;
	
	var d = round(damage / 3);
	
	spar_effect_push_alert(SPAR_EFFECTS.APPLY_SELF_DAMAGE, t, d);
}

///@desc SPELL FUNCTION: summons rust on the target's side of the field
function downpour() {
	var t = targetSprite.team;
	
	spar_effect_push_alert(SPAR_EFFECTS.SET_RUST, t);
}

///@desc SPELL FUNCTION: grants the target the curse of the imp (dodgeable)
function arc_blast() {
	var t = targetSprite;
	
	spar_effect_push_alert(SPAR_EFFECTS.BESTOW_MINDSET, t, MINDSETS.IMP_CURSE);
}

///@desc SPELL FUNCTION: fails unless forest is active, removes forest, fully restores caster's
/// HP, and grants blessing of the tree to all nearby allies
function hikams_winter_spell() {
	if (spar.currentArena != ARENAS.FOREST) {
		spellFailed = true;
		return -1;
	}
	
	var t = activeSprite.team;
	
	spar_effect_push_alert(SPAR_EFFECTS.DESTROY_ARENA);
	spar_effect_push_alert(SPAR_EFFECTS.FULLY_RESTORE_MP, t);
	spar_effect_push_alert(SPAR_EFFECTS.BESTOW_MINDSET_TEAM, t, MINDSETS.TREE_BLESS);
}

///@desc SPELL FUNCTION: adopts the target's mindset. if curse, heal target team fully. If blessing, heal caster team fully
function osmosis() {
	// store target and caster in locals
	var t = targetSprite;
	var c = activeSprite;
	
	var m = t.mindset;
	
	if (m != 0) {
		spar_effect_push_alert(SPAR_EFFECTS.COPY_MINDSET, c, t);
	}
	
	spar_effect_push_alert(SPAR_EFFECTS.DRAIN_HEALTH, c.team, round(damage / 3));
}

///@desc SPELL FUNCTION: this spell is a priority spell that binds the target so long as it is not dodged.
function flash_freeze() {
	// IS A PRIORITY MOVE
	
	var t = targetSprite;
	
	// bind the target
	spar_effect_push_alert(SPAR_EFFECTS.SET_BOUND, t);
}

///@desc SPELL FUNCTION: resets the arena
function landslide() {
	if (spar.currentArena >= 0) {
		spar_effect_push_alert(SPAR_EFFECTS.DESTROY_ARENA);	
	}
}

///@desc SPELL FUNCTION: creates an Energy Blast against the enemy team that always deals 400 damage
function amands_energy_blast() {
	var t = activeSprite.enemy;

	spar_effect_push_alert(SPAR_EFFECTS.ENERGY_BLAST, t, AMANDS_BLAST);
}

///@desc SPELL FUNCTION: flips the targets mindset. If curse->blessing, heal some HP, if blessing->curse, remove some HP,
/// so long as it isn't dodged.
function shift_perspective() {
	var t = targetSprite;
	var m = t.mindset;
	var a = 250;
	
	if (m > 0) {
		if (m <= MINDSETS.IMP_BLESS) {
			spar_effect_push_alert(SPAR_EFFECTS.SHIFT_MINDSET, t);
			spar_effect_push_alert(SPAR_EFFECTS.RESTORE_HP, t.team, a);
		}
		else {
			spar_effect_push_alert(SPAR_EFFECTS.SHIFT_MINDSET, t);
			spar_effect_push_alert(SPAR_EFFECTS.DEPLETE_HP_NONLETHAL, t.team, a);
		}
	}
	else {
		spellFailed = true;
		return -1;
	}
}

///@desc SPELL FUNCTION: damage will be appropriately calculated for psychic spells. This
/// is just a means of notifying the player!
function psychic_impact() {
	// find target's weak spot and attack them there
	if !(dodgeSuccess) {
		var c = activeSprite;
		var t = targetSprite;

		spar_effect_push_alert(SPAR_EFFECTS.PSYCHIC_ATTACK, c, t);
	}
}

///@desc SPELL FUNCTION: resets the arena and deals self damage
function tremor() {
	if (spar.currentArena >= 0) {
		spar_effect_push_alert(SPAR_EFFECTS.DESTROY_ARENA);
	}
	
	var t = activeSprite.team;
	var d = round(damage / 3);
	
	spar_effect_push_alert(SPAR_EFFECTS.APPLY_SELF_DAMAGE, t, d);
}

///@desc SPELL FUNCTION: the caster of this spell flies into the sky and becomes invulnerable
/// until the end of the turn when they swoop back in for an attack.
function skydive() {
	// PRIORITY MOVE
	
	var c = activeSprite;
	var t = targetSprite;
	
	spar_effect_push_alert(SPAR_EFFECTS.GRID_ADD_SKYDIVE, c, t);
}

///@desc SPELL FUNCTION: this spell does extra damage when cast against mechanical sprites, it then
/// changes their type to natural.
function destructive_blow() {
	var t = targetSprite;
	
	if (t.currentAlign == ALIGNMENTS.MECHANICAL) {
		var t = targetSprite;
		var a = ALIGNMENTS.NATURAL;
		
		damage = round(damage * 1.5);
		
		spar_effect_push_alert(SPAR_EFFECTS.INCREASE_DAMAGE_MECHANICAL, targetSprite);
		spar_effect_push_alert(SPAR_EFFECTS.CHANGE_ALIGNMENT, t, a);
	}
}

///@desc SPELL FUNCTION: this spell does extra damage when cast against astral sprites, it then
/// changes their type to natural.
function purifying_flame() {
	var t = targetSprite;
	
	if (t.currentAlign == ALIGNMENTS.ASTRAL) {
		var t = targetSprite;
		var a = ALIGNMENTS.NATURAL;
		
		damage = round(damage * 1.5);
		
		spar_effect_push_alert(SPAR_EFFECTS.INCREASE_DAMAGE_ASTRAL, t);
		spar_effect_push_alert(SPAR_EFFECTS.CHANGE_ALIGNMENT, t, a);
	}
}

///@desc SPELL FUNCTION: set berserk for nearby sprites
function jabuls_fight_song() {
	var c = activeSprite;
	
	spar_effect_push_alert(SPAR_EFFECTS.FULLY_RESTORE_HP, c.team);
	spar_effect_push_alert(SPAR_EFFECTS.SET_BERSERK_NEARBY_SPRITES, c);
}

///@desc SPELL FUNCTION: summons miasma on the target's side of the field
function noxious_fumes() {
	var t = targetSprite.team;
	
	spar_effect_push_alert(SPAR_EFFECTS.SET_MIASMA, t);
}

///@desc SPELL FUNCTION: hexes the target
function crecias_crystal_spikes() {
	var t = targetSprite;
	
	spar_effect_push_alert(SPAR_EFFECTS.SET_HEXED, t);
}

///@desc SPELL FUNCTION: finds the element that would deal the most damage and sets the spell's
/// type to match the results. This spell also deals damage to the caster, even if it's dodged.
function psychic_fissure() {
	var c = activeSprite;
	var t = targetSprite;
	
	var d = round(damage / 3);
	
	if !(dodgeSuccess) {
		spar_effect_push_alert(SPAR_EFFECTS.PSYCHIC_ATTACK, c, t);
	}
	
	spar_effect_push_alert(SPAR_EFFECTS.APPLY_SELF_DAMAGE, c.team, d);
}

///@desc SPELL FUNCTION: splits the target team into two pairs and swaps them
function rearrange() {
	var t = targetSprite.team;
	
	spar_effect_push_alert(SPAR_EFFECTS.FORCE_SWAP_TEAM, t);
}

///@desc SPELL FUNCTION: attempts to dodge for the duration of the turn. If the caster
/// is still sneaking/dodging at the end of the turn, they will deliver a powerful attack.
function sneak_attack() {
	var c = activeSprite;
	var t = targetSprite;
	
	spar_effect_push_alert(SPAR_EFFECTS.GRID_ADD_SNEAK_ATTACK, c, t);
}

///@desc SPELL FUNCTION: creates a sheild that deflects all spells until the end of the turn
function deflective_shield() {
	// PRIORITY SPELL
	
	var c = activeSprite;
	
	spar_effect_push_alert(SPAR_EFFECTS.SET_DEFLECTIVE, c);
}

///@desc SPELL FUNCTION: sets parrying to true (when parrying, the sprite reverses damage 
/// twofold unto basic-attacking sprites that target this one. After doing so, the sprite becomes
/// INVULNERABLE (this spell is also a prioritySpell)
function dions_parry() {
	var c = activeSprite;
	
	spar_effect_push_alert(SPAR_EFFECTS.SET_PARRYING, c);
}

///@desc SPELL FUNCTION: creates a blast with a target and damage that is dependent on the caster's luckroll
function dions_gambling_blast() {
	var c = activeSprite;
	var t = targetSprite;
	var lr = c.luckRoll * 1000;
	
	if (lr >= 900)	{
		var p = round(abs(MAX_LUCK - lr) * 0.3);
		spar_effect_push_alert(SPAR_EFFECTS.ENERGY_BLAST, t.team, p);
	}
	
	if (lr < 900)	{
		var p = round(abs(lr - MIN_LUCK) * 0.3);
		spar_effect_push_alert(SPAR_EFFECTS.ENERGY_BLAST_SELF, c.team, p);
	}
}

///@desc SPELL FUNCTION: gives half caster's current HP to target team, then takes a third of target's current HP
function dions_barter_trick() {
	// trade half of the caster's current HP for a third of the enemy's current HP
	
	var t = activeSprite.enemy;
	var c = activeSprite.team;
	
	var a1 = ceil(c.currentHP * (15 / 16));
	var a2 = ceil(t.currentHP * (7 / 8));
	
	spar_effect_push_alert(SPAR_EFFECTS.DEPLETE_HP_NONLETHAL, c, a1);
	spar_effect_push_alert(SPAR_EFFECTS.DEPLETE_HP_NONLETHAL, t, a2);
	
	spar_effect_push_alert(SPAR_EFFECTS.RESTORE_HP, c, a2);
	spar_effect_push_alert(SPAR_EFFECTS.RESTORE_HP, t, a1);
}

///@desc SPELL FUNCTION: sets hum on the target's side of the field
function magnetic_pulse() {
	var t = targetSprite.team;
	
	spar_effect_push_alert(SPAR_EFFECTS.SET_HUM, t);
}

///@desc SPELL FUNCTION: grants curse of the mother to the caster
function burn_out() {
	var c = activeSprite;
	
	spar_effect_push_alert(SPAR_EFFECTS.BESTOW_MINDSET, c, MINDSETS.MOTHER_CURSE);
}

///@desc SPELL FUNCTION: summons miasma on both sides of the field
function stinkbomb() {
	spar_effect_push_alert(SPAR_EFFECTS.SET_MIASMA_GLOBAL);
}

///@desc SPELL FUNCTION: grants curse of the imp to the target (dodgeable)
function wind_slice() {
	var t = targetSprite;
		
	spar_effect_push_alert(SPAR_EFFECTS.BESTOW_MINDSET, t, MINDSETS.IMP_CURSE);
	
}

///@desc SPELL FUNCTION: makes the arena reflect the caster's elemental bias
function channel_essence() {
	var c = activeSprite;
	
	var s = get_best_elemental_stat(c);
	
	switch (s) {
		case elements.fire:
			spar_effect_push_alert(SPAR_EFFECTS.ARENA_CHANGE_VOLCANO);
		break;
		
		case elements.water:
			spar_effect_push_alert(SPAR_EFFECTS.ARENA_CHANGE_OCEAN);
		break;
		
		case elements.storm:
			spar_effect_push_alert(SPAR_EFFECTS.ARENA_CHANGE_CLOUDS);
		break;
		
		case elements.earth:
			spar_effect_push_alert(SPAR_EFFECTS.ARENA_CHANGE_FOREST);
		break;
	}
}

///@desc SPELL FUNCTION: makes the arena exploit the target's elemental bias (dodgeable)
function spheras_curse() {
	var t = targetSprite;
	
	var s = get_worst_elemental_stat(t);
	
	switch (s) {
		case elements.fire:
			spar_effect_push_alert(SPAR_EFFECTS.ARENA_CHANGE_VOLCANO);
		break;
		
		case elements.water:
			spar_effect_push_alert(SPAR_EFFECTS.ARENA_CHANGE_OCEAN);
		break;
		
		case elements.storm:
			spar_effect_push_alert(SPAR_EFFECTS.ARENA_CHANGE_CLOUDS);
		break;
		
		case elements.earth:
			spar_effect_push_alert(SPAR_EFFECTS.ARENA_CHANGE_FOREST);
		break;
	}
}

///@desc SPELL FUNCTION: hexes target and all nearby allies
function crecias_crystal_wind() {
	var t = targetSprite;
	
	spar_effect_push_alert(SPAR_EFFECTS.SET_HEXED, t);

	
	spar_effect_push_alert(SPAR_EFFECTS.SET_HEXED_NEARBY_ALLIES, t);
}

///@desc SPELL FUNCTION: changes the arena to VOLCANO
function lava_spire() {
	spar_effect_push_alert(SPAR_EFFECTS.ARENA_CHANGE_VOLCANO);
}

///@desc SPELL FUNCTION: changes the arena to OCEAN
function endless_river() {
	spar_effect_push_alert(SPAR_EFFECTS.ARENA_CHANGE_OCEAN);
}

///@desc SPELL FUNCTION: changes the arena to clouds
function cloud_break() {
	spar_effect_push_alert(SPAR_EFFECTS.ARENA_CHANGE_CLOUDS);
}

///@desc SPELL FUNCTION: hexes the target (dodgeable)
function telekinetic_blast() {
	var t = targetSprite;
	
	spar_effect_push_alert(SPAR_EFFECTS.SET_HEXED, t);
	
}

///@desc SPELL FUNCTION: grants the target CURSE OF THE IMP (dodgeable)
function knock_over() {	
	var t = targetSprite;
	
	spar_effect_push_alert(SPAR_EFFECTS.BESTOW_MINDSET, t, MINDSETS.IMP_CURSE);
	
}

///@desc SPELL FUNCTION: binds the caster
function full_thrust() {
	var c = activeSprite;
	
	spar_effect_push_alert(SPAR_EFFECTS.SET_BOUND, c);
}

///@desc SPELL FUNCTION: fails unless arena is volcano. destroys the arena
/// summons miasma on the target's side of the field
function volcanic_eruption() {
	if (spar.currentArena != ARENAS.VOLCANO) {
		sparActionProcessor.spellFailed = true;
		return -1;
	}
	
	spar_effect_push_alert(SPAR_EFFECTS.DESTROY_ARENA);
	
	var t = targetSprite.team;
	
	spar_effect_push_alert(SPAR_EFFECTS.SET_MIASMA, t);
}

///@desc SPELL FUNCTION: changes all allies luck roll to highest possible
function broadcast_data() {
	var t = activeSprite.team;
	
	spar_effect_push_alert(SPAR_EFFECTS.FORCE_BEST_LUCK_TEAM, t);
}

///@desc SPELL FUNCTION: destroys arena and hexes all enemies
function collapse_space() {
	var t = activeSprite.enemy;
	
	if (spar.currentArena != -1) {
		spar_effect_push_alert(SPAR_EFFECTS.DESTROY_ARENA);
		spar_effect_push_alert(SPAR_EFFECTS.SET_HEXED_TEAM, t);
	}
	else {
		spellFailed = true;
	}
}

///@desc SPELL FUNCTION: changes all enemies luck roll to lowest possible
function expand_time() {
	var t = activeSprite.enemy;
	
	spar_effect_push_alert(SPAR_EFFECTS.FORCE_WORST_LUCK_TEAM, t);
}

///@desc SPELL FUNCTION: destroys arena and traps all enemies
function spheras_demise() {
	var t = activeSprite.enemy;
	
	if (spar.currentArena != -1) {
		spar_effect_push_alert(SPAR_EFFECTS.DESTROY_ARENA);
		spar_effect_push_alert(SPAR_EFFECTS.SET_BOUND_TEAM, t);
	}
	else {
		spellFailed = true;	
	}
}

///@desc SPELL FUNCTION: forces the enemy to repeat this turn next turn
function time_loop() {
	var t = targetSprite;
	
	spar_effect_push_alert(SPAR_EFFECTS.REPEAT_LAST_TURN, t);
}

///@desc SPELL FUNCTION: creates a black hole that absorbs all spells
function eradicate() {
	var c = activeSprite;
	var t = targetSprite;
	
	spar_effect_push_alert(SPAR_EFFECTS.BLACK_HOLE_SET_ACTIVE, c, t);
}

// SPELL FUNCTION: sets both teams' MP to 0
/// (use dark deal 10 times and you'll be awoken from sleeping to do the Cenotomb quest)
function dark_deal() {
	var t = activeSprite.enemy;
	var c = activeSprite.team;
	
	spar_effect_push_alert(SPAR_EFFECTS.DEPLETE_MP, t, t.currentMP);
	spar_effect_push_alert(SPAR_EFFECTS.DEPLETE_MP, c, c.currentMP);
}

/// SPELL FUNCTION: sets user team's HP to 1, ends the turn. Sets a variable indicating
/// that the whole team should become invulnerable at the beginning of the next turn
function hail_sphera() {
	var c = activeSprite.team;
	
	spar_effect_push_alert(SPAR_EFFECTS.DEPLETE_HP, c, c.currentHP - 1);
	spar_effect_push_alert(SPAR_EFFECTS.SET_HAIL_SPHERA, c);
	spar_effect_push_alert(SPAR_EFFECTS.FORCE_TURN_END);
}

#endregion  

// add all spells to grid	ID								NAME											DESCRIPTION										LORE											TYPE					POWER	COST	RANGE						EFFECT					DODGEABLE?		BYPASS DODGE		BYPASS FAILURE		BYPASS RANGE
master_grid_add_spell(		SPELLS.SOLAR_FLARE,				textGrid[# 1, SPELLS.SOLAR_FLARE],				textGrid[# 2, SPELLS.SOLAR_FLARE],				textGrid[# 3, SPELLS.SOLAR_FLARE],				SPELL_TYPES.FIRE,		150,	80,		ranges.nearestFiveSprites,	solar_flare,			true,			true,				false,				true);
master_grid_add_spell(		SPELLS.TIDAL_FORCE,				textGrid[# 1, SPELLS.TIDAL_FORCE],				textGrid[# 2, SPELLS.TIDAL_FORCE],				textGrid[# 3, SPELLS.TIDAL_FORCE],				SPELL_TYPES.WATER,		150,	80,		ranges.nearestFiveSprites,	tidal_force,			true,			true,				false,				true);
master_grid_add_spell(		SPELLS.NEBULA_STORM,			textGrid[# 1, SPELLS.NEBULA_STORM],				textGrid[# 2, SPELLS.NEBULA_STORM],				textGrid[# 3, SPELLS.NEBULA_STORM],				SPELL_TYPES.STORM,		150,	80,		ranges.nearestFiveSprites,	nebula_storm,			true,			true,				false,				true);
master_grid_add_spell(		SPELLS.TECTONIC_SHIFT,			textGrid[# 1, SPELLS.TECTONIC_SHIFT],			textGrid[# 2, SPELLS.TECTONIC_SHIFT],			textGrid[# 3, SPELLS.TECTONIC_SHIFT],			SPELL_TYPES.EARTH,		150,	80,		ranges.nearestFiveSprites,	tectonic_shift,			true,			true,				false,				true);
master_grid_add_spell(		SPELLS.FIREBALL,				textGrid[# 1, SPELLS.FIREBALL],					textGrid[# 2, SPELLS.FIREBALL],					textGrid[# 3, SPELLS.FIREBALL],					SPELL_TYPES.FIRE,		80,		25,		ranges.nearestFiveSprites,	fireball,				true,			false,				false,				false);
master_grid_add_spell(		SPELLS.HOLY_WATER,				textGrid[# 1, SPELLS.HOLY_WATER],				textGrid[# 2, SPELLS.HOLY_WATER],				textGrid[# 3, SPELLS.HOLY_WATER],				SPELL_TYPES.WATER,		70,		35,		ranges.nearestFiveSprites,	holy_water,				true,			false,				false,				false);
master_grid_add_spell(		SPELLS.SHOCK,					textGrid[# 1, SPELLS.SHOCK],					textGrid[# 2, SPELLS.SHOCK],					textGrid[# 3, SPELLS.SHOCK],					SPELL_TYPES.STORM,		80,		35,		ranges.nearestFiveSprites,	shock,					true,			false,				false,				false);
master_grid_add_spell(		SPELLS.DECAY,					textGrid[# 1, SPELLS.DECAY],					textGrid[# 2, SPELLS.DECAY],					textGrid[# 3, SPELLS.DECAY],					SPELL_TYPES.EARTH,		80,		30,		ranges.nearestFiveSprites,	decay,					false,			false,				false,				false);
master_grid_add_spell(		SPELLS.EXPEL_FORCE,				textGrid[# 1, SPELLS.EXPEL_FORCE],				textGrid[# 2, SPELLS.EXPEL_FORCE],				textGrid[# 3, SPELLS.EXPEL_FORCE],				SPELL_TYPES.PHYSICAL,	100,	30,		ranges.nearestThreeSprites,	expel_force,			true,			false,				false,				false);
master_grid_add_spell(		SPELLS.LADY_SOLANUS_GRACE,		textGrid[# 1, SPELLS.LADY_SOLANUS_GRACE],		textGrid[# 2, SPELLS.LADY_SOLANUS_GRACE],		textGrid[# 3, SPELLS.LADY_SOLANUS_GRACE],		SPELL_TYPES.TRICK,		0,		60,		ranges.onlySelf,			lady_solanus_grace,		false,			false,				false,				false);
master_grid_add_spell(		SPELLS.TYPHOON,					textGrid[# 1, SPELLS.TYPHOON],					textGrid[# 2, SPELLS.TYPHOON],					textGrid[# 3, SPELLS.TYPHOON],					SPELL_TYPES.STORM,		100,	35,		ranges.nearestThreeSprites,	typhoon,				true,			false,				false,				false);
master_grid_add_spell(		SPELLS.HEALING_LIGHT,			textGrid[# 1, SPELLS.HEALING_LIGHT],			textGrid[# 2, SPELLS.HEALING_LIGHT],			textGrid[# 3, SPELLS.HEALING_LIGHT],			SPELL_TYPES.TRICK,		0,		45,		ranges.onlySelf,			healing_light,			false,			false,				false,				false);
master_grid_add_spell(		SPELLS.RUBURS_WATER_CANNON,		textGrid[# 1, SPELLS.RUBURS_WATER_CANNON],		textGrid[# 2, SPELLS.RUBURS_WATER_CANNON],		textGrid[# 3, SPELLS.RUBURS_WATER_CANNON],		SPELL_TYPES.WATER,		120,	60,		ranges.nearestThreeSprites,	ruburs_water_cannon,	true,			false,				false,				false);
master_grid_add_spell(		SPELLS.RUBURS_GRAPPLE,			textGrid[# 1, SPELLS.RUBURS_GRAPPLE],			textGrid[# 2, SPELLS.RUBURS_GRAPPLE],			textGrid[# 3, SPELLS.RUBURS_GRAPPLE],			SPELL_TYPES.PHYSICAL,	80,		45,		ranges.nearestThreeSprites, ruburs_grapple,			true,			false,				false,				false);
master_grid_add_spell(		SPELLS.LUSIAS_HARVEST_SPELL,	textGrid[# 1, SPELLS.LUSIAS_HARVEST_SPELL],		textGrid[# 2, SPELLS.LUSIAS_HARVEST_SPELL],		textGrid[# 3, SPELLS.LUSIAS_HARVEST_SPELL],		SPELL_TYPES.EARTH,		110,	40,		ranges.nearestThreeSprites,	lusias_harvest_spell,	false,			true,				false,				true);
master_grid_add_spell(		SPELLS.WATERLOG,				textGrid[# 1, SPELLS.WATERLOG],					textGrid[# 2, SPELLS.WATERLOG],					textGrid[# 3, SPELLS.WATERLOG],					SPELL_TYPES.WATER,		70,		35,		ranges.nearestFiveSprites,	waterlog,				false,			false,				false,				false);
master_grid_add_spell(		SPELLS.AIR_PRESSURE,			textGrid[# 1, SPELLS.AIR_PRESSURE],				textGrid[# 2, SPELLS.AIR_PRESSURE],				textGrid[# 3, SPELLS.AIR_PRESSURE],				SPELL_TYPES.STORM,		70,		35,		ranges.nearestFiveSprites,	air_pressure,			true,			false,				false,				false);
master_grid_add_spell(		SPELLS.SUPERBLOOM,				textGrid[# 1, SPELLS.SUPERBLOOM],				textGrid[# 2, SPELLS.SUPERBLOOM],				textGrid[# 3, SPELLS.SUPERBLOOM],				SPELL_TYPES.EARTH,		100,	50,		ranges.nearestThreeSprites,	superbloom,				true,			true,				false,				true);
master_grid_add_spell(		SPELLS.RAPID_STRIKE,			textGrid[# 1, SPELLS.RAPID_STRIKE],				textGrid[# 2, SPELLS.RAPID_STRIKE],				textGrid[# 3, SPELLS.RAPID_STRIKE],				SPELL_TYPES.PHYSICAL,	75,		40,		ranges.nearestThreeSprites,	rapid_strike,			false,			false,				false,				false);
master_grid_add_spell(		SPELLS.LOOMING_DANGER,			textGrid[# 1, SPELLS.LOOMING_DANGER],			textGrid[# 2, SPELLS.LOOMING_DANGER],			textGrid[# 3, SPELLS.LOOMING_DANGER],			SPELL_TYPES.TRICK,		0,		30,		ranges.anySprite,			looming_danger,			false,			true,				false,				false);
master_grid_add_spell(		SPELLS.INTERCEPT,				textGrid[# 1, SPELLS.INTERCEPT],				textGrid[# 2, SPELLS.INTERCEPT],				textGrid[# 3, SPELLS.INTERCEPT],				SPELL_TYPES.TRICK,		0,		25,		ranges.nearestFiveSprites,	intercept,				false,			true,				false,				false);
master_grid_add_spell(		SPELLS.STEAM_BATH,				textGrid[# 1, SPELLS.STEAM_BATH],				textGrid[# 2, SPELLS.STEAM_BATH],				textGrid[# 3, SPELLS.STEAM_BATH],				SPELL_TYPES.WATER,		65,		35,		ranges.nearestFiveSprites,	steam_bath,				true,			true,				false,				true);
master_grid_add_spell(		SPELLS.UNDERTOW,				textGrid[# 1, SPELLS.UNDERTOW],					textGrid[# 2, SPELLS.UNDERTOW],					textGrid[# 3, SPELLS.UNDERTOW],					SPELL_TYPES.WATER,		100,	50,		ranges.nearestFiveSprites,	undertow,				false,			true,				false,				false);
master_grid_add_spell(		SPELLS.EMPATHIZE,				textGrid[# 1, SPELLS.EMPATHIZE],				textGrid[# 2, SPELLS.EMPATHIZE],				textGrid[# 3, SPELLS.EMPATHIZE],				SPELL_TYPES.TRICK,		0,		20,		ranges.anySprite,			empathize,				false,			true,				false,				false);
master_grid_add_spell(		SPELLS.HELLFIRE,				textGrid[# 1, SPELLS.HELLFIRE],					textGrid[# 2, SPELLS.HELLFIRE],					textGrid[# 3, SPELLS.HELLFIRE],					SPELL_TYPES.FIRE,		100,	50,		ranges.anySprite,			hellfire,				true,			false,				false,				false);
master_grid_add_spell(		SPELLS.BALL_LIGHTNING,			textGrid[# 1, SPELLS.BALL_LIGHTNING],			textGrid[# 2, SPELLS.BALL_LIGHTNING],			textGrid[# 3, SPELLS.BALL_LIGHTNING],			SPELL_TYPES.STORM,		0,		50,		ranges.nearestFiveSprites,	ball_lightning,			true,			true,				false,				false);
master_grid_add_spell(		SPELLS.QUICKSAND,				textGrid[# 1, SPELLS.QUICKSAND],				textGrid[# 2, SPELLS.QUICKSAND],				textGrid[# 3, SPELLS.QUICKSAND],				SPELL_TYPES.EARTH,		70,		40,		ranges.anySprite,			quicksand,				false,			true,				false,				false);
master_grid_add_spell(		SPELLS.LORD_MOGRADTHS_RAGE,		textGrid[# 1, SPELLS.LORD_MOGRADTHS_RAGE],		textGrid[# 2, SPELLS.LORD_MOGRADTHS_RAGE],		textGrid[# 3, SPELLS.LORD_MOGRADTHS_RAGE],		SPELL_TYPES.TRICK,		0,		50,		ranges.nearestFiveSprites,	lord_mogradths_rage,	false,			true,				false,				false);
master_grid_add_spell(		SPELLS.DRAIN_LIFEFORCE,			textGrid[# 1, SPELLS.DRAIN_LIFEFORCE],			textGrid[# 2, SPELLS.DRAIN_LIFEFORCE],			textGrid[# 3, SPELLS.DRAIN_LIFEFORCE],			SPELL_TYPES.PHYSICAL,	90,		40,		ranges.nearestFiveSprites,	drain_lifeforce,		true,			false,				false,				false);
master_grid_add_spell(		SPELLS.PYROKINESIS,				textGrid[# 1, SPELLS.PYROKINESIS],				textGrid[# 2, SPELLS.PYROKINESIS],				textGrid[# 3, SPELLS.PYROKINESIS],				SPELL_TYPES.FIRE,		135,	60,		ranges.nearestFiveSprites,	pyrokinesis,			false,			true,				true,				true);
master_grid_add_spell(		SPELLS.DOWNPOUR,				textGrid[# 1, SPELLS.DOWNPOUR],					textGrid[# 2, SPELLS.DOWNPOUR],					textGrid[# 3, SPELLS.DOWNPOUR],					SPELL_TYPES.WATER,		75,		40,		ranges.nearestFiveSprites,	downpour,				false,			true,				false,				true);
master_grid_add_spell(		SPELLS.ARC_BLAST,				textGrid[# 1, SPELLS.ARC_BLAST],				textGrid[# 2, SPELLS.ARC_BLAST],				textGrid[# 3, SPELLS.ARC_BLAST],				SPELL_TYPES.STORM,		110,	50,		ranges.nearestThreeSprites,	arc_blast,				false,			false,				false,				false);
master_grid_add_spell(		SPELLS.HIKAMS_WINTER_SPELL,		textGrid[# 1, SPELLS.HIKAMS_WINTER_SPELL],		textGrid[# 2, SPELLS.HIKAMS_WINTER_SPELL],		textGrid[# 3, SPELLS.HIKAMS_WINTER_SPELL],		SPELL_TYPES.EARTH,		70,		30,		ranges.anySprite,			hikams_winter_spell,	false,			true,				false,				false);
master_grid_add_spell(		SPELLS.OSMOSIS,					textGrid[# 1, SPELLS.OSMOSIS],					textGrid[# 2, SPELLS.OSMOSIS],					textGrid[# 3, SPELLS.OSMOSIS],					SPELL_TYPES.WATER,		90,		40,		ranges.nearestFiveSprites,	osmosis,				false,			false,				false,				false);
master_grid_add_spell(		SPELLS.FLASH_FREEZE,			textGrid[# 1, SPELLS.FLASH_FREEZE],				textGrid[# 2, SPELLS.FLASH_FREEZE],				textGrid[# 3, SPELLS.FLASH_FREEZE],				SPELL_TYPES.WATER,		110,	50,		ranges.nearestFiveSprites,	flash_freeze,			false,			false,				false,				false);
master_grid_add_spell(		SPELLS.LANDSLIDE,				textGrid[# 1, SPELLS.LANDSLIDE],				textGrid[# 2, SPELLS.LANDSLIDE],				textGrid[# 3, SPELLS.LANDSLIDE],				SPELL_TYPES.EARTH,		110,	50,		ranges.nearestFiveSprites,	landslide,				true,			true,				false,				true);
master_grid_add_spell(		SPELLS.AMANDS_ENERGY_BLAST,		textGrid[# 1, SPELLS.AMANDS_ENERGY_BLAST],		textGrid[# 2, SPELLS.AMANDS_ENERGY_BLAST],		textGrid[# 3, SPELLS.AMANDS_ENERGY_BLAST],		SPELL_TYPES.TRICK,		0,		40,		ranges.onlySelf,			amands_energy_blast,	true,			true,				false,				false);
master_grid_add_spell(		SPELLS.SHIFT_PERSPECTIVE,		textGrid[# 1, SPELLS.SHIFT_PERSPECTIVE],		textGrid[# 2, SPELLS.SHIFT_PERSPECTIVE],		textGrid[# 3, SPELLS.SHIFT_PERSPECTIVE],		SPELL_TYPES.TRICK,		0,		35,		ranges.anySprite,			shift_perspective,		false,			false,				false,				false);
master_grid_add_spell(		SPELLS.PSYCHIC_IMPACT,			textGrid[# 1, SPELLS.PSYCHIC_IMPACT],			textGrid[# 2, SPELLS.PSYCHIC_IMPACT],			textGrid[# 3, SPELLS.PSYCHIC_IMPACT],			SPELL_TYPES.TRICK,		75,		50,		ranges.anySprite,			psychic_impact,			false,			true,				false,				false);
master_grid_add_spell(		SPELLS.TREMOR,					textGrid[# 1, SPELLS.TREMOR],					textGrid[# 2, SPELLS.TREMOR],					textGrid[# 3, SPELLS.TREMOR],					SPELL_TYPES.EARTH,		120,	60,		ranges.nearestThreeSprites,	tremor,					false,			true,				false,				true);
master_grid_add_spell(		SPELLS.SKYDIVE,					textGrid[# 1, SPELLS.SKYDIVE],					textGrid[# 2, SPELLS.SKYDIVE],					textGrid[# 3, SPELLS.SKYDIVE],					SPELL_TYPES.PHYSICAL,	0,		50,		ranges.nearestThreeSprites,	skydive,				false,			false,				false,				false);
master_grid_add_spell(		SPELLS.DESTRUCTIVE_BLOW,		textGrid[# 1, SPELLS.DESTRUCTIVE_BLOW],			textGrid[# 2, SPELLS.DESTRUCTIVE_BLOW],			textGrid[# 3, SPELLS.DESTRUCTIVE_BLOW],			SPELL_TYPES.PHYSICAL,	100,	40,		ranges.nearestThreeSprites,	destructive_blow,		true,			false,				false,				false);
master_grid_add_spell(		SPELLS.PURIFYING_FLAME,			textGrid[# 1, SPELLS.PURIFYING_FLAME],			textGrid[# 2, SPELLS.PURIFYING_FLAME],			textGrid[# 3, SPELLS.PURIFYING_FLAME],			SPELL_TYPES.FIRE,		100,	40,		ranges.nearestFiveSprites,	purifying_flame,		true,			false,				false,				false);
master_grid_add_spell(		SPELLS.JABULS_FIGHT_SONG,		textGrid[# 1, SPELLS.JABULS_FIGHT_SONG],		textGrid[# 2, SPELLS.JABULS_FIGHT_SONG],		textGrid[# 3, SPELLS.JABULS_FIGHT_SONG],		SPELL_TYPES.TRICK,		0,		35,		ranges.onlySelf,			jabuls_fight_song,		false,			true,				false,				true);
master_grid_add_spell(		SPELLS.NOXIOUS_FUMES,			textGrid[# 1, SPELLS.NOXIOUS_FUMES],			textGrid[# 2, SPELLS.NOXIOUS_FUMES],			textGrid[# 3, SPELLS.NOXIOUS_FUMES],			SPELL_TYPES.FIRE,		75,		40,		ranges.nearestFiveSprites,	noxious_fumes,			false,			true,				false,				true);
master_grid_add_spell(		SPELLS.CRECIAS_CRYSTAL_SPIKES,	textGrid[# 1, SPELLS.CRECIAS_CRYSTAL_SPIKES],	textGrid[# 2, SPELLS.CRECIAS_CRYSTAL_SPIKES],	textGrid[# 3, SPELLS.CRECIAS_CRYSTAL_SPIKES],	SPELL_TYPES.EARTH,		120,	65,		ranges.nearestThreeSprites,	crecias_crystal_spikes,	false,			false,				false,				false);
master_grid_add_spell(		SPELLS.PSYCHIC_FISSURE,			textGrid[# 1, SPELLS.PSYCHIC_FISSURE],			textGrid[# 2, SPELLS.PSYCHIC_FISSURE],			textGrid[# 3, SPELLS.PSYCHIC_FISSURE],			SPELL_TYPES.TRICK,		125,	70,		ranges.anySprite,			psychic_fissure,		false,			true,				true,				true);
master_grid_add_spell(		SPELLS.REARRANGE,				textGrid[# 1, SPELLS.REARRANGE],				textGrid[# 2, SPELLS.REARRANGE],				textGrid[# 3, SPELLS.REARRANGE],				SPELL_TYPES.TRICK,		0,		40,		ranges.nearestThreeSprites,	rearrange,				true,			false,				false,				false);
master_grid_add_spell(		SPELLS.SNEAK_ATTACK,			textGrid[# 1, SPELLS.SNEAK_ATTACK],				textGrid[# 2, SPELLS.SNEAK_ATTACK],				textGrid[# 3, SPELLS.SNEAK_ATTACK],				SPELL_TYPES.PHYSICAL,	0,		50,		ranges.nearestFiveSprites,	sneak_attack,			false,			false,				false,				false);
master_grid_add_spell(		SPELLS.DEFLECTIVE_SHIELD,		textGrid[# 1, SPELLS.DEFLECTIVE_SHIELD],		textGrid[# 2, SPELLS.DEFLECTIVE_SHIELD],		textGrid[# 3, SPELLS.DEFLECTIVE_SHIELD],		SPELL_TYPES.TRICK,		0,		50,		ranges.onlySelf,			deflective_shield,		false,			true,				false,				true);
master_grid_add_spell(		SPELLS.DIONS_PARRY,				textGrid[# 1, SPELLS.DIONS_PARRY],				textGrid[# 2, SPELLS.DIONS_PARRY],				textGrid[# 3, SPELLS.DIONS_PARRY],				SPELL_TYPES.PHYSICAL,	0,		40,		ranges.onlySelf,			dions_parry,			false,			true,				false,				true);
master_grid_add_spell(		SPELLS.DIONS_GAMBLING_BLAST,	textGrid[# 1, SPELLS.DIONS_GAMBLING_BLAST],		textGrid[# 2, SPELLS.DIONS_GAMBLING_BLAST],		textGrid[# 3, SPELLS.DIONS_GAMBLING_BLAST],		SPELL_TYPES.TRICK,		0,		35,		ranges.onlySelf,			dions_gambling_blast,	false,			true,				false,				true);
master_grid_add_spell(		SPELLS.DIONS_BARTER_TRICK,		textGrid[# 1, SPELLS.DIONS_BARTER_TRICK],		textGrid[# 2, SPELLS.DIONS_BARTER_TRICK],		textGrid[# 3, SPELLS.DIONS_BARTER_TRICK],		SPELL_TYPES.TRICK,		0,		0,		ranges.onlySelf,			dions_barter_trick,		false,			true,				false,				true);
master_grid_add_spell(		SPELLS.MAGNETIC_PULSE,			textGrid[# 1, SPELLS.MAGNETIC_PULSE],			textGrid[# 2, SPELLS.MAGNETIC_PULSE],			textGrid[# 3, SPELLS.MAGNETIC_PULSE],			SPELL_TYPES.STORM,		90,		40,		ranges.nearestFiveSprites,	magnetic_pulse,			true,			true,				false,				true);
master_grid_add_spell(		SPELLS.BURN_OUT,				textGrid[# 1, SPELLS.BURN_OUT],					textGrid[# 2, SPELLS.BURN_OUT],					textGrid[# 3, SPELLS.BURN_OUT],					SPELL_TYPES.FIRE,		140,	50,		ranges.nearestThreeSprites,	burn_out,				true,			true,				true,				true);
master_grid_add_spell(		SPELLS.STINKBOMB,				textGrid[# 1, SPELLS.STINKBOMB],				textGrid[# 2, SPELLS.STINKBOMB],				textGrid[# 3, SPELLS.STINKBOMB],				SPELL_TYPES.EARTH,		100,	50,		ranges.nearestFiveSprites,	stinkbomb,				true,			true,				false,				true);
master_grid_add_spell(		SPELLS.WIND_SLICE,				textGrid[# 1, SPELLS.WIND_SLICE],				textGrid[# 2, SPELLS.WIND_SLICE],				textGrid[# 3, SPELLS.WIND_SLICE],				SPELL_TYPES.STORM,		120,	55,		ranges.nearestFiveSprites,	wind_slice,				true,			false,				false,				false);
master_grid_add_spell(		SPELLS.CHANNEL_ESSENCE,			textGrid[# 1, SPELLS.CHANNEL_ESSENCE],			textGrid[# 2, SPELLS.CHANNEL_ESSENCE],			textGrid[# 3, SPELLS.CHANNEL_ESSENCE],			SPELL_TYPES.TRICK,		0,		30,		ranges.onlySelf,			channel_essence,		false,			true,				false,				true);
master_grid_add_spell(		SPELLS.SPHERAS_CURSE,			textGrid[# 1, SPELLS.SPHERAS_CURSE],			textGrid[# 2, SPELLS.SPHERAS_CURSE],			textGrid[# 3, SPELLS.SPHERAS_CURSE],			SPELL_TYPES.TRICK,		0,		30,		ranges.nearestOneEnemy,		spheras_curse,			false,			true,				false,				true);
master_grid_add_spell(		SPELLS.CRECIAS_CRYSTAL_WIND,	textGrid[# 1, SPELLS.CRECIAS_CRYSTAL_WIND],		textGrid[# 2, SPELLS.CRECIAS_CRYSTAL_WIND],		textGrid[# 3, SPELLS.CRECIAS_CRYSTAL_WIND],		SPELL_TYPES.EARTH,		100,	45,		ranges.nearestFiveSprites,	crecias_crystal_wind,	true,			true,				false,				false);
master_grid_add_spell(		SPELLS.LAVA_SPIRE,				textGrid[# 1, SPELLS.LAVA_SPIRE],				textGrid[# 2, SPELLS.LAVA_SPIRE],				textGrid[# 3, SPELLS.LAVA_SPIRE],				SPELL_TYPES.FIRE,		100,	50,		ranges.nearestThreeSprites,	lava_spire,				true,			true,				false,				true);
master_grid_add_spell(		SPELLS.ENDLESS_RIVER,			textGrid[# 1, SPELLS.ENDLESS_RIVER],			textGrid[# 2, SPELLS.ENDLESS_RIVER],			textGrid[# 3, SPELLS.ENDLESS_RIVER],			SPELL_TYPES.WATER,		80,		40,		ranges.nearestFiveSprites,	endless_river,			true,			true,				false,				true);
master_grid_add_spell(		SPELLS.CLOUD_BREAK,				textGrid[# 1, SPELLS.CLOUD_BREAK],				textGrid[# 2, SPELLS.CLOUD_BREAK],				textGrid[# 3, SPELLS.CLOUD_BREAK],				SPELL_TYPES.STORM,		60,		30,		ranges.anySprite,			cloud_break,			false,			true,				false,				true);
master_grid_add_spell(		SPELLS.TELEKINETIC_BLAST,		textGrid[# 1, SPELLS.TELEKINETIC_BLAST],		textGrid[# 2, SPELLS.TELEKINETIC_BLAST],		textGrid[# 3, SPELLS.TELEKINETIC_BLAST],		SPELL_TYPES.PHYSICAL,	120,	65,		ranges.anySprite,			telekinetic_blast,		false,			true,				false,				false);
master_grid_add_spell(		SPELLS.KNOCK_OVER,				textGrid[# 1, SPELLS.KNOCK_OVER],				textGrid[# 2, SPELLS.KNOCK_OVER],				textGrid[# 3, SPELLS.KNOCK_OVER],				SPELL_TYPES.PHYSICAL,	100,	40,		ranges.nearestFiveSprites,	knock_over,				true,			false,				false,				false);
master_grid_add_spell(		SPELLS.FULL_THRUST,				textGrid[# 1, SPELLS.FULL_THRUST],				textGrid[# 2, SPELLS.FULL_THRUST],				textGrid[# 3, SPELLS.FULL_THRUST],				SPELL_TYPES.PHYSICAL,	160,	60,		ranges.nearestThreeSprites,	full_thrust,			true,			true,				true,				true);
master_grid_add_spell(		SPELLS.VOLCANIC_ERUPTION,		textGrid[# 1, SPELLS.VOLCANIC_ERUPTION],		textGrid[# 2, SPELLS.VOLCANIC_ERUPTION],		textGrid[# 3, SPELLS.VOLCANIC_ERUPTION],		SPELL_TYPES.FIRE,		130,	70,		ranges.nearestThreeSprites,	volcanic_eruption,		true,			true,				false,				true);
master_grid_add_spell(		SPELLS.BROADCAST_DATA,			textGrid[# 1, SPELLS.BROADCAST_DATA],			textGrid[# 2, SPELLS.BROADCAST_DATA],			textGrid[# 3, SPELLS.BROADCAST_DATA],			SPELL_TYPES.TRICK,		0,		40,		ranges.onlySelf,			broadcast_data,			false,			true,				false,				true);
master_grid_add_spell(		SPELLS.COLLAPSE_SPACE,			textGrid[# 1, SPELLS.COLLAPSE_SPACE],			textGrid[# 2, SPELLS.COLLAPSE_SPACE],			textGrid[# 3, SPELLS.COLLAPSE_SPACE],			SPELL_TYPES.TRICK,		0,		40,		ranges.onlySelf,			collapse_space,			false,			true,				false,				true);
master_grid_add_spell(		SPELLS.EXPAND_TIME,				textGrid[# 1, SPELLS.EXPAND_TIME],				textGrid[# 2, SPELLS.EXPAND_TIME],				textGrid[# 3, SPELLS.EXPAND_TIME],				SPELL_TYPES.TRICK,		0,		40,		ranges.onlySelf,			expand_time,			false,			true,				false,				true);
master_grid_add_spell(		SPELLS.SPHERAS_DEMISE,			textGrid[# 1, SPELLS.SPHERAS_DEMISE],			textGrid[# 2, SPELLS.SPHERAS_DEMISE],			textGrid[# 3, SPELLS.SPHERAS_DEMISE],			SPELL_TYPES.TRICK,		0,		40,		ranges.onlySelf,			spheras_demise,			false,			true,				false,				true);
master_grid_add_spell(		SPELLS.TIME_LOOP,				textGrid[# 1, SPELLS.TIME_LOOP],				textGrid[# 2, SPELLS.TIME_LOOP],				textGrid[# 3, SPELLS.TIME_LOOP],				SPELL_TYPES.TRICK,		0,		50,		ranges.anySprite,			time_loop,				false,			true,				false,				true);
master_grid_add_spell(		SPELLS.ERADICATE,				textGrid[# 1, SPELLS.ERADICATE],				textGrid[# 2, SPELLS.ERADICATE],				textGrid[# 3, SPELLS.ERADICATE],				SPELL_TYPES.TRICK,		0,		65,		ranges.onlySelf,			eradicate,				false,			true,				false,				true);
master_grid_add_spell(		SPELLS.DARK_DEAL,				textGrid[# 1, SPELLS.DARK_DEAL],				textGrid[# 2, SPELLS.DARK_DEAL],				textGrid[# 3, SPELLS.DARK_DEAL],				SPELL_TYPES.TRICK,		0,		1,		ranges.onlySelf,			dark_deal,				false,			true,				false,				true);
master_grid_add_spell(		SPELLS.HAIL_SPHERA,				textGrid[# 1, SPELLS.HAIL_SPHERA],				textGrid[# 2, SPELLS.HAIL_SPHERA],				textGrid[# 3, SPELLS.HAIL_SPHERA],				SPELL_TYPES.TRICK,		0,		60,		ranges.onlySelf,			hail_sphera,			false,			true,				false,				true);			
// encode spell grid
global.allSpells = encode_grid(global.spellGrid);

// delete spell grid
//ds_grid_destroy(global.spellGrid);

///@desc This function is meant to be called by the spellbook whenever there is a new currentSpell.
function spellbook_load_spell_params() {	
	// use index to get all params
	currentSpell	= player.spellBookGrid[# SPELL_PARAMS.ID,			index];
	name			= player.spellBookGrid[# SPELL_PARAMS.NAME,			index];
	description		= player.spellBookGrid[# SPELL_PARAMS.DESCRIPTION,	index];
	spellType		= player.spellBookGrid[# SPELL_PARAMS.TYPE,			index];
	spellRange		= player.spellBookGrid[# SPELL_PARAMS.RANGE,		index];
	spellPower		= player.spellBookGrid[# SPELL_PARAMS.POWER,		index];
	spellCost		= player.spellBookGrid[# SPELL_PARAMS.COST,			index];
	
	description = string_insert("   ", description, 0);
	
	spell_set_potential_cost(spellCost);
}

///@desc This function is meant to be called by the sparActionProcessor whenever a spell is being cast
function processor_load_spell_params() {
	// decode spell grid
	var grid = ds_grid_create(SPELL_PARAMS.HEIGHT, SPELLS.HEIGHT);
	decode_grid(global.allSpells, grid);
	
	// use currentSpell to get all params
	spellName		= grid[# SPELL_PARAMS.NAME,							currentSpell];
	spellCost		= real(grid[# SPELL_PARAMS.COST,					currentSpell]);
	spellType		= real(grid[# SPELL_PARAMS.TYPE,					currentSpell]);
	spellPower		= real(grid[# SPELL_PARAMS.POWER,					currentSpell]);
	spellEffect		= correct_string_after_decode(grid[# SPELL_PARAMS.EFFECT,	currentSpell]);
	spellDodgeable	= real(grid[# SPELL_PARAMS.DODGEABLE,				currentSpell]);
	spellRange		= real(grid[# SPELL_PARAMS.RANGE,					currentSpell]);
	bypassDodge		= real(grid[# SPELL_PARAMS.BYPASS_DODGE,			currentSpell]);
	bypassFailure	= real(grid[# SPELL_PARAMS.BYPASS_FAILURE,			currentSpell]);
	bypassRange		= real(grid[# SPELL_PARAMS.BYPASS_RANGE,			currentSpell]);
	
	// destroy spell grid
	ds_grid_destroy(grid);
}

///@desc This function is meant to be called by the sparActionProcessor whenever a spell is being cast
function builder_load_spell_params() {
	// decode spell grid
	var grid = ds_grid_create(SPELL_PARAMS.HEIGHT, SPELLS.HEIGHT);
	decode_grid(global.allSpells, grid);
	
	if (displaySpell == -1) {
		// use currentSpell to get all params
		spellName		= grid[# SPELL_PARAMS.NAME,							currentSpell];
		spellCost		= real(grid[# SPELL_PARAMS.COST,					currentSpell]);
		spellType		= real(grid[# SPELL_PARAMS.TYPE,					currentSpell]);
		spellPower		= real(grid[# SPELL_PARAMS.POWER,					currentSpell]);
		spellEffect		= correct_string_after_decode(grid[# SPELL_PARAMS.EFFECT,	currentSpell]);
		spellDodgeable	= real(grid[# SPELL_PARAMS.DODGEABLE,				currentSpell]);
		spellRange		= real(grid[# SPELL_PARAMS.RANGE,					currentSpell]);
		description		= grid[# SPELL_PARAMS.DESCRIPTION,					currentSpell];
	}
	else {
		// use currentSpell to get all params
		spellName		= grid[# SPELL_PARAMS.NAME,							displaySpell];
		spellCost		= real(grid[# SPELL_PARAMS.COST,					displaySpell]);
		spellType		= real(grid[# SPELL_PARAMS.TYPE,					displaySpell]);
		spellPower		= real(grid[# SPELL_PARAMS.POWER,					displaySpell]);
		spellEffect		= correct_string_after_decode(grid[# SPELL_PARAMS.EFFECT,	displaySpell]);
		spellDodgeable	= real(grid[# SPELL_PARAMS.DODGEABLE,				displaySpell]);
		spellRange		= real(grid[# SPELL_PARAMS.RANGE,					displaySpell]);
		description		= grid[# SPELL_PARAMS.DESCRIPTION,					displaySpell];	
	}
	// destroy spell grid
	ds_grid_destroy(grid);
}

function spell_type_get_string(_spellType) {
	var t = _spellType;
	
	switch (t) {
		case SPELL_TYPES.FIRE:
			return "FIRE";
		break;
		
		case SPELL_TYPES.WATER:
			return "WATER";
		break;
		
		case SPELL_TYPES.STORM:
			return "STORM";
		break;
		
		case SPELL_TYPES.EARTH:
			return "EARTH";
		break;
		
		case SPELL_TYPES.PHYSICAL:
			return "PHYSICAL";
		break;
		
		case SPELL_TYPES.TRICK:
			return "TRICK";
		break;
		
		case SPELL_TYPES.HEIGHT:
			return "ANY";
		break;
	}
}

function action_get_spell_id(_action) {
	return _action - sparActions.height;
}