///@desc This function takes an abilityType 
/// ID and the instance ID of a sprite. It then
/// checks to see if the given sprite’s ability 
/// is of the given abilityType. If so, it
/// executes the sprite’s ability function 
function ability_check(_sprite, _abilityType, _sprite2) {
	// store args in locals
	var s = _sprite;
	var t = _abilityType;

	// store the potential third argument as the second sprite
	var s2 = argument[2];

	// get sprite's ability type
	var st = s.currentAbilityType;
	
	// check if ability type matches the given one
	if (st == t) {
		if (s2 >= 0) {
			// push a spar effect alert containing the spriteID
			spar_effect_push_alert(SPAR_EFFECTS.ACTIVATE_ABILITY, s, s2);		
		}
		else {
			spar_effect_push_alert(SPAR_EFFECTS.ACTIVATE_ABILITY, s, -1);	
		}
	}
}

// enum containing ability IDs
enum ABILITIES {
	HOT_TO_THE_TOUCH,
	WAVY_DANCE,
	STORM_SURFER,
	NATURES_RECLAMATION,
	BATTLE_INSTINCT,
	UNBREAKABLE_SHELL,
	SUPERCHARGED,
	WELL_READ,
	POWER_OF_FRIENDSHIP,
	UNDERSEA_PREDATOR,
	UNSTABLE_POWER,
	FREE_REFILLS,
	REFLECTIVE_SURFACE,
	FLOWERY_SPIRIT,
	GIFT_OF_SONG,
	HANG_TEN,
	TERRITORIAL_HUNTER,
	NATURAL_INGREDIENTS,
	ABSORPTIVE_BODY,
	CREEP_OUT,
	NEW_ABILITY_1,
	ALL_SEEING_EYES,
	SORT_AWAY,
	SHORT_FUSE,
	OFFER_REFUGE,
	SIGNAL_JAMMER,
	SYNCHRONIZED_SOLDIERS,
	HERBAL_CONCOCTION,
	HEALING_HAZE,
	AQUATIC_ESSENCE,
	FIERY_AURA,
	THUNDROUS_CRY,
	MASSIVE_BODY,
	UNDERDOG,
	KEEPING_TIDY,
	WRECKING_BALL,
	DRIFT_AWAY,
	TRICKSTER_FAERIE,
	DUMPSTER_DIVER,
	SPRING_LOADED,
	FLOOD_SHELTER,
	PROPOGATE,
	NEW_ABILITY_2,
	REDEEMING_QUALITIES,
	GENERATOR,
	DUAL_WIELD,
	SHADOWY_FIEND,
	METAL_MUNCHER,
	VOLCANIC_MASS,
	EYE_OF_THE_STORM,
	NEW_ABILITY_3,
	CENTRIPETAL_FORCE,
	NEW_ABILITY_4,
	PURE_MALICE,
	GUARDIAN_ANGEL,
	NEW_ABILITY_5,
	RING_LEADER,
	TIME_POLICE,
	SPACE_CADET,
	BAD_OMEN,
	ALL_KNOWING,
	BEND_PHYSICS,
	COMPRESS_TIME,
	END_OF_DAYS,
	HEIGHT
}

// enum containing ability params


// enum that contains all types of ability checks. This mostly exists
// so that abilities have a way of indicating when they should be activated
enum ABILITY_CHECKS {
	TURN_BEGIN,
	TARGET_SELECTION,
	TURN_PROCESS,
	SWAP_ATTEMPT,
	SWAP_SUCCESS,
	SPRITE_RESTING,
	SPELL_ATTEMPT,
	SPELL_DAMAGE_CALC,
	SPELL_SUCCESS,
	BASIC_ATTACK_ATTEMPT,
	BASIC_ATTACK_DAMAGE_CALC,
	BASIC_ATTACK_SUCCESS,
	DAMAGE_ATTEMPT,
	DAMAGE_CALC,
	DAMAGE_SUCCESS,
	DODGE_ATTEMPT,
	DODGE_SUCCESS,
	ARENA_CHANGE,
	HP_CHANGE,
	MP_CHANGE,
	HINDRANCE_CHANGE,
	MINDSET_CHANGE,
	STATUS_CHANGE,
	ALIGNMENT_CHANGE,
	SIZE_CHANGE,
	DAMAGE_CHANGE,
	TURN_END,
	ABILITY_CHANGE,
	TARGET_CHANGE,
	DAMAGE_AVOIDED,
	EFFECT_AVOIDED,
	ABILITY_ACTIVATED,
	EFFECT_ACTIVATED,
	APPLY_MIASMA,
	APPLY_HEXED,
	APPLY_BOUND,
	HEIGHT
}

#region CREATE ALL ABILITY EFFECT FUNCTIONS

///@desc ABILITY FUNCTION -- HACHA CHACHA:
/// TYPE: BASIC ATTACK SUCCESS
/// If this sprite is hit with a BASIC ATTACK, the opposing sprite
/// takes a flat amount of SELF DAMAGE.
function hot_to_the_touch() {
	
}

///@desc ABILITY FUNCTION -- DIIPSY:
/// TYPE: ACTION ATTEMPT:
/// If ARENA is OCEAN and this sprite is targeted by a dodgeable
/// SPELL or BASIC ATTACK, it will automatically DODGE
function wavy_dance() {
		
}

///@desc ABILITY FUNCTION -- GLIDRAKE:
/// TYPE: SPELL ATTEMPT
/// If this sprite is targeted by a STORM spell, they ignore damage and receive
/// the BLESSING OF THE IMP.
function storm_surfer() {
	
}

///@desc ABILITY FUNCTION -- PODRIC:
/// TYPE: BASIC ATTACK ATTEMPT:
/// This sprite's BASIC ATTACKS deal 1.5 damage against non-NATURAL
/// sprites.
function natures_reclamation() {
		
}


///@desc ABILITY FUNCTION -- SPARMATE:
/// TYPE: BASIC ATTACK ATTEMPT:
/// If this sprite is targeted by a BASIC ATTACK or PHYSICAL SPELL,
/// it performs a DODGE check. If the sprite is set to dodge, it 
/// performs an additional check.
function battle_instinct() {
	
}
	
///@desc ABILITY FUNCTION -- CRUSTULAR:
/// TYPE: ACTION SUCCESS
/// If this sprite is targeted by a basic attack or physical spell, they
/// will receive half damage.
function unbreakable_shell() {
	
}

///@desc ABILITY FUNCTION -- FISTICOGS:
/// TYPE: SPELL SUCCESS
/// If this sprite is hit by a STORM SPELL, their MINDSET changes to the
/// BLESSING OF THE WARRIOR.
function supercharged() {
	
}

///@desc ABILITY FUNCTION -- BOOKISH:
/// TYPE: TURN BEGIN
/// This sprite adds a ninth SPELL to their team's spellbook, it changes
/// randomly each turn (always one of the player's known spells)
function well_read() {
	
}

///@desc ABILITY FUNCTION -- PLEEP:
/// TYPE: ACTION SUCCESS
/// If one of this sprite's nearby allies are targeted for an attack, damage 
/// is cut in half and both sprites gain BLESSING OF THE WARRIOR.
function power_of_friendship() {
	
}

///@desc ABILITY FUNCTION -- FISHMONGER:
/// TYPE: BASIC ATTACK ATTEMPT
/// If the ARENA is OCEAN, this sprite's BASIC ATTACKS deal 1.5 damage and
/// are undodgeable.
function undersea_predator() {
	
}

///@desc ABILITY FUNCTION -- GEMBO:
/// TYPE: TURN BEGIN
/// Every fifth turn, this sprite creates an ENERGY BLAST against
/// both players.
function unstable_power() {
	
}

///@desc ABILITY FUNCTION -- JOE:
/// TYPE: TURN END
/// This sprite RESTORES 30 MP at the end of each turn.
function free_refills() {
	
}

///@desc ABILITY FUNCTION -- MIRREFRACT:
/// TYPE: SPELL ATTEMPT
/// If this sprite is targeted by a SPELL, it switches itself with the caster
/// and makes them become the target.
function reflective_surface() {
	
}

///@desc ABILITY FUNCTION -- FLOOPWALKER:
/// TYPE: SPELL ATTEMPT
/// If this sprite uses a SPELL, the ARENA becomes FOREST and the DMI is increased
/// by 2.
function flowery_spirit() {
	
}

///@desc ABILITY FUNCTION -- SONGBIRD:
/// TYPE: TURN BEGIN
/// This sprite receives a random BLESSING at the beginning of each turn.
function gift_of_song() {
	
}

///@desc ABILITY FUNCTION -- SHREDATOR:
/// TYPE: BASIC ATTACK ATEMPT
/// If the ARENA is OCEAN, and this sprite attempts a BASIC ATTACK, the DMI is
/// increased by 2.
function hang_ten() {
		 
}

///@desc ABILITY FUNCTION -- FURVOR:
/// TYPE: BASIC ATTACK ATTEMPT
/// This sprite's BASIC ATTACKS deal 1.5 damage aginst NATURAL sprites.
function territorial_hunter() {
		
}

///@desc ABILITY FUNCTION -- GASTRONIMO:
/// TYPE: SPELL SUCCESS
/// If this sprite is hit by an EARTH SPELL, their team instead RESTORES
/// the amount of HEALTH that would have been lost.
function natural_ingredients() {
	
}

///@desc ABILITY FUNCTION -- DURENDOUX:
/// TYPE: ACTION SUCCESS
/// If this sprite is hit with a basic attack or physical spell, the attacker
/// becomes BOUND.
function absorptive_body() {
	
}

///@desc ABILITY FUNCTION -- STAGEFRITE:
/// TYPE: TURN BEGIN
/// All of this sprite's nearby sprites become HEXED at the beginning of each turn.
function creep_out() {
	
}

///@desc ABILITY FUNCTION -- SCROOTINEYES:
/// TYPE: TARGET SELECTION
/// This sprite has increased RANGE for all ELEMENTAL and TRICK SPELLS.
function all_seeing_eyes() {
		
}

///@desc ABILITY FUNCTION -- ARRAYNGE:
/// TYPE: ACTION SUCCESS
/// If this sprite is hit with a basic attack or physical spell, the attacker
/// is forced to swap with a random ally.
function sort_away() {
	
}

///@desc ABILITY FUNCTION -- TICKDOFF:
/// TYPE: TURN END
/// This sprite becomes BERSERK at the end of every fifth turn.
function short_fuse() {
	
}

///@desc ABILITY FUNCTION -- FORTUGA:
/// TYPE: ACTION ATTEMPT
/// If one of this sprite's nearby allies is targeted by a PHYSICAL SPELL or
/// BASIC ATTACK, they will take the target's place.
function offer_refuge() {
	
}

///@desc ABILITY FUNCTION -- SPYOTIS:
/// TYPE: TURN BEGIN
/// This sprite sets HUM on both sides of the field at the beginning of each
/// turn.
function signal_jammer() {
	
}

///@desc ABILITY FUNCTION -- DRUMLINE:
/// TYPE: TURN PROCESS
/// This sprite's allies attack in order of the teamList.
function synchronized_soldiers() {
	
}

///@desc ABILITY FUNCTION -- REVOLTURE:
/// TYPE: APPLY MIASMA
/// This sprite's team RESTORES HEALTH from MIASMA instead of taking damage
function herbal_concoction() {
	
}

///@desc ABILITY FUNCTION -- CLEANSAGE:
/// TYPE: REST SUCCESS
/// When this sprite RESTS, it removes all HINDRANCES for their team
/// and RESTORES 250 HP.
function healing_haze() {
	
}

///@desc ABILITY FUNCTION -- FLOTSO:
/// TYPE: REST SUCCESS
/// If this sprite RESTS, the ARENA becomes OCEAN.
function aquatic_essence() {
	
}

///@desc ABILITY FUNCTION -- HEATSUNE:
/// TYPE: SPELL ATTEMPT
/// If this sprite casts a FIRE SPELL, the DMI is first increased by 1.
function fiery_aura() {
	
}

///@desc ABILITY FUNCTION -- BLITZKRANE:
/// TYPE: ACTION SUCCESS
/// If this sprite is hit with a damaging SPELL or BASIC ATTACK,
/// the ARENA changes to SKY.
function thundrous_cry() {
	
}

///@desc ABILITY FUNCTION -- EXONOLITH:
/// TYPE: BASIC ATTACK DAMAGE CALC
/// If this sprite uses a BASIC ATTACK, their RESISTANCE is used for
/// damage calc instead of POWER.
function massive_body() {
	
}

///@desc ABILITY FUNCTION -- PUGILOON:
/// TYPE: ACTION DAMAGE CALC
/// If this sprite's team has less than half of their max HP, their 
/// BASIC ATTACKS and PHYSICAL SPELLS deal 2* damage.
function underdog() {
	
}

///@desc ABILITY FUNCTION -- MR SUDSY
/// TYPE: TURN END
/// This sprite clears all HINDRANCES and CURSES for their team at the
/// end of each turn.
function keeping_tidy() {
	
}

///@desc ABILITY FUNCTION -- DEMOLITOPS:
/// TYPE: BASIC ATTACK DAMAGE CALC
/// This sprite's BASIC ATTACKS deal 2* damage against MECHANICAL sprites.
function wrecking_ball() {
	
}

///@desc ABILITY FUNCTION -- DOORMAUS:
/// TYPE: REST SUCCESS
/// If this sprite rests, they will automatically SWAP with another sprite at
/// no cost.
function drift_away() {
	
}

///@desc ABILITY FUNCTION -- ZEPHIRA
/// TYPE: SPELL SUCCESS
/// If this sprite successfully casts a TRICK SPELL, their target's team
/// takes 200 HP.
function trickster_faerie() {
	
}

///@desc ABILITY FUNCTION -- CANUKI
/// TYPE: SPELL SUCCESS
/// Whenever a nearby sprite casts a SPELL, half of the MP used to cast is
/// absorbed by this sprite.
function dumpster_diver() {
	
}

///@desc ABILITY FUNCTION -- JACKHAMMER
/// TYPE: TARGET SELECTION
/// This sprite can target any other sprite with a BASIC ATTACK.
function spring_loaded() {
	
}

///@desc ABILITY FUNCTION -- SPLASHGUARD
/// TYPE: SPELL ATTEMPT
/// If any of this sprite's allies are targeted with a WATER SPELL, this
/// sprite will take their place as the target.
function flood_shelter() {
	
}

///@desc ABILITY FUNCTION -- UPROOTER
/// TYPE: APPLY BOUND
/// This sprite can swap even when BOUND.
function propogate() {
	
}

///@desc ABILITY FUNCTION -- CAPN CLOPS
/// TYPE: TURN END
/// If this sprite's team has less than half HP, it fully restores
/// their MP at the end of the turn.
function redeeming_quality() {
	
}

///@desc ABILITY FUNCTION -- PLASMASS
/// TYPE: SPELL ATTEMPT
/// When this sprite casts a FIRE or STORM spell, the DMI is increased
/// by 1.
function generator() {
	
}

///@desc ABILITY FUNCTION -- OBSIDUAL:
/// TYPE: BASIC ATTACK DAMAGE CALC
/// This sprite's BASIC ATTACKS deal 1.3* damage.
function dual_wield() {
	
}

///@desc ABILITY FUNCTION -- NINTOX:
/// TYPE: ACTION ATTEMPT
/// If MIASMA is present on this sprite's side of the field, they perform a
/// DODGE check whenever targeted by a damaging spell or basic attack.
function shadowy_fiend() {
	
}

///@desc ABILITY FUNCTION -- CHROMALIODON
/// TYPE: ACTION ATTEMPT
/// If a MECHANICAL sprite targets this sprite with a BASIC ATTACK OR
/// PHYSICAL SPELL, this sprite RESTORES HP equal to the damage it would
/// have taken and causes the SPELL to fail.
function metal_muncher() {
	
}

///@desc ABILITY FUNCTION -- CRAGMA
/// TYPE: BASIC ATTACK DAMAGE CALC
/// This sprite's basic attacks use the FIRE stat for damage calc instead of
/// the POWER stat.
function volcanic_mass() {
	
}

///@desc ABILITY FUNCTION -- CORVOLT
/// TYPE: TURN START
/// If the ARENA is SKY, all of this sprite's nearby allies will become
/// INVULNERABLE at the beginning of each turn.
function eye_of_the_storm() {
	
}

///@desc ABILITY FUNCTION -- WYRMPOOL
/// TYPE: TURN START
/// If the ARENA is OCEAN, all of this sprite's nearby enemies will become
/// BOUND at the beginning of each turn.
function centripetal_force() {
	
}

///@desc ABILITY FUNCTION -- CENOTOMB
/// TYPE: BASIC ATTACK ATTEMPT 
/// This sprite's BASIC ATTACKS deal 2* damage while HEXED
function pure_malice() {
	
}

///@desc ABILITY FUNCTION -- STEWARDRAKE
/// TYPE: ACTION ATTEMPT
/// This sprite's nearby allies always take 2/3* damage
function guardian_angel() {
	
}

///@desc ABILITY FUNCTION -- DOMINO
/// TYPE: BASIC ATTACK SUCCESS
/// When this sprite hits another with a basic attack, that sprite
/// will take their place as target for the rest of the turn.
function ring_leader() {
	
}

///@desc ABILITY FUNCTION -- ANACHRONAUT
/// TYPE: SPELL ATTEMPT
/// All ancient and time based spells will automatically fail when this
/// sprite is present
function time_police() {
	
}

///@desc ABILITY FUNCTION -- SHPUPO
/// TYPE: SPELL SUCCESS
/// This sprite ignores the secondary effect of all SPELLS
function space_cadet() {
	
}

///@desc ABILITY FUNCTION -- NEEDLEPAW
/// TYPE: ACTION ATTEMPT
/// This sprite forces all enemy sprites to have their LUCK locked at the
/// lowest possible value
function bad_omen() {
	
}

///@desc ABILITY FUNCTION -- OMNOST
/// TYPE: SPELL ATTEMPT
/// When this sprite casts ELEMENTAL SPELLS, the DMI is increased by 2. When
/// this sprite is targeted by ELEMENTAL SPELLS, the DMI is decreased by 2.
function all_knowing() {
	
}

///@desc ABILITY FUNCTION -- PRISMATTER
/// TYPE: ACTION ATTEMPT
/// When this sprite casts PHYSICAL SPELLS or uses BASIC ATTACKS, the DMI is 
/// increased by 1. When this sprite is targeted by PHYSICAL SPELLS or BASIC
/// ATTACKS, the DMI is decreased by 1.
function bend_physics() {
	
}

///@desc ABILITY FUNCTION -- KRONARC
/// TYPE: TURN PROCESS
/// This sprite always moves absolute first (before all priority spells)
function compress_time() {
	
}

///@desc ABILITY FUNCTION -- COSMALCOS
/// TYPE: SPELL ATTEMPT
/// All SPELLS that target this sprite will automatically fail.
function end_of_days() {
	
}

#endregion

// get all text params from csv file