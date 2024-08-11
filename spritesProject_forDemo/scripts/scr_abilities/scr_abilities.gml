// enum containing ability IDs

// enum containing ability params

// enum that contains all types of ability checks. This mostly exists
// so that abilities have a way of indicating when they should be activated
enum ABILITY_CHECKS {
	TURN_BEGIN,
	SWAP_ATTEMPT,
	SWAP_SUCCESS,
	SPRITE_RESTING,
	SPELL_ATTEMPT,
	SPELL_SUCCESS,
	BASIC_ATTACK_ATTEMPT,
	BASIC_ATTACK_SUCCESS,
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
	HEIGHT
}

#region CREATE ALL ABILITY EFFECT FUNCTIONS

///@desc ABILITY FUNCTION: This function is called when a sprite
/// with this ability is targeted by a basic attack or a spell. If 
/// they are not already attempting to dodge, they will do a dodge check.
function battle_instinct() {
	
}

///@desc ABILITY FUNCTION: This function is called at the end of 
/// each turn by a sprite that has this ability. Every fourth turn,
/// a flat amount of damage is dealt to the opposing team depending
/// on the current luck roll of the sprite with this ability.
function unstable_power() {
	
}

///@desc ABILITY FUNCTION: This function is called when a sprite
/// with this ability is targeted by a basic attack. The attacking
/// sprite's team takes a flat amount of damage
function hot_to_the_touch() {
	
}

///@desc ABILITY FUNCTION: This function is called when the arena
/// is of type: ocean and a sprite with this ability is targeted by
/// a spell or a basic attack. The sprite with this ability
/// automatically dodges
function oily_hyde() {
		
}

///@desc ABILITY FUNCTION: This function is called at the beginning
/// of each turn by a sprite with this ability. A ninth spell is 
/// randomly selected from their team's knownSpells list and added
/// to the spellBook
function well_read() {
	
}

///@desc ABILITY FUNCTION: This function is called when a sprite with
/// this ability is targeted by a STORM spell. Damage is negated and
/// this sprite gains the Blessing of the Warrior
function supercharged() {
	
}

///@desc ABILITY FUNCTION: This function is called when a sprite with
/// this ability is targeted by basic attack or physical spell. This sprite
/// takes half damage
function unbreakable_shell() {
	
}

///@desc ABILITY FUNCTION: This function is called in the step event of
/// a sprite with this ability. This ability constantly ensures that 
/// HUM is present on both sides of the field
function magnetic_field() {
	
}

///@desc ABILITY FUNCTION: This function is called when a sprite with
/// this ability is targeted by an EARTH spell. Damage is negated and
/// their team's health is fully regenerated
function farm_to_table() {
	
}

///@desc ABILITY FUNCTION: This function is called when a sprite
/// with this ability is targeted by a spell. The caster of the
/// spell becomes the target
function reflection() {
	
}

///@desc ABILITY FUNCTION: This function is called by a sprite with
/// this ability at the beginning of each turn. The sprite with this
/// ability gains a randomly selected blessing that is different from
/// whichever one it has currently
function gift_of_song() {
	
}

///@desc ABILITY FUNCTION: This function is called by a sprite with
/// this ability at the beginning of each turn if the arena is of Type:
/// Ocean. This sprite gains the Blessing of the Imp
function surfs_up() {
		 
}

///@desc ABILITY FUNCTION: This function is called by a sprite with
/// this ability at the end of each turn. All of this sprite's allies'
/// curses are shifted to their respective blessings
function joyous_spirit() {
	
}

///@desc ABILITY FUNCTION: This function is called by a sprite with
/// this ability when one of their nearby allies is hit by an attack.
/// This sprite deals 1.5* damage for the rest of the turn
function power_of_friendship() {
	
}

///@desc ABILITY FUNCTION: This function is called by a sprite with
/// this ability at the beginning of each turn if the arena is of Type:
/// Stratosphere. This sprite gains the Blessing of the Imp
function storm_surfer() {
	
}

///@desc ABILITY FUNCTION: This function is called by a sprite with
/// this ability at the end of each turn. All nearby enemies become
/// HEXED
function creep_out() {
	
}

///@desc ABILITY FUNCTION: This function is called by a sprite with
/// this ability when they are targeted by a physical spell or basic 
/// attack
function absorptive_body() {
	
}

///@desc ABILITY FUNCTION: This function is called by a sprite with
/// this ability when they use a basic attack. The damage output is
/// multiplied by 1.5*
function dual_wield() {
	
}

///@desc ABILITY FUNCTION: This function is called by a sprite with this
/// ability at the end of every turn if MIASMA is active on their side
/// of the field. This sprite's team instead regains the health they
/// would have lost from MIASMA
function herbal_concoction() {
	
}

///@desc ABILITY FUNCTION: This function is called by a sprite with
/// this ability if they are targeted by a basic attack. They force
/// their attacker to switch with a randomly selected ally.
function sort_away() {
	
}

///@desc ABILITY FUNCTION: This function is called by a sprite with
/// this ability whenever a sprite attempts to ddoge their attacks
/// and spells. The dodge always automatically fails
function all_seeing_eyes() {
		
}

///@desc ABILITY FUNCTION: This function is called by a sprite with
/// this ability at the end of each turn. Their team automatically
/// restores up to 30 MP
function free_refills() {
	
}

///@desc ABILITY FUNCTION: This function is called by a sprite with
/// this ability at the end of each turn. Every fifth turn, this
/// sprite deals a flat amount of damage to both players.
function short_fuse() {
	
}

///@desc ABILITY FUNCTION: This function is called by a sprite with
/// this ability at the beginning of each turn. It sets a variable
/// that causes the turn selection to skip over any allies that 
/// would move before the sprite with this ability. After this sprite
/// makes their move, their allies all follow suit in order of agility
function synchronized_soldiers() {
	
}

///@desc ABILITY FUNCTION: This function is called by a sprite with
/// this ability whenever they are targeted by a FIRE spell, or cast
/// a FIRE spell against a different sprite. They receive no damage
/// from fire spells and they deal 1.5* damage when casting them
function fiery_aura() {
	
}

///@desc ABILITY FUNCTION: This function is called by a sprite with
/// this ability whenever they meditate. If the arena is not already
/// of type: Ocean, it becomes so
function aquatic_essence() {
	
}

///@desc ABILITY FUNCTION: This function is called by a sprite with
/// this ability whenever they do damage to a sprite of the type:
/// MECHANICAL. They deal 1.5* damage to sprites of that type
function natures_reclamation() {
		
}

///@desc ABILITY FUNCTION: This function is called by a sprite with
/// this ability whenever they meditate. This sprite and all of their
/// allies gain the Blessing of the Tree.
function healing_haze() {
	
}

///@desc ABILITY FUNCTION: This function is called by a sprite with
/// this ability whenever they target another sprite of type: NATURAL
/// for an attack or spell. Their attacks do 1.5* damage against sprites
/// of that type
function territorial_hunter() {
		
}

#endregion

// get all text params from csv file