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

function lord_mogradths_rage() {
	
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

function psychic_fissure() {
	
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

function crecias_crystal_wind() {
	
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