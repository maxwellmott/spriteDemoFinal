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
	grapple,
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
	stinkbomb,
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

// add all spells to grid	ID					NAME								DESCRIPTION							LORE								TYPE				POWER	COST	RANGE						EFFECT
master_grid_add_spell(		SPELLS.solarFlare,	textGrid[# 1, SPELLS.solarFlare],	textGrid[# 1, SPELLS.solarFlare],	textGrid[# 2, SPELLS.solarFlare],	SPELL_TYPES.FIRE,	150,	80,		ranges.nearestFiveSprites,	);
master_grid_add_spell(		SPELLS.tidalForce,	textGrid[# 1, SPELLS.tidalForce],	textGrid[# 1, SPELLS.tidalForce],	textGrid[# 2, SPELLS.tidalForce],	SPELL_TYPES.WATER,	150,	80,		ranges.nearestFiveSprites,	);
master_grid_add_spell(		SPELLS.nebulaStorm,	textGrid[# 1, SPELLS.nebulaStorm],	textGrid[# 1, SPELLS.nebulaStorm],	textGrid[# 2, SPELLS.nebulaStorm],	SPELL_TYPES.STORM,	150,	80,		ranges.nearestFiveSprites,	);

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