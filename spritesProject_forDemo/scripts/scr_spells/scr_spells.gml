// set legal spell count
#macro	SPELLMAX	8

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
	LORD_MORGADTHS_RAGE,
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
	DESTABILIZING_BLOW,
	FULL_THRUST,
	VOLANIC_ERUPTION,
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
global.spellGrid = ds_grid_create(SPELL_PARAMS.HEIGHT, SPELLS.height);

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
	
	// initialize dummy list
	var list = ds_list_create();
	
	// get player's allyList
	if (t == spar.playerOne) {
		ds_list_copy(list, spar.allyList);
	}
	
	if (t == spar.playerTwo) {
		ds_list_copy(list, spar.enemyList);
	}
	
	// use a repeat loop to grant curse of the warrior to
	// all sprites on the list
	var i = 0;	repeat (ds_list_size(list)) {
		bestow_mindset(list[| i], -1 * (MINDSETS.WARRIOR));
		
		i++;
	}
	
	// delete the list
	ds_list_destroy(list);
}

///@desc SPELL FUNCTION: forces the target to swap (dodgeable)
function tidal_force() {

}

///@desc SPELL FUNCTION: hexes all enemies
function nebula_storm() {
	// get target's team
	var t = targetSprite.team;

	// initialize dummy list
	var list = ds_list_create();
	
	// get enemy allyList
	if (t == spar.playerOne) {
		ds_list_copy(list, spar.allyList);
	}
	
	if (t == spar.playerTwo) {
		ds_list_copy(list, spar.enemyList);
	}
	
	// use a repeat loop to hex all enemies
	var i = 0;	repeat (ds_list_size(list)) {
		set_hexed(list[| i]);
		
		i++;
	}
	
	// delete the dummy list
	ds_list_destroy(list);
}

///@desc SPELL FUNCTION: binds all enemies
function tectonic_shift() {
	// get target's team
	var t = targetSprite.team;

	// initialize dummy list
	var list = ds_list_create();
	
	// get enemy allyList
	if (t == spar.playerOne) {
		ds_list_copy(list, spar.allyList);
	}
	
	if (t == spar.playerTwo) {
		ds_list_copy(list, spar.enemyList);
	}
	
	// use a repeat loop to hex all enemies
	var i = 0;	repeat (ds_list_size(list)) {
		set_bound(list[| i]);
		
		i++;
	}
	
	// delete the dummy list
	ds_list_destroy(list);	
}

///@desc SPELL FUNCTION: no effect
function fireball() {
	// maybe uhh delete this uhh function
}

///@desc SPELL FUNCTION: deals extra damage if the sprite
function holy_water() {
	// any spells that effect damage calc will be on a list
	// that will be checked before damage calc is performed
	// (effect functions are called after damage calc)
}

///@desc SPELL FUNCTION: binds target (dodgeable)
function shock() {
	if (dodgeSuccess == false) {
		set_bound(targetSprite);
	}
}

///@desc SPELL FUNCTION: restores half of health depleted (dodgeable)
function decay() {
	if (dodgeSuccess == false) {
		var t = activeSprite.team;
		var d = damage / 2;
		
		restore_hp(t, d);
	}
}

function expel_force() {
	// no effect
}

///@desc SPELL FUNCTION: partially restores team and grants all allies blessing of the tree
function lady_solanus_grace() {
	// get caster's team
	var t = activeSprite.team;
	
	// heal team fully
	fully_restore_hp(t);
	
	// initialize dummy list
	var list = ds_list_create();
	
	// get the team's allyList
	if (t == spar.playerOne) {
		ds_list_copy(list, spar.allyList);
	}
	
	if (t == spar.playerTwo) {
		ds_list_copy(list, spar.enemyList);
	}
	
	var i = 0;	repeat (ds_list_size(list)) {
		bestow_mindset(list[| i], MINDSETS.TREE);
		
		i++;
	}
}

///@desc SPELL FUNCTION: grants target curse of the tree (dodgeable)
function typhoon() {
	if (dodgeSuccess == false) {
		bestow_mindset(targetSprite, 0 - MINDSETS.TREE);
	}
}

///@desc SPELL FUNCTION: fully heals the caster's team
function healing_light() {
	var t = activeSprite.team;
	
	fully_restore_hp(t);
}

///@desc SPELL FUNCTION: no effect
function ruburs_water_cannon() {
	// no effect
}

///@desc SPELL FUNCTION: binds the target (dodgeable)
function ruburs_grapple() {
	if (dodgeSuccess == false) {
		set_bound(targetSprite);
	}
}

///@desc SPELL FUNCTION: changes arena to forest
function lusias_harvest_spell() {
	arena_change_forest();
}

///@desc SPELL FUNCTION: grants target the curse of the tree
function waterlog() {
	bestow_mindset(targetSprite, 0 - MINDSETS.TREE);
}

///@desc SPELL FUNCTION: grants target and all nearby enemies the curse of the tree
function air_pressure() {
	
	// initialize the dummy list
	var list = ds_list_create();
	
	// copy the target's nearbyAlly list
	ds_list_copy(list, targetSprites.nearbyAllies);
	
	// use a repeat loop to grant curse to all nearbyAllies
	var i = 0;	repeat (ds_list_size(nearbyAllies)) {
		bestow_mindset(list[| i], 0 - MINDSETS.TREE);
		
		i++;
	}
	
	// grant mindset to targetSprite
	bestow_mindset(targetSprite, 0 - MINDSETS.TREE);
	
	// destroy list
	ds_list_destroy(list);
}

///@desc SPELL FUNCTION: removes all curses and hindrances from caster's side of the field
function superbloom() {
	// get caster's team
	var t = activeSprite.team;
	
	// create dummy list
	var list = ds_list_create();
	
	// get team's ally list
	if (t == spar.playerOne) {
		ds_list_copy(list, spar.allyList);	
	}
	
	if (t == spar.playerTwo) {
		ds_list_copy(list, spar.enemyList);	
	}
	
	// use a repeat list to remove any curses
	var i = 0;	repeat (ds_list_size(list)) {
		if (list[| i].mindset < 0) {
			list[| i].mindset = 0;	
		}
		
		i++;
	}
	
	// remove all hindrances
	clear_hum(t);
	clear_miasma(t);
	clear_rust(t);
}

function rapid_strike() {
	// the ID of this spell is on a list of "prioritySpells"
}

function looming_danger() {
	// the ID of this spell is on a list of "prioritySpells"
	
	// start a timer for an Energy Blast
}

function intercept() {
	// take target's place in any spells targeting them this turn 
}

function steam_bath() {
	// heal team, remove hindrances, turn all curses to blessings (dodgeable)
}

function undertow() {
	// grant target curse of the imp
}

function empathize() {
	// adopt target's mindset and partially heal target's team (dodgeable)
}

function hellfire() {
	// hex target and all nearby allies (dodgeable)
}

function ball_lightning() {
	// the ID of this spell is on a list of "prioritySpells"
	
	// absorb all storm spells and cause them to totally fail
	
	// at the end of the turn, deliver the attack with additional damage for each 
	// storm spell absorbed
}

function quicksand() {
	// traps target
}

function lord_mogradths_rage() {
	// hex and curse target and all nearby allies (dodgeable)
}

function drain_lifeforce() {
	// restore half of the health depleted from target (dodgeable)
}

function pyrokinesis() {
	// deal a fraction of the damage to the caster
}

function downpour() {
	// summon rust on target's side of the field
}

function arc_blast() {
	// grant target curse of the imp 
}

function hikams_winter_spell() {
	// fail unless forest is active
	
	// reset arena
	
	// fully restore caster's MP and HP
	
	// grant blessing of the tree to all nearby allies
}

function osmosis() {
	// restore half of the HP depleted from target
}

function flash_freeze() {
	// bind the target
}

function landslide() {
	// reset arena and grant curse of the warrior to target and nearby allies
}

function amands_energy_blast() {
	// create an Energy Blast against the enemy team that deals damage relative to
	// the caster's luck for the turn
}

function shift_perspective() {
	// flip the target's mindset
	
	// if curse->blessing heal some HP
	
	// if blessing->curse remove some HP
}

function psychic_impact() {
	// find target's weak spot and attack them there
}

function tremor() {
	// no effect
}

function skydive() {
	// become invulnerable until the end of the turn
	
	// at the end of the turn, deliver the attack
}

function destructive_blow() {
	// there will be a check before damage is dealt wherein
	// this spell will do extra damage to MECHANICAL sprites when
	// cast
}

function purifying_flame() {
	// there will be a check before damage is dealth wherein
	// this spell will do extra damage to ASTRAL sprites when
	// cast
}

function jabuls_fight_song() {
	// partially restore target's HP and grant curse of the warrior
	// to them and all their nearby allies
}

function noxious_fumes() {
	// summon miasma on target's side of the field
}

function crecias_crystal_spikes() {
	// hex target
}

function psychic_fissure() {
	// same effect as psychic impact (there will be a check for
	// these two spells that modify damage before it is done)
}

function rearrange() {
	// split target team into two pairs and swap them (dodgeable)
}

function sneak_attack() {
	// set caster to dodge
	
	// if caster manages to avoid damage, deliver an attack
}

function deflective_shield() {
	// create a shield that deflects all spells until the end of the turn
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
	// summon hum
}

function burn_out() {
	// grant curse of the mother to the caster
}

function stinkbomb() {
	// summon miasma on both sides of the field
}

function wind_slice() {
	// grant curse of the imp to the target (dodgeable)
}

function channel_essence() {
	// make arena reflect caster's elemental bias
}

function spheras_curse() {
	// make arena exploit target's elemental bias (dodgeable)
}

function crecias_crystal_wind() {
	// hex target and all nearby allies
}

function lava_spire() {
	// change arena to volcano
}

function endless_river() {
	// change arena to ocean
}

function cloud_break() {
	// change arena to stratosphere
}

function telekinetic_blast() {
	// hex target (dodgeable)
}

function destabilizing_blow() {
	// grant target curse of the imp (dodgeable)
}

function full_thrust() {
	// bind caster
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

// add all spells to grid	ID								NAME										DESCRIPTION									LORE										TYPE					POWER	COST	RANGE						EFFECT					DODGEABLE?
master_grid_add_spell(		SPELLS.SOLAR_FLARE,				textGrid[# 1, SPELLS.SOLAR_FLARE],			textGrid[# 2, SPELLS.SOLAR_FLARE],			textGrid[# 3, SPELLS.SOLAR_FLARE],			SPELL_TYPES.FIRE,		150,	80,		ranges.nearestFiveSprites,	solar_flare,			true);
master_grid_add_spell(		SPELLS.TIDAL_FORCE,				textGrid[# 1, SPELLS.TIDAL_FORCE],			textGrid[# 2, SPELLS.TIDAL_FORCE],			textGrid[# 3, SPELLS.TIDAL_FORCE],			SPELL_TYPES.WATER,		150,	80,		ranges.nearestFiveSprites,	tidal_force,			true);
master_grid_add_spell(		SPELLS.NEBULA_STORM,				textGrid[# 1, SPELLS.NEBULA_STORM],			textGrid[# 2, SPELLS.NEBULA_STORM],			textGrid[# 3, SPELLS.NEBULA_STORM],			SPELL_TYPES.STORM,		150,	80,		ranges.nearestFiveSprites,	nebula_storm,			true);
master_grid_add_spell(		SPELLS.TECTONIC_SHIFT,			textGrid[# 1, SPELLS.TECTONIC_SHIFT],		textGrid[# 2, SPELLS.TECTONIC_SHIFT],		textGrid[# 3, SPELLS.TECTONIC_SHIFT],		SPELL_TYPES.EARTH,		150,	80,		ranges.nearestFiveSprites,	tectonic_shift,			true);
master_grid_add_spell(		SPELLS.FIREBALL,				textGrid[# 1, SPELLS.FIREBALL],				textGrid[# 2, SPELLS.FIREBALL],				textGrid[# 3, SPELLS.FIREBALL],				SPELL_TYPES.FIRE,		80,		25,		ranges.nearestFiveSprites,	fireball,				true);
master_grid_add_spell(		SPELLS.HOLY_WATER,				textGrid[# 1, SPELLS.HOLY_WATER],			textGrid[# 2, SPELLS.HOLY_WATER],			textGrid[# 3, SPELLS.HOLY_WATER],			SPELL_TYPES.WATER,		70,		35,		ranges.nearestFiveSprites,	holy_water,				true);
master_grid_add_spell(		SPELLS.SHOCK,					textGrid[# 1, SPELLS.SHOCK],				textGrid[# 2, SPELLS.SHOCK],				textGrid[# 3, SPELLS.SHOCK],				SPELL_TYPES.STORM,		80,		35,		ranges.nearestFiveSprites,	shock,					true);
master_grid_add_spell(		SPELLS.DECAY,					textGrid[# 1, SPELLS.DECAY],				textGrid[# 2, SPELLS.DECAY],				textGrid[# 3, SPELLS.DECAY],				SPELL_TYPES.EARTH,		80,		30,		ranges.nearestFiveSprites,	decay,					false);
master_grid_add_spell(		SPELLS.EXPEL_FORCE,				textGrid[# 1, SPELLS.EXPEL_FORCE],			textGrid[# 2, SPELLS.EXPEL_FORCE],			textGrid[# 3, SPELLS.EXPEL_FORCE],			SPELL_TYPES.PHYSICAL,	100,	30,		ranges.nearestThreeSprites,	expel_force,			true);
master_grid_add_spell(		SPELLS.LADY_SOLANUS_GRACE,		textGrid[# 1, SPELLS.LADY_SOLANUS_GRACE],		textGrid[# 2, SPELLS.LADY_SOLANUS_GRACE],		textGrid[# 3, SPELLS.LADY_SOLANUS_GRACE],		SPELL_TYPES.TRICK,		0,		60,		ranges.onlySelf,			lady_solanus_grace,		false);
master_grid_add_spell(		SPELLS.TYPHOON,					textGrid[# 1, SPELLS.TYPHOON],				textGrid[# 2, SPELLS.TYPHOON],				textGrid[# 3, SPELLS.TYPHOON],				SPELL_TYPES.STORM,		100,	35,		ranges.nearestThreeSprites,	typhoon,				true);
master_grid_add_spell(		SPELLS.HEALING_LIGHT,			textGrid[# 1, SPELLS.HEALING_LIGHT],			textGrid[# 2, SPELLS.HEALING_LIGHT],			textGrid[# 3, SPELLS.HEALING_LIGHT],			SPELL_TYPES.TRICK,		0,		45,		ranges.onlySelf,			healing_light,			false);
master_grid_add_spell(		SPELLS.RUBURS_WATER_CANNON,		textGrid[# 1, SPELLS.RUBURS_WATER_CANNON],	textGrid[# 2, SPELLS.RUBURS_WATER_CANNON],	textGrid[# 3, SPELLS.RUBURS_WATER_CANNON],	SPELL_TYPES.WATER,		120,	60,		ranges.nearestThreeSprites,	ruburs_water_cannon,	true);
master_grid_add_spell(		SPELLS.RUBURS_GRAPPLE,			textGrid[# 1, SPELLS.RUBURS_GRAPPLE],		textGrid[# 2, SPELLS.RUBURS_GRAPPLE],		textGrid[# 3, SPELLS.RUBURS_GRAPPLE],		SPELL_TYPES.PHYSICAL,	80,		45,		ranges.nearestThreeSprites, ruburs_grapple,			true);
master_grid_add_spell(		SPELLS.LUSIAS_HARVEST_SPELL,		textGrid[# 1, SPELLS.LUSIAS_HARVEST_SPELL],	textGrid[# 2, SPELLS.LUSIAS_HARVEST_SPELL],	textGrid[# 3, SPELLS.LUSIAS_HARVEST_SPELL],	SPELL_TYPES.EARTH,		0,		25,		ranges.onlySelf,			lusias_harvest_spell,	false);
master_grid_add_spell(		SPELLS.WATERLOG,				textGrid[# 1, SPELLS.WATERLOG],				textGrid[# 2, SPELLS.WATERLOG],				textGrid[# 3, SPELLS.WATERLOG],				SPELL_TYPES.WATER,		70,		35,		ranges.nearestFiveSprites,	waterlog,				false);
master_grid_add_spell(		SPELLS.AIR_PRESSURE,				textGrid[# 1, SPELLS.AIR_PRESSURE],			textGrid[# 2, SPELLS.AIR_PRESSURE],			textGrid[# 3, SPELLS.AIR_PRESSURE],			SPELL_TYPES.STORM,		70,		35,		ranges.nearestFiveSprites,	air_pressure,			true);
master_grid_add_spell(		SPELLS.SUPERBLOOM,				textGrid[# 1, SPELLS.SUPERBLOOM],			textGrid[# 2, SPELLS.SUPERBLOOM],			textGrid[# 3, SPELLS.SUPERBLOOM],			SPELL_TYPES.EARTH,		100,	50,		ranges.nearestThreeSprites,	superbloom,				true);
master_grid_add_spell(		SPELLS.RAPID_STRIKE,				textGrid[# 1, SPELLS.RAPID_STRIKE],			textGrid[# 2, SPELLS.RAPID_STRIKE],			textGrid[# 3, SPELLS.RAPID_STRIKE],			SPELL_TYPES.PHYSICAL,	75,		40,		ranges.nearestThreeSprites,	rapid_strike,			false);
master_grid_add_spell(		SPELLS.LOOMING_DANGER,			textGrid[# 1, SPELLS.LOOMING_DANGER],		textGrid[# 2, SPELLS.LOOMING_DANGER],		textGrid[# 3, SPELLS.LOOMING_DANGER],		SPELL_TYPES.TRICK,		0,		30,		ranges.anySprite,			looming_danger,			false);
master_grid_add_spell(		SPELLS.STEAM_BATH,				textGrid[# 1, SPELLS.STEAM_BATH],			textGrid[# 2, SPELLS.STEAM_BATH],			textGrid[# 3, SPELLS.STEAM_BATH],			SPELL_TYPES.WATER,		65,		35,		ranges.nearestFiveSprites,	steam_bath,				true);
master_grid_add_spell(		SPELLS.UNDERTOW,				textGrid[# 1, SPELLS.UNDERTOW],				textGrid[# 2, SPELLS.UNDERTOW],				textGrid[# 3, SPELLS.UNDERTOW],				SPELL_TYPES.WATER,		100,	50,		ranges.nearestFiveSprites,	undertow,				false);
master_grid_add_spell(		SPELLS.EMPATHIZE,				textGrid[# 1, SPELLS.EMPATHIZE],			textGrid[# 2, SPELLS.EMPATHIZE],			textGrid[# 3, SPELLS.EMPATHIZE],			SPELL_TYPES.TRICK,		0,		20,		ranges.anySprite,			empathize,				false);
master_grid_add_spell(		SPELLS.HELLFIRE,				textGrid[# 1, SPELLS.HELLFIRE],				textGrid[# 2, SPELLS.HELLFIRE],				textGrid[# 3, SPELLS.HELLFIRE],				SPELL_TYPES.FIRE,		100,	50,		ranges.anySprite,			hellfire,				true);
master_grid_add_spell(		SPELLS.BALL_LIGHTNING,			textGrid[# 1, SPELLS.BALL_LIGHTNING],		textGrid[# 2, SPELLS.BALL_LIGHTNING],		textGrid[# 3, SPELLS.BALL_LIGHTNING],		SPELL_TYPES.STORM,		80,		50,		ranges.nearestFiveSprites,	ball_lightning,			true);
master_grid_add_spell(		SPELLS.QUICKSAND,				textGrid[# 1, SPELLS.QUICKSAND],			textGrid[# 2, SPELLS.QUICKSAND],			textGrid[# 3, SPELLS.QUICKSAND],			SPELL_TYPES.EARTH,		70,		40,		ranges.anySprite,			quicksand,				false);
master_grid_add_spell(		SPELLS.LORD_MOGRADTHS_RAGE,		textGrid[# 1, SPELLS.LORD_MOGRADTHS_RAGE],	textGrid[# 2, SPELLS.LORD_MOGRADTHS_RAGE],	textGrid[# 3, SPELLS.LORD_MOGRADTHS_RAGE],	SPELL_TYPES.TRICK,		0,		50,		ranges.nearestFiveSprites,	lord_mogradths_rage,	false);
master_grid_add_spell(		SPELLS.DRAIN_LIFEFORCE,			textGrid[# 1, SPELLS.DRAIN_LIFEFORCE],		textGrid[# 2, SPELLS.DRAIN_LIFEFORCE],		textGrid[# 3, SPELLS.DRAIN_LIFEFORCE],		SPELL_TYPES.PHYSICAL,	90,		40,		ranges.nearestFiveSprites,	drain_lifeforce,		true);
master_grid_add_spell(		SPELLS.PYROKINESIS,				textGrid[# 1, SPELLS.PYROKINESIS],			textGrid[# 2, SPELLS.PYROKINESIS],			textGrid[# 3, SPELLS.PYROKINESIS],			SPELL_TYPES.FIRE,		135,	60,		ranges.nearestFiveSprites,	pyrokinesis,			false);
master_grid_add_spell(		SPELLS.DOWNPOUR,				textGrid[# 1, SPELLS.DOWNPOUR],				textGrid[# 2, SPELLS.DOWNPOUR],				textGrid[# 3, SPELLS.DOWNPOUR],				SPELL_TYPES.WATER,		75,		40,		ranges.nearestFiveSprites,	downpour,				false);
master_grid_add_spell(		SPELLS.ARC_BLAST,				textGrid[# 1, SPELLS.ARC_BLAST],				textGrid[# 2, SPELLS.ARC_BLAST],				textGrid[# 3, SPELLS.ARC_BLAST],				SPELL_TYPES.STORM,		110,	50,		ranges.nearestThreeSprites,	arc_blast,				false);
master_grid_add_spell(		SPELLS.HIKAMS_WINTER_SPELL,		textGrid[# 1, SPELLS.HIKAMS_WINTER_SPELL],	textGrid[# 2, SPELLS.HIKAMS_WINTER_SPELL],	textGrid[# 3, SPELLS.HIKAMS_WINTER_SPELL],	SPELL_TYPES.EARTH,		70,		30,		ranges.anySprite,			hikams_winter_spell,	false);
master_grid_add_spell(		SPELLS.OSMOSIS,					textGrid[# 1, SPELLS.OSMOSIS],				textGrid[# 2, SPELLS.OSMOSIS],				textGrid[# 3, SPELLS.OSMOSIS],				SPELL_TYPES.WATER,		90,		40,		ranges.nearestFiveSprites,	osmosis,				false);
master_grid_add_spell(		SPELLS.FLASH_FREEZE,				textGrid[# 1, SPELLS.FLASH_FREEZE],			textGrid[# 2, SPELLS.FLASH_FREEZE],			textGrid[# 3, SPELLS.FLASH_FREEZE],			SPELL_TYPES.WATER,		110,	50,		ranges.nearestFiveSprites,	flash_freeze,			false);
master_grid_add_spell(		SPELLS.LANDSLIDE,				textGrid[# 1, SPELLS.LANDSLIDE],			textGrid[# 2, SPELLS.LANDSLIDE],			textGrid[# 3, SPELLS.LANDSLIDE],			SPELL_TYPES.EARTH,		110,	50,		ranges.nearestFiveSprites,	landslide,				true);
master_grid_add_spell(		SPELLS.AMANDS_ENERGY_BLAST,		textGrid[# 1, SPELLS.AMANDS_ENERGY_BLAST],	textGrid[# 2, SPELLS.AMANDS_ENERGY_BLAST],	textGrid[# 3, SPELLS.AMANDS_ENERGY_BLAST],	SPELL_TYPES.TRICK,		0,		40,		ranges.nearestThreeSprites,	amands_energy_blast,	true);
master_grid_add_spell(		SPELLS.SHIFT_PERSPECTIVE,		textGrid[# 1, SPELLS.SHIFT_PERSPECTIVE],		textGrid[# 2, SPELLS.SHIFT_PERSPECTIVE],		textGrid[# 3, SPELLS.SHIFT_PERSPECTIVE],		SPELL_TYPES.TRICK,		0,		35,		ranges.anySprite,			shift_perspective,		false);
master_grid_add_spell(		SPELLS.PSYCHIC_IMPACT,			textGrid[# 1, SPELLS.PSYCHIC_IMPACT],		textGrid[# 2, SPELLS.PSYCHIC_IMPACT],		textGrid[# 3, SPELLS.PSYCHIC_IMPACT],		SPELL_TYPES.TRICK,		90,		40,		ranges.anySprite,			psychic_impact,			false);
master_grid_add_spell(		SPELLS.TREMOR,					textGrid[# 1, SPELLS.TREMOR],				textGrid[# 2, SPELLS.TREMOR],				textGrid[# 3, SPELLS.TREMOR],				SPELL_TYPES.EARTH,		120,	60,		ranges.nearestThreeSprites,	tremor,					false);
master_grid_add_spell(		SPELLS.SKYDIVE,					textGrid[# 1, SPELLS.SKYDIVE],				textGrid[# 2, SPELLS.SKYDIVE],				textGrid[# 3, SPELLS.SKYDIVE],				SPELL_TYPES.PHYSICAL,	120,	50,		ranges.nearestThreeSprites,	skydive,				false);
master_grid_add_spell(		SPELLS.DESTRUCTIVE_BLOW,			textGrid[# 1, SPELLS.DESTRUCTIVE_BLOW],		textGrid[# 2, SPELLS.DESTRUCTIVE_BLOW],		textGrid[# 3, SPELLS.DESTRUCTIVE_BLOW],		SPELL_TYPES.PHYSICAL,	100,	40,		ranges.nearestThreeSprites,	destructive_blow,		true);
master_grid_add_spell(		SPELLS.PURIFYING_FLAME,			textGrid[# 1, SPELLS.PURIFYING_FLAME],		textGrid[# 2, SPELLS.PURIFYING_FLAME],		textGrid[# 3, SPELLS.PURIFYING_FLAME],		SPELL_TYPES.FIRE,		100,	40,		ranges.nearestFiveSprites,	purifying_flame,		true);
master_grid_add_spell(		SPELLS.JABULS_FIGHT_SONG,			textGrid[# 1, SPELLS.JABULS_FIGHT_SONG],		textGrid[# 2, SPELLS.JABULS_FIGHT_SONG],		textGrid[# 3, SPELLS.JABULS_FIGHT_SONG],		SPELL_TYPES.TRICK,		0,		35,		ranges.onlySelf,			jabuls_fight_song,		false);
master_grid_add_spell(		SPELLS.NOXIOUS_FUMES,			textGrid[# 1, SPELLS.NOXIOUS_FUMES],			textGrid[# 2, SPELLS.NOXIOUS_FUMES],			textGrid[# 3, SPELLS.NOXIOUS_FUMES],			SPELL_TYPES.FIRE,		75,		40,		ranges.nearestFiveSprites,	noxious_fumes,			false);
master_grid_add_spell(		SPELLS.CRECIAS_CRYSTAL_SPIKES,	textGrid[# 1, SPELLS.CRECIAS_CRYSTAL_SPIKES],	textGrid[# 2, SPELLS.CRECIAS_CRYSTAL_SPIKES],	textGrid[# 3, SPELLS.CRECIAS_CRYSTAL_SPIKES],	SPELL_TYPES.EARTH,		120,	65,		ranges.nearestThreeSprites,	crecias_crystal_spikes,	false);
master_grid_add_spell(		SPELLS.PSYCHIC_FISSURE,			textGrid[# 1, SPELLS.PSYCHIC_FISSURE],		textGrid[# 2, SPELLS.PSYCHIC_FISSURE],		textGrid[# 3, SPELLS.PSYCHIC_FISSURE],		SPELL_TYPES.TRICK,		130,	60,		ranges.anySprite,			psychic_fissure,		true);
master_grid_add_spell(		SPELLS.REARRANGE,				textGrid[# 1, SPELLS.REARRANGE],			textGrid[# 2, SPELLS.REARRANGE],			textGrid[# 3, SPELLS.REARRANGE],			SPELL_TYPES.TRICK,		0,		40,		ranges.nearestThreeSprites,	rearrange,				true);
master_grid_add_spell(		SPELLS.SNEAK_ATTACK,				textGrid[# 1, SPELLS.SNEAK_ATTACK],			textGrid[# 2, SPELLS.SNEAK_ATTACK],			textGrid[# 3, SPELLS.SNEAK_ATTACK],			SPELL_TYPES.PHYSICAL,	100,	50,		ranges.nearestFiveSprites,	sneak_attack,			false);
master_grid_add_spell(		SPELLS.DEFLECTIVE_SHIELD,		textGrid[# 1, SPELLS.DEFLECTIVE_SHIELD],		textGrid[# 2, SPELLS.DEFLECTIVE_SHIELD],		textGrid[# 3, SPELLS.DEFLECTIVE_SHIELD],		SPELL_TYPES.TRICK,		0,		50,		ranges.onlySelf,			deflective_shield,		false);
master_grid_add_spell(		SPELLS.DIONS_PARRY,				textGrid[# 1, SPELLS.DIONS_PARRY],			textGrid[# 2, SPELLS.DIONS_PARRY],			textGrid[# 3, SPELLS.DIONS_PARRY],			SPELL_TYPES.PHYSICAL,	135,	40,		ranges.onlySelf,			dions_parry,			false);
master_grid_add_spell(		SPELLS.DIONS_GAMBLING_BLAST,		textGrid[# 1, SPELLS.DIONS_GAMBLING_BLAST],	textGrid[# 2, SPELLS.DIONS_GAMBLING_BLAST],	textGrid[# 3, SPELLS.DIONS_GAMBLING_BLAST],	SPELL_TYPES.TRICK,		0,		35,		ranges.onlySelf,			dions_gambling_blast,	false);
master_grid_add_spell(		SPELLS.DIONS_BARTER_TRICK,		textGrid[# 1, SPELLS.DIONS_BARTER_TRICK],		textGrid[# 2, SPELLS.DIONS_BARTER_TRICK],		textGrid[# 3, SPELLS.DIONS_BARTER_TRICK],		SPELL_TYPES.TRICK,		0,		0,		ranges.onlySelf,			dions_barter_trick,		false);
master_grid_add_spell(		SPELLS.MAGNETIC_PULSE,			textGrid[# 1, SPELLS.MAGNETIC_PULSE],		textGrid[# 2, SPELLS.MAGNETIC_PULSE],		textGrid[# 3, SPELLS.MAGNETIC_PULSE],		SPELL_TYPES.STORM,		90,		40,		ranges.nearestFiveSprites,	magnetic_pulse,			true);
master_grid_add_spell(		SPELLS.BURN_OUT,					textGrid[# 1, SPELLS.BURN_OUT],				textGrid[# 2, SPELLS.BURN_OUT],				textGrid[# 3, SPELLS.BURN_OUT],				SPELL_TYPES.FIRE,		140,	50,		ranges.nearestThreeSprites,	burn_out,				true);
master_grid_add_spell(		SPELLS.STINKBOMB,				textGrid[# 1, SPELLS.STINKBOMB],			textGrid[# 2, SPELLS.STINKBOMB],			textGrid[# 3, SPELLS.STINKBOMB],			SPELL_TYPES.EARTH,		100,	50,		ranges.nearestFiveSprites,	stinkbomb,				true);
master_grid_add_spell(		SPELLS.WIND_SLICE,				textGrid[# 1, SPELLS.WIND_SLICE],			textGrid[# 2, SPELLS.WIND_SLICE],			textGrid[# 3, SPELLS.WIND_SLICE],			SPELL_TYPES.STORM,		120,	55,		ranges.nearestFiveSprites,	wind_slice,				true);
master_grid_add_spell(		SPELLS.CHANNEL_ESSENCE,			textGrid[# 1, SPELLS.CHANNEL_ESSENCE],		textGrid[# 2, SPELLS.CHANNEL_ESSENCE],		textGrid[# 3, SPELLS.CHANNEL_ESSENCE],		SPELL_TYPES.TRICK,		0,		30,		ranges.onlySelf,			channel_essence,		false);
master_grid_add_spell(		SPELLS.SPHERAS_CURSE,			textGrid[# 1, SPELLS.SPHERAS_CURSE],			textGrid[# 2, SPELLS.SPHERAS_CURSE],			textGrid[# 3, SPELLS.SPHERAS_CURSE],			SPELL_TYPES.TRICK,		0,		30,		ranges.nearestOneEnemy,		spheras_curse,			false);
master_grid_add_spell(		SPELLS.CRECIAS_CRYSTAL_WIND,		textGrid[# 1, SPELLS.CRECIAS_CRYSTAL_WIND],	textGrid[# 2, SPELLS.CRECIAS_CRYSTAL_WIND],	textGrid[# 3, SPELLS.CRECIAS_CRYSTAL_WIND],	SPELL_TYPES.EARTH,		100,	45,		ranges.nearestFiveSprites,	crecias_crystal_wind,	true);
master_grid_add_spell(		SPELLS.LAVA_SPIRE,				textGrid[# 1, SPELLS.LAVA_SPIRE],			textGrid[# 2, SPELLS.LAVA_SPIRE],			textGrid[# 3, SPELLS.LAVA_SPIRE],			SPELL_TYPES.FIRE,		100,	50,		ranges.nearestThreeSprites,	lava_spire,				true);
master_grid_add_spell(		SPELLS.ENDLESS_RIVER,			textGrid[# 1, SPELLS.ENDLESS_RIVER],			textGrid[# 2, SPELLS.ENDLESS_RIVER],			textGrid[# 3, SPELLS.ENDLESS_RIVER],			SPELL_TYPES.WATER,		80,		40,		ranges.nearestFiveSprites,	endless_river,			true);
master_grid_add_spell(		SPELLS.CLOUD_BREAK,				textGrid[# 1, SPELLS.CLOUD_BREAK],			textGrid[# 2, SPELLS.CLOUD_BREAK],			textGrid[# 3, SPELLS.CLOUD_BREAK],			SPELL_TYPES.STORM,		60,		30,		ranges.anySprite,			cloud_break,			false);
master_grid_add_spell(		SPELLS.TELEKINETIC_BLAST,		textGrid[# 1, SPELLS.TELEKINETIC_BLAST],		textGrid[# 2, SPELLS.TELEKINETIC_BLAST],		textGrid[# 3, SPELLS.TELEKINETIC_BLAST],		SPELL_TYPES.PHYSICAL,	120,	65,		ranges.anySprite,			telekinetic_blast,		false);
master_grid_add_spell(		SPELLS.DESTABILIZING_BLOW,		textGrid[# 1, SPELLS.DESTABILIZING_BLOW],	textGrid[# 2, SPELLS.DESTABILIZING_BLOW],	textGrid[# 3, SPELLS.DESTABILIZING_BLOW],	SPELL_TYPES.PHYSICAL,	100,	40,		ranges.nearestFiveSprites,	destabilizing_blow,		true);
master_grid_add_spell(		SPELLS.FULL_THRUST,				textGrid[# 1, SPELLS.FULL_THRUST],			textGrid[# 2, SPELLS.FULL_THRUST],			textGrid[# 3, SPELLS.FULL_THRUST],			SPELL_TYPES.PHYSICAL,	160,	60,		ranges.nearestThreeSprites,	full_thrust,			true);
master_grid_add_spell(		SPELLS.VOLCANIC_ERUPTION,		textGrid[# 1, SPELLS.VOLCANIC_ERUPTION],		textGrid[# 2, SPELLS.VOLCANIC_ERUPTION],		textGrid[# 3, SPELLS.VOLCANIC_ERUPTION],		SPELL_TYPES.FIRE,		130,	70,		ranges.nearestThreeSprites,	volcanic_eruption,		true);
master_grid_add_spell(		SPELLS.BROADCAST_DATA,			textGrid[# 1, SPELLS.BROADCAST_DATA],		textGrid[# 2, SPELLS.BROADCAST_DATA],		textGrid[# 3, SPELLS.BROADCAST_DATA],		SPELL_TYPES.TRICK,		0,		40,		ranges.onlySelf,			broadcast_data,			false);
master_grid_add_spell(		SPELLS.COLLAPSE_SPACE,			textGrid[# 1, SPELLS.COLLAPSE_SPACE],		textGrid[# 2, SPELLS.COLLAPSE_SPACE],		textGrid[# 3, SPELLS.COLLAPSE_SPACE],		SPELL_TYPES.TRICK,		0,		60,		ranges.onlySelf,			collapse_space,			false);
master_grid_add_spell(		SPELLS.EXPAND_TIME,				textGrid[# 1, SPELLS.EXPAND_TIME],			textGrid[# 2, SPELLS.EXPAND_TIME],			textGrid[# 3, SPELLS.EXPAND_TIME],			SPELL_TYPES.TRICK,		0,		40,		ranges.onlySelf,			expand_time,			false);
master_grid_add_spell(		SPELLS.SPHERAS_DEMISE,			textGrid[# 1, SPELLS.SPHERAS_DEMISE],		textGrid[# 2, SPELLS.SPHERAS_DEMISE],		textGrid[# 3, SPELLS.SPHERAS_DEMISE],		SPELL_TYPES.TRICK,		0,		60,		ranges.onlySelf,			spheras_demise,			false);
master_grid_add_spell(		SPELLS.TIME_LOOP,				textGrid[# 1, SPELLS.TIME_LOOP],				textGrid[# 2, SPELLS.TIME_LOOP],				textGrid[# 3, SPELLS.TIME_LOOP],				SPELL_TYPES.TRICK,		0,		50,		ranges.anySprite,			time_loop,				false);
master_grid_add_spell(		SPELLS.ERADICATE,				textGrid[# 1, SPELLS.ERADICATE],			textGrid[# 2, SPELLS.ERADICATE],			textGrid[# 3, SPELLS.ERADICATE],			SPELL_TYPES.TRICK,		0,		65,		ranges.onlySelf,			eradicate,				false);

// encode spell grid
global.allSpells = encode_grid(global.spellGrid);

// delete spell grid
ds_grid_destroy(global.spellGrid);

///@desc This function is meant to be called by the spellbook whenever there is a new currentSpell.
function spellbook_load_params() {
	// use currentSpell to get all params
	name			= player.spellBookGrid[# SPELL_PARAMS.NAME,			currentSpell];
	description		= player.spellBookGrid[# SPELL_PARAMS.DESCRIPTION,	currentSpell];
	spellType		= player.spellBookGrid[# SPELL_PARAMS.TYPE,			currentSpell];
	spellRange		= player.spellBookGrid[# SPELL_PARAMS.RANGE,		currentSpell];
	spellPower		= player.spellBookGrid[# SPELL_PARAMS.POWER,		currentSpell];
	spellCost		= player.spellBookGrid[# SPELL_PARAMS.COST,			currentSpell];
}

function spar_spell_load_params() {
	// decode spell grid
	var grid = ds_grid_create(SPELL_PARAMS.HEIGHT, SPELLS.height);
	decode_grid(global.allSpells, grid);
	
	// use currentSpell to get all params
	spellName	= grid[# SPELL_PARAMS.NAME,			currentSpell];
	spellCost	= grid[# SPELL_PARAMS.COST,			currentSpell];
	spellType	= grid[# SPELL_PARAMS.TYPE,			currentSpell];
	spellPower	= grid[# SPELL_PARAMS.POWER,		currentSpell];
	spellEffect	= grid[# SPELL_PARAMS.EFFECT,		currentSpell];
}