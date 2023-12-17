// set legal spell count
#macro	SPELLMAX	8

// spell ids enum
enum SPELLS {
	solarFlare,
	tidalForce,
	nebulaStorm,
	tectonicShift,
	fireball,
	holyWater,
	shock,
	decay,
	expelForce,
	ladySolanusGrace,
	typhoon,
	healingLight,
	rubursWaterCannon,
	rubursGrapple,
	lusiasHarvestSpell,
	waterlog,
	airPressure,
	superbloom,
	rapidStrike,
	loomingDanger,
	intercept,
	steamBath,
	undertow,
	empathize,
	hellfire,
	ballLightning,
	quicksand,
	lordMogradthsRage,
	drainLifeforce,
	pyrokinesis,
	downpour,
	arcBlast,
	hikamsWinterSpell,
	osmosis,
	flashFreeze,
	landslide,
	amandsEnergyBlast,
	shiftPerspective,
	psychicImpact,
	tremor,
	skydive,
	destructiveBlow,
	purifyingFlame,
	jabulsFightSong,
	noxiousFumes,
	creciasCrystalSpikes,
	psychicFissure,
	rearrange,
	sneakAttack,
	deflectiveShield,
	dionsParry,
	dionsGamblingBlast,
	dionsBarterTrick,
	magneticPulse,
	burnOut,
	stinkbomb,
	windSlice,
	channelEssence,
	spherasCurse,
	creciasCrystalWind,
	lavaSpire,
	endlessRiver,
	cloudBreak,
	telekineticBlast,
	destabilizingBlow,
	fullThrust,
	volcanicEruption,
	broadcastData,
	collapseSpace,
	expandTime,
	spherasDemise,
	height
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

#region SPELL FUNCTION

function solar_flare() {
		
}

function tidal_force() {
	
}

function nebula_storm() {
	
}

function tectonic_shift() {
	
}

function fireball() {
	
}

function holy_water() {
	
}

function shock() {
	
}

function decay() {
	
}

function expel_force() {
	
}

function lady_solanus_grace() {
	
}

function typhoon() {
	
}

function healing_light() {
	
}

function ruburs_water_cannon() {
	
}

function ruburs_grapple() {
	
}

function lusias_harvest_spell() {
	
}

function waterlog() {
	
}

function air_pressure() {
	
}

function superbloom() {
	
}

function rapid_strike() {
	
}

function looming_danger() {
	
}

function intercept() {
	
}

function steam_bath() {
	
}

function undertow() {
	
}

function empathize() {
	
}

function hellfire() {
	
}

function ball_lightning() {
	
}

function quicksand() {
	
}

function lord_morgadths_rage() {
	
}

function drain_lifeforce() {
	
}

function pyrokinesis() {
	
}

function downpour() {
	
}

function arc_blast() {
	
}

function hikams_winter_spell() {
	
}

function osmosis() {
	
}

function flash_freeze() {
	
}

function landslide() {
	
}

function amands_energy_blast() {
	
}

function shift_perspective() {
	
}

function psychic_impact() {
	
}

function tremor() {

}

function skydive() {
	
}

function destructive_blow() {
	
}

function purifying_flame() {
	
}

function jabuls_fight_song() {
	
}

function noxious_fumes() {
	
}

function crecias_crystal_spikes() {
	
}

function psychic_fisure() {
	
}

function rearrange() {
	
}

function sneak_attack() {
	
}

function deflective_shield() {
	
}

function dions_parry() {
	
}

function dions_gambling_blast() {
	
}

function dions_barter_trick() {
	
}

function magnetic_pulse() {
	
}

function burn_out() {
	
}

function stinkbomb() {
	
}

function wind_slice() {
	
}

function channel_essence() {
	
}

function spheras_curse() {
	
}

function lava_spire() {
	
}

function endless_river() {
	
}

function cloud_break() {
	
}

function telekinetic_blast() {
	
}

function destabilizing_blow() {
	
}

function full_thrust() {
	
}

function volcanic_eruption() {
	
}

function broadcast_data() {
	
}

function collapse_space() {
	
}

function expand_time() {
	
}

function spheras_demise() {
	
}

#endregion  

// add all spells to grid	ID							NAME										DESCRIPTION									LORE										TYPE					POWER	COST	RANGE						EFFECT
master_grid_add_spell(		SPELLS.solarFlare,			textGrid[# 1, SPELLS.solarFlare],			textGrid[# 2, SPELLS.solarFlare],			textGrid[# 3, SPELLS.solarFlare],			SPELL_TYPES.FIRE,		150,	80,		ranges.nearestFiveSprites,	solar_flare,			true);
master_grid_add_spell(		SPELLS.tidalForce,			textGrid[# 1, SPELLS.tidalForce],			textGrid[# 2, SPELLS.tidalForce],			textGrid[# 3, SPELLS.tidalForce],			SPELL_TYPES.WATER,		150,	80,		ranges.nearestFiveSprites,	tidal_force,			true);
master_grid_add_spell(		SPELLS.nebulaStorm,			textGrid[# 1, SPELLS.nebulaStorm],			textGrid[# 2, SPELLS.nebulaStorm],			textGrid[# 3, SPELLS.nebulaStorm],			SPELL_TYPES.STORM,		150,	80,		ranges.nearestFiveSprites,	nebula_storm,			true);
master_grid_add_spell(		SPELLS.tectonicShift,		textGrid[# 1, SPELLS.tectonicShift],		textGrid[# 2, SPELLS.tectonicShift],		textGrid[# 3, SPELLS.tectonicShift],		SPELL_TYPES.EARTH,		150,	80,		ranges.nearestFiveSprites,	tectonic_shift,			true);
master_grid_add_spell(		SPELLS.fireball,			textGrid[# 1, SPELLS.fireball],				textGrid[# 2, SPELLS.fireball],				textGrid[# 3, SPELLS.fireball],				SPELL_TYPES.FIRE,		80,		25,		ranges.nearestFiveSprites,	fireball,				true);
master_grid_add_spell(		SPELLS.holyWater,			textGrid[# 1, SPELLS.holyWater],			textGrid[# 2, SPELLS.holyWater],			textGrid[# 3, SPELLS.holyWater],			SPELL_TYPES.WATER,		70,		35,		ranges.nearestFiveSprites,	holy_water,				true);
master_grid_add_spell(		SPELLS.shock,				textGrid[# 1, SPELLS.shock],				textGrid[# 2, SPELLS.shock],				textGrid[# 3, SPELLS.shock],				SPELL_TYPES.STORM,		80,		35,		ranges.nearestFiveSprites,	shock,					true);
master_grid_add_spell(		SPELLS.decay,				textGrid[# 1, SPELLS.decay],				textGrid[# 2, SPELLS.decay],				textGrid[# 3, SPELLS.decay],				SPELL_TYPES.EARTH,		80,		30,		ranges.nearestFiveSprites,	decay,					false);
master_grid_add_spell(		SPELLS.expelForce,			textGrid[# 1, SPELLS.expelForce],			textGrid[# 2, SPELLS.expelForce],			textGrid[# 3, SPELLS.expelForce],			SPELL_TYPES.PHYSICAL,	100,	30,		ranges.nearestThreeSprites,	expel_force,			true);
master_grid_add_spell(		SPELLS.ladySolanusGrace,	textGrid[# 1, SPELLS.ladySolanusGrace],		textGrid[# 2, SPELLS.ladySolanusGrace],		textGrid[# 3, SPELLS.ladySolanusGrace],		SPELL_TYPES.TRICK,		0,		60,		ranges.onlySelf,			lady_solanus_grace,		false);
master_grid_add_spell(		SPELLS.typhoon,				textGrid[# 1, SPELLS.typhoon],				textGrid[# 2, SPELLS.typhoon],				textGrid[# 3, SPELLS.typhoon],				SPELL_TYPES.STORM,		100,	35,		ranges.nearestThreeSprites,	typhoon,				true);
master_grid_add_spell(		SPELLS.healingLight,		textGrid[# 1, SPELLS.healingLight],			textGrid[# 2, SPELLS.healingLight],			textGrid[# 3, SPELLS.healingLight],			SPELL_TYPES.TRICK,		0,		45,		ranges.onlySelf,			healing_light,			false);
master_grid_add_spell(		SPELLS.rubursWaterCannon,	textGrid[# 1, SPELLS.rubursWaterCannon],	textGrid[# 2, SPELLS.rubursWaterCannon],	textGrid[# 3, SPELLS.rubursWaterCannon],	SPELL_TYPES.WATER,		120,	60,		ranges.nearestThreeSprites,	ruburs_water_cannon,	true);
master_grid_add_spell(		SPELLS.rubursGrapple,		textGrid[# 1, SPELLS.rubursGrapple],		textGrid[# 2, SPELLS.rubursGrapple],		textGrid[# 3, SPELLS.rubursGrapple],		SPELL_TYPES.PHYSICAL,	80,		45,		ranges.nearestThreeSprites, ruburs_grapple,			true);
master_grid_add_spell(		SPELLS.lusiasHarvestSpell,	textGrid[# 1, SPELLS.lusiasHarvestSpell],	textGrid[# 2, SPELLS.lusiasHarvestSpell],	textGrid[# 3, SPELLS.lusiasHarvestSpell],	SPELL_TYPES.EARTH,		0,		25,		ranges.onlySelf,			lusias_harvest_spell,	false);
master_grid_add_spell(		SPELLS.waterlog,			textGrid[# 1, SPELLS.waterlog],				textGrid[# 2, SPELLS.waterlog],				textGrid[# 3, SPELLS.waterlog],				SPELL_TYPES.WATER,		70,		35,		ranges.nearestFiveSprites,	waterlog,				false);
master_grid_add_spell(		SPELLS.airPressure,			textGrid[# 1, SPELLS.airPressure],			textGrid[# 2, SPELLS.airPressure],			textGrid[# 3, SPELLS.airPressure],			SPELL_TYPES.STORM,		70,		35,		ranges.nearestFiveSprites,	air_pressure,			true);

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