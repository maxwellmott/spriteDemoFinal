// enum containing IDs for different rates of flashing
enum FLASHING_RATES {
	VERY_SLOW,
	SLOW,
	MODERATE,
	FAST,
	VERY_FAST,
	HEIGHT
}

///@desc This function takes an ID from the FLASHING_RATES enumerator
/// and returns a value to be used in a mod equation to make a sprite flicker
/// a different color
function flash_rate_get_mod_value(_flashRate) {
	var fr = _flashRate;
	
	switch (fr) {
		case FLASHING_RATES.VERY_SLOW:	return	45;	break;
		case FLASHING_RATES.SLOW:		return	30;	break;
		case FLASHING_RATES.MODERATE:	return	20;	break;
		case FLASHING_RATES.FAST:		return	10;	break;
		case FLASHING_RATES.VERY_FAST:	return	5;	break;	
	}
}

///@desc This function checks sparActionProcessor.damage and then
/// sets the target's flashRate according to how much damage was dealt
function flash_rate_set_from_damage() {
	var d = damage;
	var t = targetSprite;
	
	t.flashNum = 0;
	
	if (d > 0)		t.flashRate = flash_rate_get_mod_value(FLASHING_RATES.VERY_SLOW);	t.flashCount = 1;
	if (d > 25)		t.flashRate = flash_rate_get_mod_value(FLASHING_RATES.SLOW);		t.flashCount = 2;
	if (d > 75)		t.flashRate = flash_rate_get_mod_value(FLASHING_RATES.MODERATE);	t.flashCount = 3;
	if (d > 150)	t.flashRate = flash_rate_get_mod_value(FLASHING_RATES.FAST);		t.flashCount = 4;
	if (d > 250)	t.flashRate = flash_rate_get_mod_value(FLASHING_RATES.VERY_FAST);	t.flashCount = 5;
	
	global.gameTime += (global.gameTime mod t.flashRate);
	
	t.alarm[0] = (t.flashRate * 5);
}

#region SPELL ANIMATIONS

var animationsList = ds_list_create();

animationsList[| SPELLS.SOLAR_FLARE]				=	spr_spellFX_solar_flare;
animationsList[| SPELLS.TIDAL_FORCE]				=	spr_spellFX_tidal_force;
animationsList[| SPELLS.NEBULA_STORM]				=	spr_spellFX_nebula_storm;
animationsList[| SPELLS.TECTONIC_SHIFT]			=	spr_spellFX_tectonic_shift;
animationsList[| SPELLS.FIREBALL]					=	spr_spellFX_fireball;
animationsList[| SPELLS.HOLY_WATER]				=	spr_spellFX_holy_water;
animationsList[| SPELLS.SHOCK]						=	spr_spellFX_shock;
animationsList[| SPELLS.DECAY]						=	spr_spellFX_decay;
animationsList[| SPELLS.EXPEL_FORCE]				=	spr_spellFX_expel_force;
animationsList[| SPELLS.LADY_SOLANUS_GRACE]		=	spr_spellFX_lady_solanus_grace;
animationsList[| SPELLS.TYPHOON]					=	spr_spellFX_typhoon;
animationsList[| SPELLS.HEALING_LIGHT]				=	spr_spellFX_healing_light;
animationsList[| SPELLS.RUBURS_WATER_CANNON]		=	spr_spellFX_ruburs_water_cannon;
animationsList[| SPELLS.RUBURS_GRAPPLE]			=	spr_spellFX_ruburs_grapple;
animationsList[| SPELLS.LUSIAS_HARVEST_SPELL]		=	spr_spellFX_lusias_harvest_spell;
animationsList[| SPELLS.WATERLOG]					=	spr_spellFX_waterlog;
animationsList[| SPELLS.AIR_PRESSURE]				=	spr_spellFX_air_pressure;
animationsList[| SPELLS.SUPERBLOOM]				=	spr_spellFX_superbloom;
animationsList[| SPELLS.RAPID_STRIKE]				=	spr_spellFX_rapid_strike;
animationsList[| SPELLS.LOOMING_DANGER]			=	spr_spellFX_looming_danger;
animationsList[| SPELLS.INTERCEPT]					=	spr_spellFX_intercept;
animationsList[| SPELLS.STEAM_BATH]				=	spr_spellFX_steam_bath;
animationsList[| SPELLS.UNDERTOW]					=	spr_spellFX_undertow;
animationsList[| SPELLS.EMPATHIZE]					=	spr_spellFX_empathize;
animationsList[| SPELLS.HELLFIRE]					=	spr_spellFX_hellfire;
animationsList[| SPELLS.BALL_LIGHTNING]			=	spr_spellFX_ball_lightning;
animationsList[| SPELLS.QUICKSAND]					=	spr_spellFX_quicksand;
animationsList[| SPELLS.LORD_MOGRADTHS_RAGE]		=	spr_spellFX_lord_mogradths_rage;
animationsList[| SPELLS.DRAIN_LIFEFORCE]			=	spr_spellFX_drain_lifeforce;
animationsList[| SPELLS.PYROKINESIS]				=	spr_spellFX_pyrokinesis;
animationsList[| SPELLS.DOWNPOUR]					=	spr_spellFX_downpour;
animationsList[| SPELLS.ARC_BLAST]					=	spr_spellFX_arc_blast;
animationsList[| SPELLS.HIKAMS_WINTER_SPELL]		=	spr_spellFX_hikams_winter_spell;
animationsList[| SPELLS.OSMOSIS]					=	spr_spellFX_osmosis;
animationsList[| SPELLS.FLASH_FREEZE]				=	spr_spellFX_flash_freeze;
animationsList[| SPELLS.LANDSLIDE]					=	spr_spellFX_landslide;
animationsList[| SPELLS.AMANDS_ENERGY_BLAST]		=	spr_spellFX_amands_energy_blast;
animationsList[| SPELLS.SHIFT_PERSPECTIVE]			=	spr_spellFX_shift_perspective;
animationsList[| SPELLS.PSYCHIC_IMPACT]			=	spr_spellFX_psychic_impact;
animationsList[| SPELLS.TREMOR]					=	spr_spellFX_tremor;
animationsList[| SPELLS.SKYDIVE]					=	spr_spellFX_skydive;
animationsList[| SPELLS.DESTRUCTIVE_BLOW]			=	spr_spellFX_destructive_blow;
animationsList[| SPELLS.PURIFYING_FLAME]			=	spr_spellFX_purifying_flame;
animationsList[| SPELLS.JABULS_FIGHT_SONG]			=	spr_spellFX_jabuls_fight_song;
animationsList[| SPELLS.NOXIOUS_FUMES]				=	spr_spellFX_noxious_fumes;
animationsList[| SPELLS.CRECIAS_CRYSTAL_SPIKES]	=	spr_spellFX_crecias_crystal_spikes;
animationsList[| SPELLS.PSYCHIC_FISSURE]			=	spr_spellFX_psychic_fissure;
animationsList[| SPELLS.REARRANGE]					=	spr_spellFX_rearrange;
animationsList[| SPELLS.SNEAK_ATTACK]				=	spr_spellFX_sneak_attack;
animationsList[| SPELLS.DEFLECTIVE_SHIELD]			=	spr_spellFX_deflective_shield;
animationsList[| SPELLS.DIONS_PARRY]				=	spr_spellFX_dions_parry;
animationsList[| SPELLS.DIONS_GAMBLING_BLAST]		=	spr_spellFX_dions_gambling_blast;
animationsList[| SPELLS.DIONS_BARTER_TRICK]		=	spr_spellFX_dions_barter_trick;
animationsList[| SPELLS.MAGNETIC_PULSE]			=	spr_spellFX_magnetic_pulse;
animationsList[| SPELLS.BURN_OUT]					=	spr_spellFX_burn_out;
animationsList[| SPELLS.STINKBOMB]					=	spr_spellFX_stinkbomb;
animationsList[| SPELLS.WIND_SLICE]				=	spr_spellFX_wind_slice;
animationsList[| SPELLS.CHANNEL_ESSENCE]			=	spr_spellFX_channel_essence;
animationsList[| SPELLS.SPHERAS_CURSE]				=	spr_spellFX_spheras_curse;
animationsList[| SPELLS.CRECIAS_CRYSTAL_WIND]		=	spr_spellFX_crecias_crystal_wind;
animationsList[| SPELLS.LAVA_SPIRE]				=	spr_spellFX_lava_spire;
animationsList[| SPELLS.ENDLESS_RIVER]				=	spr_spellFX_endless_river;
animationsList[| SPELLS.CLOUD_BREAK]				=	spr_spellFX_cloud_break;
animationsList[| SPELLS.TELEKINETIC_BLAST]			=	spr_spellFX_telekinetic_blast;
animationsList[| SPELLS.KNOCK_OVER]				=	spr_spellFX_knock_over;
animationsList[| SPELLS.FULL_THRUST]				=	spr_spellFX_full_thrust;
animationsList[| SPELLS.VOLCANIC_ERUPTION]			=	spr_spellFX_volcanic_eruption;
animationsList[| SPELLS.BROADCAST_DATA]			=	spr_spellFX_broadcast_data;
animationsList[| SPELLS.COLLAPSE_SPACE]			=	spr_spellFX_collapse_space;
animationsList[| SPELLS.EXPAND_TIME]				=	spr_spellFX_expand_time;
animationsList[| SPELLS.SPHERAS_DEMISE]			=	spr_spellFX_spheras_demise;
animationsList[| SPELLS.TIME_LOOP]					=	spr_spellFX_time_loop;
animationsList[| SPELLS.ERADICATE]					=	spr_spellFX_eradicate;
animationsList[| SPELLS.DARK_DEAL]					=	spr_spellFX_darkDeal;
animationsList[| SPELLS.HAIL_SPHERA]				=	spr_spellFX_hailSphera;

// encode the list
global.allSpellAnimations = encode_list(animationsList);

// destroy the list
ds_list_destroy(animationsList);

#endregion