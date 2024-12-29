#region SPELL FX

var spellFXList = ds_list_create();

// encode the list
global.allSpellFX = encode_list(spellFXList);

// delete the temporary ds_list
ds_list_destroy(spellFXList);

#endregion


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

spellFXList[| SPELLS.SOLAR_FLARE]				=	spr_spellFX_solar_flare;
spellFXList[| SPELLS.TIDAL_FORCE]				=	spr_spellFX_tidal_force;
spellFXList[| SPELLS.NEBULA_STORM]				=	spr_spellFX_nebula_storm;
spellFXList[| SPELLS.TECTONIC_SHIFT]			=	spr_spellFX_tectonic_shift;
spellFXList[| SPELLS.FIREBALL]					=	spr_spellFX_fireball;
spellFXList[| SPELLS.HOLY_WATER]				=	spr_spellFX_holy_water;
spellFXList[| SPELLS.SHOCK]						=	spr_spellFX_shock;
spellFXList[| SPELLS.DECAY]						=	spr_spellFX_decay;
spellFXList[| SPELLS.EXPEL_FORCE]				=	spr_spellFX_expel_force;
spellFXList[| SPELLS.LADY_SOLANUS_GRACE]		=	spr_spellFX_lady_solanus_grace;
spellFXList[| SPELLS.TYPHOON]					=	spr_spellFX_typhoon;
spellFXList[| SPELLS.HEALING_LIGHT]				=	spr_spellFX_healing_light;
spellFXList[| SPELLS.RUBURS_WATER_CANNON]		=	spr_spellFX_ruburs_water_cannon;
spellFXList[| SPELLS.RUBURS_GRAPPLE]			=	spr_spellFX_ruburs_grapple;
spellFXList[| SPELLS.LUSIAS_HARVEST_SPELL]		=	spr_spellFX_lusias_harvest_spell;
spellFXList[| SPELLS.WATERLOG]					=	spr_spellFX_waterlog;
spellFXList[| SPELLS.AIR_PRESSURE]				=	spr_spellFX_air_pressure;
spellFXList[| SPELLS.SUPERBLOOM]				=	spr_spellFX_superbloom;
spellFXList[| SPELLS.RAPID_STRIKE]				=	spr_spellFX_rapid_strike;
spellFXList[| SPELLS.LOOMING_DANGER]			=	spr_spellFX_looming_danger;
spellFXList[| SPELLS.INTERCEPT]					=	spr_spellFX_intercept;
spellFXList[| SPELLS.STEAM_BATH]				=	spr_spellFX_steam_bath;
spellFXList[| SPELLS.UNDERTOW]					=	spr_spellFX_undertow;
spellFXList[| SPELLS.EMPATHIZE]					=	spr_spellFX_empathize;
spellFXList[| SPELLS.HELLFIRE]					=	spr_spellFX_hellfire;
spellFXList[| SPELLS.BALL_LIGHTNING]			=	spr_spellFX_ball_lightning;
spellFXList[| SPELLS.QUICKSAND]					=	spr_spellFX_quicksand;
spellFXList[| SPELLS.LORD_MOGRADTHS_RAGE]		=	spr_spellFX_lord_mogradths_rage;
spellFXList[| SPELLS.DRAIN_LIFEFORCE]			=	spr_spellFX_drain_lifeforce;
spellFXList[| SPELLS.PYROKINESIS]				=	spr_spellFX_pyrokinesis;
spellFXList[| SPELLS.DOWNPOUR]					=	spr_spellFX_downpour;
spellFXList[| SPELLS.ARC_BLAST]					=	spr_spellFX_arc_blast;
spellFXList[| SPELLS.HIKAMS_WINTER_SPELL]		=	spr_spellFX_hikams_winter_spell;
spellFXList[| SPELLS.OSMOSIS]					=	spr_spellFX_osmosis;
spellFXList[| SPELLS.FLASH_FREEZE]				=	spr_spellFX_flash_freeze;
spellFXList[| SPELLS.LANDSLIDE]					=	spr_spellFX_landslide;
spellFXList[| SPELLS.AMANDS_ENERGY_BLAST]		=	spr_spellFX_amands_energy_blast;
spellFXList[| SPELLS.SHIFT_PERSPECTIVE]			=	spr_spellFX_shift_perspective;
spellFXList[| SPELLS.PSYCHIC_IMPACT]			=	spr_spellFX_psychic_impact;
spellFXList[| SPELLS.TREMOR]					=	spr_spellFX_tremor;
spellFXList[| SPELLS.SKYDIVE]					=	spr_spellFX_skydive;
spellFXList[| SPELLS.DESTRUCTIVE_BLOW]			=	spr_spellFX_destructive_blow;
spellFXList[| SPELLS.PURIFYING_FLAME]			=	spr_spellFX_purifying_flame;
spellFXList[| SPELLS.JABULS_FIGHT_SONG]			=	spr_spellFX_jabuls_fight_song;
spellFXList[| SPELLS.NOXIOUS_FUMES]				=	spr_spellFX_noxious_fumes;
spellFXList[| SPELLS.CRECIAS_CRYSTAL_SPIKES]	=	spr_spellFX_crecias_crystal_spikes;
spellFXList[| SPELLS.PSYCHIC_FISSURE]			=	spr_spellFX_psychic_fissure;
spellFXList[| SPELLS.REARRANGE]					=	spr_spellFX_rearrange;
spellFXList[| SPELLS.SNEAK_ATTACK]				=	spr_spellFX_sneak_attack;
spellFXList[| SPELLS.DEFLECTIVE_SHIELD]			=	spr_spellFX_deflective_shield;
spellFXList[| SPELLS.DIONS_PARRY]				=	spr_spellFX_dions_parry;
spellFXList[| SPELLS.DIONS_GAMBLING_BLAST]		=	spr_spellFX_dions_gambling_blast;
spellFXList[| SPELLS.DIONS_BARTER_TRICK]		=	spr_spellFX_dions_barter_trick;
spellFXList[| SPELLS.MAGNETIC_PULSE]			=	spr_spellFX_magnetic_pulse;
spellFXList[| SPELLS.BURN_OUT]					=	spr_spellFX_burn_out;
spellFXList[| SPELLS.STINKBOMB]					=	spr_spellFX_stinkbomb;
spellFXList[| SPELLS.WIND_SLICE]				=	spr_spellFX_wind_slice;
spellFXList[| SPELLS.CHANNEL_ESSENCE]			=	spr_spellFX_channel_essence;
spellFXList[| SPELLS.SPHERAS_CURSE]				=	spr_spellFX_spheras_curse;
spellFXList[| SPELLS.CRECIAS_CRYSTAL_WIND]		=	spr_spellFX_crecias_crystal_wind;
spellFXList[| SPELLS.LAVA_SPIRE]				=	spr_spellFX_lava_spire;
spellFXList[| SPELLS.ENDLESS_RIVER]				=	spr_spellFX_endless_river;
spellFXList[| SPELLS.CLOUD_BREAK]				=	spr_spellFX_cloud_break;
spellFXList[| SPELLS.TELEKINETIC_BLAST]			=	spr_spellFX_telekinetic_blast;
spellFXList[| SPELLS.KNOCK_OVER]				=	spr_spellFX_knock_over;
spellFXList[| SPELLS.FULL_THRUST]				=	spr_spellFX_full_thrust;
spellFXList[| SPELLS.VOLCANIC_ERUPTION]			=	spr_spellFX_volcanic_eruption;
spellFXList[| SPELLS.BROADCAST_DATA]			=	spr_spellFX_broadcast_data;
spellFXList[| SPELLS.COLLAPSE_SPACE]			=	spr_spellFX_collapse_space;
spellFXList[| SPELLS.EXPAND_TIME]				=	spr_spellFX_expand_time;
spellFXList[| SPELLS.SPHERAS_DEMISE]			=	spr_spellFX_spheras_demise;
spellFXList[| SPELLS.TIME_LOOP]					=	spr_spellFX_time_loop;
spellFXList[| SPELLS.ERADICATE]					=	spr_spellFX_eradicate;
spellFXList[| SPELLS.DARK_DEAL]					=	spr_spellFX_darkDeal;
spellFXList[| SPELLS.HAIL_SPHERA]				=	spr_spellFX_hailSphera;

// encode the list
global.allSpellAnimations = encode_list(animationsList);

// destroy the list
ds_list_destroy(animationsList);

#endregion