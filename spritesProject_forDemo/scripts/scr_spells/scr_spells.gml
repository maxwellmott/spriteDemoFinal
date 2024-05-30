// set legal spell count
#macro	SPELLMAX				8
#macro	BASIC_ATTACK_POWER		75
//
#macro AMANDS_BLAST		400

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
	HEIGHT
}

#region BUILD PRIORITY LIST
	var priorityList = ds_list_create();
	
	// populate priority list
	ds_list_add(priorityList,	SPELLS.SHOCK,		SPELLS.RAPID_STRIKE,		SPELLS.BALL_LIGHTNING,		SPELLS.FLASH_FREEZE,	SPELLS.SNEAK_ATTACK,
								SPELLS.SKYDIVE,		SPELLS.DEFLECTIVE_SHIELD,	SPELLS.DIONS_PARRY,		SPELLS.TIME_LOOP,		SPELLS.ERADICATE);
								
	// encode priority list
	global.prioritySpellList = encode_list(priorityList);
	
	// delete temp list
	ds_list_destroy(priorityList);

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
	spar_effect_push_alert(SPAR_EFFECTS.BESTOW_MINDSET_TEAM, t, -1 * (MINDSETS.WARRIOR));
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
		spar_effect_push_alert(SPAR_EFFECTS.INCREASE_DAMAGE_ASTRAL, 1.5);
	}
}

///@desc SPELL FUNCTION: binds target (dodgeable)
function shock() {
	if !(dodgeSuccess) {
		var t = 
		
		spar_effect_push_alert(SPAR_EFFECTS.SET_BOUND, t)
	}
}

///@desc SPELL FUNCTION: restores half of health depleted (dodgeable)
function decay() {
	if (dodgeSuccess == false) {
		var t = activeSprite.team;
		var d = damage / 2;
		
		spar_effect_push_alert(SPAR_EFFECTS.DRAIN_HEALTH, t, d);
	}
}

function expel_force() {
	// no effect
}

///@desc SPELL FUNCTION: partially restores team and grants all allies blessing of the tree
function lady_solanus_grace() {
	// get caster's team
	var t = activeSprite.team;
	
	spar_effect_push_alert(SPAR_EFFECTS.FULLY_RESTORE_HP, t);
	spar_effect_push_alert(SPAR_EFFECTS.BESTOW_MINDSET_TEAM, t, MINDSETS.TREE);
}

///@desc SPELL FUNCTION: grants target curse of the tree (dodgeable)
function typhoon() {
	if !(dodgeSuccess) {
		var t = targetSprite;
		
		spar_effect_push_alert(SPAR_EFFECTS.BESTOW_MINDSET, t, 0 - MINDSETS.TREE);
	}
}

///@desc SPELL FUNCTION: fully heals the caster's team
function healing_light() {
	var t = activeSprite.team;
	
	spar_effect_push_alert(SPAR_EFFECTS.FULLY_RESTORE_HP, t);
}

///@desc SPELL FUNCTION: no effect
function ruburs_water_cannon() {
	// no effect
}

///@desc SPELL FUNCTION: binds the target (dodgeable)
function ruburs_grapple() {
	if !(dodgeSuccess) {
		var t = targetSprite;
		
		spar_effect_push_alert(SPAR_EFFECTS.SET_BOUND, t)
	}
}

///@desc SPELL FUNCTION: changes arena to forest
function lusias_harvest_spell() {
	spar_effect_push_alert(SPAR_EFFECTS.ARENA_CHANGE_FOREST);
}

///@desc SPELL FUNCTION: grants target the curse of the tree
function waterlog() {
	var t = targetSprite;
	
	spar_effect_push_alert(SPAR_EFFECTS.BESTOW_MINDSET, t, 0 - MINDSETS.TREE);
}

///@desc SPELL FUNCTION: grants target and all nearby enemies the curse of the tree
function air_pressure() {
	var t = targetSprite.team;
	
	spar_effect_push_alert(SPAR_EFFECTS.BESTOW_MINDSET_TEAM, t);
}

///@desc SPELL FUNCTION: removes all curses and hindrances from caster's side of the field
function superbloom() {
	var t = targetSprite.team;
	
	spar_effect_push_alert(SPAR_EFFECTS.CLEAR_TEAM_HINDRANCES, t);
}

///@desc SPELL FUNCTION: this spell strikes first. it's id will be on a list of priority moves
function rapid_strike() {
	// the ID of this spell is on a list of "prioritySpells"
}

///@desc SPELL FUNCTION: this spell starts a timer for an Energy Blast on the
/// target's team.
function looming_danger() {	
	var c = 3;
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
	
	spar_effect_push_alert(SPAR_EFFECTS.CLEAR_TEAM_HINDRANCES, c);
	
	spar_effect_push_alert(SPAR_EFFECTS.SET_RUST, t);
}

///@desc SPELL FUNCTION: grants target curse of the imp
function undertow() {
	var t = targetSprite;
	
	spar_effect_push_alert(SPAR_EFFECTS.BESTOW_MINDSET, t, 0 - MINDSETS.IMP);
}

///@desc SPELL FUNCTION: adopts target's mindset and fully heals target or caster's team
/// depending on whether the mindset in question is a blessing or a curse. (dodgeable)
function empathize() {
	if !(dodgeSuccess) {
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
	// turn the caster's ballLightningActive variable to true
	activeSprite.ballLightningActive = true;
}

///@desc SPELL FUNCTION: binds the target
function quicksand() {
	// store targetSprite
	var t = targetSprite;
	
	// bind the targetSprite
	set_bound(t);
}

///@desc SPELL FUNCTION: hexes and binds the target and all nearby allies (target can dodge)
function lord_mogradths_rage() {
	// store targetSprite in a local variable
	var t = targetSprite;
	
	// initialize the dummy list
	var list = ds_list_create();
	
	// get nearbyAllies list
	ds_list_copy(list, t.nearbyAllies);
	
	// use a repeat loop to hex and bind all nearby allies
	var i = 0;	repeat (ds_list_size(list)) {
		var s = list[| i];
		set_hexed(s);
		set_bound(s);
		
		// increment i
		i++;
	}
	
	// check for dodgeSuccess
	if !(dodgeSuccess) {
		// if no successful dodge, hex and bind target
		set_hexed(t);
		set_bound(t);
	}
}

///@desc SPELL FUNCTION: restores half of the health depleted from target (dodgeable)
function drain_lifeforce() {
	if (dodgeSuccess == false) {
		var t = activeSprite.team;
		var d = damage / 2;
		
		restore_hp(t, d);
	}
}

///@desc SPELL FUNCTION: deals a fraction of the damage to the caster
function pyrokinesis() {
	if (dodgeSuccess) {
		// calculate what the damage would have been so that you
		// can still calculate the recoil damage
		var d = 100;	///@FIXME
	}
	else {
		var d = damage / 3;	
	}
	
	// get caster's team
	var t = activeSprite.team;
	
	deplete_hp(t, d);
}

///@desc SPELL FUNCTION: summons rust on the target's side of the field
function downpour() {
	var t = targetSprite.team;
	
	set_rust(t);
}

///@desc SPELL FUNCTION: grants the target the curse of the imp (dodgeable)
function arc_blast() {
	var t = targetSprite;
	
	bestow_mindset(t, 0 - MINDSETS.IMP);
}

///@desc SPELL FUNCTION: fails unless forest is active, removes forest, fully restores caster's
/// HP, and grants blessing of the tree to all nearby allies
function hikams_winter_spell() {
	// fail unless forest is active
	if (spar.currentArena == arenas.forest) {	
		var t = activeSprite.team;
		
		// fully restore caster's MP and HP
		fully_restore_hp(t);

		// grant blessing of the tree to all nearby allies
		var i = 0;	repeat (ds_list_size(activeSprite.nearbyAllies)) {
			var inst = nearbyAllies[| i];
			
			bestow_mindset(inst, MINDSETS.TREE);
			
			i++;
		}
		
		// reset arena
		spar.currentArena = -1;
	}
}

///@desc SPELL FUNCTION: adopts the target's mindset. if curse, heal target team fully. If blessing, heal caster team fully
function osmosis() {
	if !(dodgeSuccess) {
		// store target and caster in locals
		var t = targetSprite;
		var c = activeSprite;
		
		// check if target has an altered mindset
		if (t.mindset != 0) {
			c.mindset = t.mindset;
			
			// if curse, fully heal target team
			if (t.mindset < 0) {
				fully_restore_hp(t.team);	
			}
			
			// if blessing, fully heal caster's team
			if (t.mindset > 0) {
				fully_restore_hp(c.team);	
			}
		}
	}
}

///@desc SPELL FUNCTION: this spell is a priority spell that binds the target so long as it is not dodged.
function flash_freeze() {
	// IS A PRIORITY MOVE
	
	var t = targetSprite;
	
	// bind the target
	if !(dodgeSuccess) {
		if !(t.bound) {
			set_bound(t);
		}
	}
}

///@desc SPELL FUNCTION: resets the arena and grants curse of the warrior to target and nearby allies
function landslide() {
	arena_change_normal();
	
	var t = targetSprite;
	
	var l = ds_list_create();
	
	ds_list_copy(l, t.nearbyAllies);
	
	bestow_mindset(t, 0 - MINDSETS.WARRIOR);
	
	var i = 0;	repeat (ds_list_size(l)) {
		var inst = l[| i];
		
		bestow_mindset(inst, 0 - MINDSETS.WARRIOR);
		
		i++;
	}
}

///@desc SPELL FUNCTION: creates an Energy Blast against the enemy team that always deals 400 damage
function amands_energy_blast() {
	var t = targetSprite.team;
	
	energy_blast(t, AMANDS_BLAST);
}

///@desc SPELL FUNCTION: flips the targets mindset. If curse->blessing, heal some HP, if blessing->curse, remove some HP,
/// so long as it isn't dodged.
function shift_perspective() {
	if !(dodgeSuccess) {
		// flip the target's mindset
		var t = targetSprite;
		var m = t.mindset;
		
		if (m != 0) {
			// if curse->blessing heal some HP
			if (m < 0) {
				restore_hp(t.team, 200);	
			}
		
			// if blessing->curse remove some HP
			if (m > 0) {
				deplete_hp_nonlethal(t.team, 200);
			}
		}
	}
}

///@desc SPELL FUNCTION: THIS FUNCTION IS STILL UNFINISHED
function psychic_impact() {
	// find target's weak spot and attack them there
	if !(dodgeSuccess) {
		// calculate damage for each possible element
		
		// check which is the highest

		// set the damage to equal that amount
	}
}

function tremor() {
	// no effect
}

///@desc SPELL FUNCTION: the caster of this spell flies into the sky and becomes invulnerable
/// until the end of the turn when they swoop back in for an attack.
function skydive() {
	// PRIORITY MOVE
	
	var c = activeSprite;
	var t = targetSprite;
	
	// become invulnerable until the end of the turn
	c.flying = true;
	
	// add skydive to list of skydives
	grid_add_skydive(c, t)
}

///@desc SPELL FUNCTION: this spell does extra damage when cast against mechanical sprites, it then
/// changes their type to natural.
function destructive_blow() {
	var t = targetSprite;
	
	if (t.currentAlign == ALIGNMENTS.MECHANICAL) {
		damage = damage * 1.5;
		
		t.currentAlign = ALIGNMENTS.NATURAL;
	}
}

///@desc SPELL FUNCTION: this spell does extra damage when cast against astral sprites, it then
/// changes their type to natural.
function purifying_flame() {
	var t = targetSprite;
	
	if (t.currentAlign == ALIGNMENTS.ASTRAL) {
		damage = damage * 1.5;
		
		t.currentAlign = ALIGNMENTS.NATURAL;
	}
}

///@desc SPELL FUNCTION: partially restore target's HP and grant blessing
/// of the warrior to them and all their nearby allies
function jabuls_fight_song() {
	var c = activeSprite;
	
	var l = ds_list_create();
	ds_list_copy(l, c.nearbyAllies);
	
	var i = 0;	repeat (ds_list_size(l)) {
		var inst = l[| i];
		
		bestow_mindset(inst, MINDSETS.WARRIOR);
		
		i++;	
	}
}

///@desc SPELL FUNCTION: summons miasma on the target's side of the field
function noxious_fumes() {
	var t = targetSprite.team;
	
	set_miasma(t);
}

///@desc SPELL FUNCTION: hexes the target
function crecias_crystal_spikes() {
	var t = targetSprite;
	
	set_hexed(t);
}

///@desc SPELL FUNCTION: finds the element that would deal the most damage and sets the spell's
/// type to match the results. This spell also deals damage to the caster, even if it's dodged.
function psychic_fissure() {
	var d = 0;
	
	// calculate damage for each possible element
	
	// check which is the highest
	
	// set d to equal that amount
	
	if !(dodgeSuccess) {
		// set current damage to equal d	
	}
	
}

///@desc SPELL FUNCTION: splits the target team into two pairs and swaps them
function rearrange() {
	randomize();
	
	if !(dodgeSuccess) {
		// get target's spot number
		var ct = activeSprite.team;
		
		// create a dummy list
		var iil = ds_list_create();
		
		// find out which list to copy
		if (ct == spar.playerOne)	ds_list_copy(iil, spar.enemyList);
		if (ct == spar.playerTwo)	ds_list_copy(iil, spar.allyList);
		
		// get a random integer
		var int = irandom_range(0, 3);
		
		// set target as the list token at the index of the random integer
		var t	= iil[| int];
		var tsn = t.spotNum;
		
		// get target team
		var tt = t.team;
		
		// create temp list
		var l = ds_list_create();
		
		// build a list of numbers representing viable swap partners
		var i = 0;	repeat (4) {
			// if i doesn't equal target spot num, add it to the list
			if (i != tsn)	ds_list_add(l, i);
			
			i++;
		}
		
		// pick a random number off of that list and set it as the
		// partner's spot number
		var int = irandom_range(0, 3);
		var psn = l[| int];
		
		// create inst list
		var il = ds_list_create();
		
		// copy appropriate list
		if (tt == spar.playerOne)	ds_list_copy(il, spar.allyList);
		if (tt == spar.playerTwo)	ds_list_copy(il, spar.enemyList);
		
		// store swap partner's sprite ID
		var psid	= il[| psn].spriteID;
		
		// store target's sprite ID
		var tsid	= il[| tsn].spriteID;
		
		// swap sprite IDs
		
		var temp	= psid;
		psid		= tsid;
		tsid		= temp;
		
		// delete lists
		ds_list_destroy(l);
		ds_list_destroy(il);
	}	
}

///@desc SPELL FUNCTION: attempts to dodge for the duration of the turn. If the caster
/// is still sneaking/dodging at the end of the turn, they will deliver a powerful attack.
function sneak_attack() {
	// PRIORITY SPELL
	
	var c = activeSprite;
	
	// set dodging to true
	c.dodging = true;
	
	// set sneaking to true
	c.sneaking = true;
	
	// get target
	var t = targetSprite;
	
	// add sneak attack to grid
	grid_add_sneak_attack(c, t);
}

///@desc SPELL FUNCTION: creates a sheild that deflects all spells until the end of the turn
function deflective_shield() {
	// PRIORITY SPELL
	
	var c = activeSprite;
	
	c.deflective = true;
	
}

function dions_parry() {
	// the ID of this spell is on a list of "prioritySpells"
	
	// if the caster is targeted by a basic attack, ignore damage done
	// to the caster and halve the target's resistance when calcing damage
	// for the retaliation
}

function dions_gambling_blast() {
	// generate an Energy Blast with random power. This has a small chance
	// to target the caster's team instead
}

function dions_barter_trick() {
	// trade a quarter of the caster's HP for half of the target's HP
}

function magnetic_pulse() {
	// set hum on target's side of field
	var t = targetSprite.team;
	
	set_hum(t);
}

function burn_out() {
	// grant curse of the mother to the caster
	
	var c = activeSprite;
	
	bestow_mindset(c, 0 - MINDSETS.MOTHER);
}

function stinkbomb() {
	// summon miasma on both sides of the field
	
	set_miasma(spar.playerOne);
	set_miasma(spar.playerTwo);
}

function wind_slice() {
	// grant curse of the imp to the target (dodgeable)
	
	if !(dodgeSuccess) {
		var t = targetSprite;
		
		bestow_mindset(t, 0 - MINDSETS.IMP);
	}
}

function channel_essence() {
	// make arena reflect caster's elemental bias
}

function spheras_curse() {
	// make arena exploit target's elemental bias (dodgeable)
}

function crecias_crystal_wind() {
	// hex target and all nearby allies
	
	// get target sprite
	var t = targetSprite;
	
	// create dummy list
	var l = ds_list_create();
	
	// copy nearby allies list
	ds_list_copy(l, t.nearbyAllies);
}

function lava_spire() {
	// change arena to volcano
	
	arena_change_volcano();
}

function endless_river() {
	// change arena to ocean
	
	arena_change_ocean();
}

function cloud_break() {
	// change arena to stratosphere
	
	arena_change_stratos();
}

function telekinetic_blast() {
	// hex target (dodgeable)
	
	if !(dodgeSuccess) {
		var t = targetSprite;
		
		set_hexed(t);
	}
}

function knock_over() {
	// grant target curse of the imp (dodgeable)
	
	if !(dodgeSuccess) {
		var t = targetSprite;
		
		bestow_mindset(t, 0 - MINDSETS.IMP);
	}
}

function full_thrust() {
	// bind caster
	
	var c = activeSprite;
	
	set_bound(c);
}

function volcanic_eruption() {
	// fail unless arena is volcano
	
	// reset arena 

	// summon miasma on target's side of the field
	
	// grant all enemies curse of the mother
}

function broadcast_data() {
	// change all allies luck roll to highest possible
}

function collapse_space() {
	// reset arena and hex all enemies
}

function expand_time() {
	// change all enemies luck roll to lowest possible
}

function spheras_demise() {
	// reset arena and trap all enemies
}

function time_loop() {
	// the ID of this spell is on a list of "prioritySpells"
	
	// force target to perform same action as last turn (replaces their selected action)
}

function eradicate() {
	// the ID of this spell is on a list of "prioritySpells"
	
	// absorb all storm spells and cause them to totally fail
	
	// at the end of the turn, deliver an Energy Blast with damage 
	// relative to each spell absorbed
}

#endregion  

// add all spells to grid	ID								NAME											DESCRIPTION										LORE											TYPE					POWER	COST	RANGE						EFFECT					DODGEABLE?
master_grid_add_spell(		SPELLS.SOLAR_FLARE,				textGrid[# 1, SPELLS.SOLAR_FLARE],				textGrid[# 2, SPELLS.SOLAR_FLARE],				textGrid[# 3, SPELLS.SOLAR_FLARE],				SPELL_TYPES.FIRE,		150,	80,		ranges.nearestFiveSprites,	solar_flare,			true);
master_grid_add_spell(		SPELLS.TIDAL_FORCE,				textGrid[# 1, SPELLS.TIDAL_FORCE],				textGrid[# 2, SPELLS.TIDAL_FORCE],				textGrid[# 3, SPELLS.TIDAL_FORCE],				SPELL_TYPES.WATER,		150,	80,		ranges.nearestFiveSprites,	tidal_force,			true);
master_grid_add_spell(		SPELLS.NEBULA_STORM,			textGrid[# 1, SPELLS.NEBULA_STORM],				textGrid[# 2, SPELLS.NEBULA_STORM],				textGrid[# 3, SPELLS.NEBULA_STORM],				SPELL_TYPES.STORM,		150,	80,		ranges.nearestFiveSprites,	nebula_storm,			true);
master_grid_add_spell(		SPELLS.TECTONIC_SHIFT,			textGrid[# 1, SPELLS.TECTONIC_SHIFT],			textGrid[# 2, SPELLS.TECTONIC_SHIFT],			textGrid[# 3, SPELLS.TECTONIC_SHIFT],			SPELL_TYPES.EARTH,		150,	80,		ranges.nearestFiveSprites,	tectonic_shift,			true);
master_grid_add_spell(		SPELLS.FIREBALL,				textGrid[# 1, SPELLS.FIREBALL],					textGrid[# 2, SPELLS.FIREBALL],					textGrid[# 3, SPELLS.FIREBALL],					SPELL_TYPES.FIRE,		80,		25,		ranges.nearestFiveSprites,	fireball,				true);
master_grid_add_spell(		SPELLS.HOLY_WATER,				textGrid[# 1, SPELLS.HOLY_WATER],				textGrid[# 2, SPELLS.HOLY_WATER],				textGrid[# 3, SPELLS.HOLY_WATER],				SPELL_TYPES.WATER,		70,		35,		ranges.nearestFiveSprites,	holy_water,				true);
master_grid_add_spell(		SPELLS.SHOCK,					textGrid[# 1, SPELLS.SHOCK],					textGrid[# 2, SPELLS.SHOCK],					textGrid[# 3, SPELLS.SHOCK],					SPELL_TYPES.STORM,		80,		35,		ranges.nearestFiveSprites,	shock,					true);
master_grid_add_spell(		SPELLS.DECAY,					textGrid[# 1, SPELLS.DECAY],					textGrid[# 2, SPELLS.DECAY],					textGrid[# 3, SPELLS.DECAY],					SPELL_TYPES.EARTH,		80,		30,		ranges.nearestFiveSprites,	decay,					false);
master_grid_add_spell(		SPELLS.EXPEL_FORCE,				textGrid[# 1, SPELLS.EXPEL_FORCE],				textGrid[# 2, SPELLS.EXPEL_FORCE],				textGrid[# 3, SPELLS.EXPEL_FORCE],				SPELL_TYPES.PHYSICAL,	100,	30,		ranges.nearestThreeSprites,	expel_force,			true);
master_grid_add_spell(		SPELLS.LADY_SOLANUS_GRACE,		textGrid[# 1, SPELLS.LADY_SOLANUS_GRACE],		textGrid[# 2, SPELLS.LADY_SOLANUS_GRACE],		textGrid[# 3, SPELLS.LADY_SOLANUS_GRACE],		SPELL_TYPES.TRICK,		0,		60,		ranges.onlySelf,			lady_solanus_grace,		false);
master_grid_add_spell(		SPELLS.TYPHOON,					textGrid[# 1, SPELLS.TYPHOON],					textGrid[# 2, SPELLS.TYPHOON],					textGrid[# 3, SPELLS.TYPHOON],					SPELL_TYPES.STORM,		100,	35,		ranges.nearestThreeSprites,	typhoon,				true);
master_grid_add_spell(		SPELLS.HEALING_LIGHT,			textGrid[# 1, SPELLS.HEALING_LIGHT],			textGrid[# 2, SPELLS.HEALING_LIGHT],			textGrid[# 3, SPELLS.HEALING_LIGHT],			SPELL_TYPES.TRICK,		0,		45,		ranges.onlySelf,			healing_light,			false);
master_grid_add_spell(		SPELLS.RUBURS_WATER_CANNON,		textGrid[# 1, SPELLS.RUBURS_WATER_CANNON],		textGrid[# 2, SPELLS.RUBURS_WATER_CANNON],		textGrid[# 3, SPELLS.RUBURS_WATER_CANNON],		SPELL_TYPES.WATER,		120,	60,		ranges.nearestThreeSprites,	ruburs_water_cannon,	true);
master_grid_add_spell(		SPELLS.RUBURS_GRAPPLE,			textGrid[# 1, SPELLS.RUBURS_GRAPPLE],			textGrid[# 2, SPELLS.RUBURS_GRAPPLE],			textGrid[# 3, SPELLS.RUBURS_GRAPPLE],			SPELL_TYPES.PHYSICAL,	80,		45,		ranges.nearestThreeSprites, ruburs_grapple,			true);
master_grid_add_spell(		SPELLS.LUSIAS_HARVEST_SPELL,	textGrid[# 1, SPELLS.LUSIAS_HARVEST_SPELL],		textGrid[# 2, SPELLS.LUSIAS_HARVEST_SPELL],		textGrid[# 3, SPELLS.LUSIAS_HARVEST_SPELL],		SPELL_TYPES.EARTH,		0,		25,		ranges.onlySelf,			lusias_harvest_spell,	false);
master_grid_add_spell(		SPELLS.WATERLOG,				textGrid[# 1, SPELLS.WATERLOG],					textGrid[# 2, SPELLS.WATERLOG],					textGrid[# 3, SPELLS.WATERLOG],					SPELL_TYPES.WATER,		70,		35,		ranges.nearestFiveSprites,	waterlog,				false);
master_grid_add_spell(		SPELLS.AIR_PRESSURE,			textGrid[# 1, SPELLS.AIR_PRESSURE],				textGrid[# 2, SPELLS.AIR_PRESSURE],				textGrid[# 3, SPELLS.AIR_PRESSURE],				SPELL_TYPES.STORM,		70,		35,		ranges.nearestFiveSprites,	air_pressure,			true);
master_grid_add_spell(		SPELLS.SUPERBLOOM,				textGrid[# 1, SPELLS.SUPERBLOOM],				textGrid[# 2, SPELLS.SUPERBLOOM],				textGrid[# 3, SPELLS.SUPERBLOOM],				SPELL_TYPES.EARTH,		100,	50,		ranges.nearestThreeSprites,	superbloom,				true);
master_grid_add_spell(		SPELLS.RAPID_STRIKE,			textGrid[# 1, SPELLS.RAPID_STRIKE],				textGrid[# 2, SPELLS.RAPID_STRIKE],				textGrid[# 3, SPELLS.RAPID_STRIKE],				SPELL_TYPES.PHYSICAL,	75,		40,		ranges.nearestThreeSprites,	rapid_strike,			false);
master_grid_add_spell(		SPELLS.LOOMING_DANGER,			textGrid[# 1, SPELLS.LOOMING_DANGER],			textGrid[# 2, SPELLS.LOOMING_DANGER],			textGrid[# 3, SPELLS.LOOMING_DANGER],			SPELL_TYPES.TRICK,		0,		30,		ranges.anySprite,			looming_danger,			false);
master_grid_add_spell(		SPELLS.STEAM_BATH,				textGrid[# 1, SPELLS.STEAM_BATH],				textGrid[# 2, SPELLS.STEAM_BATH],				textGrid[# 3, SPELLS.STEAM_BATH],				SPELL_TYPES.WATER,		65,		35,		ranges.nearestFiveSprites,	steam_bath,				true);
master_grid_add_spell(		SPELLS.UNDERTOW,				textGrid[# 1, SPELLS.UNDERTOW],					textGrid[# 2, SPELLS.UNDERTOW],					textGrid[# 3, SPELLS.UNDERTOW],					SPELL_TYPES.WATER,		100,	50,		ranges.nearestFiveSprites,	undertow,				false);
master_grid_add_spell(		SPELLS.EMPATHIZE,				textGrid[# 1, SPELLS.EMPATHIZE],				textGrid[# 2, SPELLS.EMPATHIZE],				textGrid[# 3, SPELLS.EMPATHIZE],				SPELL_TYPES.TRICK,		0,		20,		ranges.anySprite,			empathize,				false);
master_grid_add_spell(		SPELLS.HELLFIRE,				textGrid[# 1, SPELLS.HELLFIRE],					textGrid[# 2, SPELLS.HELLFIRE],					textGrid[# 3, SPELLS.HELLFIRE],					SPELL_TYPES.FIRE,		100,	50,		ranges.anySprite,			hellfire,				true);
master_grid_add_spell(		SPELLS.BALL_LIGHTNING,			textGrid[# 1, SPELLS.BALL_LIGHTNING],			textGrid[# 2, SPELLS.BALL_LIGHTNING],			textGrid[# 3, SPELLS.BALL_LIGHTNING],			SPELL_TYPES.STORM,		80,		50,		ranges.nearestFiveSprites,	ball_lightning,			true);
master_grid_add_spell(		SPELLS.QUICKSAND,				textGrid[# 1, SPELLS.QUICKSAND],				textGrid[# 2, SPELLS.QUICKSAND],				textGrid[# 3, SPELLS.QUICKSAND],				SPELL_TYPES.EARTH,		70,		40,		ranges.anySprite,			quicksand,				false);
master_grid_add_spell(		SPELLS.LORD_MOGRADTHS_RAGE,		textGrid[# 1, SPELLS.LORD_MOGRADTHS_RAGE],		textGrid[# 2, SPELLS.LORD_MOGRADTHS_RAGE],		textGrid[# 3, SPELLS.LORD_MOGRADTHS_RAGE],		SPELL_TYPES.TRICK,		0,		50,		ranges.nearestFiveSprites,	lord_mogradths_rage,	false);
master_grid_add_spell(		SPELLS.DRAIN_LIFEFORCE,			textGrid[# 1, SPELLS.DRAIN_LIFEFORCE],			textGrid[# 2, SPELLS.DRAIN_LIFEFORCE],			textGrid[# 3, SPELLS.DRAIN_LIFEFORCE],			SPELL_TYPES.PHYSICAL,	90,		40,		ranges.nearestFiveSprites,	drain_lifeforce,		true);
master_grid_add_spell(		SPELLS.PYROKINESIS,				textGrid[# 1, SPELLS.PYROKINESIS],				textGrid[# 2, SPELLS.PYROKINESIS],				textGrid[# 3, SPELLS.PYROKINESIS],				SPELL_TYPES.FIRE,		135,	60,		ranges.nearestFiveSprites,	pyrokinesis,			false);
master_grid_add_spell(		SPELLS.DOWNPOUR,				textGrid[# 1, SPELLS.DOWNPOUR],					textGrid[# 2, SPELLS.DOWNPOUR],					textGrid[# 3, SPELLS.DOWNPOUR],					SPELL_TYPES.WATER,		75,		40,		ranges.nearestFiveSprites,	downpour,				false);
master_grid_add_spell(		SPELLS.ARC_BLAST,				textGrid[# 1, SPELLS.ARC_BLAST],				textGrid[# 2, SPELLS.ARC_BLAST],				textGrid[# 3, SPELLS.ARC_BLAST],				SPELL_TYPES.STORM,		110,	50,		ranges.nearestThreeSprites,	arc_blast,				false);
master_grid_add_spell(		SPELLS.HIKAMS_WINTER_SPELL,		textGrid[# 1, SPELLS.HIKAMS_WINTER_SPELL],		textGrid[# 2, SPELLS.HIKAMS_WINTER_SPELL],		textGrid[# 3, SPELLS.HIKAMS_WINTER_SPELL],		SPELL_TYPES.EARTH,		70,		30,		ranges.anySprite,			hikams_winter_spell,	false);
master_grid_add_spell(		SPELLS.OSMOSIS,					textGrid[# 1, SPELLS.OSMOSIS],					textGrid[# 2, SPELLS.OSMOSIS],					textGrid[# 3, SPELLS.OSMOSIS],					SPELL_TYPES.WATER,		90,		40,		ranges.nearestFiveSprites,	osmosis,				false);
master_grid_add_spell(		SPELLS.FLASH_FREEZE,			textGrid[# 1, SPELLS.FLASH_FREEZE],				textGrid[# 2, SPELLS.FLASH_FREEZE],				textGrid[# 3, SPELLS.FLASH_FREEZE],				SPELL_TYPES.WATER,		110,	50,		ranges.nearestFiveSprites,	flash_freeze,			false);
master_grid_add_spell(		SPELLS.LANDSLIDE,				textGrid[# 1, SPELLS.LANDSLIDE],				textGrid[# 2, SPELLS.LANDSLIDE],				textGrid[# 3, SPELLS.LANDSLIDE],				SPELL_TYPES.EARTH,		110,	50,		ranges.nearestFiveSprites,	landslide,				true);
master_grid_add_spell(		SPELLS.AMANDS_ENERGY_BLAST,		textGrid[# 1, SPELLS.AMANDS_ENERGY_BLAST],		textGrid[# 2, SPELLS.AMANDS_ENERGY_BLAST],		textGrid[# 3, SPELLS.AMANDS_ENERGY_BLAST],		SPELL_TYPES.TRICK,		0,		40,		ranges.nearestThreeSprites,	amands_energy_blast,	true);
master_grid_add_spell(		SPELLS.SHIFT_PERSPECTIVE,		textGrid[# 1, SPELLS.SHIFT_PERSPECTIVE],		textGrid[# 2, SPELLS.SHIFT_PERSPECTIVE],		textGrid[# 3, SPELLS.SHIFT_PERSPECTIVE],		SPELL_TYPES.TRICK,		0,		35,		ranges.anySprite,			shift_perspective,		false);
master_grid_add_spell(		SPELLS.PSYCHIC_IMPACT,			textGrid[# 1, SPELLS.PSYCHIC_IMPACT],			textGrid[# 2, SPELLS.PSYCHIC_IMPACT],			textGrid[# 3, SPELLS.PSYCHIC_IMPACT],			SPELL_TYPES.TRICK,		90,		40,		ranges.anySprite,			psychic_impact,			false);
master_grid_add_spell(		SPELLS.TREMOR,					textGrid[# 1, SPELLS.TREMOR],					textGrid[# 2, SPELLS.TREMOR],					textGrid[# 3, SPELLS.TREMOR],					SPELL_TYPES.EARTH,		120,	60,		ranges.nearestThreeSprites,	tremor,					false);
master_grid_add_spell(		SPELLS.SKYDIVE,					textGrid[# 1, SPELLS.SKYDIVE],					textGrid[# 2, SPELLS.SKYDIVE],					textGrid[# 3, SPELLS.SKYDIVE],					SPELL_TYPES.PHYSICAL,	120,	50,		ranges.nearestThreeSprites,	skydive,				false);
master_grid_add_spell(		SPELLS.DESTRUCTIVE_BLOW,		textGrid[# 1, SPELLS.DESTRUCTIVE_BLOW],			textGrid[# 2, SPELLS.DESTRUCTIVE_BLOW],			textGrid[# 3, SPELLS.DESTRUCTIVE_BLOW],			SPELL_TYPES.PHYSICAL,	100,	40,		ranges.nearestThreeSprites,	destructive_blow,		true);
master_grid_add_spell(		SPELLS.PURIFYING_FLAME,			textGrid[# 1, SPELLS.PURIFYING_FLAME],			textGrid[# 2, SPELLS.PURIFYING_FLAME],			textGrid[# 3, SPELLS.PURIFYING_FLAME],			SPELL_TYPES.FIRE,		100,	40,		ranges.nearestFiveSprites,	purifying_flame,		true);
master_grid_add_spell(		SPELLS.JABULS_FIGHT_SONG,		textGrid[# 1, SPELLS.JABULS_FIGHT_SONG],		textGrid[# 2, SPELLS.JABULS_FIGHT_SONG],		textGrid[# 3, SPELLS.JABULS_FIGHT_SONG],		SPELL_TYPES.TRICK,		0,		35,		ranges.onlySelf,			jabuls_fight_song,		false);
master_grid_add_spell(		SPELLS.NOXIOUS_FUMES,			textGrid[# 1, SPELLS.NOXIOUS_FUMES],			textGrid[# 2, SPELLS.NOXIOUS_FUMES],			textGrid[# 3, SPELLS.NOXIOUS_FUMES],			SPELL_TYPES.FIRE,		75,		40,		ranges.nearestFiveSprites,	noxious_fumes,			false);
master_grid_add_spell(		SPELLS.CRECIAS_CRYSTAL_SPIKES,	textGrid[# 1, SPELLS.CRECIAS_CRYSTAL_SPIKES],	textGrid[# 2, SPELLS.CRECIAS_CRYSTAL_SPIKES],	textGrid[# 3, SPELLS.CRECIAS_CRYSTAL_SPIKES],	SPELL_TYPES.EARTH,		120,	65,		ranges.nearestThreeSprites,	crecias_crystal_spikes,	false);
master_grid_add_spell(		SPELLS.PSYCHIC_FISSURE,			textGrid[# 1, SPELLS.PSYCHIC_FISSURE],			textGrid[# 2, SPELLS.PSYCHIC_FISSURE],			textGrid[# 3, SPELLS.PSYCHIC_FISSURE],			SPELL_TYPES.TRICK,		130,	60,		ranges.anySprite,			psychic_fissure,		true);
master_grid_add_spell(		SPELLS.REARRANGE,				textGrid[# 1, SPELLS.REARRANGE],				textGrid[# 2, SPELLS.REARRANGE],				textGrid[# 3, SPELLS.REARRANGE],				SPELL_TYPES.TRICK,		0,		40,		ranges.nearestThreeSprites,	rearrange,				true);
master_grid_add_spell(		SPELLS.SNEAK_ATTACK,			textGrid[# 1, SPELLS.SNEAK_ATTACK],				textGrid[# 2, SPELLS.SNEAK_ATTACK],				textGrid[# 3, SPELLS.SNEAK_ATTACK],				SPELL_TYPES.PHYSICAL,	100,	50,		ranges.nearestFiveSprites,	sneak_attack,			false);
master_grid_add_spell(		SPELLS.DEFLECTIVE_SHIELD,		textGrid[# 1, SPELLS.DEFLECTIVE_SHIELD],		textGrid[# 2, SPELLS.DEFLECTIVE_SHIELD],		textGrid[# 3, SPELLS.DEFLECTIVE_SHIELD],		SPELL_TYPES.TRICK,		0,		50,		ranges.onlySelf,			deflective_shield,		false);
master_grid_add_spell(		SPELLS.DIONS_PARRY,				textGrid[# 1, SPELLS.DIONS_PARRY],				textGrid[# 2, SPELLS.DIONS_PARRY],				textGrid[# 3, SPELLS.DIONS_PARRY],				SPELL_TYPES.PHYSICAL,	135,	40,		ranges.onlySelf,			dions_parry,			false);
master_grid_add_spell(		SPELLS.DIONS_GAMBLING_BLAST,	textGrid[# 1, SPELLS.DIONS_GAMBLING_BLAST],		textGrid[# 2, SPELLS.DIONS_GAMBLING_BLAST],		textGrid[# 3, SPELLS.DIONS_GAMBLING_BLAST],		SPELL_TYPES.TRICK,		0,		35,		ranges.onlySelf,			dions_gambling_blast,	false);
master_grid_add_spell(		SPELLS.DIONS_BARTER_TRICK,		textGrid[# 1, SPELLS.DIONS_BARTER_TRICK],		textGrid[# 2, SPELLS.DIONS_BARTER_TRICK],		textGrid[# 3, SPELLS.DIONS_BARTER_TRICK],		SPELL_TYPES.TRICK,		0,		0,		ranges.onlySelf,			dions_barter_trick,		false);
master_grid_add_spell(		SPELLS.MAGNETIC_PULSE,			textGrid[# 1, SPELLS.MAGNETIC_PULSE],			textGrid[# 2, SPELLS.MAGNETIC_PULSE],			textGrid[# 3, SPELLS.MAGNETIC_PULSE],			SPELL_TYPES.STORM,		90,		40,		ranges.nearestFiveSprites,	magnetic_pulse,			true);
master_grid_add_spell(		SPELLS.BURN_OUT,				textGrid[# 1, SPELLS.BURN_OUT],					textGrid[# 2, SPELLS.BURN_OUT],					textGrid[# 3, SPELLS.BURN_OUT],					SPELL_TYPES.FIRE,		140,	50,		ranges.nearestThreeSprites,	burn_out,				true);
master_grid_add_spell(		SPELLS.STINKBOMB,				textGrid[# 1, SPELLS.STINKBOMB],				textGrid[# 2, SPELLS.STINKBOMB],				textGrid[# 3, SPELLS.STINKBOMB],				SPELL_TYPES.EARTH,		100,	50,		ranges.nearestFiveSprites,	stinkbomb,				true);
master_grid_add_spell(		SPELLS.WIND_SLICE,				textGrid[# 1, SPELLS.WIND_SLICE],				textGrid[# 2, SPELLS.WIND_SLICE],				textGrid[# 3, SPELLS.WIND_SLICE],				SPELL_TYPES.STORM,		120,	55,		ranges.nearestFiveSprites,	wind_slice,				true);
master_grid_add_spell(		SPELLS.CHANNEL_ESSENCE,			textGrid[# 1, SPELLS.CHANNEL_ESSENCE],			textGrid[# 2, SPELLS.CHANNEL_ESSENCE],			textGrid[# 3, SPELLS.CHANNEL_ESSENCE],			SPELL_TYPES.TRICK,		0,		30,		ranges.onlySelf,			channel_essence,		false);
master_grid_add_spell(		SPELLS.SPHERAS_CURSE,			textGrid[# 1, SPELLS.SPHERAS_CURSE],			textGrid[# 2, SPELLS.SPHERAS_CURSE],			textGrid[# 3, SPELLS.SPHERAS_CURSE],			SPELL_TYPES.TRICK,		0,		30,		ranges.nearestOneEnemy,		spheras_curse,			false);
master_grid_add_spell(		SPELLS.CRECIAS_CRYSTAL_WIND,	textGrid[# 1, SPELLS.CRECIAS_CRYSTAL_WIND],		textGrid[# 2, SPELLS.CRECIAS_CRYSTAL_WIND],		textGrid[# 3, SPELLS.CRECIAS_CRYSTAL_WIND],		SPELL_TYPES.EARTH,		100,	45,		ranges.nearestFiveSprites,	crecias_crystal_wind,	true);
master_grid_add_spell(		SPELLS.LAVA_SPIRE,				textGrid[# 1, SPELLS.LAVA_SPIRE],				textGrid[# 2, SPELLS.LAVA_SPIRE],				textGrid[# 3, SPELLS.LAVA_SPIRE],				SPELL_TYPES.FIRE,		100,	50,		ranges.nearestThreeSprites,	lava_spire,				true);
master_grid_add_spell(		SPELLS.ENDLESS_RIVER,			textGrid[# 1, SPELLS.ENDLESS_RIVER],			textGrid[# 2, SPELLS.ENDLESS_RIVER],			textGrid[# 3, SPELLS.ENDLESS_RIVER],			SPELL_TYPES.WATER,		80,		40,		ranges.nearestFiveSprites,	endless_river,			true);
master_grid_add_spell(		SPELLS.CLOUD_BREAK,				textGrid[# 1, SPELLS.CLOUD_BREAK],				textGrid[# 2, SPELLS.CLOUD_BREAK],				textGrid[# 3, SPELLS.CLOUD_BREAK],				SPELL_TYPES.STORM,		60,		30,		ranges.anySprite,			cloud_break,			false);
master_grid_add_spell(		SPELLS.TELEKINETIC_BLAST,		textGrid[# 1, SPELLS.TELEKINETIC_BLAST],		textGrid[# 2, SPELLS.TELEKINETIC_BLAST],		textGrid[# 3, SPELLS.TELEKINETIC_BLAST],		SPELL_TYPES.PHYSICAL,	120,	65,		ranges.anySprite,			telekinetic_blast,		false);
master_grid_add_spell(		SPELLS.KNOCK_OVER,				textGrid[# 1, SPELLS.KNOCK_OVER],				textGrid[# 2, SPELLS.KNOCK_OVER],				textGrid[# 3, SPELLS.KNOCK_OVER],				SPELL_TYPES.PHYSICAL,	100,	40,		ranges.nearestFiveSprites,	knock_over,				true);
master_grid_add_spell(		SPELLS.FULL_THRUST,				textGrid[# 1, SPELLS.FULL_THRUST],				textGrid[# 2, SPELLS.FULL_THRUST],				textGrid[# 3, SPELLS.FULL_THRUST],				SPELL_TYPES.PHYSICAL,	160,	60,		ranges.nearestThreeSprites,	full_thrust,			true);
master_grid_add_spell(		SPELLS.VOLCANIC_ERUPTION,		textGrid[# 1, SPELLS.VOLCANIC_ERUPTION],		textGrid[# 2, SPELLS.VOLCANIC_ERUPTION],		textGrid[# 3, SPELLS.VOLCANIC_ERUPTION],		SPELL_TYPES.FIRE,		130,	70,		ranges.nearestThreeSprites,	volcanic_eruption,		true);
master_grid_add_spell(		SPELLS.BROADCAST_DATA,			textGrid[# 1, SPELLS.BROADCAST_DATA],			textGrid[# 2, SPELLS.BROADCAST_DATA],			textGrid[# 3, SPELLS.BROADCAST_DATA],			SPELL_TYPES.TRICK,		0,		40,		ranges.onlySelf,			broadcast_data,			false);
master_grid_add_spell(		SPELLS.COLLAPSE_SPACE,			textGrid[# 1, SPELLS.COLLAPSE_SPACE],			textGrid[# 2, SPELLS.COLLAPSE_SPACE],			textGrid[# 3, SPELLS.COLLAPSE_SPACE],			SPELL_TYPES.TRICK,		0,		60,		ranges.onlySelf,			collapse_space,			false);
master_grid_add_spell(		SPELLS.EXPAND_TIME,				textGrid[# 1, SPELLS.EXPAND_TIME],				textGrid[# 2, SPELLS.EXPAND_TIME],				textGrid[# 3, SPELLS.EXPAND_TIME],				SPELL_TYPES.TRICK,		0,		40,		ranges.onlySelf,			expand_time,			false);
master_grid_add_spell(		SPELLS.SPHERAS_DEMISE,			textGrid[# 1, SPELLS.SPHERAS_DEMISE],			textGrid[# 2, SPELLS.SPHERAS_DEMISE],			textGrid[# 3, SPELLS.SPHERAS_DEMISE],			SPELL_TYPES.TRICK,		0,		60,		ranges.onlySelf,			spheras_demise,			false);
master_grid_add_spell(		SPELLS.TIME_LOOP,				textGrid[# 1, SPELLS.TIME_LOOP],				textGrid[# 2, SPELLS.TIME_LOOP],				textGrid[# 3, SPELLS.TIME_LOOP],				SPELL_TYPES.TRICK,		0,		50,		ranges.anySprite,			time_loop,				false);
master_grid_add_spell(		SPELLS.ERADICATE,				textGrid[# 1, SPELLS.ERADICATE],				textGrid[# 2, SPELLS.ERADICATE],				textGrid[# 3, SPELLS.ERADICATE],				SPELL_TYPES.TRICK,		0,		65,		ranges.onlySelf,			eradicate,				false);

// encode spell grid
global.allSpells = encode_grid(global.spellGrid);

// delete spell grid
//ds_grid_destroy(global.spellGrid);

///@desc This function is meant to be called by the spellbook whenever there is a new currentSpell.
function spellbook_load_spell_params() {	
	// use currentSpell to get all params
	name			= player.spellBookGrid[# SPELL_PARAMS.NAME,			index];
	description		= player.spellBookGrid[# SPELL_PARAMS.DESCRIPTION,	index];
	spellType		= player.spellBookGrid[# SPELL_PARAMS.TYPE,			index];
	spellRange		= player.spellBookGrid[# SPELL_PARAMS.RANGE,		index];
	spellPower		= player.spellBookGrid[# SPELL_PARAMS.POWER,		index];
	spellCost		= player.spellBookGrid[# SPELL_PARAMS.COST,			index];
}

///@desc This function is meant to be called by the sparActionProcessor whenever a spell is being cast
function processor_load_spell_params() {
	// decode spell grid
	var grid = ds_grid_create(SPELL_PARAMS.HEIGHT, SPELLS.HEIGHT);
	decode_grid(global.allSpells, grid);
	
	// use currentSpell to get all params
	spellName	= grid[# SPELL_PARAMS.NAME,			currentSpell];
	spellCost	= real(grid[# SPELL_PARAMS.COST,	currentSpell]);
	spellType	= real(grid[# SPELL_PARAMS.TYPE,	currentSpell]);
	spellPower	= real(grid[# SPELL_PARAMS.POWER,	currentSpell]);
	spellEffect	= real(string_digits(grid[# SPELL_PARAMS.EFFECT,	currentSpell]));
}

function action_get_spell_id(_action) {
	return _action - sparActions.height;
}