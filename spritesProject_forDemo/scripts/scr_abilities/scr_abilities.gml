// enum containing ability IDs

// enum containing ability params

// enum containing ability types

#region CREATE ALL ABILITY FUNCTIONS

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
/// this sprite gains the Blessing of the Imp
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

#endregion

// get all text params from csv file