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
	timeLoop,
	eradicate,
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
	// grant all allies curse of the warrior
}

function tidal_force() {
	// force target to swap (dodgeable)
}

function nebula_storm() {
	// hex all enemies
}

function tectonic_shift() {
	// bind all enemies
}

function fireball() {
	// no effect
}

function holy_water() {
	// heal team
}

function shock() {
	// bind target (dodgeable)
}

function decay() {
	// restore half of health depleted (dodgeable)
}

function expel_force() {
	// no effect
}

function lady_solanus_grace() {
	// heal team and grant all allies blessing of the tree
}

function typhoon() {
	// grant target curse of the warrior
}

function healing_light() {
	// fully heal team
}

function ruburs_water_cannon() {
	// no effect
}

function ruburs_grapple() {
	// bind target (dodgeable)
}

function lusias_harvest_spell() {
	// change arena to forest
}

function waterlog() {
	// grant target curse of the tree
}

function air_pressure() {
	// grant target and all nearby enemies the curse of the tree
}

function superbloom() {
	// remove all curses and hindrances from caster's side of the field
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
	// this spell will do extra damage to mechanical sprites when
	// cast
}

function purifying_flame() {
	// there will be a check before damage is dealth wherein
	// this spell will do extra damage to astral sprites when
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
master_grid_add_spell(		SPELLS.solarFlare,				textGrid[# 1, SPELLS.solarFlare],			textGrid[# 2, SPELLS.solarFlare],			textGrid[# 3, SPELLS.solarFlare],			SPELL_TYPES.FIRE,		150,	80,		ranges.nearestFiveSprites,	solar_flare,			true);
master_grid_add_spell(		SPELLS.tidalForce,				textGrid[# 1, SPELLS.tidalForce],			textGrid[# 2, SPELLS.tidalForce],			textGrid[# 3, SPELLS.tidalForce],			SPELL_TYPES.WATER,		150,	80,		ranges.nearestFiveSprites,	tidal_force,			true);
master_grid_add_spell(		SPELLS.nebulaStorm,				textGrid[# 1, SPELLS.nebulaStorm],			textGrid[# 2, SPELLS.nebulaStorm],			textGrid[# 3, SPELLS.nebulaStorm],			SPELL_TYPES.STORM,		150,	80,		ranges.nearestFiveSprites,	nebula_storm,			true);
master_grid_add_spell(		SPELLS.tectonicShift,			textGrid[# 1, SPELLS.tectonicShift],		textGrid[# 2, SPELLS.tectonicShift],		textGrid[# 3, SPELLS.tectonicShift],		SPELL_TYPES.EARTH,		150,	80,		ranges.nearestFiveSprites,	tectonic_shift,			true);
master_grid_add_spell(		SPELLS.fireball,				textGrid[# 1, SPELLS.fireball],				textGrid[# 2, SPELLS.fireball],				textGrid[# 3, SPELLS.fireball],				SPELL_TYPES.FIRE,		80,		25,		ranges.nearestFiveSprites,	fireball,				true);
master_grid_add_spell(		SPELLS.holyWater,				textGrid[# 1, SPELLS.holyWater],			textGrid[# 2, SPELLS.holyWater],			textGrid[# 3, SPELLS.holyWater],			SPELL_TYPES.WATER,		70,		35,		ranges.nearestFiveSprites,	holy_water,				true);
master_grid_add_spell(		SPELLS.shock,					textGrid[# 1, SPELLS.shock],				textGrid[# 2, SPELLS.shock],				textGrid[# 3, SPELLS.shock],				SPELL_TYPES.STORM,		80,		35,		ranges.nearestFiveSprites,	shock,					true);
master_grid_add_spell(		SPELLS.decay,					textGrid[# 1, SPELLS.decay],				textGrid[# 2, SPELLS.decay],				textGrid[# 3, SPELLS.decay],				SPELL_TYPES.EARTH,		80,		30,		ranges.nearestFiveSprites,	decay,					false);
master_grid_add_spell(		SPELLS.expelForce,				textGrid[# 1, SPELLS.expelForce],			textGrid[# 2, SPELLS.expelForce],			textGrid[# 3, SPELLS.expelForce],			SPELL_TYPES.PHYSICAL,	100,	30,		ranges.nearestThreeSprites,	expel_force,			true);
master_grid_add_spell(		SPELLS.ladySolanusGrace,		textGrid[# 1, SPELLS.ladySolanusGrace],		textGrid[# 2, SPELLS.ladySolanusGrace],		textGrid[# 3, SPELLS.ladySolanusGrace],		SPELL_TYPES.TRICK,		0,		60,		ranges.onlySelf,			lady_solanus_grace,		false);
master_grid_add_spell(		SPELLS.typhoon,					textGrid[# 1, SPELLS.typhoon],				textGrid[# 2, SPELLS.typhoon],				textGrid[# 3, SPELLS.typhoon],				SPELL_TYPES.STORM,		100,	35,		ranges.nearestThreeSprites,	typhoon,				true);
master_grid_add_spell(		SPELLS.healingLight,			textGrid[# 1, SPELLS.healingLight],			textGrid[# 2, SPELLS.healingLight],			textGrid[# 3, SPELLS.healingLight],			SPELL_TYPES.TRICK,		0,		45,		ranges.onlySelf,			healing_light,			false);
master_grid_add_spell(		SPELLS.rubursWaterCannon,		textGrid[# 1, SPELLS.rubursWaterCannon],	textGrid[# 2, SPELLS.rubursWaterCannon],	textGrid[# 3, SPELLS.rubursWaterCannon],	SPELL_TYPES.WATER,		120,	60,		ranges.nearestThreeSprites,	ruburs_water_cannon,	true);
master_grid_add_spell(		SPELLS.rubursGrapple,			textGrid[# 1, SPELLS.rubursGrapple],		textGrid[# 2, SPELLS.rubursGrapple],		textGrid[# 3, SPELLS.rubursGrapple],		SPELL_TYPES.PHYSICAL,	80,		45,		ranges.nearestThreeSprites, ruburs_grapple,			true);
master_grid_add_spell(		SPELLS.lusiasHarvestSpell,		textGrid[# 1, SPELLS.lusiasHarvestSpell],	textGrid[# 2, SPELLS.lusiasHarvestSpell],	textGrid[# 3, SPELLS.lusiasHarvestSpell],	SPELL_TYPES.EARTH,		0,		25,		ranges.onlySelf,			lusias_harvest_spell,	false);
master_grid_add_spell(		SPELLS.waterlog,				textGrid[# 1, SPELLS.waterlog],				textGrid[# 2, SPELLS.waterlog],				textGrid[# 3, SPELLS.waterlog],				SPELL_TYPES.WATER,		70,		35,		ranges.nearestFiveSprites,	waterlog,				false);
master_grid_add_spell(		SPELLS.airPressure,				textGrid[# 1, SPELLS.airPressure],			textGrid[# 2, SPELLS.airPressure],			textGrid[# 3, SPELLS.airPressure],			SPELL_TYPES.STORM,		70,		35,		ranges.nearestFiveSprites,	air_pressure,			true);
master_grid_add_spell(		SPELLS.superbloom,				textGrid[# 1, SPELLS.superbloom],			textGrid[# 2, SPELLS.superbloom],			textGrid[# 3, SPELLS.superbloom],			SPELL_TYPES.EARTH,		100,	50,		ranges.nearestThreeSprites,	superbloom,				true);
master_grid_add_spell(		SPELLS.rapidStrike,				textGrid[# 1, SPELLS.rapidStrike],			textGrid[# 2, SPELLS.rapidStrike],			textGrid[# 3, SPELLS.rapidStrike],			SPELL_TYPES.PHYSICAL,	75,		40,		ranges.nearestThreeSprites,	rapid_strike,			false);
master_grid_add_spell(		SPELLS.loomingDanger,			textGrid[# 1, SPELLS.loomingDanger],		textGrid[# 2, SPELLS.loomingDanger],		textGrid[# 3, SPELLS.loomingDanger],		SPELL_TYPES.TRICK,		0,		30,		ranges.anySprite,			looming_danger,			false);
master_grid_add_spell(		SPELLS.steamBath,				textGrid[# 1, SPELLS.steamBath],			textGrid[# 2, SPELLS.steamBath],			textGrid[# 3, SPELLS.steamBath],			SPELL_TYPES.WATER,		65,		35,		ranges.nearestFiveSprites,	steam_bath,				true);
master_grid_add_spell(		SPELLS.undertow,				textGrid[# 1, SPELLS.undertow],				textGrid[# 2, SPELLS.undertow],				textGrid[# 3, SPELLS.undertow],				SPELL_TYPES.WATER,		100,	50,		ranges.nearestFiveSprites,	undertow,				false);
master_grid_add_spell(		SPELLS.empathize,				textGrid[# 1, SPELLS.empathize],			textGrid[# 2, SPELLS.empathize],			textGrid[# 3, SPELLS.empathize],			SPELL_TYPES.TRICK,		0,		20,		ranges.anySprite,			empathize,				false);
master_grid_add_spell(		SPELLS.hellfire,				textGrid[# 1, SPELLS.hellfire],				textGrid[# 2, SPELLS.hellfire],				textGrid[# 3, SPELLS.hellfire],				SPELL_TYPES.FIRE,		100,	50,		ranges.anySprite,			hellfire,				true);
master_grid_add_spell(		SPELLS.ballLightning,			textGrid[# 1, SPELLS.ballLightning],		textGrid[# 2, SPELLS.ballLightning],		textGrid[# 3, SPELLS.ballLightning],		SPELL_TYPES.STORM,		80,		50,		ranges.nearestFiveSprites,	ball_lightning,			true);
master_grid_add_spell(		SPELLS.quicksand,				textGrid[# 1, SPELLS.quicksand],			textGrid[# 2, SPELLS.quicksand],			textGrid[# 3, SPELLS.quicksand],			SPELL_TYPES.EARTH,		70,		40,		ranges.anySprite,			quicksand,				false);
master_grid_add_spell(		SPELLS.lordMogradthsRage,		textGrid[# 1, SPELLS.lordMogradthsRage],	textGrid[# 2, SPELLS.lordMogradthsRage],	textGrid[# 3, SPELLS.lordMogradthsRage],	SPELL_TYPES.TRICK,		0,		50,		ranges.nearestFiveSprites,	lord_mogradths_rage,	false);
master_grid_add_spell(		SPELLS.drainLifeforce,			textGrid[# 1, SPELLS.drainLifeforce],		textGrid[# 2, SPELLS.drainLifeforce],		textGrid[# 3, SPELLS.drainLifeforce],		SPELL_TYPES.PHYSICAL,	90,		40,		ranges.nearestFiveSprites,	drain_lifeforce,		true);
master_grid_add_spell(		SPELLS.pyrokinesis,				textGrid[# 1, SPELLS.pyrokinesis],			textGrid[# 2, SPELLS.pyrokinesis],			textGrid[# 3, SPELLS.pyrokinesis],			SPELL_TYPES.FIRE,		135,	60,		ranges.nearestFiveSprites,	pyrokinesis,			false);
master_grid_add_spell(		SPELLS.downpour,				textGrid[# 1, SPELLS.downpour],				textGrid[# 2, SPELLS.downpour],				textGrid[# 3, SPELLS.downpour],				SPELL_TYPES.WATER,		75,		40,		ranges.nearestFiveSprites,	downpour,				false);
master_grid_add_spell(		SPELLS.arcBlast,				textGrid[# 1, SPELLS.arcBlast],				textGrid[# 2, SPELLS.arcBlast],				textGrid[# 3, SPELLS.arcBlast],				SPELL_TYPES.STORM,		110,	50,		ranges.nearestThreeSprites,	arc_blast,				false);
master_grid_add_spell(		SPELLS.hikamsWinterSpell,		textGrid[# 1, SPELLS.hikamsWinterSpell],	textGrid[# 2, SPELLS.hikamsWinterSpell],	textGrid[# 3, SPELLS.hikamsWinterSpell],	SPELL_TYPES.EARTH,		70,		30,		ranges.anySprite,			hikams_winter_spell,	false);
master_grid_add_spell(		SPELLS.osmosis,					textGrid[# 1, SPELLS.osmosis],				textGrid[# 2, SPELLS.osmosis],				textGrid[# 3, SPELLS.osmosis],				SPELL_TYPES.WATER,		90,		40,		ranges.nearestFiveSprites,	osmosis,				false);
master_grid_add_spell(		SPELLS.flashFreeze,				textGrid[# 1, SPELLS.flashFreeze],			textGrid[# 2, SPELLS.flashFreeze],			textGrid[# 3, SPELLS.flashFreeze],			SPELL_TYPES.WATER,		110,	50,		ranges.nearestFiveSprites,	flash_freeze,			false);
master_grid_add_spell(		SPELLS.landslide,				textGrid[# 1, SPELLS.landslide],			textGrid[# 2, SPELLS.landslide],			textGrid[# 3, SPELLS.landslide],			SPELL_TYPES.EARTH,		110,	50,		ranges.nearestFiveSprites,	landslide,				true);
master_grid_add_spell(		SPELLS.amandsEnergyBlast,		textGrid[# 1, SPELLS.amandsEnergyBlast],	textGrid[# 2, SPELLS.amandsEnergyBlast],	textGrid[# 3, SPELLS.amandsEnergyBlast],	SPELL_TYPES.TRICK,		0,		40,		ranges.nearestThreeSprites,	amands_energy_blast,	true);
master_grid_add_spell(		SPELLS.shiftPerspective,		textGrid[# 1, SPELLS.shiftPerspective],		textGrid[# 2, SPELLS.shiftPerspective],		textGrid[# 3, SPELLS.shiftPerspective],		SPELL_TYPES.TRICK,		0,		35,		ranges.anySprite,			shift_perspective,		false);
master_grid_add_spell(		SPELLS.psychicImpact,			textGrid[# 1, SPELLS.psychicImpact],		textGrid[# 2, SPELLS.psychicImpact],		textGrid[# 3, SPELLS.psychicImpact],		SPELL_TYPES.TRICK,		90,		40,		ranges.anySprite,			psychic_impact,			false);
master_grid_add_spell(		SPELLS.tremor,					textGrid[# 1, SPELLS.tremor],				textGrid[# 2, SPELLS.tremor],				textGrid[# 3, SPELLS.tremor],				SPELL_TYPES.EARTH,		120,	60,		ranges.nearestThreeSprites,	tremor,					false);
master_grid_add_spell(		SPELLS.skydive,					textGrid[# 1, SPELLS.skydive],				textGrid[# 2, SPELLS.skydive],				textGrid[# 3, SPELLS.skydive],				SPELL_TYPES.PHYSICAL,	120,	50,		ranges.nearestThreeSprites,	skydive,				false);
master_grid_add_spell(		SPELLS.destructiveBlow,			textGrid[# 1, SPELLS.destructiveBlow],		textGrid[# 2, SPELLS.destructiveBlow],		textGrid[# 3, SPELLS.destructiveBlow],		SPELL_TYPES.PHYSICAL,	100,	40,		ranges.nearestThreeSprites,	destructive_blow,		true);
master_grid_add_spell(		SPELLS.purifyingFlame,			textGrid[# 1, SPELLS.purifyingFlame],		textGrid[# 2, SPELLS.purifyingFlame],		textGrid[# 3, SPELLS.purifyingFlame],		SPELL_TYPES.FIRE,		100,	40,		ranges.nearestFiveSprites,	purifying_flame,		true);
master_grid_add_spell(		SPELLS.jabulsFightSong,			textGrid[# 1, SPELLS.jabulsFightSong],		textGrid[# 2, SPELLS.jabulsFightSong],		textGrid[# 3, SPELLS.jabulsFightSong],		SPELL_TYPES.TRICK,		0,		35,		ranges.onlySelf,			jabuls_fight_song,		false);
master_grid_add_spell(		SPELLS.noxiousFumes,			textGrid[# 1, SPELLS.noxiousFumes],			textGrid[# 2, SPELLS.noxiousFumes],			textGrid[# 3, SPELLS.noxiousFumes],			SPELL_TYPES.FIRE,		75,		40,		ranges.nearestFiveSprites,	noxious_fumes,			false);
master_grid_add_spell(		SPELLS.creciasCrystalSpikes,	textGrid[# 1, SPELLS.creciasCrystalSpikes],	textGrid[# 2, SPELLS.creciasCrystalSpikes],	textGrid[# 3, SPELLS.creciasCrystalSpikes],	SPELL_TYPES.EARTH,		120,	65,		ranges.nearestThreeSprites,	crecias_crystal_spikes,	false);
master_grid_add_spell(		SPELLS.psychicFissure,			textGrid[# 1, SPELLS.psychicFissure],		textGrid[# 2, SPELLS.psychicFissure],		textGrid[# 3, SPELLS.psychicFissure],		SPELL_TYPES.TRICK,		130,	60,		ranges.anySprite,			psychic_fissure,		true);
master_grid_add_spell(		SPELLS.rearrange,				textGrid[# 1, SPELLS.rearrange],			textGrid[# 2, SPELLS.rearrange],			textGrid[# 3, SPELLS.rearrange],			SPELL_TYPES.TRICK,		0,		40,		ranges.nearestThreeSprites,	rearrange,				true);
master_grid_add_spell(		SPELLS.sneakAttack,				textGrid[# 1, SPELLS.sneakAttack],			textGrid[# 2, SPELLS.sneakAttack],			textGrid[# 3, SPELLS.sneakAttack],			SPELL_TYPES.PHYSICAL,	100,	50,		ranges.nearestFiveSprites,	sneak_attack,			false);
master_grid_add_spell(		SPELLS.deflectiveShield,		textGrid[# 1, SPELLS.deflectiveShield],		textGrid[# 2, SPELLS.deflectiveShield],		textGrid[# 3, SPELLS.deflectiveShield],		SPELL_TYPES.TRICK,		0,		50,		ranges.onlySelf,			deflective_shield,		false);
master_grid_add_spell(		SPELLS.dionsParry,				textGrid[# 1, SPELLS.dionsParry],			textGrid[# 2, SPELLS.dionsParry],			textGrid[# 3, SPELLS.dionsParry],			SPELL_TYPES.PHYSICAL,	135,	40,		ranges.onlySelf,			dions_parry,			false);
master_grid_add_spell(		SPELLS.dionsGamblingBlast,		textGrid[# 1, SPELLS.dionsGamblingBlast],	textGrid[# 2, SPELLS.dionsGamblingBlast],	textGrid[# 3, SPELLS.dionsGamblingBlast],	SPELL_TYPES.TRICK,		0,		35,		ranges.onlySelf,			dions_gambling_blast,	false);
master_grid_add_spell(		SPELLS.dionsBarterTrick,		textGrid[# 1, SPELLS.dionsBarterTrick],		textGrid[# 2, SPELLS.dionsBarterTrick],		textGrid[# 3, SPELLS.dionsBarterTrick],		SPELL_TYPES.TRICK,		0,		0,		ranges.onlySelf,			dions_barter_trick,		false);
master_grid_add_spell(		SPELLS.magneticPulse,			textGrid[# 1, SPELLS.magneticPulse],		textGrid[# 2, SPELLS.magneticPulse],		textGrid[# 3, SPELLS.magneticPulse],		SPELL_TYPES.STORM,		90,		40,		ranges.nearestFiveSprites,	magnetic_pulse,			true);
master_grid_add_spell(		SPELLS.burnOut,					textGrid[# 1, SPELLS.burnOut],				textGrid[# 2, SPELLS.burnOut],				textGrid[# 3, SPELLS.burnOut],				SPELL_TYPES.FIRE,		140,	50,		ranges.nearestThreeSprites,	burn_out,				true);
master_grid_add_spell(		SPELLS.stinkbomb,				textGrid[# 1, SPELLS.stinkbomb],			textGrid[# 2, SPELLS.stinkbomb],			textGrid[# 3, SPELLS.stinkbomb],			SPELL_TYPES.EARTH,		100,	50,		ranges.nearestFiveSprites,	stinkbomb,				true);
master_grid_add_spell(		SPELLS.windSlice,				textGrid[# 1, SPELLS.windSlice],			textGrid[# 2, SPELLS.windSlice],			textGrid[# 3, SPELLS.windSlice],			SPELL_TYPES.STORM,		120,	55,		ranges.nearestFiveSprites,	wind_slice,				true);
master_grid_add_spell(		SPELLS.channelEssence,			textGrid[# 1, SPELLS.channelEssence],		textGrid[# 2, SPELLS.channelEssence],		textGrid[# 3, SPELLS.channelEssence],		SPELL_TYPES.TRICK,		0,		30,		ranges.onlySelf,			channel_essence,		false);
master_grid_add_spell(		SPELLS.spherasCurse,			textGrid[# 1, SPELLS.spherasCurse],			textGrid[# 2, SPELLS.spherasCurse],			textGrid[# 3, SPELLS.spherasCurse],			SPELL_TYPES.TRICK,		0,		30,		ranges.nearestOneEnemy,		spheras_curse,			false);
master_grid_add_spell(		SPELLS.creciasCrystalWind,		textGrid[# 1, SPELLS.creciasCrystalWind],	textGrid[# 2, SPELLS.creciasCrystalWind],	textGrid[# 3, SPELLS.creciasCrystalWind],	SPELL_TYPES.EARTH,		100,	45,		ranges.nearestFiveSprites,	crecias_crystal_wind,	true);
master_grid_add_spell(		SPELLS.lavaSpire,				textGrid[# 1, SPELLS.lavaSpire],			textGrid[# 2, SPELLS.lavaSpire],			textGrid[# 3, SPELLS.lavaSpire],			SPELL_TYPES.FIRE,		100,	50,		ranges.nearestThreeSprites,	lava_spire,				true);
master_grid_add_spell(		SPELLS.endlessRiver,			textGrid[# 1, SPELLS.endlessRiver],			textGrid[# 2, SPELLS.endlessRiver],			textGrid[# 3, SPELLS.endlessRiver],			SPELL_TYPES.WATER,		80,		40,		ranges.nearestFiveSprites,	endless_river,			true);
master_grid_add_spell(		SPELLS.cloudBreak,				textGrid[# 1, SPELLS.cloudBreak],			textGrid[# 2, SPELLS.cloudBreak],			textGrid[# 3, SPELLS.cloudBreak],			SPELL_TYPES.STORM,		60,		30,		ranges.anySprite,			cloud_break,			false);
master_grid_add_spell(		SPELLS.telekineticBlast,		textGrid[# 1, SPELLS.telekineticBlast],		textGrid[# 2, SPELLS.telekineticBlast],		textGrid[# 3, SPELLS.telekineticBlast],		SPELL_TYPES.PHYSICAL,	120,	65,		ranges.anySprite,			telekinetic_blast,		false);
master_grid_add_spell(		SPELLS.destabilizingBlow,		textGrid[# 1, SPELLS.destabilizingBlow],	textGrid[# 2, SPELLS.destabilizingBlow],	textGrid[# 3, SPELLS.destabilizingBlow],	SPELL_TYPES.PHYSICAL,	100,	40,		ranges.nearestFiveSprites,	destabilizing_blow,		true);
master_grid_add_spell(		SPELLS.fullThrust,				textGrid[# 1, SPELLS.fullThrust],			textGrid[# 2, SPELLS.fullThrust],			textGrid[# 3, SPELLS.fullThrust],			SPELL_TYPES.PHYSICAL,	160,	60,		ranges.nearestThreeSprites,	full_thrust,			true);
master_grid_add_spell(		SPELLS.volcanicEruption,		textGrid[# 1, SPELLS.volcanicEruption],		textGrid[# 2, SPELLS.volcanicEruption],		textGrid[# 3, SPELLS.volcanicEruption],		SPELL_TYPES.FIRE,		130,	70,		ranges.nearestThreeSprites,	volcanic_eruption,		true);
master_grid_add_spell(		SPELLS.broadcastData,			textGrid[# 1, SPELLS.broadcastData],		textGrid[# 2, SPELLS.broadcastData],		textGrid[# 3, SPELLS.broadcastData],		SPELL_TYPES.TRICK,		0,		40,		ranges.onlySelf,			broadcast_data,			false);
master_grid_add_spell(		SPELLS.collapseSpace,			textGrid[# 1, SPELLS.collapseSpace],		textGrid[# 2, SPELLS.collapseSpace],		textGrid[# 3, SPELLS.collapseSpace],		SPELL_TYPES.TRICK,		0,		60,		ranges.onlySelf,			collapse_space,			false);
master_grid_add_spell(		SPELLS.expandTime,				textGrid[# 1, SPELLS.expandTime],			textGrid[# 2, SPELLS.expandTime],			textGrid[# 3, SPELLS.expandTime],			SPELL_TYPES.TRICK,		0,		40,		ranges.onlySelf,			expand_time,			false);
master_grid_add_spell(		SPELLS.spherasDemise,			textGrid[# 1, SPELLS.spherasDemise],		textGrid[# 2, SPELLS.spherasDemise],		textGrid[# 3, SPELLS.spherasDemise],		SPELL_TYPES.TRICK,		0,		60,		ranges.onlySelf,			spheras_demise,			false);
master_grid_add_spell(		SPELLS.timeLoop,				textGrid[# 1, SPELLS.timeLoop],				textGrid[# 2, SPELLS.timeLoop],				textGrid[# 3, SPELLS.timeLoop],				SPELL_TYPES.TRICK,		0,		50,		ranges.anySprite,			time_loop,				false);
master_grid_add_spell(		SPELLS.eradicate,				textGrid[# 1, SPELLS.eradicate],			textGrid[# 2, SPELLS.eradicate],			textGrid[# 3, SPELLS.eradicate],			SPELL_TYPES.TRICK,		0,		65,		ranges.onlySelf,			eradicate,				false);

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