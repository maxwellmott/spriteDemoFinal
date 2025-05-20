#macro BOTH_PLAYERS_EFFECTED		-49

// swap list needs to be held globally because it needs to be referenced
// the same way in two different events
// both of these global variables were created so that there was a way to reference
// them in the middle of different processes without worrying about scope
global.swapList = -1;
global.miasmaDamage = 0;
global.miasmaTeam = -1;
global.mpSpendingSprite = -1;

///@desc This function asks for one argument--the ID of an effect from the SPAR_EFFECTS
/// enum--but it is meant to be overloaded with any arguments that the given function
/// requires. This function is called by spells and abilities and different checks that
/// would result in a spar effect needing to be somehow applied. The function takes
/// the ID of the given effect function, as well as any overloading args and stores
/// them on an encoded list which is then pushed to the spar effectAlertList.
function spar_effect_push_alert(_effectID) {
	// store effectFunction ID in local variable
	var eid = _effectID;
	
	// create a temporary list to store all arguments
	var list = ds_list_create();
	
	// add effectID to temporary list
	list[| 0] = eid;
	
	// get number of additional arguments
	var argCount = argument_count - 1;
	
	// check if there are any additional arguments
	if (argCount > 0) {
		// use a repeat loop to parse through additional args
		var i = 1;	repeat (argCount) {
			// add additional args to temporary list
			list[| i] = argument[i];
			
			// increment i
			i++;
		}
	}
	
	// encode temporary list
	var encList = encode_list(list);
	
	// get the current size of effectAlertList
	var alertCount = ds_list_size(spar.effectAlertList);
	
	var listPos = alertCount;
	
	// check that the current alert is NOT of type "arbitrate_turn"
	if (eid != SPAR_EFFECTS.ARBITRATE_TURN) {
		// check if there are any alerts
		if (alertCount > 0) {
			// use a repeat loop to check each alert
			var i = 0;	repeat (alertCount) {
				var alert = spar.effectAlertList[| i];	
				
				// get the parameters of the current alert
				var pl = ds_list_create();
				decode_list(alert, pl);
				
				// check if the current alert is of type "arbitate_turn"
				if (real(pl[| 0]) == SPAR_EFFECTS.ARBITRATE_TURN) {
					// move this alert down one spot on the list
					spar.effectAlertList[| i + 1] = alert;
					
					// decrement listPos
					listPos -= 1;
				}
			}
		}
	}
	
	// push encoded list to alert list
	spar.effectAlertList[| listPos] = encList;
}

///@desc This function is called in the create event of the sparEffectAlert object. The
/// function simply finds any arguments on the alertParams list and adds them to the global.argumentList
/// for the execute_arguments function being used to call the effect function attached to the alert
function effect_alert_get_args() {
	if (ds_list_size(alertParams) > 1) {
		var i = 1;	repeat (ds_list_size(alertParams) - 1) {			
			global.argumentList[| i - 1] = correct_string_after_decode(alertParams[| i]);
			
			i++;
		}
	}
}

///@desc This function is called when the alertText is loaded. It replaces underscores
/// with any subject that may have been loaded by the effectFunction. It replaces
/// asterisks with any object that may have been loaded by the effectFunction.
function effect_alert_build_text() {	
	var subCount = string_count("_", alertText);
	var objCount = string_count("*", alertText);
	
	if (subCount > 0) {
		repeat (subCount) {
			alertText = string_replace(alertText, "_", subject);
		}
	}
	
	if (objCount > 0) {
		repeat (subCount) {
			alertText = string_replace(alertText, "*", object);	
		}
	}
}

///@desc This function takes the ID of a mindset and returns a string with the
/// name of that mindset
function get_mindset_name(_ID) {
	var ID = _ID;
	
	switch (ID) {
		case MINDSETS.IMP_CURSE: 
			return "CURSE OF THE IMP";
		break;
		
		case MINDSETS.TREE_CURSE:
			return "CURSE OF THE TREE";
		break;
		
		case MINDSETS.WARRIOR_CURSE:
			return "CURSE OF THE WARRIOR";
		break;
		
		case MINDSETS.MOTHER_CURSE:
			return "CURSE OF THE MOTHER";
		break;
		
		case MINDSETS.MOTHER_BLESS:
			return "BLESSING OF THE MOTHER";
		break;
		
		case MINDSETS.WARRIOR_BLESS:
			return "BLESSING OF THE WARRIOR";
		break;
		
		case MINDSETS.TREE_BLESS:
			return "BLESSING OF THE TREE";
		break;
		
		case MINDSETS.IMP_BLESS:
			return "BLESSING OF THE IMP";
		break;
	}
}

// enum that contains all spar hindrances
enum HINDRANCES {
	MIASMA,
	HUM,
	RUST,
	HEIGHT
}

// enum that contains all spar statuses
enum STATUSES {
	HEXED,
	BOUND,
	INVULNERABLE,
	BERSERK,
	HEIGHT
}

// enum that contains all spar mindsets
enum MINDSETS {
	NORMAL,
	TREE_BLESS,
	WARRIOR_BLESS,
	MOTHER_BLESS,
	IMP_BLESS,
	TREE_CURSE,
	WARRIOR_CURSE,
	MOTHER_CURSE,
	IMP_CURSE,
	HEIGHT
}

// enum that contains all spar effect IDs
enum SPAR_EFFECTS {
	ARENA_CHANGE_VOLCANO,						
	ARENA_CHANGE_OCEAN,
	ARENA_CHANGE_CLOUDS,
	ARENA_CHANGE_FOREST,
	ARENA_CHANGE_NORMAL,
	SET_MIASMA,
	SET_HUM,
	SET_RUST,
	ENERGY_BLAST,
	BESTOW_MINDSET,
	SHIFT_MINDSET,
	COPY_MINDSET,
	RESTORE_MP,
	RESTORE_HP,
	DEPLETE_MP,
	DEPLETE_HP,
	DEPLETE_HP_NONLETHAL,
	SET_BOUND,
	SET_HEXED,
	REMOVE_BOUND,
	REMOVE_HEXED,
	CLEAR_MIASMA,
	CLEAR_HUM,
	CLEAR_RUST,
	CLEAR_MINDSET,
	FULLY_RESTORE_HP,
	FULLY_RESTORE_MP,
	GRID_ADD_SKYDIVE,
	GRID_ADD_SNEAK_ATTACK,
	GRID_ADD_TIMED_BLAST,
	CLEAR_TEAM_HINDRANCES,
	CLEAR_ALL_HINDRANCES,
	BLAST_TIMER_GO_OFF,
	BLAST_TIMERS_DECREMENT_COUNT,
	APPLY_MIASMA,
	APPLY_HUM,
	APPLY_RUST,
	FORCE_SWAP,
	FORCE_SWAP_TEAM,
	FORCE_SWAP_GLOBAL,
	SET_MIASMA_GLOBAL,
	SET_HUM_GLOBAL,
	SET_RUST_GLOBAL,
	CLEAR_MIASMA_GLOBAL,
	CLEAR_HUM_GLOBAL,
	CLEAR_RUST_GLOBAL,
	CLEAR_MINDSET_NEARBY_ALLIES,
	CLEAR_MINDSET_NEARBY_ENEMIES,
	CLEAR_MINDSET_NEARBY_SPRITES,
	CLEAR_MINDSET_TEAM,
	CLEAR_MINDSET_GLOBAL,
	BESTOW_MINDSET_NEARBY_ALLIES,
	BESTOW_MINDSET_NEARBY_ENEMIES,
	BESTOW_MINDSET_NEARBY_SPRITES,
	BESTOW_MINDSET_TEAM,
	BESTOW_MINDSET_GLOBAL,
	SHIFT_MINDSET_NEARBY_ALLIES,
	SHIFT_MINDSET_NEARBY_ENEMIES,
	SHIFT_MINDSET_NEARBY_SPRITES,
	SHIFT_MINDSET_TEAM,
	SHIFT_MINDSET_GLOBAL,
	SHIFT_CURSE,
	SHIFT_BLESSING,
	SHIFT_CURSE_NEARBY_ALLIES,
	SHIFT_CURSE_NEARBY_ENEMIES,
	SHIFT_CURSE_NEARBY_SPRITES,
	SHIFT_CURSE_TEAM,
	SHIFT_CURSE_GLOBAL,
	SHIFT_BLESSING_NEARBY_ALLIES,
	SHIFT_BLESSING_NEARBY_ENEMIES,
	SHIFT_BLESSING_NEARBY_SPRITES,
	SHIFT_BLESSING_TEAM,
	SHIFT_BLESSING_GLOBAL,
	SET_HEXED_NEARBY_ALLIES,
	SET_HEXED_NEARBY_ENEMIES,
	SET_HEXED_NEARBY_SPRITES,
	SET_HEXED_TEAM,
	SET_HEXED_GLOBAL,
	SET_BOUND_NEARBY_ALLIES,
	SET_BOUND_NEARBY_ENEMIES,
	SET_BOUND_NEARBY_SPRITES,
	SET_BOUND_TEAM,
	SET_BOUND_GLOBAL,
	APPLY_HEXED,
	APPLY_BOUND,
	ENERGY_BLAST_GLOBAL,
	INCREASE_DAMAGE,
	DECREASE_DAMAGE,
	INCREASE_DAMAGE_NATURAL,
	DECREASE_DAMAGE_NATURAL,
	INCREASE_DAMAGE_MECHANICAL,
	DECREASE_DAMAGE_MECHANICAL,
	INCREASE_DAMAGE_ASTRAL,
	DECREASE_DAMAGE_ASTRAL,
	VOLCANO_WATER_DECREASE_DAMAGE,
	VOLCANO_FIRE_INCREASE_DAMAGE,
	OCEAN_FIRE_DECREASE_DAMAGE,
	OCEAN_STORM_INCREASE_DAMAGE,
	OCEAN_WATER_INCREASE_DAMAGE,
	STRATOS_EARTH_DECREASE_DAMAGE,
	STRATOS_STORM_INCREASE_DAMAGE,
	FOREST_FIRE_INCREASE_DAMAGE,
	FOREST_EARTH_INCREASE_DAMAGE,
	DESTROY_ARENA,
	DRAIN_HEALTH,
	DRAIN_MAGIC,
	REPLACE_TARGET,
	BALL_LIGHTNING_SET_ACTIVE,
	BALL_LIGHTNING_ABSORB_SPELL,
	BALL_LIGHTNING_APPLY_DAMAGE,
	BLACK_HOLE_SET_ACTIVE,
	BLACK_HOLE_ABSORB_SPELL,
	BLACK_HOLE_APPLY_DAMAGE,
	APPLY_SELF_DAMAGE,
	SET_BERSERK,
	SET_BERSERK_NEARBY_ALLIES,
	SET_BERSERK_NEARBY_ENEMIES,
	SET_BERSERK_NEARBY_SPRITES,
	SET_BERSERK_TEAM,
	SET_BERSERK_GLOBAL,
	SET_INVULNERABLE,
	SET_INVULNERABLE_NEARBY_ALLIES,
	SET_INVULNERABLE_NEARBY_ENEMIES,
	SET_INVULNERABLE_NEARBY_SPRITES,
	SET_INVULNERABLE_TEAM,
	SET_INVULNERABLE_GLOBAL,
	SET_PARRYING,
	APPLY_PARRY,
	IGNORE_PARRY,
	SET_DIVIDING,
	SET_MULTIPLYING,
	DIVIDE_HEALING,
	DIVIDE_DAMAGE,
	MULTIPLY_HEALING,
	MULTIPLY_DAMAGE,
	SET_DEFLECTIVE,
	DEFLECT_SPELL,
	FORCE_TURN_END,
	REPEAT_LAST_TURN,
	PSYCHIC_ATTACK,
	CHANGE_ALIGNMENT,
	CHANGE_SIZE,
	ENERGY_BLAST_SELF,
	FORCE_BEST_LUCK,
	FORCE_WORST_LUCK,
	FORCE_BEST_LUCK_TEAM,
	FORCE_WORST_LUCK_TEAM,
	FORCE_BEST_LUCK_GLOBAL,
	FORCE_WORST_LUCK_GLOBAL,
	SET_HAIL_SPHERA,
	HAIL_SPHERA_SET_INVULNERABLE,
	BERSERK_INCREASE_DAMAGE,
	APPLY_BERSERK,
	APPLY_INVULNERABLE,
	END_BERSERK,
	END_BERSERK_NEARBY_ALLIES,
	END_BERSERK_NEARBY_ENEMIES,
	END_BERSERK_NEARBY_SPRITES,
	END_BERSERK_TEAM,
	END_BERSERK_GLOBAL,
	END_INVULNERABLE,
	END_INVULNERABLE_NEARBY_ALLIES,
	END_INVULNERABLE_NEARBY_ENEMIES,
	END_INVULNERABLE_NEARBY_SPRITES,
	END_INVULNERABLE_TEAM,
	END_INVULNERABLE_GLOBAL,
	RESTORE_ALIGNMENT,
	RESTORE_SIZE,
	SKYDIVE_APPLY_DAMAGE,
	SNEAK_ATTACK_APPLY_DAMAGE,
	SKYDIVE_FAILURE,
	SNEAK_ATTACK_FAILURE,
	ACTIVATE_ABILITY,
	BONUS_SPELL,
	IMPROVE_RANGE,
	SYNCHRONIZE_SPRITES, 
	ARBITRATE_TURN,
	BASIC_ATTACK_FIRE,
	BASIC_ATTACK_WATER,
	BASIC_ATTACK_STORM,
	BASIC_ATTACK_EARTH,
	BASIC_ATTACK_RESISTANCE,
	BASIC_ATTACK_AGILITY,
	SET_IMMOBILIZED,
	REMOVE_IMMOBILIZED,
	NEGATE_DAMAGE,
	NEGATE_SPELL_COST,
	FORCE_SPELL_FAILURE,
	OUT_OF_RANGE_SELECTION,
	OUT_OF_RANGE_ACTION,
	HEIGHT
}

// enum that contains all spar effect params
enum SPAR_EFFECT_PARAMS {
	ID,
	ALERT_TEXT,
	EFFECT_FUNCTION,
	ANIMATION,
	HEIGHT
}

///@desc SPAR EFFECT: sets the current ARENA to VOLCANO
function arena_change_volcano() {
	if (spar.currentArena != ARENAS.VOLCANO) {
		spar.newArena = ARENAS.VOLCANO;
		spar.image_index = 0;
		spar.image_speed = 0;
	}	else	{
		ds_list_destroy(effectedSprites);
		instance_destroy(id);	
	}
}

///@desc SPAR EFFECT: sets the current ARENA to OCEAN
function arena_change_ocean() {
	if (spar.currentArena != ARENAS.OCEAN) {
		spar.newArena = ARENAS.OCEAN;
		spar.image_index = 0;
		spar.image_speed = 0;
	}	else	{
		ds_list_destroy(effectedSprites);
		instance_destroy(id);	
	}
}

///@desc SPAR EFFECT: sets the current ARENA to STRATOS
function arena_change_clouds() {
	if (spar.currentArena != ARENAS.CLOUDS) {
		spar.newArena = ARENAS.CLOUDS;
		spar.image_index = 0;
		spar.image_speed = 0;
	}	else	{
		ds_list_destroy(effectedSprites);
		instance_destroy(id);	
	}
}

///@desc SPAR EFFECT: sets the current ARENA to FOREST
function arena_change_forest() {
	if (spar.currentArena != ARENAS.FOREST) {
		spar.newArena = ARENAS.FOREST;
		spar.image_index = 0;
		spar.image_speed = 0;
	}	else	{
		ds_list_destroy(effectedSprites);
		instance_destroy(id);	
	}
}

///@desc SPAR EFFECT: sets the current ARENA to NORMAL
function arena_change_normal() {
	if (spar.currentArena != -1) {
		spar.newArena = -1;
		spar.image_index = 0;
		spar.image_speed = 0;
	}	else	{
		ds_list_destroy(effectedSprites);
		instance_destroy(id);	
	}
}

///@desc SPAR EFFECT: sets MIASMA to true for targetPlayer
function set_miasma(_targetPlayer) {	
	var t = _targetPlayer;
	
	if !(t.miasma) {
		effectedPlayer = t;
		subject = t.name;
		t.miasma = true;
	}	else	{
		ds_list_destroy(effectedSprites);
		instance_destroy(id);	
	}
}

///@desc SPAR EFFECT: sets HUM to true for targetPlayer
function set_hum(_targetPlayer) {
	var t = _targetPlayer;
	
	if !(t.hum) {
		effectedPlayer = t;
		subject = t.name;
		t.hum = true;
	}	else	{
		ds_list_destroy(effectedSprites);
		instance_destroy(id);	
	}
}

///@desc SPAR EFFECT: sets RUST to true for targetPlayer
function set_rust(_targetPlayer) {
	var t = _targetPlayer;
	
	if !(t.rust) {
		effectedPlayer = t;
		subject = t.name;
		t.rust = true;
	}	else	{
		ds_list_destroy(effectedSprites);
		instance_destroy(id);	
	}
}

///@desc SPAR EFFECT: applies damage from an ENERGY BLAST to targetPlayer
function energy_blast(_targetPlayer, _damage) {
	var t = _targetPlayer;
	var d = _damage;
	
	deplete_hp(t, d);
	
	subject = t.name;
	effectedPlayer = t;
}

///@desc SPAR EFFECT: bestows the given MINDSET to the given target sprite
function bestow_mindset(_target, _mindset) {
	var t = _target;
	var m = _mindset;
	
	if (t.mindset != m) {
		ds_list_add(effectedSprites, t);
		subject = t.name;
		object = get_mindset_name(m);
		t.mindset = m;
	}	else	{
		ds_list_destroy(effectedSprites);
		instance_destroy(id);
	}
}

///@desc SPAR EFFECT: shifts the target's MINDSET from BLESSING to CURSE or vice versa
function shift_mindset(_target) {
	var t = _target;

	if (t.mindset != 0) {
		ds_list_add(effectedSprites, t);
		subject = t.name;
		
		// initialize new mindset
		var nm = 0;
		
		// check if the mindset is a curse
		if (t.mindset > MINDSETS.IMP_BLESS) {
			// set the new mindset
			nm = t.mindset - 4;
		}
		// if the mindset is a blessing
		else {
			if (t.mindset > MINDSETS.NORMAL) {
				// set the new mindset
				nm = t.mindset + 4;
			}
		}
		
		// check if new mindset was set
		if (nm > 0) {
			t.mindset = nm;	
		}
		
	}	else	{
		ds_list_destroy(effectedSprites);
		instance_destroy(id);	
	}
}

///@desc SPAR EFFECT: the caster copies the target's MINDSET
function copy_mindset(_caster, _target) {
	var c = _caster;
	var t = _target;
	
	if (t.mindset != 0) {
		ds_list_add(effectedSprites, c, t);
		subject = t.name;
		c.mindset = t.mindset;
	}	else	{
		ds_list_destroy(effectedSprites);
		instance_destroy(id);	
	}
}

///@desc SPAR EFFECT: the targetPlayer restores the given amount of MP
function restore_mp_spar_effect(_targetPlayer, _amount) {
	var t = _targetPlayer;
	var a = round(_amount);
	
	effectedPlayer = t;
	subject = t.name;
	
	var mpNeeded = MAX_MP - t.currentMP;
	
	if (a >= mpNeeded)	t.currentMP = MAX_MP;
	else				t.currentMP += a;
}

///@desc SPAR EFFECT: the targetPlayer restores the given amount of HP
function restore_hp_spar_effect(_targetPlayer, _amount) {
	var t = _targetPlayer;
	var a = round(_amount);
	
	effectedPlayer = t;
	subject = t.name;
	
	var hpNeeded = MAX_HP - t.currentHP;
	
	if (a >= hpNeeded)	t.currentHP = MAX_HP;
	else				t.currentHP += a;
}

///@desc SPAR EFFECT: the targetPlayer loses the given amount of HP
function deplete_hp_spar_effect(_targetPlayer, _amount) {
	var t = _targetPlayer;
	var a = round(_amount);
	
	effectedPlayer = t;
	subject = t.name;
	
	var hpLeft = t.currentHP;
	
	if (a >= hpLeft)	t.currentHP = 0;
	else				t.currentHP -= a;
}

///@desc SPAR EFFECT: the targetPlayer loses the given amount of MP
function deplete_mp_spar_effect(_targetPlayer, _amount) {
	var t = _targetPlayer;
	var a = round(_amount);
	
	effectedPlayer = t;
	subject = t.name;
	
	var mpLeft = t.currentMP;
	
	if (a >= mpLeft)	t.currentMP = 0;
	else				t.currentMP -= a;
}

///@desc SPAR EFFECT: the targetPlayer loses the given amount of HP or
/// the most it can give while still having 1 HP left
function deplete_hp_nonlethal(_targetPlayer, _amount) {
	var t = _targetPlayer;
	var a = round(_amount);
	
	effectedPlayer = t;
	subject = t.name;
	
	var hpLeft = t.currentHP;
	
	if (a >= hpLeft)	t.currentHP = 1;
	else				t.currentHP -= a;
}

///@desc SPAR EFFECT: sets BOUND to true for the target sprite
function set_bound(_target) {
	var t = _target;
	if !(t.bound) {
		if !(spar_check_invulnerable(t)) {
			if !(spar_check_berserk(t)) {
				ds_list_add(effectedSprites, t);
				subject = t.name;
				t.bound = true;
				t.boundCounter = 1;
			}	else	{
				ds_list_destroy(effectedSprites);
				instance_destroy(id);	
			}
		}	else	{
			ds_list_destroy(effectedSprites);
			instance_destroy(id);	
		}
	}	else	{
		ds_list_destroy(effectedSprites);
		instance_destroy(id);	
	}
}

///@desc SPAR EFFECT: sets HEXED to true for the target sprite
function set_hexed(_target) {
	var t = _target;
	if !(t.bound) {
		if !(spar_check_invulnerable(t)) {
			if !(spar_check_berserk(t)) {
				ds_list_add(effectedSprites, t);
				subject = t.name;
				t.hexed = true;
				t.hexedCounter = 1;
			}	else	{
				ds_list_destroy(effectedSprites);
				instance_destroy(id);	
			}
		}	else	{
			ds_list_destroy(effectedSprites);
			instance_destroy(id);	
		}
	}	else	{
		ds_list_destroy(effectedSprites);
		instance_destroy(id);	
	}
}

///@desc SPAR EFFECT: sets BOUND to false for the target sprite
function remove_bound(_target) {
	var t = _target;
	
	if (t.bound) {
		ds_list_add(effectedSprites, t);
		subject = t.name;
		t.bound = false;
		t.boundCounter = 0;
	}	else	{
		ds_list_destroy(effectedSprites);
		instance_destroy(id);	
	}
}

///@desc SPAR EFFECT: sets HEXED to false for the target sprite
function remove_hexed(_target) {
	var t = _target;
	
	if (t.hexed) {
		ds_list_add(effectedSprites, t);
		subject = t.name;
		t.hexed  = false;
		t.hexedCounter = 0;
	}	else	instance_destroy(id);	
}

///@desc SPAR EFFECT: sets MIASMA to false for the targetPlayer
function clear_miasma(_targetPlayer) {
	var t = _targetPlayer;
	
	if (t.miasma) {
		effectedPlayer = t;
		subject = t.name;
		t.miasma = false;
	}	else	{
		ds_list_destroy(effectedSprites);
		effectedSprites = -1;
		instance_destroy(id);	
	}
}

///@desc SPAR EFFECT: sets HUM to false for the targetPlayer
function clear_hum(_targetPlayer) {
	var t = _targetPlayer;
	
	if (t.hum) {
		effectedPlayer = t;
		subject = t.name;
		t.hum = false;
	}	else	{
		ds_list_destroy(effectedSprites);
		effectedSprites = -1;
		instance_destroy(id);	
	}
}

///@desc SPAR EFFECT: sets RUST to false for the targetPlayer
function clear_rust(_targetPlayer) {
	var t = _targetPlayer;
	
	if (t.rust) {
		effectedPlayer = t;
		subject = t.name;
		t.rust = false;
	}	else {
		ds_list_destroy(effectedSprites);
		effectedSprites = -1;
		instance_destroy(id);
	}
}

///@desc SPAR EFFECT: removes the MINDSET of the target by setting it to 0
function clear_mindset(_target) {
	var t = _target;
	
	if (t.mindset != 0) {
		ds_list_add(effectedSprites, t);
		subject = t.name;
		t.mindset = 0;
	}	else	{
		ds_list_destroy(effectedSprites);
		effectedSprites = -1;
		instance_destroy(id);	
	}
}
	
///@desc SPAR EFFECT: fully restores targetPlayer's HP
function fully_restore_hp(_targetPlayer) {
	var t = _targetPlayer;
	
	if (t.currentHP < MAX_HP) {
		effectedPlayer = t;
		subject = t.name;
		t.currentHP = MAX_HP;
	}	else	{	
		ds_list_destroy(effectedSprites);
		effectedSprites = -1;
		instance_destroy(id);	
	}
}

///@desc SPAR EFFECT: fully restores targetPlayer's MP
function fully_restore_mp(_targetPlayer) {
	var t = _targetPlayer;
	
	if (t.currentMP != MAX_MP) {
		effectedPlayer = t;
		subject = t.name;
		t.currentMP = MAX_MP;
	}	else	{
		ds_list_destroy(effectedSprites);
		effectedSprites = -1;
		instance_destroy(id);	
	}
}
	
///@desc SPAR EFFECT: adds a new SKYDIVE to the grid
function grid_add_skydive(_caster, _target) {
	var c = _caster;
	var t = _target;
	
	ds_list_add(effectedSprites, c);
	subject = c.name;
	
	c.invulnerable		= true;
	c.invulnerableCount = INVULNERABLE_COUNT_MAX;
	c.flying			= true;
	
	// resize grid
	ds_grid_resize(spar.skydiveGrid, 2, spar.skydiveCount + 1);
	
	// add values
	spar.skydiveGrid[# 0, spar.skydiveCount]	= c;
	spar.skydiveGrid[# 1, spar.skydiveCount]	= t;
	
	// increment skydive count
	spar.skydiveCount++;
}
	
///@desc SPAR EFFECT: adds a new SNEAK ATTACK to the grid
function grid_add_sneak_attack(_caster, _target) {
	var c = _caster;
	
	ds_list_add(effectedSprites, c);
	subject = c.name;
	
	// set dodging to true
	c.dodging = true;
	
	// set sneaking to true
	c.sneaking = true;
	
	// get target
	var t = _target;
	
	// resize grid
	ds_grid_resize(spar.sneakAttackGrid, 2, spar.sneakAttackCount + 1);
	
	// add values
	spar.sneakAttackGrid[# 0, spar.sneakAttackCount]	= c;
	spar.sneakAttackGrid[# 1, spar.sneakAttackCount]	= t;
	
	// increment sneak attack count
	spar.sneakAttackCount++;
}
	
///@desc SPAR EFFECT: adds a new TIMED BLAST to the grid
function grid_add_timed_blast(_counter, _power, _targetPlayer) {
	// store all arguments in local variables
	var c = _counter;
	var p = _power;
	var t = _targetPlayer;
	
	effectedPlayer = t;
	
	// add the params of the blast to the blast grid
	var count = spar.blastCount;
	
	// resize the timed blast grid
	ds_grid_resize(spar.timedBlastGrid, 3, count + 1);
	
	spar.timedBlastGrid[# 0, count] = c;
	spar.timedBlastGrid[# 1, count] = p;
	spar.timedBlastGrid[# 2, count] = t;
	
	// increment the blast count
	spar.blastCount++;	
}	

///@desc SPAR EFFECT: clears all hindrances on the given team's
/// side of the field
function clear_team_hindrances(_team) {
	var t = _team;
	
	if (t.miasma)
	|| (t.hum)
	|| (t.rust) {
		effectedPlayer = t;
		subject = t.name;
		
		t.miasma = false;
		t.hum = false;
		t.rust = false;
	}
}

///@desc SPAR EFFECT: clears all hindrances on both sides of the field
function clear_all_hindrances() {
	var t1 = spar.playerOne;
	var t2 = spar.playerTwo;
	
	if ((t1.miasma + t1.hum + t1.rust + t2.miasma + t2.hum + t2.rust) > 0) {
		effectedPlayer = BOTH_PLAYERS_EFFECTED;
		t1.miasma = false;
		t1.hum = false;
		t1.rust = false;
		
		t2.miasma = false;
		t2.hum = false;
		t2.rust = false;
	}
}

///@desc SPAR EFFECT: triggers a TIMED BLAST whose timer is up
function blast_timer_go_off(_blastNum) {
	var n = _blastNum;
	
	// get all blast params
	var c = spar.timedBlastGrid[# 0, n];
	var p = spar.timedBlastGrid[# 1, n];
	var t = spar.timedBlastGrid[# 2, n];
	
	// create the energy blast
	spar_effect_push_alert(SPAR_EFFECTS.ENERGY_BLAST, t, p);
	
	// decrement the blastCount
	spar.blastCount--;
	
	// check if this is the last entry
	if (n != ds_grid_height(spar.timedBlastGrid)) {
		// if this was not the last entry, move each of the other entries
		// up one step
		var i = 1;	repeat (ds_grid_height(spar.timedBlastGrid) - n) {
			spar.timedBlastGrid[# 0, n] =	spar.timedBlastGrid[# 0, n + i];
			spar.timedBlastGrid[# 1, n] =	spar.timedBlastGrid[# 1, n + i];
			spar.timedBlastGrid[# 2, n] =	spar.timedBlastGrid[# 2, n + i];
			
			// increment i
			i++;
		}
	}
	
	// resize the timedBlast grid
	ds_grid_remove_row(spar.timedBlastGrid, n);
}

///@desc SPAR EFFECT: drops the counter for each blast timer down one tick
function blast_timers_decrement_count() {
	var i = 0;	repeat (spar.blastCount) {
		spar.timedBlastGrid[# 0, i] -= 1;
		
		if (spar.timedBlastGrid[# 0, i] <= 0) {
			spar_effect_push_alert(SPAR_EFFECTS.BLAST_TIMER_GO_OFF, i);
		}
		
		i++;
	}
}

///@desc SPAR EFFECT: applies the damage from MIASMA
function apply_miasma(_effectedTeam) {
	var t = _effectedTeam;
	global.miasmaDamage = 0;
	
	global.miasmaTeam = t;
	
	subject = t.name;
	
	// get correct list of sprites
	var tl = -1;
	if (t == spar.playerOne)	tl = spar.allyList;
	if (t == spar.playerTwo)	tl = spar.enemyList;
	
	// check for natural sprites to increase damage
	// and add to effectedSprites list
	var i = 0;	repeat (4) {
		if (tl[| i].currentAlign == ALIGNMENTS.NATURAL) 
		&& !(tl[| i].invulnerable) {
			ds_list_add(effectedSprites, tl[| i]);
			
			global.miasmaDamage += 125;
		}
		
		i++;
	}
	
	// perform an ability check for apply miasma
	ability_check(ABILITY_TYPES.APPLY_MIASMA);
	
	// check that damage was increased at least once before applying
	if (global.miasmaDamage > 0) {
		spar_effect_push_alert(SPAR_EFFECTS.DEPLETE_HP, t, global.miasmaDamage);
	}
	else if (global.miasmaDamage < 0) {
		spar_effect_push_alert(SPAR_EFFECTS.RESTORE_HP, t, (global.miasmaDamage * -1));
	}
	
	global.miasmaDamage = 0;
	global.miasmaTeam = -1;
}

///@desc SPAR EFFECT: applies negation of ELEMENTAL damage from HUM
function apply_hum(_activeSprite) {
	var c = _activeSprite;
	
	ds_list_add(effectedSprites, c);
	subject = c.team.name;
	
	// damage cannot be edited by any of these functions. There will be a check
	// before damage is applied, and that check will call this function as a means
	// of notifying the player after the fact
}

///@desc SPAR EFFECT: applies increase of PHYSICAL damage from RUST
function apply_rust(_targetSprite) {
	var t = _targetSprite;
	
	ds_list_add(effectedSprites, t);
	subject = t.team.name;
	// damage cannot be edited by any of these functions. There will be a check
	// before damage is applied, and that check will call this function as a means
	// of notifying the player after the fact
}
	
///@desc SPAR EFFECT: forces the target to swap with a randomly chosen ally
function force_swap(_targetSprite) {
	randomize();
	
	// initialize global.swapList
	global.swapList = ds_list_create();
	
	// get target's spot number
	var t = _targetSprite;
	var tsn = t.spotNum;
	
	// get target team
	var tt = t.team;
	
	// create temp list
	var l = ds_list_create();
	
	// build a list of numbers representing viable swap partners
	var i = 0;	repeat (4) {
		// if i doesn't equal target spot num, add it to the list
		if (i != tsn)	ds_list_add(l, i);
		
		i++;
	}
	
	// pick a random number off of that list and set it as the
	// partner's spot number
	var int = irandom_range(0, 2);
	var psn = l[| int];
	
	// create inst list
	var il = ds_list_create();
	
	// copy appropriate list
	if (tt == spar.playerOne)	ds_list_copy(il, spar.allyList);
	if (tt == spar.playerTwo)	ds_list_copy(il, spar.enemyList);
	
	// store swap partner's ID
	var psid	= il[| psn];
	
	// store target's ID
	var tsid	= il[| tsn];
	
	// add both swappers to global.swapList
	ds_list_add(global.swapList, psid, tsid);
	
	// add target and swapper to effectedSprites, store tt.name in subject
	ds_list_add(effectedSprites, t, il[| psn]);
	subject = tt.name;	
	
	// perform an ability check for swap attempt
	ability_check(ABILITY_TYPES.SWAP_ATTEMPT);
	
	// if neither swapper is bound:
	if !(spar_check_bound(psid)) {
		if !(spar_check_bound(tsid)) {
			// if neither swapper is invulnerable
			if !(spar_check_invulnerable(psid)) {
				if !(spar_check_invulnerable(tsid)) {
					// retain mindset to maintain through swap
					var m1 = psid.mindset;
					var m2 = tsid.mindset;
					
					// reset all necessary vars for both sprites
					with (tsid) {
						dodging			= false;
						hexed			= false;
						berserk			= false;
						parrying		= false;	
						deflective		= false;
						sneaking		= false;
					}
					
					with (psid) {
						dodging			= false;
						hexed			= false;
						berserk			= false;
						parrying		= false;
						deflective		= false;
						sneaking		= false;	
					}
					
					// create temp var for psid
					var temp	= psid.spriteID;	
					
					// swap sprite IDs
					psid.spriteID	= tsid.spriteID;
					tsid.spriteID	= temp;		
					
					// load params for each swapper
					with (psid)		sprite_load_parameters();
					with (tsid)		sprite_load_parameters();
									
					// swap mindsets
					psid.mindset = m2;
					tsid.mindset = m1;
					
					// get the action, target, and luckRoll for both swappers
					var t_action	= spar.turnGrid[# TURN_GRID.ACTION, tsn];
					var t_target	= spar.turnGrid[# TURN_GRID.TARGET, tsn];
					var t_luck		= spar.turnGrid[# TURN_GRID.LUCK, tsn];
					
					var p_action	= spar.turnGrid[# TURN_GRID.ACTION, psn];
					var p_target	= spar.turnGrid[# TURN_GRID.TARGET, psn];
					var p_luck		= spar.turnGrid[# TURN_GRID.LUCK, psn];
					
					// swap the two sprites' turn rows
					spar.turnGrid[# TURN_GRID.ACTION, tsn] = p_action;
					spar.turnGrid[# TURN_GRID.TARGET, tsn] = p_target;
					spar.turnGrid[# TURN_GRID.LUCK, tsn] = p_luck;
					
					spar.turnGrid[# TURN_GRID.ACTION, psn] = t_action;
					spar.turnGrid[# TURN_GRID.TARGET, psn] = t_target;
					spar.turnGrid[# TURN_GRID.LUCK, psn] = t_luck;
				}
			}
		}	
	}	
	
	// perform an ability check for swap success
	ability_check(ABILITY_TYPES.SWAP_SUCCESS);

	// delete lists
	ds_list_destroy(l);
	ds_list_destroy(il);
	ds_list_destroy(global.swapList);
}

///@desc SPAR EFFECT: forces the target team to split into two groups randomly
/// and perform swaps
function force_swap_team(_targetPlayer) {
	randomize();
		
	// initialize global.swapList
	global.swapList = ds_list_create();
		
	// get target's spot number
	var ct = _targetPlayer;
	
	effectedPlayer = ct;
	subject = ct.name;
	
	// create a dummy list
	var iil = ds_list_create();
	
	// find out which list to copy
	if (ct == spar.playerOne)	ds_list_copy(iil, spar.allyList);
	if (ct == spar.playerTwo)	ds_list_copy(iil, spar.enemyList);
	
	// get a random integer
	var int = irandom_range(0, 3);
	
	// set target as the list token at the index of the random integer
	var t	= iil[| int];
	var tsn = t.spotNum;
	
	// if this is the enemy team, subtract 4 from spotNum
	if (ct == spar.playerTwo)	tsn -= 4;
	
	// get target team
	var tt = t.team;
	
	// create temp list
	var l = ds_list_create();
	
	// build a list of numbers representing viable swap partners
	var i = 0;	repeat (4) {
		// if i doesn't equal target spot num, add it to the list
		if (i != tsn)	ds_list_add(l, i);
		
		i++;
	}
	
	// pick a random number off of that list and set it as the
	// partner's spot number
	var int = irandom_range(0, 2);
	var psn = l[| int];
	
	// create inst list
	var il = ds_list_create();
	
	// copy appropriate list
	if (tt == spar.playerOne)	ds_list_copy(il, spar.allyList);
	if (tt == spar.playerTwo)	ds_list_copy(il, spar.enemyList);
	
	// store swap partner's ID
	var psid	= il[| psn];
	
	// store target's ID
	var tsid	= il[| tsn];
	
	// initialize vars for second swap (since this is for the whole team)
	var tsn2 = -1;
	var psn2 = -1;
	var tsid2 = -1;
	var psid2 = -1;
	
	// use a repeat loop to set vars for second swap
	var i = 0;	repeat (4) {
		// check if this is neither the psn or the tsn
		if (tsn != i)
		&& (psn != i) {
			// check that the tsn2 has not yet been set
			if (tsn2 == -1) {
				tsn2 = i;
				tsid2 = il[| tsn2];
			}
			// if the tsn2 has already been set
			else {
				psn2 = i;
				psid2 = il[| psn2];
			}
		}
		
		// increment i
		i++;
	}	
	
	// if neither swapper is bound:
	if !(spar_check_bound(psid)) {
		if !(spar_check_bound(tsid)) {
			// if neither swapper is invulnerable:
			if !(spar_check_invulnerable(psid)) {
				if !(spar_check_invulnerable(tsid)) {
					// add both sprites to global.swapList
					ds_list_add(global.swapList, psid, tsid);
					
					// retain mindset to maintain through swap
					var m1 = psid.mindset;
					var m2 = tsid.mindset;
					
					// reset all necessary vars for both sprites
					with (tsid) {
						dodging			= false;
						hexed			= false;
						berserk			= false;
						parrying		= false;	
						deflective		= false;
						sneaking		= false;
					}
					
					with (psid) {
						dodging			= false;
						hexed			= false;
						berserk			= false;
						parrying		= false;
						deflective		= false;
						sneaking		= false;	
					}
					
					// swap sprite IDs
					var temp		= tsid.spriteID;
					tsid.spriteID	= psid.spriteID;
					psid.spriteID	= temp;
										
					// load params for both swappers
					with (psid)		sprite_load_parameters();
					with (tsid)		sprite_load_parameters();
					
					// swap mindsets
					psid.mindset = m2;
					tsid.mindset = m1;
					
					// get the action, target, and luckRoll for both swappers
					var t_action	= spar.turnGrid[# TURN_GRID.ACTION, tsn];
					var t_target	= spar.turnGrid[# TURN_GRID.TARGET, tsn];
					var t_luck		= spar.turnGrid[# TURN_GRID.LUCK, tsn];
					
					var p_action	= spar.turnGrid[# TURN_GRID.ACTION, psn];
					var p_target	= spar.turnGrid[# TURN_GRID.TARGET, psn];
					var p_luck		= spar.turnGrid[# TURN_GRID.LUCK, psn];

					// swap the two sprites' turn rows
					spar.turnGrid[# TURN_GRID.ACTION, tsn] = p_action;
					spar.turnGrid[# TURN_GRID.TARGET, tsn] = p_target;
					spar.turnGrid[# TURN_GRID.LUCK, tsn] = p_luck;
					
					spar.turnGrid[# TURN_GRID.ACTION, psn] = t_action;
					spar.turnGrid[# TURN_GRID.TARGET, psn] = t_target;
					spar.turnGrid[# TURN_GRID.LUCK, psn] = t_luck;
				}
			}
		}
	}	
	
	// if neither swapper is bound:
	if !(spar_check_bound(psid2)) {
		if !(spar_check_bound(tsid2)) {
			// if neither swapper is invulnerable:
			if !(spar_check_invulnerable(psid2)) {
				if !(spar_check_invulnerable(tsid2)) {
					// add both sprites to global.swapList
					ds_list_add(global.swapList, psid2, tsid2);
					
					// retain mindset to maintain through swap
					var m1 = psid2.mindset;
					var m2 = tsid2.mindset;
					
					// reset all necessary vars for both sprites
					with (tsid2) {
						dodging			= false;
						hexed			= false;
						berserk			= false;
						parrying		= false;	
						deflective		= false;
						sneaking		= false;
					}
					
					with (psid2) {
						dodging			= false;
						hexed			= false;
						berserk			= false;
						parrying		= false;
						deflective		= false;
						sneaking		= false;	
					}
					
					// swap sprite IDs
					var temp		= tsid2.spriteID;
					tsid2.spriteID	= psid2.spriteID;
					psid2.spriteID	= temp;
										
					// load params for both swappers
					with (psid2)		sprite_load_parameters();
					with (tsid2)		sprite_load_parameters();
					
					// swap mindsets
					psid2.mindset = m2;
					tsid2.mindset = m1;
					
					// get the action, target, and luckRoll for both swappers
					var t_action	= spar.turnGrid[# TURN_GRID.ACTION, tsn2];
					var t_target	= spar.turnGrid[# TURN_GRID.TARGET, tsn2];
					var t_luck		= spar.turnGrid[# TURN_GRID.LUCK, tsn2];
					
					var p_action	= spar.turnGrid[# TURN_GRID.ACTION, psn2];
					var p_target	= spar.turnGrid[# TURN_GRID.TARGET, psn2];
					var p_luck		= spar.turnGrid[# TURN_GRID.LUCK, psn2];
					
					// swap the two sprites' turn rows
					spar.turnGrid[# TURN_GRID.ACTION, tsn2] = p_action;
					spar.turnGrid[# TURN_GRID.TARGET, tsn2] = p_target;
					spar.turnGrid[# TURN_GRID.LUCK, tsn2] = p_luck;
					
					spar.turnGrid[# TURN_GRID.ACTION, psn2] = t_action;
					spar.turnGrid[# TURN_GRID.TARGET, psn2] = t_target;
					spar.turnGrid[# TURN_GRID.LUCK, psn2] = t_luck;
				}
			}
		}
	}	
	
	// perform an ability check for swap success
	ability_check(ABILITY_TYPES.SWAP_SUCCESS);
	
	// delete lists
	ds_list_destroy(l);
	ds_list_destroy(il);
	ds_list_destroy(global.swapList);

}

///@desc SPAR EFFECT: forces both teams to perform swaps with all their sprites
function force_swap_global() {
	var ct = -1;
	
	// initialize global.swapList
	global.swapList = ds_list_create();
	
	effectedPlayer = BOTH_PLAYERS_EFFECTED;
	
	var i = 0;	repeat (2) {
		// reset random seed
		randomize();
		
		if (i)	ct = spar.playerOne;
		if !(i)	ct = spar.playerTwo;
		
		// create a dummy list
		var iil = ds_list_create();
		
		// find out which list to copy
		if (ct == spar.playerOne)	ds_list_copy(iil, spar.allyList);
		if (ct == spar.playerTwo)	ds_list_copy(iil, spar.enemyList);
		
		// get a random integer
		var int = irandom_range(0, 3);
		
		// set target as the list token at the index of the random integer
		var t	= iil[| int];
		var tsn = t.spotNum;
		
		// get target team
		var tt = t.team;
		
		// create temp list
		var l = ds_list_create();
		
		// build a list of numbers representing viable swap partners
		var j = 0;	repeat (4) {
			// if i doesn't equal target spot num, add it to the list
			if (j != tsn)	ds_list_add(l, j);
			
			j++;
		}
		
		// pick a random number off of that list and set it as the
		// partner's spot number
		var int = irandom_range(0, 3);
		var psn = l[| int];
		
		// create inst list
		var il = ds_list_create();
		
		// copy appropriate list
		if (tt == spar.playerOne)	ds_list_copy(il, spar.allyList);
		if (tt == spar.playerTwo)	ds_list_copy(il, spar.enemyList);
			
		// store swap partner's ID
		var psid	= il[| psn];
		
		// store target's ID
		var tsid	= il[| tsn];
		
		// initialize vars for second swap (since this is for the whole team)
		var tsn2 = -1;
		var psn2 = -1;
		var tsid2 = -1;
		var psid2 = -1;
		
		// use a repeat loop to set vars for second swap
		var j = 0;	repeat (4) {
			// check if this is neither the psn or the tsn
			if (tsn != j)
			&& (psn != j) {
				// check that the tsn2 has not yet been set
				if (tsn2 == -1) {
					tsn2 = j;
					tsid2 = il[| tsn2];
				}
				// if the tsn2 has already been set
				else {
					psn2 = j;
					psid2 = il[| psn2];
				}
			}
			
			// increment j
			j++;
		}
		
		// perform an ability check for swap attempt
		ability_check(ABILITY_TYPES.SWAP_ATTEMPT);
		
		// if neither swapper is bound:
		if !(spar_check_bound(psid)) {
			if !(spar_check_bound(tsid)) {
				// if neither swapper is invulnerable
				if !(spar_check_invulnerable(psid)) {
					if !(spar_check_invulnerable(tsid)) {	
						// add both sprites to global.swapList
						ds_list_add(global.swapList, psid, tsid);
						
						// retain mindset to maintain through swap
						var m1 = psid.mindset;
						var m2 = tsid.mindset;
						
						// reset all necessary vars for both sprites
						with (tsid) {
							dodging			= false;
							hexed			= false;
							berserk			= false;
							parrying		= false;	
							deflective		= false;
							sneaking		= false;
						}
						
						with (psid) {
							dodging			= false;
							hexed			= false;
							berserk			= false;
							parrying		= false;
							deflective		= false;
							sneaking		= false;	
						}
						
						// swap list positions
						il[| psn]	= tsid;
						il[| tsn]	= psid;	
						
						// create temp var for psid
						var temp	= psid.spriteID;	
						
						// swap sprite IDs
						psid.spriteID		= tsid.spriteID;
						tsid.spriteID		= temp;
						
						// load params for both swappers
						with (psid)		sprite_load_parameters();
						with (tsid)		sprite_load_parameters();
						
						// swap mindsets
						psid.mindset = m2;
						tsid.mindset = m1;
						
						// get the action, target, and luckRoll for both swappers
						var t_action	= spar.turnGrid[# TURN_GRID.ACTION, tsn];
						var t_target	= spar.turnGrid[# TURN_GRID.TARGET, tsn];
						var t_luck		= spar.turnGrid[# TURN_GRID.LUCK, tsn];
						
						var p_action	= spar.turnGrid[# TURN_GRID.ACTION, psn];
						var p_target	= spar.turnGrid[# TURN_GRID.TARGET, psn];
						var p_luck		= spar.turnGrid[# TURN_GRID.LUCK, psn];
						
						// swap the two sprites' turn rows
						spar.turnGrid[# TURN_GRID.ACTION, tsn] = p_action;
						spar.turnGrid[# TURN_GRID.TARGET, tsn] = p_target;
						spar.turnGrid[# TURN_GRID.LUCK, tsn] = p_luck;
						
						spar.turnGrid[# TURN_GRID.ACTION, psn] = t_action;
						spar.turnGrid[# TURN_GRID.TARGET, psn] = t_target;
						spar.turnGrid[# TURN_GRID.LUCK, psn] = t_luck;
					}
				}
			}
		}		
		
		// if neither swapper is bound:
		if !(spar_check_bound(psid2)) {
			if !(spar_check_bound(tsid2)) {
				// if neither swapper is invulnerable:
				if !(spar_check_invulnerable(psid2)) {
					if !(spar_check_invulnerable(tsid2)) {
						// add both sprites to global.swapList
						ds_list_add(global.swapList, psid2, tsid2);
						
						// retain mindset to maintain through swap
						var m1 = psid2.mindset;
						var m2 = tsid2.mindset;
						
						// reset all necessary vars for both sprites
						with (tsid2) {
							dodging			= false;
							hexed			= false;
							berserk			= false;
							parrying		= false;	
							deflective		= false;
							sneaking		= false;
						}
						
						with (psid2) {
							dodging			= false;
							hexed			= false;
							berserk			= false;
							parrying		= false;
							deflective		= false;
							sneaking		= false;	
						}
						
						// swap sprite IDs
						var temp		= tsid2.spriteID;
						tsid2.spriteID	= psid2.spriteID;
						psid2.spriteID	= temp;
											
						// load params for both swappers
						with (psid2)		sprite_load_parameters();
						with (tsid2)		sprite_load_parameters();
						
						// swap mindsets
						psid2.mindset = m2;
						tsid2.mindset = m1;
						
						// get the action, target, and luckRoll for both swappers
						var t_action	= spar.turnGrid[# TURN_GRID.ACTION, tsn2];
						var t_target	= spar.turnGrid[# TURN_GRID.TARGET, tsn2];
						var t_luck		= spar.turnGrid[# TURN_GRID.LUCK, tsn2];
						
						var p_action	= spar.turnGrid[# TURN_GRID.ACTION, psn2];
						var p_target	= spar.turnGrid[# TURN_GRID.TARGET, psn2];
						var p_luck		= spar.turnGrid[# TURN_GRID.LUCK, psn2];
						
						// swap the two sprites' turn rows
						spar.turnGrid[# TURN_GRID.ACTION, tsn2] = p_action;
						spar.turnGrid[# TURN_GRID.TARGET, tsn2] = p_target;
						spar.turnGrid[# TURN_GRID.LUCK, tsn2] = p_luck;
						
						spar.turnGrid[# TURN_GRID.ACTION, psn2] = t_action;
						spar.turnGrid[# TURN_GRID.TARGET, psn2] = t_target;
						spar.turnGrid[# TURN_GRID.LUCK, psn2] = t_luck;
					}
				}
			}
		}	
		
		// perform an ability check for swap success
		ability_check(ABILITY_TYPES.SWAP_SUCCESS);
				
		// delete lists
		ds_list_destroy(l);
		ds_list_destroy(il);
		ds_list_destroy(global.swapList);
		
		// increment i
		i++;
	}
}

///@desc SPAR EFFECT: sets MIASMA on both sides of the field
function set_miasma_global() {
	if !(spar.playerOne.miasma)
	|| !(spar.playerTwo.miasma) {
		effectedPlayer = BOTH_PLAYERS_EFFECTED;
		spar.playerOne.miasma = true;
		spar.playerTwo.miasma = true;
	}	else	ds_list_destroy(effectedSprites);	effectedSprites = -1;	instance_destroy(id);	
}

///@desc SPAR EFFECT: sets HUM on both sides of the field
function set_hum_global() {
	if !(spar.playerOne.hum)
	|| !(spar.playerTwo.hum) {
		effectedPlayer = BOTH_PLAYERS_EFFECTED;
		spar.playerOne.hum = true;
		spar.playerTwo.hum = true;
	}	else	ds_list_destroy(effectedSprites);	effectedSprites = -1;	instance_destroy(id);	
}

///@desc SPAR EFFECT: sets RUST on both sides of the field
function set_rust_global() {
	if !(spar.playerOne.rust)
	|| !(spar.playerTwo.rust) {
		effectedPlayer = BOTH_PLAYERS_EFFECTED;
		spar.playerOne.rust = true;
		spar.playerTwo.rust = true;
	}	else	ds_list_destroy(effectedSprites);	effectedSprites = -1;	instance_destroy(id);	
}

///@desc SPAR EFFECT: clears MIASMA from both sides of the field
function clear_miasma_global() {
	if (spar.playerOne.miasma) 
	|| (spar.playerTwo.miasma) {
		effectedPlayer = BOTH_PLAYERS_EFFECTED;
		spar.playerOne.miasma = false;
		spar.playerTwo.miasma = false;
	}	else	ds_list_destroy(effectedSprites);	effectedSprites = -1;	instance_destroy(id);	
}

///@desc SPAR EFFECT: clears HUM from both sides of the field
function clear_hum_global() {
	if (spar.playerOne.hum) 
	|| (spar.playerTwo.hum) {
		effectedPlayer = BOTH_PLAYERS_EFFECTED;
		spar.playerOne.hum = false;
		spar.playerTwo.hum = false;
	}
}

///@desc SPAR EFFECT: clears rust from both sides of the field
function clear_rust_global() {
	if (spar.playerOne.rust) 
	|| (spar.playerTwo.rust) {
		effectedPlayer = BOTH_PLAYERS_EFFECTED;
		spar.playerOne.rust = false;
		spar.playerTwo.rust = false;
	}	else	ds_list_destroy(effectedSprites);	effectedSprites = -1;	instance_destroy(id);	
}

///@desc SPAR EFFECT: clears the MINDSET of any nearby allies
function clear_mindset_nearby_allies(_target) {
	// store args in locals
	var t = _target;
	
	subject = t.name;
	
	// use a repeat loop to check if any nearbySprites need to have
	// their mindset cleared
	var i = 0;	repeat (ds_list_size(t.nearbyAllies)) {
		var inst = t.nearbyAllies[| i];
		
		if (inst.mindset != 0) {
			ds_list_add(effectedSprites, inst);
			inst.mindset = 0;
		}
		
		i++;
	}
	
	// if no sprites were effected, destroy spar effect alert
	if (ds_list_size(effectedSprites <= 0)) {
		instance_destroy(id);
	}
}

///@desc SPAR EFFECT: clears the MINDSET of any nearby enemies
function clear_mindset_nearby_enemies(_target) {
	// store args in locals
	var t = _target;
	
	subject = t.name;
	
	// use a repeat loop to check if any nearbySprites need to have
	// their mindset cleared
	var i = 0;	repeat (ds_list_size(t.nearbyEnemies)) {
		var inst = t.nearbyEnemies[| i];
		
		if (inst.mindset != 0) {
			ds_list_add(effectedSprites, inst);
			inst.mindset = 0;
		}
		
		i++;
	}
	
	// if no sprites were effected, destroy spar effect alert
	if (ds_list_size(effectedSprites <= 0)) {
		instance_destroy(id);
	}
}

///@desc SPAR EFFECT: clears the MINDSET of any nearby sprites
function clear_mindset_nearby_sprites(_target) {
	// store args in locals
	var t = _target;
	
	subject = t.name;
	
	// use a repeat loop to check if any nearbySprites need to have
	// their mindset cleared
	var i = 0;	repeat (ds_list_size(t.nearbySprites)) {
		var inst = t.nearbySprites[| i];
		
		if (inst.mindset != 0) {
			ds_list_add(effectedSprites, inst);
			inst.mindset = 0;
		}
		
		i++;
	}
	
	// if no sprites were effected, destroy spar effect alert
	if (ds_list_size(effectedSprites <= 0)) {
		instance_destroy(id);
	}
}

///@desc SPAR EFFECT: clears the MINDSET of all sprites on the target team
function clear_mindset_team(_targetPlayer) {
	// store args in locals
	var t = _targetPlayer;
	
	subject = t.name;
	
	// get the correct list based on the target player
	if (t == spar.playerOne)	var list = spar.allyList;
	if (t == spar.playerTwo)	var list = spar.enemyList;
	
	// use a repeat loop to check if any nearbySprites need to have
	// their mindset cleared
	var i = 0;	repeat (ds_list_size(list)) {
		var inst = list[| i];
		
		if (inst.mindset != 0) {
			ds_list_add(effectedSprites, inst);
			inst.mindset = 0;
		}
		
		i++;
	}
	
	// if no sprites were effected, destroy spar effect alert
	if (ds_list_size(effectedSprites <= 0)) {
		instance_destroy(id);
	}
}

///@desc SPAR EFFECT: clears the MINDSET of all sprites on the field
function clear_mindset_global() {
	var i = 0;	repeat (2) {
		
		// get the correct list based on the target player
		if (i)	var list = spar.allyList;
		if !(i)	var list = spar.enemyList;
		
		// use a repeat loop to check if any nearbySprites need to have
		// their mindset cleared
		var j = 0;	repeat (ds_list_size(list)) {
			var inst = list[| j];
			
			if (inst.mindset != 0) {
				ds_list_add(effectedSprites, inst);
				inst.mindset = 0;
			}
			
			j++;
		}	
		
		i++;
	}
	
	effectedPlayer = BOTH_PLAYERS_EFFECTED;
	
	// if no sprites were effected, destroy spar effect alert
	if (ds_list_size(effectedSprites <= 0)) {
		instance_destroy(id);
	}
}

///@desc SPAR EFFECT: grants a MINDSET to all allies near the target
function bestow_mindset_nearby_allies(_target, _mindset) {
	// store args in locals
	var t = _target;
	var m = _mindset;
	
	subject = t.name;
	object = get_mindset_name(m);
	
	// use a repeat loop to check if any nearbySprites need to have
	// their mindset cleared
	var i = 0;	repeat (ds_list_size(t.nearbyAllies)) {
		var inst = t.nearbyAllies[| i];
		
		if (inst.mindset != m) {
			ds_list_add(effectedSprites, inst);
			inst.mindset = m;
		}
		
		i++;
	}
	
	// if no sprites were effected, destroy spar effect alert
	if (ds_list_size(effectedSprites <= 0)) {
		instance_destroy(id);
	}
}

///@desc SPAR EFFECT: grants a MINDSET to all enemies near the target
function bestow_mindset_nearby_enemies(_target, _mindset) {
	// store args in locals
	var t = _target;
	var m = _mindset;
	
	subject = t.name;
	object = get_mindset_name(m);
	
	// use a repeat loop to check if any nearbySprites need to have
	// their mindset cleared
	var i = 0;	repeat (ds_list_size(t.nearbyEnemies)) {
		var inst = t.nearbyEnemies[| i];
		
		if (inst.mindset != m) {
			ds_list_add(effectedSprites, inst);
			inst.mindset = m;
		}
		
		i++;
	}
	
	// if no sprites were effected, destroy spar effect alert
	if (ds_list_size(effectedSprites <= 0)) {
		instance_destroy(id);
	}
}

///@desc SPAR EFFECT: grants a MINDSET to all sprites near the target
function bestow_mindset_nearby_sprites(_target, _mindset) {
	// store args in locals
	var t = _target;
	var m = _mindset;
	
	subject = t.name;
	object = get_mindset_name(m);
	
	// use a repeat loop to check if any nearbySprites need to have
	// their mindset cleared
	var i = 0;	repeat (ds_list_size(t.nearbySprites)) {
		var inst = t.nearbySprites[| i];
		
		if (inst.mindset != m) {
			ds_list_add(effectedSprites, inst);
			inst.mindset = m;
		}
		
		i++;
	}
	
	// if no sprites were effected, destroy spar effect alert
	if (ds_list_size(effectedSprites <= 0)) {
		instance_destroy(id);
	}
}

///@desc SPAR EFFECT: grants a MINDSET to all members of the given team
function bestow_mindset_team(_targetPlayer, _mindset) {	
	// store arguments in local variables
	var t = _targetPlayer;
	var m = _mindset;
	
	subject = t.name;
	object = get_mindset_name(m);
	
	// get the correct list based on the target player
	if (t == spar.playerOne)	var list = spar.allyList;
	if (t == spar.playerTwo)	var list = spar.enemyList;	
	
	// use a repeat loop to grant curse of the warrior to
	// all sprites on the list
	var i = 0;	repeat (ds_list_size(list)) {
		var inst = list[| i];
		
		if (inst.mindset != m) {
			ds_list_add(effectedSprites, inst);
			inst.mindset = m;
		}
		
		i++;
	}
	
	// if no sprites were effected, destroy spar effect alert
	if (ds_list_size(effectedSprites) <= 0) {
		instance_destroy(id);
	}
}

///@desc SPAR EFFECT: grants a MINDSET to all sprites on the field
function bestow_mindset_global(_mindset) {
	var m = _mindset;
	
	object = get_mindset_name(m);
	
	var i = 0;	repeat (2) {
	
		// get the correct list based on i
		if (i)	var list = spar.allyList;
		if !(i)	var list = spar.enemyList;
		
		// use a repeat loop to grant curse of the warrior to
		// all sprites on the list
		var j = 0;	repeat (ds_list_size(list)) {
			var inst = list[| j];
			
			if (inst.mindset != m) {
				ds_list_add(effectedSprites, inst);
				inst.mindset = m;
			}
			
			j++;
		}
		
		i++;
	}
	
	// if no sprites were effected, destroy spar effect alert
	if (ds_list_size(effectedSprites <= 0)) {
		instance_destroy(id);
	}
}

///@desc SPAR EFFECT: shifts the MINDSET of all target's nearby allies
function shift_mindset_nearby_allies(_target) {
	// store args in locals
	var t = _target;
	
	subject = t.name;
	
	// use a repeat loop to check if any nearbySprites need to have
	// their mindset cleared
	var i = 0;	repeat (ds_list_size(t.nearbyAllies)) {
		var inst = t.nearbyAllies[| i];
		
		// initialize new mindset
		var nm = -1;
		
		// check if the mindset is a curse
		if (inst.mindset > MINDSETS.IMP_BLESS) {
			// set the new mindset
			nm = inst.mindset - 4;
		}
		// if the mindset is a blessing
		else {
			if (inst.mindset > MINDSETS.NORMAL) {
				// set the new mindset
				nm = inst.mindset + 4;
			}
		}
		
		// check if new mindset was set
		if (nm > 0) {
			inst.mindset = nm;	
		}
		
		i++;
	}
	
	// if no sprites were effected, destroy spar effect alert
	if (ds_list_size(effectedSprites <= 0)) {
		instance_destroy(id);
	}
}

///@desc SPAR EFFECT: shifts the MINDSET of all target's nearby enemies
function shift_mindset_nearby_enemies(_target) {
	// store args in locals
	var t = _target;
	
	subject = t.name;
	
	// use a repeat loop to check if any nearbySprites need to have
	// their mindset cleared
	var i = 0;	repeat (ds_list_size(t.nearbyEnemies)) {
		var inst = t.nearbyEnemies[| i];
		
		// initialize new mindset
		var nm = -1;
		
		// check if the mindset is a curse
		if (inst.mindset > MINDSETS.IMP_BLESS) {
			// set the new mindset
			nm = inst.mindset - 4;
		}
		// if the mindset is a blessing
		else {
			if (inst.mindset > MINDSETS.NORMAL) {
				// set the new mindset
				nm = inst.mindset + 4;
			}
		}
		
		// check if new mindset was set
		if (nm > 0) {
			inst.mindset = nm;	
		}
		
		i++;
	}
	
	// if no sprites were effected, destroy spar effect alert
	if (ds_list_size(effectedSprites <= 0)) {
		ds_list_destroy(effectedSprites);
		effectedSprites = -1;
		instance_destroy(id);
	}
}

///@desc SPAR EFFECT: shifts the MINDSET of all target's nearby sprites
function shift_mindset_nearby_sprites(_target) {
	// store args in locals
	var t = _target;
	
	subject = t.name;
	
	// use a repeat loop to check if any nearbySprites need to have
	// their mindset cleared
	var i = 0;	repeat (ds_list_size(t.nearbySprites)) {
		var inst = t.nearbySprites[| i];
		
		// initialize new mindset
		var nm = -1;
		
		// check if the mindset is a curse
		if (inst.mindset > MINDSETS.IMP_BLESS) {
			// set the new mindset
			nm = inst.mindset - 4;
		}
		// if the mindset is a blessing
		else {
			if (inst.mindset > MINDSETS.NORMAL) {
				// set the new mindset
				nm = inst.mindset + 4;
			}
		}
		
		// check if new mindset was set
		if (nm > 0) {
			inst.mindset = nm;	
		}
		
		i++;
	}
	
	// if no sprites were effected, destroy spar effect alert
	if (ds_list_size(effectedSprites <= 0)) {
		instance_destroy(id);
	}
}

///@desc SPAR EFFECT: shifts the MINDSET of all sprites on the target team
function shift_mindset_team(_targetPlayer) {
	// store arguments in local variables
	var t = _targetPlayer;
	
	subject = t.name;
	
	// get the correct list based on the target player
	if (t == spar.playerOne)	var list = spar.allyList;
	if (t == spar.playerTwo)	var list = spar.enemyList;	
	
	// use a repeat loop to grant curse of the warrior to
	// all sprites on the list
	var i = 0;	repeat (ds_list_size(list)) {
		var inst = list[| i];
		
		// initialize new mindset
		var nm = -1;
		
		// check if the mindset is a curse
		if (inst.mindset > MINDSETS.IMP_BLESS) {
			// set the new mindset
			nm = inst.mindset - 4;
		}
		// if the mindset is a blessing
		else {
			if (inst.mindset > MINDSETS.NORMAL) {
				// set the new mindset
				nm = inst.mindset + 4;
			}
		}
		
		// check if new mindset was set
		if (nm > 0) {
			inst.mindset = nm;	
		}

		i++;
	}
	
	// if no sprites were effected, destroy spar effect alert
	if (ds_list_size(effectedSprites <= 0)) {
		instance_destroy(id);
	}
}

///@desc SPAR EFFECT: shifts the MINDSET of all sprites on the field
function shift_mindset_global() {	
	var i = 0;	repeat (2) {
		
		// get the correct list based on the target player
		if (i)	var list = spar.allyList;
		if !(i)	var list = spar.enemyList;
		
		// use a repeat loop to check if any nearbySprites need to have
		// their mindset cleared
		var j = 0;	repeat (ds_list_size(list)) {
			var inst = list[| j];
			
			// initialize new mindset
			var nm = -1;
			
			// check if the mindset is a curse
			if (inst.mindset > MINDSETS.IMP_BLESS) {
				// set the new mindset
				nm = inst.mindset - 4;
			}
			// if the mindset is a blessing
			else {
				if (inst.mindset > MINDSETS.NORMAL) {
					// set the new mindset
					nm = inst.mindset + 4;
				}
			}
			
			// check if new mindset was set
			if (nm > 0) {
				inst.mindset = nm;	
			}
			
			j++;
		}	
		
		i++;
	}
	
	// if no sprites were effected, destroy spar effect alert
	if (ds_list_size(effectedSprites <= 0)) {
		instance_destroy(id);
	}
}

///@desc SPAR EFFECT: shifts CURSE to BLESSING for target
function shift_curse(_target) {
	var t = _target;
	
	ds_list_add(effectedSprites, t);
	subject = t.name;
	
	// check if the mindset is a curse
	if (t.mindset > MINDSETS.IMP_BLESS) {
		// shift the mindset to a blessing
		t.mindset -= 4;
	}	else	{
		instance_destroy(id);
	}
}

///@desc SPAR EFFECT: shifts BLESSING to CURSE for target
function shift_blessing(_target) {
	var t = _target;
	
	ds_list_add(effectedSprites, t);
	subject = t.name;
	
	// check if the mindset is a blessing
	if (t.mindset > MINDSETS.NORMAL) 
	&& (t.mindset < MINDSETS.TREE_CURSE) {
		// shift the mindset to a curse
		t.mindset += 4;
	}	else	ds_list_destroy(effectedSprites);	effectedSprites = -1;	instance_destroy(id);	
}

///@desc SPAR EFFECT: shifts CURSE to BLESSING for target's nearby allies
function shift_curse_nearby_allies(_target) {
	// store args in locals
	var t = _target;
	
	subject = t.name;
	
	// use a repeat loop to check if any nearbySprites need to have
	// their mindset cleared
	var i = 0;	repeat (ds_list_size(t.nearbyAllies)) {
		var inst = t.nearbyAllies[| i];
		
		// check if the mindset is a curse
		if (t.mindset > MINDSETS.IMP_BLESS) {
			// add this sprite to the effected sprites list
			ds_list_add(effectedSprites, inst);
			
			// shift the mindset to a blessing
			t.mindset -= 4;
		}
		
		i++;
	}
	
	// if no sprites were effected, destroy spar effect alert
	if (ds_list_size(effectedSprites <= 0)) {
		instance_destroy(id);
	}
}

///@desc SPAR EFFECT: shifts CURSE to BLESSING for target's nearby enemies
function shift_curse_nearby_enemies(_target) {
	// store args in locals
	var t = _target;
	
	subject = t.name;
	
	// use a repeat loop to check if any nearbySprites need to have
	// their mindset cleared
	var i = 0;	repeat (ds_list_size(t.nearbyEnemies)) {
		var inst = t.nearbyEnemies[| i];
		
		// check if the mindset is a curse
		if (t.mindset > MINDSETS.IMP_BLESS) {
			// add this sprite to the effected sprites list
			ds_list_add(effectedSprites, inst);
			
			// shift the mindset to a blessing
			t.mindset -= 4;
		}
		
		i++;
	}
	
	// if no sprites were effected, destroy spar effect alert
	if (ds_list_size(effectedSprites <= 0)) {
		instance_destroy(id);
	}
}

///@desc SPAR EFFECT: shifts CURSE to BLESSING for target's nearby sprites
function shift_curse_nearby_sprites(_target) {
	// store args in locals
	var t = _target;
	
	subject = t.name;
	
	// use a repeat loop to check if any nearbySprites need to have
	// their mindset cleared
	var i = 0;	repeat (ds_list_size(t.nearbySprites)) {
		var inst = t.nearbySprites[| i];
		
		// check if the mindset is a curse
		if (t.mindset > MINDSETS.IMP_BLESS) {
			// add this sprite to the effected sprites list
			ds_list_add(effectedSprites, inst);
			
			// shift the mindset to a blessing
			t.mindset -= 4;
		}
		
		i++;
	}
	
	// if no sprites were effected, destroy spar effect alert
	if (ds_list_size(effectedSprites <= 0)) {
		instance_destroy(id);
	}
}

///@desc SPAR EFFECT: shifts CURSE to BLESSING for all sprites on target team
function shift_curse_team(_targetPlayer) {
	// store arguments in local variables
	var t = _targetPlayer;
	
	subject = t.name;
	
	// get the correct list based on the target player
	if (t == spar.playerOne)	var list = spar.allyList;
	if (t == spar.playerTwo)	var list = spar.enemyList;	
	
	// use a repeat loop to grant curse of the warrior to
	// all sprites on the list
	var i = 0;	repeat (ds_list_size(list)) {
		var inst = list[| i];
		
		// check if the mindset is a curse
		if (inst.mindset > MINDSETS.IMP_BLESS) {
			// add this sprite to the effected sprites list
			ds_list_add(effectedSprites, inst);
			
			// shift the mindset to a blessing
			inst.mindset -= 4;
		}
		
		i++;
	}
	
	// if no sprites were effected, destroy spar effect alert
	if (ds_list_size(effectedSprites <= 0)) {
		instance_destroy(id);
	}
}

///@desc SPAR EFFECT: shifts CURSE to BLESSING for all sprites on the field
function shift_curse_global() {	
	var i = 0;	repeat (2) {
		
		// get the correct list based on the target player
		if (i)	var list = spar.allyList;
		if !(i)	var list = spar.enemyList;
		
		// use a repeat loop to check if any nearbySprites need to have
		// their mindset cleared
		var j = 0;	repeat (ds_list_size(list)) {
			var inst = list[| j];
			
			// check if the mindset is a curse
			if (inst.mindset > MINDSETS.IMP_BLESS) {
				// add this sprite to the effected sprites list
				ds_list_add(effectedSprites, inst);
				
				// shift the mindset to a blessing
				inst.mindset -= 4;
			}
			
			j++;
		}	
		
		i++;
	}
	
	// if no sprites were effected, destroy spar effect alert
	if (ds_list_size(effectedSprites <= 0)) {
		instance_destroy(id);
	}	
}

///@desc SPAR EFFECT: shifts BLESSING to CURSE for target's nearby allies
function shift_blessing_nearby_allies(_target) {
	// store args in locals
	var t = _target;
	
	subject = t.name;
	
	// use a repeat loop to check if any nearbySprites need to have
	// their mindset cleared
	var i = 0;	repeat (ds_list_size(t.nearbyAllies)) {
		var inst = t.nearbyAllies[| i];
		
		// check if the mindset is a blessing
		if (inst.mindset > MINDSETS.NORMAL) 
		&& (inst.mindset < MINDSETS.TREE_CURSE) {
			// add this sprite to the effected sprites list
			ds_list_add(effectedSprites, inst);
			
			// shift the mindset to a curse
			inst.mindset += 4;
		}
		
		i++;
	}
	
	// if no sprites were effected, destroy spar effect alert
	if (ds_list_size(effectedSprites <= 0)) {
		instance_destroy(id);
	}
}

///@desc SPAR EFFECT: shifts BLESSING to CURSE for target's nearby enemies
function shift_blessing_nearby_enemies(_target) {
	// store args in locals
	var t = _target;
	
	subject = t.name;
	
	// use a repeat loop to check if any nearbySprites need to have
	// their mindset cleared
	var i = 0;	repeat (ds_list_size(t.nearbyEnemies)) {
		var inst = t.nearbyEnemies[| i];
		
		// check if the mindset is a blessing
		if (inst.mindset > MINDSETS.NORMAL) 
		&& (inst.mindset < MINDSETS.TREE_CURSE) {
			// add this sprite to the effected sprites list
			ds_list_add(effectedSprites, inst);
			
			// shift the mindset to a curse
			inst.mindset += 4;
		}
		
		i++;
	}
	
	// if no sprites were effected, destroy spar effect alert
	if (ds_list_size(effectedSprites <= 0)) {
		instance_destroy(id);
	}
}

///@desc SPAR EFFECT: shifts BLESSING to CURSE for target's nearby sprites
function shift_blessing_nearby_sprites(_target) {
	// store args in locals
	var t = _target;
	
	subject = t.name;
	
	// use a repeat loop to check if any nearbySprites need to have
	// their mindset cleared
	var i = 0;	repeat (ds_list_size(t.nearbySprites)) {
		var inst = t.nearbySprites[| i];
		
		// check if the mindset is a blessing
		if (inst.mindset > MINDSETS.NORMAL) 
		&& (inst.mindset < MINDSETS.TREE_CURSE) {
			// add this sprite to the effected sprites list
			ds_list_add(effectedSprites, inst);
			
			// shift the mindset to a curse
			inst.mindset += 4;
		}
		
		i++;
	}
	
	// if no sprites were effected, destroy spar effect alert
	if (ds_list_size(effectedSprites <= 0)) {
		instance_destroy(id);
	}
}

///@desc SPAR EFFECT: shifts BLESSING to CURSE for all sprites on target team
function shift_blessing_team(_targetPlayer) {
	// store arguments in local variables
	var t = _targetPlayer;
	
	subject = t.name;
	
	// get the correct list based on the target player
	if (t == spar.playerOne)	var list = spar.allyList;
	if (t == spar.playerTwo)	var list = spar.enemyList;	
	
	// use a repeat loop to grant curse of the warrior to
	// all sprites on the list
	var i = 0;	repeat (ds_list_size(list)) {
		var inst = list[| i];
		
		// check if the mindset is a blessing
		if (inst.mindset > MINDSETS.NORMAL) 
		&& (inst.mindset < MINDSETS.TREE_CURSE) {
			// add this sprite to the effected sprites list
			ds_list_add(effectedSprites, inst);
			
			// shift the mindset to a curse
			inst.mindset += 4;
		}
		
		i++;
	}
	
	// if no sprites were effected, destroy spar effect alert
	if (ds_list_size(effectedSprites <= 0)) {
		instance_destroy(id);
	}
}

///@desc SPAR EFFECT: shifts BLESSING to CURSE for all sprites on the field
function shift_blessing_global() {
	var i = 0;	repeat (2) {
		
		// get the correct list based on the target player
		if (i)	var list = spar.allyList;
		if !(i)	var list = spar.enemyList;
		
		// use a repeat loop to check if any nearbySprites need to have
		// their mindset cleared
		var j = 0;	repeat (ds_list_size(list)) {
			var inst = list[| j];
			
			// check if the mindset is a blessing
			if (inst.mindset > MINDSETS.NORMAL) 
			&& (inst.mindset < MINDSETS.TREE_CURSE) {
				// add this sprite to the effected sprites list
				ds_list_add(effectedSprites, inst);
				
				// shift the mindset to a curse
				inst.mindset += 4;
			}
			
			j++;
		}	
		
		i++;
	}
	
	// if no sprites were effected, destroy spar effect alert
	if (ds_list_size(effectedSprites <= 0)) {
		instance_destroy(id);
	}	
}

///@desc SPAR EFFECT: set HEXED to true for all target's nearby allies
function set_hexed_nearby_allies(_target) {
	// store args in locals
	var t = _target;
	
	subject = t.name;
	
	// use a repeat loop to check if any nearbySprites need to have
	// their mindset cleared
	var i = 0;	repeat (ds_list_size(t.nearbyAllies)) {
		var inst = t.nearbyAllies[| i];
		
		if !(inst.hexed) {
			if !(spar_check_invulnerable(inst)) {
				if !(spar_check_berserk(inst))	{
					ds_list_add(effectedSprites, inst);
					inst.hexed = true;
					inst.hexedCounter = 1;
				}
			}
		}
		
		i++;
	}
	
	// if no sprites were effected, destroy spar effect alert
	if (ds_list_size(effectedSprites <= 0)) {
		instance_destroy(id);
	}
}

///@desc SPAR EFFECT: set HEXED to true for all target's nearby enemies
function set_hexed_nearby_enemies(_target) {
	// store args in locals
	var t = _target;
	
	subject = t.name;
	
	// use a repeat loop to check if any nearbySprites need to have
	// their mindset cleared
	var i = 0;	repeat (ds_list_size(t.nearbyEnemies)) {
		var inst = t.nearbyEnemies[| i];
		
		if !(inst.hexed) {
			if !(spar_check_invulnerable(inst)) {
				if !(spar_check_berserk(inst))	{
					ds_list_add(effectedSprites, inst);
					inst.hexed = true;
					inst.hexedCounter = 1;
				}
			}
		}
		
		i++;
	}
	
	// if no sprites were effected, destroy spar effect alert
	if (ds_list_size(effectedSprites <= 0)) {
		instance_destroy(id);
	}
}

///@desc SPAR EFFECT: set HEXED to true for all target's nearby sprites
function set_hexed_nearby_sprites(_target) {
	// store args in locals
	var t = _target;
	
	subject = t.name;
	
	// use a repeat loop to check if any nearbySprites need to have
	// their mindset cleared
	var i = 0;	repeat (ds_list_size(t.nearbySprites)) {
		var inst = t.nearbySprites[| i];
		
		if !(inst.hexed) {
			if !(spar_check_invulnerable(inst)) {
				if !(spar_check_berserk(inst))	{
					ds_list_add(effectedSprites, inst);
					inst.hexed = true;
					inst.hexedCounter = 1;
				}
			}
		}
		
		i++;
	}
	
	// if no sprites were effected, destroy spar effect alert
	if (ds_list_size(effectedSprites <= 0)) {
		instance_destroy(id);
	}
}

///@desc SPAR EFFECT: set HEXED to true for all sprites on target team
function set_hexed_team(_targetPlayer) {
	// store arguments in local variables
	var t = _targetPlayer;
	
	subject = t.name;
	
	// get the correct list based on the target player
	if (t == spar.playerOne)	var list = spar.allyList;
	if (t == spar.playerTwo)	var list = spar.enemyList;	
	
	// use a repeat loop to check if any nearbySprites need to have
	// their mindset cleared
	var i = 0;	repeat (ds_list_size(list)) {
		var inst = list[| i];
		
		if !(inst.hexed) {
			if !(spar_check_invulnerable(inst)) {
				if !(spar_check_berserk(inst))	{
					ds_list_add(effectedSprites, inst);
					inst.hexed = true;
					inst.hexedCounter = 1;
				}
			}
		}
		
		i++;
	}
	
	// if no sprites were effected, destroy spar effect alert
	if (ds_list_size(effectedSprites <= 0)) {
		instance_destroy(id);
	}
}

///@desc SPAR EFFECT: set HEXED to true for all sprites on the field
function set_hexed_global() {
	var i = 0;	repeat (2) {
		
		// get the correct list based on the target player
		if (i)	var list = spar.allyList;
		if !(i)	var list = spar.enemyList;
		
		// use a repeat loop to check if any nearbySprites need to have
		// their mindset cleared
		var j = 0;	repeat (ds_list_size(list)) {
			var inst = list[| j];
			
			if !(inst.hexed) {
				if !(spar_check_invulnerable(inst)) {
					if !(spar_check_berserk(inst))	{
						ds_list_add(effectedSprites, inst);
						inst.hexed = true;
						inst.hexedCounter = 1;
					}
				}
			}
			j++;
		}
		i++;
	}
	
	// if no sprites were effected, destroy spar effect alert
	if (ds_list_size(effectedSprites <= 0)) {
		instance_destroy(id);
	}	
}

///@desc SPAR EFFECT: set BOUND to true for all target's nearby allies
function set_bound_nearby_allies(_target) {
	// store args in locals
	var t = _target;
	
	subject = t.name;
	
	// use a repeat loop to check if any nearbySprites need to have
	// their mindset cleared
	var i = 0;	repeat (ds_list_size(t.nearbyAllies[|i])) {
		var inst = t.nearbyAllies[| i];

		if !(inst.bound) {
			if !(spar_check_invulnerable(inst)) {
				if !(spar_check_berserk(inst))	{
					ds_list_add(effectedSprites, inst);
					inst.bound = true;
					inst.boundCounter = 1;
				}
			}
		}
		
		i++;
	}
	
	// if no sprites were effected, destroy spar effect alert
	if (ds_list_size(effectedSprites <= 0)) {
		instance_destroy(id);
	}
}

///@desc SPAR EFFECT: set BOUND to true for all target's nearby enemies
function set_bound_nearby_enemies(_target) {
	// store args in locals
	var t = _target;
	
	subject = t.name;
	
	// use a repeat loop to check if any nearbySprites need to have
	// their mindset cleared
	var i = 0;	repeat (ds_list_size(t.nearbyEnemies[|i])) {
		var inst = t.nearbyEnemies[| i];
		
		if !(inst.bound) {
			if !(spar_check_invulnerable(inst)) {
				if !(spar_check_berserk(inst))	{
					ds_list_add(effectedSprites, inst);
					inst.bound = true;
					inst.boundCounter = 1;
				}
			}
		}
		
		i++;
	}
	
	// if no sprites were effected, destroy spar effect alert
	if (ds_list_size(effectedSprites <= 0)) {
		instance_destroy(id);
	}
}

///@desc SPAR EFFECT: set BOUND to true for all target's nearby sprites
function set_bound_nearby_sprites(_target) {
	// store args in locals
	var t = _target;
	
	subject = t.name;
	
	// use a repeat loop to check if any nearbySprites need to have
	// their mindset cleared
	var i = 0;	repeat (ds_list_size(t.nearbySprites)) {
		var inst = t.nearbySprites[| i];
		
		if !(inst.bound) {
			if !(spar_check_invulnerable(inst)) {
				if !(spar_check_berserk(inst))	{
					ds_list_add(effectedSprites, inst);
					inst.bound = true;
					inst.boundCounter = 1;
				}
			}
		}
		
		i++;
	}
	
	// if no sprites were effected, destroy spar effect alert
	if (ds_list_size(effectedSprites <= 0)) {
		instance_destroy(id);
	}
}

///@desc SPAR EFFECT: set BOUND to true for all sprites on target team
function set_bound_team(_targetPlayer) {
	// store arguments in local variables
	var t = _targetPlayer;
	
	subject = t.name;
	
	// get the correct list based on the target player
	if (t == spar.playerOne)	var list = spar.allyList;
	if (t == spar.playerTwo)	var list = spar.enemyList;	
	
	// use a repeat loop to check if any nearbySprites need to have
	// their mindset cleared
	var i = 0;	repeat (ds_list_size(list)) {
		var inst = list[| i];
		
		if !(inst.bound) {
			if !(spar_check_invulnerable(inst)) {
				if !(spar_check_berserk(inst))	{
					ds_list_add(effectedSprites, inst);
					inst.bound = true;
					inst.boundCounter = 1;
				}
			}
		}
		
		i++;
	}
	
	// if no sprites were effected, destroy spar effect alert
	if (ds_list_size(effectedSprites <= 0)) {
		instance_destroy(id);
	}
}

///@desc SPAR EFFECT: set BOUND to true for all sprites on the field
function set_bound_global() {
	var i = 0;	repeat (2) {
		
		// get the correct list based on the target player
		if (i)	var list = spar.allyList;
		if !(i)	var list = spar.enemyList;
		
		// use a repeat loop to check if any nearbySprites need to have
		// their mindset cleared
		var j = 0;	repeat (ds_list_size(list[|j])) {
			var inst = list[| j];
			
			if !(inst.bound) {
				if !(spar_check_invulnerable(inst)) {
					if !(spar_check_berserk(inst))	{
						ds_list_add(effectedSprites, inst);
						inst.bound = true;
						inst.boundCounter = 1;
					}
				}
			}
			
			j++;
		}	
		i++;
	}
	
	// if no sprites were effected, destroy spar effect alert
	if (ds_list_size(effectedSprites <= 0)) {
		instance_destroy(id);
	}	
}

///@desc SPAR EFFECT: this effect is simply here as a way of notifying the player
/// that they are HEXED and cannot cast spells
function apply_hexed(_effectedSprite) {
	var t = _effectedSprite;
	
	ds_list_add(effectedSprites, t);
	subject = t.name;
}

///@desc SPAR EFFECT: this effect is simply here as a way of notifying the player
/// that they are BOUND and cannot swap
function apply_bound(_effectedSprite) {
	var t = _effectedSprite;
	
	ds_list_add(effectedSprites, t);
	subject = t.name;
}

///@desc SPAR EFFECT: apply damage from an ENERGY BLAST to both players
function energy_blast_global(_damage) {
	var d = _damage;
	
	deplete_hp(spar.playerOne, d);
	deplete_hp(spar.playerTwo, d);
	
	effectedPlayer = BOTH_PLAYERS_EFFECTED;
}

///@desc SPAR EFFECT: this effect simply declares that the given sprite dealt extra damage
function increase_damage(_activeSprite) {
	var c = _activeSprite;
	
	subject = c.name;
}

///@desc SPAR EFFECT: this effect simply declares that the given sprite took decreased damage
function decrease_damage(_targetSprite) {
	var t = _targetSprite;
	
	subject = t.name;
}

///@desc SPAR EFFECT: this effect is simply here as a way of notifying the player
/// that the damage was altered after the fact
function increase_damage_natural(_activeSprite) {
	var c = _activeSprite;
	
	subject = c.name;
}

///@desc SPAR EFFECT: this effect is simply here as a way of notifying the player
/// that the damage was altered after the fact
function decrease_damage_natural(_activeSprite) {
	var c = _activeSprite;
	
	subject = c.name;
}

///@desc SPAR EFFECT: this effect is simply here as a way of notifying the player
/// that the damage was altered after the fact
function increase_damage_mechanical(_activeSprite) {
	var c = _activeSprite;
	
	subject = c.name;	
}

///@desc SPAR EFFECT: this effect is simply here as a way of notifying the player
/// that the damage was altered after the fact
function decrease_damage_mechanical(_activeSprite) {
	var c = _activeSprite;
	
	subject = c.name;	
}

///@desc SPAR EFFECT: this effect is simply here as a way of notifying the player
/// that the damage was altered after the fact
function increase_damage_astral(_activeSprite) {
	var c = _activeSprite;
	
	subject = c.name;	
}

///@desc SPAR EFFECT: this effect is simply here as a way of notifying the player
/// that the damage was altered after the fact
function decrease_damage_astral(_activeSprite) {
	var c = _activeSprite;
	
	subject = c.name;	
}

///@desc SPAR EFFECT: this effect is simply here as a way of notifying the player
/// that the damage was altered after the fact
function volcano_water_decrease_damage() {
	
}

///@desc SPAR EFFECT: this effect is simply here as a way of notifying the player
/// that the damage was altered after the fact
function volcano_fire_increase_damage() {
}
	
///@desc SPAR EFFECT: this effect is simply here as a way of notifying the player
/// that the damage was altered after the fact
function ocean_fire_decrease_damage() {	
}

///@desc SPAR EFFECT: this effect is simply here as a way of notifying the player
/// that the damage was altered after the fact
function ocean_storm_increase_damage() {
	
}

///@desc SPAR EFFECT: this effect is simply here as a way of notifying the player
/// that the damage was altered after the fact
function ocean_water_increase_damage() {
	
}

///@desc SPAR EFFECT: this effect is simply here as a way of notifying the player
/// that the damage was altered after the fact
function stratos_earth_decrease_damage() {
	
}

///@desc SPAR EFFECT: this effect is simply here as a way of notifying the player
/// that the damage was altered after the fact
function stratos_storm_increase_damage() {
	
}

///@desc SPAR EFFECT: this effect is simply here as a way of notifying the player
/// that the damage was altered after the fact
function forest_fire_increase_damage() {
	
}

///@desc SPAR EFFECT: this effect is simply here as a way of notifying the player
/// that the damage was altered after the fact
function forest_earth_increase_damage() {
	
}

///@desc SPAR EFFECT: change the arena back to normal. This has to exist along with
/// the arena_change_normal effect, because they trigger different effects/abilities
function destroy_arena() {
	if (spar.currentArena != -1) {
		spar.newArena = -1;	
		spar.image_index = 0;
		spar.image_speed = 0;
	}	else	ds_list_destroy(effectedSprites);	effectedSprites = -1;	instance_destroy(id);	
}

///@desc SPAR EFFECT: this is simply a "restore health" function but the verbiage is
/// different and it triggers different effects/abilities
function drain_health(_receivingTeam, _amount) {
	var t = _receivingTeam;
	var a = round(_amount);
	
	effectedPlayer = t;
	subject = t.name;
	
	var hpNeeded = MAX_HP - t.currentHP;
	
	if (a >= hpNeeded)	t.currentHP = MAX_HP;
	else				t.currentHP += a;
}

///@desc SPAR EFFECT: this is simply a "restore magic" function but the verbiage is
/// different and it triggers different effects/abilities
function drain_magic(_receivingTeam, _amount) {
	var t = _receivingTeam;
	var a = round(_amount);
	
	effectedPlayer = t;
	subject = t.name;
	
	var mpNeeded = MAX_MP - t.currentMP;
	
	if (a >= mpNeeded)	t.currentMP = MAX_MP;
	else				t.currentMP += a;
}

///@desc SPAR EFFECT: search the target column of the turn grid for the target of this
/// spell. When found, replace the target's ID with the caster's
function replace_target(_caster, _target) {
	var c = _caster;
	var t = _target;
	
	ds_list_add(effectedSprites, c, t);
	subject = c.name;
	object = t.name;
	
	var i = 0;	repeat (ds_grid_height(spar.turnGrid)) {
		var _ID = spar.turnGrid[# TURN_GRID.TARGET, i];
		
		if (_ID == t.spotNum) {
			spar.turnGrid[# TURN_GRID.TARGET, i] = c.spotNum;
		}
		
		i++;
	}
}

///@desc SPAR EFFECT: set ballLightningActive to true for the casting sprite
function ball_lightning_set_active(_caster, _target) {
	var c = _caster;
	var t = _target;
	
	ds_list_add(effectedSprites, c);
	subject = c.name;
	
	c.ballLightningActive = true;
	c.ballLightningCount = 1;
	c.ballLightningTarget = t;
}

///@desc SPAR EFFECT: increase ballLightningCount for the ball lightning sprite
function ball_lightning_absorb_spell(_blSprite) {
	var c = _blSprite;
	
	// force the spell to fail
	sparActionProcessor.spellFailed = true;
	
	ds_list_add(effectedSprites, c);
	subject = c.name;
	
	c.ballLightningCount += 1;
}

///@desc SPAR EFFECT: apply the damage from the ball lightning
function ball_lightning_apply_damage(_atkr, _targ, _spellPower) {
	var c = _atkr;
	var t = _targ;
	var sp = _spellPower;
	
	ds_list_add(effectedSprites, t);
	subject = c.name;
	object = t.name;
	
	c.ballLightningActive = false;
	
	// calculate damage
	var d = get_elemental_damage(t, c, elements.storm, sp);
	
	// apply damage
	deplete_hp(t.team, d);
}

///@desc SPAR EFFECT: set blackHoleActive to true for the casting sprite
function black_hole_set_active(_caster, _target) {
	var c = _caster;
	var t = _target;
	
	ds_list_add(effectedSprites, c);
	subject = c.name;
	
	c.blackHoleActive = true;
	c.blackHoleCount = 1;
}

///@desc SPAR EFFECT: increase blackHoleCount for the black hole sprite
function black_hole_absorb_spell(_bhSprite) {
	var c = _bhSprite;
	
	// force the spell to fail
	sparActionProcessor.spellFailed = true;
	
	ds_list_add(effectedSprites, c);
	subject = c.name;
	
	c.blackHoleCount += 1;
}

///@desc SPAR EFFECT: apply the damage from the black hole
function black_hole_apply_damage(_atkr, _targ, _spellPower) {
	var c = _atkr;
	var t = _targ;
	var sp = _spellPower;
	
	ds_list_add(effectedSprites, c);
	subject = c.name;
	object = t.name;
	
	c.blackHoleActive = false;
	
	// apply damage
	deplete_hp(t, sp);
}

///@desc SPAR EFFECT: apply recoil damage to the player
function apply_self_damage(_targetPlayer, _amount) {
	var t = _targetPlayer;
	var a = _amount;
	
	effectedPlayer = t;
	subject = t.name;
	
	deplete_hp(t, a);
}

///@desc SPAR EFFECT: set BERSERK to true for the target
function set_berserk(_target) {
	var t = _target;
	
	if !(t.berserk) {
		ds_list_add(effectedSprites, t);
		subject = t.name;
		t.berserk = true;
	}	else	t.berserkCounter = 0;
}

///@desc SPAR EFFECT: set BERSERK to true for all the target's nearby allies
function set_berserk_nearby_allies(_target) {
	// store args in locals
	var t = _target;
	
	subject = t.name;
	
	// use a repeat loop to check if any nearbySprites need to have
	// their mindset cleared
	var i = 0;	repeat (ds_list_size(t.nearbyAllies)) {
		var inst = t.nearbyAllies[| i];
		
		// check if berserk or invulnerable
		if !(inst.berserk) {
			if !(spar_check_invulnerable(inst)) {
				// if other statuses present, reset them
				if (inst.bound)		inst.bound = false;
				if (inst.hexed)		inst.hexed = false;
				
				// set berserk and berserkCounter
				inst.berserk = true;
				inst.berserkCounter = 1;
				
				// add sprite ID to effectedSprites
				ds_list_add(effectedSprites, inst);
			}
			// if already berserk
		}	else	{
			inst.berserkCounter = 1;
			
			// add sprite ID to effectedSprites
			ds_list_add(effectedSprites, inst);
		}
		
		i++;
	}
	
	// if no sprites were effected, destroy spar effect alert
	if (ds_list_size(effectedSprites <= 0)) {
		instance_destroy(id);
	}
}

///@desc SPAR EFFECT: set BERSERK to true for all the target's nearby enemies
function set_berserk_nearby_enemies(_target) {
	// store args in locals
	var t = _target;
	
	subject = t.name;
	
	// use a repeat loop to check if any nearbySprites need to have
	// their mindset cleared
	var i = 0;	repeat (ds_list_size(t.nearbyEnemies)) {
		var inst = t.nearbyEnemies[| i];
		
		// check if berserk or invulnerable
		if !(inst.berserk) {
			if !(spar_check_invulnerable(inst)) {
				// if other statuses present, reset them
				if (inst.bound)		inst.bound = false;
				if (inst.hexed)		inst.hexed = false;
				
				// set berserk and berserkCounter
				inst.berserk = true;
				inst.berserkCounter = 1;
				
				// add sprite ID to effectedSprites
				ds_list_add(effectedSprites, inst);
			}
			// if already berserk
		}	else	{
			inst.berserkCounter = 1;
			
			// add sprite ID to effectedSprites
			ds_list_add(effectedSprites, inst);
		}
		
		i++;
	}
	
	// if no sprites were effected, destroy spar effect alert
	if (ds_list_size(effectedSprites <= 0)) {
		instance_destroy(id);
	}
}

///@desc SPAR EFFECT: set BERSERK to true for all the target's nearby sprites
function set_berserk_nearby_sprites(_target) {
	// store args in locals
	var t = _target;
	
	subject = t.name;
	
	// use a repeat loop to check if any nearbySprites need to have
	// their mindset cleared
	var i = 0;	repeat (ds_list_size(t.nearbySprites)) {
		var inst = t.nearbySprites[| i];
		
		// check if berserk or invulnerable
		if !(inst.berserk) {
			if !(spar_check_invulnerable(inst)) {
				// if other statuses present, reset them
				if (inst.bound)		inst.bound = false;
				if (inst.hexed)		inst.hexed = false;
				
				// set berserk and berserkCounter
				inst.berserk = true;
				inst.berserkCounter = 1;
				
				// add sprite ID to effectedSprites
				ds_list_add(effectedSprites, inst);
			}
			// if already berserk
		}	else	{
			inst.berserkCounter = 1;
			
			// add sprite ID to effectedSprites
			ds_list_add(effectedSprites, inst);
		}
		
		i++;
	}
	
	// if no sprites were effected, destroy spar effect alert
	if (ds_list_size(effectedSprites <= 0)) {
		instance_destroy(id);
	}
}
	
///@desc SPAR EFFECT: set BERSERK to true for all sprites on the target team
function set_berserk_team(_targetPlayer) {
	// store arguments in local variables
	var t = _targetPlayer;
	
	subject = t.name;
	
	// get the correct list based on the target player
	if (t == spar.playerOne)	var list = spar.allyList;
	if (t == spar.playerTwo)	var list = spar.enemyList;	
	
	// use a repeat loop to check if any nearbySprites need to have
	// their mindset cleared
	var i = 0;	repeat (ds_list_size(list)) {
		var inst = list[| i];
		
		// check if berserk or invulnerable
		if !(inst.berserk) {
			if !(spar_check_invulnerable(inst)) {
				// if other statuses present, reset them
				if (inst.bound)		inst.bound = false;
				if (inst.hexed)		inst.hexed = false;
				
				// set berserk and berserkCounter
				inst.berserk = true;
				inst.berserkCounter = 1;
				
				// add sprite ID to effectedSprites
				ds_list_add(effectedSprites, inst);
			}
			// if already berserk
		}	else	{
			inst.berserkCounter = 1;
			
			// add sprite ID to effectedSprites
			ds_list_add(effectedSprites, inst);
		}
		
		i++;
	}
	
	// if no sprites were effected, destroy spar effect alert
	if (ds_list_size(effectedSprites <= 0)) {
		instance_destroy(id);
	}
}

///@desc SPAR EFFECT: set BERSERK to true for all sprites on the field
function set_berserk_global() {
	var i = 0;	repeat (2) {
		
		// get the correct list based on the target player
		if (i)	var list = spar.allyList;
		if !(i)	var list = spar.enemyList;
		
			// use a repeat loop to check if any nearbySprites need to have
			// their mindset cleared
			var j = 0;	repeat (ds_list_size(list)) {
				var inst = list[| j];
				
				// check if berserk or invulnerable
				if !(inst.berserk) {
					if !(spar_check_invulnerable(inst)) {
						// if other statuses present, reset them
						if (inst.bound)		inst.bound = false;
						if (inst.hexed)		inst.hexed = false;
						
						// set berserk and berserkCounter
						inst.berserk = true;
						inst.berserkCounter = 1;
						
						// add sprite ID to effectedSprites
						ds_list_add(effectedSprites, inst);
					}
					// if already berserk
				}	else	{
					inst.berserkCounter = 1;
					
					// add sprite ID to effectedSprites
					ds_list_add(effectedSprites, inst);
				}
				
				j++;
			}
		
		i++;
	}
	
	// if no sprites were effected, destroy spar effect alert
	if (ds_list_size(effectedSprites <= 0)) {
		instance_destroy(id);
	}
}

///@desc SPAR EFFECT: set INVULNERABLE to true for the target
function set_invulnerable(_target) {
	var t = _target;
	
	if !(t.invulnerable) {
		ds_list_add(effectedSprites, t);
		subject = t.name;		
		
		if (t.berserk)	t.berserk	= false;
		if (t.bound)	t.bound		= false;
		if (t.hexed)	t.hexed		= false;
		
		t.invulnerable = true;
		t.invulnerableCounter = 1;
	}	else	instance_destroy(id);	
}

///@desc SPAR EFFECT: set INVULNERABLE to true for all the target's nearby allies
function set_invulnerable_nearby_allies(_target) {
	// store args in locals
	var t = _target;
	
	subject = t.name;
	
	// use a repeat loop to check if any nearbySprites need to have
	// their mindset cleared
	var i = 0;	repeat (ds_list_size(t.nearbyAllies)) {
		var inst = t.nearbyAllies[| i];
		
		if !(inst.invulnerable) {
			ds_list_add(effectedSprites, inst);
			
			if (inst.berserk)	inst.berserk	= false;
			if (inst.bound)		inst.bound		= false;
			if (inst.hexed)		inst.hexed		= false;
		
			inst.invulnerable = true;
			inst.invulnerableCounter = 1;
		}
		
		i++;
	}
	
	// if no sprites were effected, destroy spar effect alert
	if (ds_list_size(effectedSprites <= 0)) {
		instance_destroy(id);
	}
}

///@desc SPAR EFFECT: set INVULNERABLE to true for all the target's nearby enemies
function set_invulnerable_nearby_enemies(_target) {
	// store args in locals
	var t = _target;
	
	subject = t.name;
	
	// use a repeat loop to check if any nearbySprites need to have
	// their mindset cleared
	var i = 0;	repeat (ds_list_size(t.nearbyEnemies)) {
		var inst = t.nearbyEnemies[| i];
		
		if !(inst.invulnerable) {
			ds_list_add(effectedSprites, inst);		
			if (inst.berserk)	inst.berserk	= false;
			if (inst.bound)		inst.bound		= false;
			if (inst.hexed)		inst.hexed		= false;
			
			inst.invulnerable = true;
			inst.invulnerableCounter = 1;
		}
		
		i++;
	}
	
	// if no sprites were effected, destroy spar effect alert
	if (ds_list_size(effectedSprites <= 0)) {
		instance_destroy(id);
	}
}

///@desc SPAR EFFECT: set INVULNERABLE to true for all the target's nearby sprites
function set_invulnerable_nearby_sprites(_target) {
	// store args in locals
	var t = _target;
	
	subject = t.name;
	
	// use a repeat loop to check if any nearbySprites need to have
	// their mindset cleared
	var i = 0;	repeat (ds_list_size(t.nearbySprites)) {
		var inst = t.nearbySprites[| i];
		
		if !(inst.invulnerable) {
			ds_list_add(effectedSprites, inst);			
			if (inst.berserk)	inst.berserk	= false;
			if (inst.bound)		inst.bound		= false;
			if (inst.hexed)		inst.hexed		= false;
			
			inst.invulnerable = true;
			inst.invulnerableCounter = 1;
		}
		
		i++;
	}
	
	// if no sprites were effected, destroy spar effect alert
	if (ds_list_size(effectedSprites <= 0)) {
		instance_destroy(id);
	}
}
	
///@desc SPAR EFFECT: set INVULNERABLE to true for all sprites on the target team
function set_invulnerable_team(_targetPlayer) {
	// store arguments in local variables
	var t = _targetPlayer;
	
	subject = t.name;
	
	// get the correct list based on the target player
	if (t == spar.playerOne)	var list = spar.allyList;
	if (t == spar.playerTwo)	var list = spar.enemyList;	
	
	// use a repeat loop to grant curse of the warrior to
	// all sprites on the list
	var i = 0;	repeat (ds_list_size(list)) {
		var inst = list[| i];
		
		if !(inst.invulnerable) {
			ds_list_add(effectedSprites, inst);			
			if (inst.berserk)	inst.berserk	= false;
			if (inst.bound)		inst.bound		= false;
			if (inst.hexed)		inst.hexed		= false;
			
			inst.invulnerable = true;
			inst.invulnerableCounter = 1;
		}
		
		i++;
	}
	
	// if no sprites were effected, destroy spar effect alert
	if (ds_list_size(effectedSprites <= 0)) {
		instance_destroy(id);
	}
}

///@desc SPAR EFFECT: set INVULNERABLE to true for all sprites on the field
function set_invulnerable_global() {
	var i = 0;	repeat (2) {
		
		// get the correct list based on the target player
		if (i)	var list = spar.allyList;
		if !(i)	var list = spar.enemyList;
		
		// use a repeat loop to check if any nearbySprites need to have
		// their mindset cleared
		var j = 0;	repeat (ds_list_size(list)) {
			var inst = list[| j];
			
			if !(inst.invulnerable) {
				ds_list_add(effectedSprites, inst);			
				if (inst.berserk)	inst.berserk	= false;
				if (inst.bound)		inst.bound		= false;
				if (inst.hexed)		inst.hexed		= false;
				
				inst.invulnerable = true;
				inst.invulnerableCounter = 1;
			}
			
			j++;
		}	
		
		i++;
	}
	
	// if no sprites were effected, destroy spar effect alert
	if (ds_list_size(effectedSprites <= 0)) {
		instance_destroy(id);
	}
}

///@desc SPAR EFFECT: this effect is simply here as a way of notifying the player
/// that the damage was altered after the fact
function apply_invulnerable(_invulnSprite) {
	var c = _invulnSprite;
	
	ds_list_add(effectedSprites, c);
	subject = c.name;
}

///@desc SPAR EFFECT: set PARRYING to true for casting sprite
function set_parrying(_caster) {
	var c = _caster;
	
	ds_list_add(effectedSprites, c);
	subject = c.name;
	
	c.parrying = true;
}

///@desc SPAR EFFECT: determines what the damage would have been
/// if the sprite were not parrying, then depletes that amount of damage from
/// the attacking sprite's team after multiplying it by 1.5*
function apply_parry(_attackingSprite, _parryingSprite, _damage) {
	var t = _attackingSprite;
	var c = _parryingSprite;
	var d = _damage;
	
	ds_list_add(effectedSprites, t);
	subject = c.name;
	
	deplete_hp(t.team, round(d * 2.2));
}

///@desc SPAR EFFECT: various things might cause a parry to fail, such as
/// the attacking sprite being invulnerable. This just creates a different
/// animation and posts a specific message, while also dealing slightly increased
/// damage
function ignore_parry(_attackingSprite, _parryingSprite, _damage) {
	var t = _parryingSprite;
	var c = _attackingSprite;
	var d = _damage;
	
	ds_list_add(effectedSprites, t);
	subject = c.name;
	object = t.name;
	
	deplete_hp(t.team, d* 1.3);
}

///@desc SPAR EFFECT: sets DIVIDING to true for the target sprite
/// and sets the given coefficient
function set_dividing(_targetSprite, _coefficient) {
	var t = _targetSprite;
	var a = _coefficient;
	
	ds_list_add(effectedSprites, t);
	subject = t.name;
	
	if !(t.dividing) 
	&& !(t.multiplying) {
		t.dividing = true;
		t.coefficient = a;
	}	else	ds_list_destroy(effectedSprites);	effectedSprites = -1;	instance_destroy(id);	
}

///@desc SPAR EFFECT: sets MULTIPLYING to true for the target sprite
/// and sets the given coefficient
function set_multiplying(_targetSprite, _coefficient) {
	var t = _targetSprite;
	var a = _coefficient;
	
	ds_list_add(effectedSprites, t);
	subject = t.name;
	
	if !(t.dividing)
	&& !(t.multiplying) {
		t.multiplying = true;
		t.coefficient = a;
	}	else	ds_list_destroy(effectedSprites);	effectedSprites = -1;	instance_destroy(id);	
}

///@desc SPAR EFFECT: this effect is simply a means of notifying the player
/// that the healing was altered after the fact
function multiply_healing(_healingSprite) {
}

///@desc SPAR EFFECT: this effect is simply a means of notifying the player
/// that the damage was altered after the fact
function multiply_damage() {
	
}

///@desc SPAR EFFECT: this effect is simply a means of notifying the player
/// that the healing was altered after the fact
function divide_healing() {
	
}

///@desc SPAR EFFECT: this effect is simply a means of notifying the player
/// that the damage was altered after the fact
function divide_damage() {
	
}

///@desc SPAR EFFECT: sets deflective to true for casting sprite
function set_deflective(_caster) {
	var c = _caster;
	
	ds_list_add(effectedSprites, c);
	subject = c.name;
	
	c.deflective = true;
}

///@desc SPAR EFFECT: apply boosted elemental damage
/// against the caster
function deflect_spell(_atkr, _targ, _damg, _spell) {
	var c = _atkr;
	var t = _targ;
	var p = _damg;
	var s = _spell;	
	
	// decode spell animation list
	var list = ds_list_create();
	decode_list(global.allSpellAnimations, list);
	
	// get the animation sprite
	animation = correct_string_after_decode(list[| spellID]);
	
	// destroy temp list
	ds_list_destroy(list);
	
	// calculate spell damage
	var d = p * 1.3;
	
	// check that the caster is NOT also deflective
	if !(spar_check_deflective(t, c, d, s)) {
		deplete_hp(t.team, d);
	
		ds_list_add(effectedSprites, c);
		subject = t.name;
		object = c.name;
	}
	// else, post a new deflection
	else	{	
		// destroy effect alert
		instance_destroy(id);
	}
}

///@desc SPAR EFFECT: forces the turn to end immediately
function force_turn_end() {
	ds_grid_clear(spar.turnGrid, -1);
	spar.sparPhase = SPAR_PHASES.TURN_END;
}

///@desc SPAR EFFECT: forces the targetTeam to store these turn selections
/// and repeat them the following turn
function repeat_last_turn(_targetSprite) {
	var t = _targetSprite;
	
	ds_list_add(effectedSprites, t);
	subject = t.name;
	
	t.turnRepeat = true;
}

///@desc SPAR EFFECT: applies damage calculated using the caster's best stat
/// and the target's worst stat
function psychic_attack(_caster, _target) {
	var c = _caster;
	var t = _target;

	ds_list_add(effectedSprites, t);
	
	subject = c.name;
	object = t.name;
}

///@desc SPAR EFFECT: changes the target's alignment to the given alignment
function change_alignment(_target, _newAlignment) {
	var t = _target;
	var a = _newAlignment;

	if (t.currentAlign != a) {
		ds_list_add(effectedSprites, t);
		subject = t.name;
		t.currentAlign = a;
	}	else	ds_list_destroy(effectedSprites);	effectedSprites = -1;	instance_destroy(id);	
}

///@desc SPAR EFFECT: changes the target's size to the given size
function change_size(_target, _newSize) {
	var t = _target;
	var s = _newSize;

	if (t.currentSize != s) {
		t.currentSize = s;	
		ds_list_add(effectedSprites, t);
		subject = t.name;
	}	else	ds_list_destroy(effectedSprites);	effectedSprites = -1;	instance_destroy(id);	
}

///@desc SPAR EFFECT: this is just the energy blast function that is cast
/// specifically on the self
function energy_blast_self(_targetPlayer, _damage) {
	var t = _targetPlayer;
	var d = _damage;
	
	effectedPlayer = t;
	subject = t.name;
	
	deplete_hp(t, d);
}

///@desc SPAR EFFECT: the given sprite has their luck roll set to
/// the highest possible luck
function force_best_luck(_effectedSprite) {
	var s = _effectedSprite;
	
	s.luckRoll = MAX_LUCK;
	
	ds_list_add(effectedSprites, s);
	
	subject = s.name;
}

///@desc SPAR EFFECT: the given sprite has their luck roll set to
/// the lowest possible luck
function force_worst_luck(_effectedSprite) {
	var s = _effectedSprite;
	
	s.luckRoll = MIN_LUCK / 1000;
	
	ds_list_add(effectedSprites, s);
	
	subject = s.name;
}

///@desc SPAR EFFECT: the given player has all of their allies'
/// luck set to the highest possible
function force_best_luck_team(_effectedPlayer) {
	var t = _effectedPlayer;
	var l = -1;
	
	if (t == spar.playerOne) {
		l = spar.allyList;
	}
	
	if (t == spar.playerTwo) {
		l = spar.enemyList;	
	}
	
	var i = 0;	repeat (ds_list_size(l)) {
		var inst = l[| i];
		
		inst.luckRoll = MAX_LUCK / 1000;
		
		i++;
	}
	
	effectedPlayer = t;
	
	subject = t.name;
}

///@desc SPAR EFFECT: the given player has all of their allies'
/// luck set to the lowest possible
function force_worst_luck_team(_effectedPlayer) {
	var t = _effectedPlayer;
	var l = -1;
	
	if (t == spar.playerOne) {
		l = spar.allyList;
	}
	
	if (t == spar.playerTwo) {
		l = spar.enemyList;	
	}
	
	var i = 0;	repeat (ds_list_size(l)) {
		var inst = l[| i];
		
		inst.luckRoll = MIN_LUCK / 1000;
		
		i++;
	}
	
	effectedPlayer = t;
	
	subject = t.name;
}

///@desc SPAR EFFECT: all sprites on the field have their
/// luck roll set to the highest possible
function force_best_luck_global() {
	var i = 0;	repeat (ds_list_size(spar.spriteList)) {
		var inst = spar.spriteList[| i];
		
		inst.luckRoll = MAX_LUCK / 1000;
		
		i++;
	}
}

///@desc SPAR EFFECT: all sprites on the field have their
/// luck roll set to the lowest possible
function force_worst_luck_global() {
	var i = 0;	repeat (ds_list_size(spar.spriteList)) {
		var inst = spar.spriteList[| i];
		
		inst.luckRoll = MIN_LUCK / 1000;
		
		i++;
	}
}					

///@desc SPAR EFFECT: sets hail mary as true for the target player
function set_hail_sphera(_targetPlayer) {
	var t = _targetPlayer;
	
	effectedPlayer = t;
	subject = t.name;
	
	t.hailSphera = true;
}

///@desc SPAR EFFECT: sets all sprites on hail mary player's team to invulnerable
function hail_sphera_set_invulnerable(_targetPlayer) {
	var t = _targetPlayer;
	
	subject = t.name;
	
	if (t == spar.playerOne) {
		var i = 0;	repeat (ds_list_size(spar.allyList)) {
			var inst = spar.allyList[| i];
			
			inst.invulnerable = true;
			inst.invulnerableCount = 1;
			
			i++;
		}
	}
	
	if (t == spar.playerTwo) {
		var i = 0;	repeat (ds_list_size(spar.enemyList)) {
			var inst = spar.enemyList[| i];
			
			inst.invulnerable = true;
			inst.invulnerableCount = 1;
			
			i++;
		}
	}
	
	t.hailSphera = false;
}

///@desc SPAR EFFECT: this effect is simply a means of notifying the player
/// that the damage was altered aftert the fact
function berserk_increase_damage(_activeSprite) {
	var c = _activeSprite;
	
	ds_list_add(effectedSprites, c);
	subject = c.name;
}

///@desc SPAR EFFECT: sets BERSERK to false for target sprite
function end_berserk(_target) {
	var t = _target;
	
	if (t.berserk) {
		ds_list_add(effectedSprites, t);
		subject = t.name;
		t.berserk = false;
		t.berserkCounter = 0;
	}	else	ds_list_destroy(effectedSprites);	effectedSprites = -1;	instance_destroy(id);	
}

///@desc This function is simply an announcement that effects were ignored
/// or you aren't allowed to make that selection because the sprite is going berserk
function apply_berserk(_effectedSprite) {
	var s = _effectedSprite;
	
	subject = s.name;
	
	ds_list_add(effectedSprites, s);
}

///@desc SPAR EFFECT: sets BERSERK to false for all target sprite's nearby allies
function end_berserk_nearby_allies(_target) {
	// store args in locals
	var t = _target;
	
	subject = t.name;
	
	// use a repeat loop to check if any nearbySprites need to have
	// their mindset cleared
	var i = 0;	repeat (ds_list_size(t.nearbyAllies)) {
		var inst = t.nearbyAllies[| i];
		
		if (inst.berserk) {
			ds_list_add(effectedSprites, inst);
			inst.berserk = false;
			inst.berserkCounter = 0;
		}
		
		i++;
	}
	
	// if no sprites were effected, destroy spar effect alert
	if (ds_list_size(effectedSprites <= 0)) {
		instance_destroy(id);
	}
}

///@desc SPAR EFFECT: sets BERSERK to false for all target sprite's nearby enemies
function end_berserk_nearby_enemies(_target) {
	// store args in locals
	var t = _target;
	
	subject = t.name;
	
	// use a repeat loop to check if any nearbySprites need to have
	// their mindset cleared
	var i = 0;	repeat (ds_list_size(t.nearbyEnemies)) {
		var inst = t.nearbyEnemies[| i];
		
		if (inst.berserk) {
			ds_list_add(effectedSprites, inst);
			inst.berserk = false;
			inst.berserkCounter = 0;
		}
		
		i++;
	}
	
	// if no sprites were effected, destroy spar effect alert
	if (ds_list_size(effectedSprites <= 0)) {
		instance_destroy(id);
	}
}

///@desc SPAR EFFECT: sets BERSERK to false for all target sprite's nearby sprites
function end_berserk_nearby_sprites(_target) {
	// store args in locals
	var t = _target;
	
	subject = t.name;
	
	// use a repeat loop to check if any nearbySprites need to have
	// their mindset cleared
	var i = 0;	repeat (ds_list_size(t.nearbySprites)) {
		var inst = t.nearbySprites[| i];
		
		if (inst.berserk) {
			ds_list_add(effectedSprites, inst);
			inst.berserk = false;
			inst.berserkCounter = 0;
		}
		
		i++;
	}
	
	// if no sprites were effected, destroy spar effect alert
	if (ds_list_size(effectedSprites <= 0)) {
		instance_destroy(id);
	}	
}

///@desc SPAR EFFECT: sets BERSERK to false for all sprites on target team
function end_berserk_team(_targetPlayer) {
	// store arguments in local variables
	var t = _targetPlayer;
	
	subject = t.name;
	
	// get the correct list based on the target player
	if (t == spar.playerOne)	var list = spar.allyList;
	if (t == spar.playerTwo)	var list = spar.enemyList;	
	
	// use a repeat loop to check if any nearbySprites need to have
	// their mindset cleared
	var i = 0;	repeat (ds_list_size(list)) {
		var inst = list[| i];
		
		if (inst.berserk) {
			ds_list_add(effectedSprites, inst);
			inst.berserk = false;
			inst.berserkCounter = 0;
		}
		
		i++;
	}
	
	// if no sprites were effected, destroy spar effect alert
	if (ds_list_size(effectedSprites <= 0)) {
		instance_destroy(id);
	}	
}

///@desc SPAR EFFECT: sets BERSERK to false for all sprites on the field
function end_berserk_global() {
	var i = 0;	repeat (2) {
		
		// get the correct list based on the target player
		if (i)	var list = spar.allyList;
		if !(i)	var list = spar.enemyList;
		
		// use a repeat loop to check if any nearbySprites need to have
		// their mindset cleared
		var j = 0;	repeat (ds_list_size(list)) {
			var inst = list[| j];
			
			if (inst.berserk) {
				ds_list_add(effectedSprites, inst);
				inst.berserk = false;
				inst.berserkCounter = 0;
			}
			j++;
		}
		i++;
	}
	
	// if no sprites were effected, destroy spar effect alert
	if (ds_list_size(effectedSprites <= 0)) {
		instance_destroy(id);
	}		
}

///@desc SPAR EFFECT: sets INVULNERABLE to false for target sprite
function end_invulnerable(_target) {
	var t = _target;
	
	if (t.invulnerable) {
		ds_list_add(effectedSprites, t);
		subject = t.name;
		t.invulnerable = false;	
		t.invulnerableCounter = 0;
	}	else	instance_destroy(id);
}

///@desc SPAR EFFECT: sets INVULNERABLE to false for all target's nearby allies
function end_invulnerable_nearby_allies(_target) {
	// store args in locals
	var t = _target;
	
	subject = t.name;
	
	// use a repeat loop to check if any nearbySprites need to have
	// their mindset cleared
	var i = 0;	repeat (ds_list_size(t.nearbyAllies)) {
		var inst = t.nearbyAllies[| i];
		
		if (inst.invulnerable) {
			ds_list_add(effectedSprites, inst);
			inst.invulnerable = false;
			inst.invulnerableCounter = 0;
		}
		
		i++;
	}
	
	// if no sprites were effected, destroy spar effect alert
	if (ds_list_size(effectedSprites <= 0)) {
		instance_destroy(id);
	}
}

///@desc SPAR EFFECT: sets INVULNERABLE to false for all target's nearby enemies

function end_invulnerable_nearby_enemies(_target) {
	// store args in locals
	var t = _target;
	
	subject = t.name;
	
	// use a repeat loop to check if any nearbySprites need to have
	// their mindset cleared
	var i = 0;	repeat (ds_list_size(t.nearbyEnemies)) {
		var inst = t.nearbyEnemies[| i];
		
		if (inst.invulnerable) {
			ds_list_add(effectedSprites, inst);
			inst.invulnerable = false;
			inst.invulnerableCounter = 0;
		}
		
		i++;
	}
	
	// if no sprites were effected, destroy spar effect alert
	if (ds_list_size(effectedSprites <= 0)) {
		instance_destroy(id);
	}	
}

///@desc SPAR EFFECT: sets INVULNERABLE to false for all target's nearby sprites
function end_invulnerable_nearby_sprites(_target) {
	// store args in locals
	var t = _target;
	
	subject = t.name;
	
	// use a repeat loop to check if any nearbySprites need to have
	// their mindset cleared
	var i = 0;	repeat (ds_list_size(t.nearbySprites)) {
		var inst = t.nearbySprites[| i];
		
		if (inst.invulnerable) {
			ds_list_add(effectedSprites, inst);
			inst.invulnerable = false;
			inst.invulnerableCounter = 0;
		}
		
		i++;
	}
	
	// if no sprites were effected, destroy spar effect alert
	if (ds_list_size(effectedSprites <= 0)) {
		instance_destroy(id);
	}	
}

///@desc SPAR EFFECT: sets INVULNERABLE to false for all sprites on target team
function end_invulnerable_team(_target) {
	// store arguments in local variables
	var t = _targetPlayer;
	
	subject = t.name;
	
	// get the correct list based on the target player
	if (t == spar.playerOne)	var list = spar.allyList;
	if (t == spar.playerTwo)	var list = spar.enemyList;	
	
	// use a repeat loop to check if any nearbySprites need to have
	// their mindset cleared
	var i = 0;	repeat (ds_list_size(list)) {
		var inst = list[| i];
		
		if (inst.invulnerable) {
			ds_list_add(effectedSprites, inst);
			inst.invulnerable = false;
			inst.invulnerableCounter = 0;
		}
		
		i++;
	}
	
	// if no sprites were effected, destroy spar effect alert
	if (ds_list_size(effectedSprites <= 0)) {
		instance_destroy(id);
	}	
}

///@desc SPAR EFFECT: sets INVULNERABLE to false for all sprites on the field
function end_invulnerable_global() {
	var i = 0;	repeat (2) {
		
		// get the correct list based on the target player
		if (i)	var list = spar.allyList;
		if !(i)	var list = spar.enemyList;
		
		// use a repeat loop to check if any nearbySprites need to have
		// their mindset cleared
		var j = 0;	repeat (ds_list_size(list)) {
			var inst = list[| j];
			
			if (inst.invulnerable) {
				ds_list_add(effectedSprites, inst);
				inst.invulnerable = false;
				inst.invulnerableCounter = 0;
			}
			j++;
		}
		i++;
	}
	
	// if no sprites were effected, destroy spar effect alert
	if (ds_list_size(effectedSprites <= 0)) {
		instance_destroy(id);
	}		
}

///@desc SPAR EFFECT: restores alignment to original
function restore_alignment(_inst) {
	var inst = _inst;
	
	subject = inst.name;
	
	inst.currentAlign = inst.baseAlign;
}

///@desc SPAR EFFECT: restores size to original
function restore_size(_inst) {
	var inst = _inst;
	
	inst.currentSize = inst.baseSize;
}

///@desc SPAR EFFECT: applies the damage from a skydive
function skydive_apply_damage(_atkr, _targ) {
	// store args in locals
	var atkr = _atkr;
	var targ = _targ;
	
	// if target is not invulnerable:
	if !(targ.invulnerable) {
		// check for a mechanical target
		spar_check_mechanical_target(targ);
		
		// check for rust
		spar_check_rust(targ);
		
		// calculate damage
		var d = get_physical_damage(atkr, targ, 120);
	
		// apply damage
		deplete_hp(targ.team, d);
	}
	// if target is invulnerable, apply invulnerable
	else	spar_effect_push_alert(SPAR_EFFECTS.APPLY_INVULNERABLE, targ);
	
	atkr.flying = false;
	atkr.invulnerable = false;
}

///@desc SPAR EFFECT: applies the damage from a sneak attack
function sneak_attack_apply_damage(_atkr, _targ) {
	// store args in locals
	var atkr = _atkr;
	var targ = _targ;
	
	// if target is not invulnerable:
	if !(targ.invulnerable) {
		// check for a mechanical target
		spar_check_mechanical_target(targ);
		
		// check for rust
		spar_check_rust(targ);
		
		// calculate damage
		var d = get_physical_damage(atkr, targ, 120);
		
		// initialize dodgeCountMultiplier
		var dcm = 1;
		
		// increment dcm
		if (atkr.dodgeCount > 0) {
			dcm = 1.15;
			
			dcm += (0.1 * (atkr.dodgeCount - 1));
		}
		
		// modify damage
		d = round(d * dcm);
		
		// apply damage
		deplete_hp(targ.team, d);
	}
	// if target is invulnerable, apply invulnerable
	else	spar_effect_push_alert(SPAR_EFFECTS.APPLY_INVULNERABLE, targ);
}

///@desc SPAR EFFECT: announces that the skydive failed
function skydive_failure(_inst) {
	subject = _inst.name;
	
	ds_list_add(effectedSprites, _inst);
}

///@desc SPAR EFFECT: announces that teh sneak attack failed
function sneak_attack_failure(_inst) {
	subject = _inst.name;
	
	ds_list_add(effectedSprites, _inst);
}

///@desc SPAR EFFECT: announces that a sprite's ability has been activated
function activate_ability(_sprite) {
	// store args in locals
	var s = _sprite;
	
	// set subject
	subject = s.name;
}

///@desc SPAR EFFECT: announces that a spell was added to a player's spellbook
function bonus_spell(_player) {
	// store args in locals
	var p = _player;
	
	// set subject
	subject = p.name;
}

///@desc SPAR EFFECT: announces that the sprite's range was improved
function improve_range_spar_effect(_sprite) {
	// store args in locals
	var s = _sprite;
	
	// set subject
	subject = s.name;
}

///@desc SPAR EFFECT: announces that the player's team will attack in order
/// after setting synchronizedSoldiersActive to true for them
function synchronize_sprites(_player) {
	// store args in locals
	var p = _player;
	
	// set subject
	subject = p.name;
	
	// set synchronizedSoldiersActive to true
	p.synchronizedSoldiersActive = true;
}

///@desc SPAR EFFECT: announces that the sprite will be performing their turn
/// right away
function arbitrate_turn(_sprite) {
	// store args in locals
	var s = _sprite;
	
	// check if this sprite has already acted
	if (spar.turnGrid[# TURN_GRID.ACTION, s.spotNum] == -1)	instance_destroy(id);
	
	// set subject
	subject = s.name;
	
	// set spar.turnRow to sprites spotNum
	spar.turnRow = s.spotNum;
	
	// create sparActionProcessor
	create_once(0, 0, LAYER.meta, sparActionProcessor);
}

///@desc SPAR EFFECT: announces that damage was adjusted to use the attacker's FIRE stat
function basic_attack_fire(_atkr) {
	// store args in locals
	var atkr = _atkr;
	
	// set subject
	subject = atkr.name;
}

///@desc SPAR EFFECT: announces that damage was adjusted to use the attacker's WATER stat
function basic_attack_water(_atkr) {
	// store args in locals
	var atkr = _atkr;
	
	// set subject
	subject = atkr.name;
}

///@desc SPAR EFFECT: announces that damage was adjusted to use the attacker's STORM stat
function basic_attack_storm(_atkr) {
	// store args in locals
	var atkr = _atkr;
	
	// set subject
	subject = atkr.name;
}

///@desc SPAR EFFECT: announces that damage was adjusted to use the attacker's EARTH stat
function basic_attack_earth(_atkr) {
	// store args in locals
	var atkr = _atkr;
	
	// set subject
	subject = atkr.name;
}

///@desc SPAR EFFECT: announces that damage was adjusted to use the attacker's RESISTANCE stat
function basic_attack_resistance(_atkr) {
	// store args in locals
	var atkr = _atkr;
	
	// set subject
	subject = atkr.name;
}

///@desc SPAR EFFECT: announces that damage was adjusted to use the attacker's AGILITY stat
function basic_attack_agility(_atkr) {
	// store args in locals
	var atkr = _atkr;
	
	// set subject
	subject = atkr.name;
}

function set_immobilized(_inst) {
	// store args in locals
	var inst = _inst;
	
	// set subject
	subject = inst.name;
	
	// set immobilized to true
	inst.immobilized = true;
}

function remove_immobilized(_inst) {
	// store args in locals
	var inst = _inst;
	
	// set subject
	subject = inst.name;
	
	// set immobilized to false
	inst.immobilized = false;
}

function negate_damage(_inst) {
	// store args in locals
	var inst = _inst;
	
	// set subject
	subject = inst.name;
	
	ds_list_add(effectedSprites, inst);
}

function negate_spell_cost(_inst) {
	// store args in locals
	var inst = _inst;
	
	// set subject
	subject = inst.name;
	
	ds_list_add(effectedSprites, inst);
}

function force_spell_failure(_inst) {
	// store args in locals
	var inst = _inst;
	
	// set subject
	subject = inst.name;
	
	ds_list_add(effectedSprites, inst);
}

function out_of_range_selection(_inst) {
	// store args in locals
	var inst = _inst;
	
	// add the selected target to the list of effected sprites
	ds_list_add(effectedSprites, inst);
	
	// set subject
	subject = inst.name;
}

function out_of_range_action(_atkr, _targ) {
	// store args in locals
	var atkr = _atkr;
	var targ = _targ;
	
	// add the selected target to the list of effected sprites
	ds_list_add(effectedSprites, atkr, targ);
	
	// set subject
	subject = atkr.name;
}

// get text from csv file
var textGrid = load_csv("SPAR_EFFECTS_ENGLISH.csv");

// create the sparEffectGrid
global.sparEffectGrid = ds_grid_create(SPAR_EFFECT_PARAMS.HEIGHT, SPAR_EFFECTS.HEIGHT);

// create the master grid add function 
function master_grid_add_spar_effect(_ID) {
	var ID = _ID;
	
	var i = 0;	repeat (SPAR_EFFECT_PARAMS.HEIGHT) {
		global.sparEffectGrid[# i, ID] = argument[i];
	
		i++;
	}
}

#region BUILD THE SPAR EFFECT GRID
//							ID												ALERT TEXT														EFFECT FUNCTION						ANIMATION
master_grid_add_spar_effect(SPAR_EFFECTS.ARENA_CHANGE_VOLCANO,				textGrid[# 1, SPAR_EFFECTS.ARENA_CHANGE_VOLCANO],				arena_change_volcano,				sparFX_arenaChange);			
master_grid_add_spar_effect(SPAR_EFFECTS.ARENA_CHANGE_OCEAN,				textGrid[# 1, SPAR_EFFECTS.ARENA_CHANGE_OCEAN],					arena_change_ocean,					sparFX_arenaChange);			
master_grid_add_spar_effect(SPAR_EFFECTS.ARENA_CHANGE_CLOUDS,				textGrid[# 1, SPAR_EFFECTS.ARENA_CHANGE_CLOUDS],				arena_change_clouds,				sparFX_arenaChange);			
master_grid_add_spar_effect(SPAR_EFFECTS.ARENA_CHANGE_FOREST,				textGrid[# 1, SPAR_EFFECTS.ARENA_CHANGE_FOREST],				arena_change_forest,				sparFX_arenaChange);			
master_grid_add_spar_effect(SPAR_EFFECTS.ARENA_CHANGE_NORMAL,				textGrid[# 1, SPAR_EFFECTS.ARENA_CHANGE_NORMAL],				arena_change_normal,				sparFX_arenaChange);			
master_grid_add_spar_effect(SPAR_EFFECTS.SET_MIASMA,						textGrid[# 1, SPAR_EFFECTS.SET_MIASMA],							set_miasma,							sparFX_miasma);					
master_grid_add_spar_effect(SPAR_EFFECTS.SET_HUM,							textGrid[# 1, SPAR_EFFECTS.SET_HUM],							set_hum,							sparFX_hum);					
master_grid_add_spar_effect(SPAR_EFFECTS.SET_RUST,							textGrid[# 1, SPAR_EFFECTS.SET_RUST],							set_rust,							sparFX_rust);					
master_grid_add_spar_effect(SPAR_EFFECTS.ENERGY_BLAST,						textGrid[# 1, SPAR_EFFECTS.ENERGY_BLAST],						energy_blast,						sparFX_energyBlast);			
master_grid_add_spar_effect(SPAR_EFFECTS.BESTOW_MINDSET,					textGrid[# 1, SPAR_EFFECTS.BESTOW_MINDSET],						bestow_mindset,						sparFX_receiveBlessing);			
master_grid_add_spar_effect(SPAR_EFFECTS.SHIFT_MINDSET,						textGrid[# 1, SPAR_EFFECTS.SHIFT_MINDSET],						shift_mindset,						sparFX_shiftMindset);			
master_grid_add_spar_effect(SPAR_EFFECTS.COPY_MINDSET,						textGrid[# 1, SPAR_EFFECTS.COPY_MINDSET],						copy_mindset,						sparFX_copyMindset);			
master_grid_add_spar_effect(SPAR_EFFECTS.RESTORE_MP,						textGrid[# 1, SPAR_EFFECTS.RESTORE_MP],							restore_mp_spar_effect,				sparFX_restore);				
master_grid_add_spar_effect(SPAR_EFFECTS.RESTORE_HP,						textGrid[# 1, SPAR_EFFECTS.RESTORE_HP],							restore_hp_spar_effect,				sparFX_restore);				
master_grid_add_spar_effect(SPAR_EFFECTS.DEPLETE_MP,						textGrid[# 1, SPAR_EFFECTS.DEPLETE_MP],							deplete_mp_spar_effect,				EMPTY_SPRITE);							
master_grid_add_spar_effect(SPAR_EFFECTS.DEPLETE_HP,						textGrid[# 1, SPAR_EFFECTS.DEPLETE_HP],							deplete_hp_spar_effect,				EMPTY_SPRITE);							
master_grid_add_spar_effect(SPAR_EFFECTS.DEPLETE_HP_NONLETHAL,				textGrid[# 1, SPAR_EFFECTS.DEPLETE_HP_NONLETHAL],				deplete_hp_nonlethal,				EMPTY_SPRITE);							
master_grid_add_spar_effect(SPAR_EFFECTS.SET_BOUND,							textGrid[# 1, SPAR_EFFECTS.SET_BOUND],							set_bound,							sparFX_bound);					
master_grid_add_spar_effect(SPAR_EFFECTS.SET_HEXED,							textGrid[# 1, SPAR_EFFECTS.SET_HEXED],							set_hexed,							sparFX_hexed);					
master_grid_add_spar_effect(SPAR_EFFECTS.REMOVE_BOUND,						textGrid[# 1, SPAR_EFFECTS.REMOVE_BOUND],						remove_bound,						sparFX_clearStatus);			
master_grid_add_spar_effect(SPAR_EFFECTS.REMOVE_HEXED,						textGrid[# 1, SPAR_EFFECTS.REMOVE_HEXED],						remove_hexed,						sparFX_clearStatus);			
master_grid_add_spar_effect(SPAR_EFFECTS.CLEAR_MIASMA,						textGrid[# 1, SPAR_EFFECTS.CLEAR_MIASMA],						clear_miasma,						sparFX_clearHindrance);			
master_grid_add_spar_effect(SPAR_EFFECTS.CLEAR_HUM,							textGrid[# 1, SPAR_EFFECTS.CLEAR_HUM],							clear_hum,							sparFX_clearHindrance);			
master_grid_add_spar_effect(SPAR_EFFECTS.CLEAR_RUST,						textGrid[# 1, SPAR_EFFECTS.CLEAR_RUST],							clear_rust,							sparFX_clearHindrance);			
master_grid_add_spar_effect(SPAR_EFFECTS.CLEAR_MINDSET,						textGrid[# 1, SPAR_EFFECTS.CLEAR_MINDSET],						clear_mindset,						sparFX_clearStatus);			
master_grid_add_spar_effect(SPAR_EFFECTS.FULLY_RESTORE_HP,					textGrid[# 1, SPAR_EFFECTS.FULLY_RESTORE_HP],					fully_restore_hp,					sparFX_restore);				
master_grid_add_spar_effect(SPAR_EFFECTS.FULLY_RESTORE_MP,					textGrid[# 1, SPAR_EFFECTS.FULLY_RESTORE_MP],					fully_restore_mp,					sparFX_restore);				
master_grid_add_spar_effect(SPAR_EFFECTS.GRID_ADD_SKYDIVE,					textGrid[# 1, SPAR_EFFECTS.GRID_ADD_SKYDIVE],					grid_add_skydive,					sparFX_skydive);				
master_grid_add_spar_effect(SPAR_EFFECTS.GRID_ADD_SNEAK_ATTACK,				textGrid[# 1, SPAR_EFFECTS.GRID_ADD_SNEAK_ATTACK],				grid_add_sneak_attack,				sparFX_sneakAttack);			
master_grid_add_spar_effect(SPAR_EFFECTS.GRID_ADD_TIMED_BLAST,				textGrid[# 1, SPAR_EFFECTS.GRID_ADD_TIMED_BLAST],				grid_add_timed_blast,				sparFX_timedBlast);				
master_grid_add_spar_effect(SPAR_EFFECTS.CLEAR_TEAM_HINDRANCES,				textGrid[# 1, SPAR_EFFECTS.CLEAR_TEAM_HINDRANCES],				clear_team_hindrances,				sparFX_clearTeamHindrance);		
master_grid_add_spar_effect(SPAR_EFFECTS.CLEAR_ALL_HINDRANCES,				textGrid[# 1, SPAR_EFFECTS.CLEAR_ALL_HINDRANCES],				clear_all_hindrances,				sparFX_clearTeamHindrance);		
master_grid_add_spar_effect(SPAR_EFFECTS.BLAST_TIMER_GO_OFF,				textGrid[# 1, SPAR_EFFECTS.BLAST_TIMER_GO_OFF],					blast_timer_go_off,					sparFX_energyBlast);			
master_grid_add_spar_effect(SPAR_EFFECTS.BLAST_TIMERS_DECREMENT_COUNT,		textGrid[# 1, SPAR_EFFECTS.BLAST_TIMERS_DECREMENT_COUNT],		blast_timers_decrement_count,		sparFX_timedBlast);				
master_grid_add_spar_effect(SPAR_EFFECTS.APPLY_MIASMA,						textGrid[# 1, SPAR_EFFECTS.APPLY_MIASMA],						apply_miasma,						sparFX_miasma);					
master_grid_add_spar_effect(SPAR_EFFECTS.APPLY_HUM,							textGrid[# 1, SPAR_EFFECTS.APPLY_HUM],							apply_hum,							sparFX_hum);					
master_grid_add_spar_effect(SPAR_EFFECTS.APPLY_RUST,						textGrid[# 1, SPAR_EFFECTS.APPLY_RUST],							apply_rust,							sparFX_rust);					
master_grid_add_spar_effect(SPAR_EFFECTS.FORCE_SWAP,						textGrid[# 1, SPAR_EFFECTS.FORCE_SWAP],							force_swap,							sparFX_forceSwap);				
master_grid_add_spar_effect(SPAR_EFFECTS.FORCE_SWAP_TEAM,					textGrid[# 1, SPAR_EFFECTS.FORCE_SWAP_TEAM],					force_swap_team,					sparFX_forceSwap);				
master_grid_add_spar_effect(SPAR_EFFECTS.FORCE_SWAP_GLOBAL,					textGrid[# 1, SPAR_EFFECTS.FORCE_SWAP_GLOBAL],					force_swap_global,					sparFX_forceSwap);				
master_grid_add_spar_effect(SPAR_EFFECTS.SET_MIASMA_GLOBAL,					textGrid[# 1, SPAR_EFFECTS.SET_MIASMA_GLOBAL],					set_miasma_global,					sparFX_miasma);					
master_grid_add_spar_effect(SPAR_EFFECTS.SET_HUM_GLOBAL,					textGrid[# 1, SPAR_EFFECTS.SET_HUM_GLOBAL],						set_hum_global,						sparFX_hum);					
master_grid_add_spar_effect(SPAR_EFFECTS.SET_RUST_GLOBAL,					textGrid[# 1, SPAR_EFFECTS.SET_RUST_GLOBAL],					set_rust_global,					sparFX_rust);					
master_grid_add_spar_effect(SPAR_EFFECTS.CLEAR_MIASMA_GLOBAL,				textGrid[# 1, SPAR_EFFECTS.CLEAR_MIASMA_GLOBAL],				clear_miasma_global,				sparFX_clearHindrance);			
master_grid_add_spar_effect(SPAR_EFFECTS.CLEAR_HUM_GLOBAL,					textGrid[# 1, SPAR_EFFECTS.CLEAR_HUM_GLOBAL],					clear_hum_global,					sparFX_clearHindrance);			
master_grid_add_spar_effect(SPAR_EFFECTS.CLEAR_RUST_GLOBAL,					textGrid[# 1, SPAR_EFFECTS.CLEAR_RUST_GLOBAL],					clear_rust_global,					sparFX_clearHindrance);			
master_grid_add_spar_effect(SPAR_EFFECTS.CLEAR_MINDSET_NEARBY_ALLIES,		textGrid[# 1, SPAR_EFFECTS.CLEAR_MINDSET_NEARBY_ALLIES],		clear_mindset_nearby_allies,		sparFX_clearStatus);			
master_grid_add_spar_effect(SPAR_EFFECTS.CLEAR_MINDSET_NEARBY_ENEMIES,		textGrid[# 1, SPAR_EFFECTS.CLEAR_MINDSET_NEARBY_ENEMIES],		clear_mindset_nearby_enemies,		sparFX_clearStatus);			
master_grid_add_spar_effect(SPAR_EFFECTS.CLEAR_MINDSET_NEARBY_SPRITES,		textGrid[# 1, SPAR_EFFECTS.CLEAR_MINDSET_NEARBY_SPRITES],		clear_mindset_nearby_sprites,		sparFX_clearStatus);			
master_grid_add_spar_effect(SPAR_EFFECTS.CLEAR_MINDSET_TEAM,				textGrid[# 1, SPAR_EFFECTS.CLEAR_MINDSET_TEAM],					clear_mindset_team,					sparFX_clearStatus);			
master_grid_add_spar_effect(SPAR_EFFECTS.CLEAR_MINDSET_GLOBAL,				textGrid[# 1, SPAR_EFFECTS.CLEAR_MINDSET_GLOBAL],				clear_mindset_global,				sparFX_clearStatus);			
master_grid_add_spar_effect(SPAR_EFFECTS.BESTOW_MINDSET_NEARBY_ALLIES,		textGrid[# 1, SPAR_EFFECTS.BESTOW_MINDSET_NEARBY_ALLIES],		bestow_mindset_nearby_allies,		sparFX_receiveBlessing);			
master_grid_add_spar_effect(SPAR_EFFECTS.BESTOW_MINDSET_NEARBY_ENEMIES,		textGrid[# 1, SPAR_EFFECTS.BESTOW_MINDSET_NEARBY_ENEMIES],		bestow_mindset_nearby_enemies,		sparFX_receiveBlessing);			
master_grid_add_spar_effect(SPAR_EFFECTS.BESTOW_MINDSET_NEARBY_SPRITES,		textGrid[# 1, SPAR_EFFECTS.BESTOW_MINDSET_NEARBY_SPRITES],		bestow_mindset_nearby_sprites,		sparFX_receiveBlessing);			
master_grid_add_spar_effect(SPAR_EFFECTS.BESTOW_MINDSET_TEAM,				textGrid[# 1, SPAR_EFFECTS.BESTOW_MINDSET_TEAM],				bestow_mindset_team,				sparFX_receiveBlessing);			
master_grid_add_spar_effect(SPAR_EFFECTS.BESTOW_MINDSET_GLOBAL,				textGrid[# 1, SPAR_EFFECTS.BESTOW_MINDSET_GLOBAL],				bestow_mindset_global,				sparFX_receiveBlessing);			
master_grid_add_spar_effect(SPAR_EFFECTS.SHIFT_MINDSET_NEARBY_ALLIES,		textGrid[# 1, SPAR_EFFECTS.SHIFT_MINDSET_NEARBY_ALLIES],		shift_mindset_nearby_allies,		sparFX_shiftMindset);			
master_grid_add_spar_effect(SPAR_EFFECTS.SHIFT_MINDSET_NEARBY_ENEMIES,		textGrid[# 1, SPAR_EFFECTS.SHIFT_MINDSET_NEARBY_ENEMIES],		shift_mindset_nearby_enemies,		sparFX_shiftMindset);			
master_grid_add_spar_effect(SPAR_EFFECTS.SHIFT_MINDSET_NEARBY_SPRITES,		textGrid[# 1, SPAR_EFFECTS.SHIFT_MINDSET_NEARBY_SPRITES],		shift_mindset_nearby_sprites,		sparFX_shiftMindset);			
master_grid_add_spar_effect(SPAR_EFFECTS.SHIFT_MINDSET_TEAM,				textGrid[# 1, SPAR_EFFECTS.SHIFT_MINDSET_TEAM],					shift_mindset_team,					sparFX_shiftMindset);			
master_grid_add_spar_effect(SPAR_EFFECTS.SHIFT_MINDSET_GLOBAL,				textGrid[# 1, SPAR_EFFECTS.SHIFT_MINDSET_GLOBAL],				shift_mindset_global,				sparFX_shiftMindset);			
master_grid_add_spar_effect(SPAR_EFFECTS.SHIFT_CURSE,						textGrid[# 1, SPAR_EFFECTS.SHIFT_CURSE],						shift_curse,						sparFX_shiftMindset);			
master_grid_add_spar_effect(SPAR_EFFECTS.SHIFT_BLESSING,					textGrid[# 1, SPAR_EFFECTS.SHIFT_BLESSING],						shift_blessing,						sparFX_shiftMindset);			
master_grid_add_spar_effect(SPAR_EFFECTS.SHIFT_CURSE_NEARBY_ALLIES,			textGrid[# 1, SPAR_EFFECTS.SHIFT_CURSE_NEARBY_ALLIES],			shift_curse_nearby_allies,			sparFX_shiftMindset);			
master_grid_add_spar_effect(SPAR_EFFECTS.SHIFT_CURSE_NEARBY_ENEMIES,		textGrid[# 1, SPAR_EFFECTS.SHIFT_CURSE_NEARBY_ENEMIES],			shift_curse_nearby_enemies,			sparFX_shiftMindset);			
master_grid_add_spar_effect(SPAR_EFFECTS.SHIFT_CURSE_NEARBY_SPRITES,		textGrid[# 1, SPAR_EFFECTS.SHIFT_CURSE_NEARBY_SPRITES],			shift_curse_nearby_sprites,			sparFX_shiftMindset);			
master_grid_add_spar_effect(SPAR_EFFECTS.SHIFT_CURSE_TEAM,					textGrid[# 1, SPAR_EFFECTS.SHIFT_CURSE_TEAM],					shift_curse_team,					sparFX_shiftMindset);			
master_grid_add_spar_effect(SPAR_EFFECTS.SHIFT_CURSE_GLOBAL,				textGrid[# 1, SPAR_EFFECTS.SHIFT_CURSE_GLOBAL],					shift_curse_global,					sparFX_shiftMindset);			
master_grid_add_spar_effect(SPAR_EFFECTS.SHIFT_BLESSING_NEARBY_ALLIES,		textGrid[# 1, SPAR_EFFECTS.SHIFT_BLESSING_NEARBY_ALLIES],		shift_blessing_nearby_allies,		sparFX_shiftMindset);			
master_grid_add_spar_effect(SPAR_EFFECTS.SHIFT_BLESSING_NEARBY_ENEMIES,		textGrid[# 1, SPAR_EFFECTS.SHIFT_BLESSING_NEARBY_ENEMIES],		shift_blessing_nearby_enemies,		sparFX_shiftMindset);			
master_grid_add_spar_effect(SPAR_EFFECTS.SHIFT_BLESSING_NEARBY_SPRITES,		textGrid[# 1, SPAR_EFFECTS.SHIFT_BLESSING_NEARBY_SPRITES],		shift_blessing_nearby_sprites,		sparFX_shiftMindset);			
master_grid_add_spar_effect(SPAR_EFFECTS.SHIFT_BLESSING_TEAM,				textGrid[# 1, SPAR_EFFECTS.SHIFT_BLESSING_TEAM],				shift_blessing_team,				sparFX_shiftMindset);			
master_grid_add_spar_effect(SPAR_EFFECTS.SHIFT_BLESSING_GLOBAL,				textGrid[# 1, SPAR_EFFECTS.SHIFT_BLESSING_GLOBAL],				shift_blessing_global,				sparFX_shiftMindset);			
master_grid_add_spar_effect(SPAR_EFFECTS.SET_HEXED_NEARBY_ALLIES,			textGrid[# 1, SPAR_EFFECTS.SET_HEXED_NEARBY_ALLIES],			set_hexed_nearby_allies,			sparFX_hexed);					
master_grid_add_spar_effect(SPAR_EFFECTS.SET_HEXED_NEARBY_ENEMIES,			textGrid[# 1, SPAR_EFFECTS.SET_HEXED_NEARBY_ENEMIES],			set_hexed_nearby_enemies,			sparFX_hexed);					
master_grid_add_spar_effect(SPAR_EFFECTS.SET_HEXED_NEARBY_SPRITES,			textGrid[# 1, SPAR_EFFECTS.SET_HEXED_NEARBY_SPRITES],			set_hexed_nearby_sprites,			sparFX_hexed);					
master_grid_add_spar_effect(SPAR_EFFECTS.SET_HEXED_TEAM,					textGrid[# 1, SPAR_EFFECTS.SET_HEXED_TEAM],						set_hexed_team,						sparFX_hexed);					
master_grid_add_spar_effect(SPAR_EFFECTS.SET_HEXED_GLOBAL,					textGrid[# 1, SPAR_EFFECTS.SET_HEXED_GLOBAL],					set_hexed_global,					sparFX_hexed);					
master_grid_add_spar_effect(SPAR_EFFECTS.SET_BOUND_NEARBY_ALLIES,			textGrid[# 1, SPAR_EFFECTS.SET_BOUND_NEARBY_ALLIES],			set_bound_nearby_allies,			sparFX_bound);					
master_grid_add_spar_effect(SPAR_EFFECTS.SET_BOUND_NEARBY_ENEMIES,			textGrid[# 1, SPAR_EFFECTS.SET_BOUND_NEARBY_ENEMIES],			set_bound_nearby_enemies,			sparFX_bound);					
master_grid_add_spar_effect(SPAR_EFFECTS.SET_BOUND_NEARBY_SPRITES,			textGrid[# 1, SPAR_EFFECTS.SET_BOUND_NEARBY_SPRITES],			set_bound_nearby_sprites,			sparFX_bound);					
master_grid_add_spar_effect(SPAR_EFFECTS.SET_BOUND_TEAM,					textGrid[# 1, SPAR_EFFECTS.SET_BOUND_TEAM],						set_bound_team,						sparFX_bound);					
master_grid_add_spar_effect(SPAR_EFFECTS.SET_BOUND_GLOBAL,					textGrid[# 1, SPAR_EFFECTS.SET_BOUND_GLOBAL],					set_bound_global,					sparFX_bound);					
master_grid_add_spar_effect(SPAR_EFFECTS.APPLY_HEXED,						textGrid[# 1, SPAR_EFFECTS.APPLY_HEXED],						apply_hexed,						sparFX_hexed);					
master_grid_add_spar_effect(SPAR_EFFECTS.APPLY_BOUND,						textGrid[# 1, SPAR_EFFECTS.APPLY_BOUND],						apply_bound,						sparFX_bound);					
master_grid_add_spar_effect(SPAR_EFFECTS.ENERGY_BLAST_GLOBAL,				textGrid[# 1, SPAR_EFFECTS.ENERGY_BLAST_GLOBAL],				energy_blast_global,				sparFX_energyBlast);			
master_grid_add_spar_effect(SPAR_EFFECTS.INCREASE_DAMAGE,					textGrid[# 1, SPAR_EFFECTS.INCREASE_DAMAGE],					increase_damage,					sparFX_increaseDamage);			
master_grid_add_spar_effect(SPAR_EFFECTS.DECREASE_DAMAGE,					textGrid[# 1, SPAR_EFFECTS.DECREASE_DAMAGE],					decrease_damage,					sparFX_decreaseDamage);			
master_grid_add_spar_effect(SPAR_EFFECTS.INCREASE_DAMAGE_NATURAL,			textGrid[# 1, SPAR_EFFECTS.INCREASE_DAMAGE_NATURAL],			increase_damage_natural,			sparFX_increaseDamage);			
master_grid_add_spar_effect(SPAR_EFFECTS.DECREASE_DAMAGE_NATURAL,			textGrid[# 1, SPAR_EFFECTS.DECREASE_DAMAGE_NATURAL],			decrease_damage_natural,			sparFX_decreaseDamage);			
master_grid_add_spar_effect(SPAR_EFFECTS.INCREASE_DAMAGE_MECHANICAL,		textGrid[# 1, SPAR_EFFECTS.INCREASE_DAMAGE_MECHANICAL],			increase_damage_mechanical,			sparFX_increaseDamage);			
master_grid_add_spar_effect(SPAR_EFFECTS.DECREASE_DAMAGE_MECHANICAL,		textGrid[# 1, SPAR_EFFECTS.DECREASE_DAMAGE_MECHANICAL],			decrease_damage_mechanical,			sparFX_decreaseDamage);			
master_grid_add_spar_effect(SPAR_EFFECTS.INCREASE_DAMAGE_ASTRAL,			textGrid[# 1, SPAR_EFFECTS.INCREASE_DAMAGE_ASTRAL],				increase_damage_astral,				sparFX_increaseDamage);			
master_grid_add_spar_effect(SPAR_EFFECTS.DECREASE_DAMAGE_ASTRAL,			textGrid[# 1, SPAR_EFFECTS.DECREASE_DAMAGE_ASTRAL],				decrease_damage_astral,				sparFX_decreaseDamage);			
master_grid_add_spar_effect(SPAR_EFFECTS.VOLCANO_WATER_DECREASE_DAMAGE,		textGrid[# 1, SPAR_EFFECTS.VOLCANO_WATER_DECREASE_DAMAGE],		volcano_water_decrease_damage,		sparFX_decreaseDamage);			
master_grid_add_spar_effect(SPAR_EFFECTS.VOLCANO_FIRE_INCREASE_DAMAGE,		textGrid[# 1, SPAR_EFFECTS.VOLCANO_FIRE_INCREASE_DAMAGE],		volcano_fire_increase_damage,		sparFX_increaseDamage);			
master_grid_add_spar_effect(SPAR_EFFECTS.OCEAN_FIRE_DECREASE_DAMAGE,		textGrid[# 1, SPAR_EFFECTS.OCEAN_FIRE_DECREASE_DAMAGE],			ocean_fire_decrease_damage,			sparFX_decreaseDamage);			
master_grid_add_spar_effect(SPAR_EFFECTS.OCEAN_STORM_INCREASE_DAMAGE,		textGrid[# 1, SPAR_EFFECTS.OCEAN_STORM_INCREASE_DAMAGE],		ocean_storm_increase_damage,		sparFX_increaseDamage);			
master_grid_add_spar_effect(SPAR_EFFECTS.OCEAN_WATER_INCREASE_DAMAGE,		textGrid[# 1, SPAR_EFFECTS.OCEAN_WATER_INCREASE_DAMAGE],		ocean_water_increase_damage,		sparFX_increaseDamage);			
master_grid_add_spar_effect(SPAR_EFFECTS.STRATOS_EARTH_DECREASE_DAMAGE,		textGrid[# 1, SPAR_EFFECTS.STRATOS_EARTH_DECREASE_DAMAGE],		stratos_earth_decrease_damage,		sparFX_decreaseDamage);			
master_grid_add_spar_effect(SPAR_EFFECTS.STRATOS_STORM_INCREASE_DAMAGE,		textGrid[# 1, SPAR_EFFECTS.STRATOS_STORM_INCREASE_DAMAGE],		stratos_storm_increase_damage,		sparFX_increaseDamage);			
master_grid_add_spar_effect(SPAR_EFFECTS.FOREST_FIRE_INCREASE_DAMAGE,		textGrid[# 1, SPAR_EFFECTS.FOREST_FIRE_INCREASE_DAMAGE],		forest_fire_increase_damage,		sparFX_increaseDamage);			
master_grid_add_spar_effect(SPAR_EFFECTS.FOREST_EARTH_INCREASE_DAMAGE,		textGrid[# 1, SPAR_EFFECTS.FOREST_EARTH_INCREASE_DAMAGE],		forest_earth_increase_damage,		sparFX_increaseDamage);			
master_grid_add_spar_effect(SPAR_EFFECTS.DESTROY_ARENA,						textGrid[# 1, SPAR_EFFECTS.DESTROY_ARENA],						destroy_arena,						sparFX_destroyArena);			
master_grid_add_spar_effect(SPAR_EFFECTS.DRAIN_HEALTH,						textGrid[# 1, SPAR_EFFECTS.DRAIN_HEALTH],						drain_health,						sparFX_restore);				
master_grid_add_spar_effect(SPAR_EFFECTS.DRAIN_MAGIC,						textGrid[# 1, SPAR_EFFECTS.DRAIN_MAGIC],						drain_magic,						sparFX_restore);				
master_grid_add_spar_effect(SPAR_EFFECTS.REPLACE_TARGET,					textGrid[# 1, SPAR_EFFECTS.REPLACE_TARGET],						replace_target,						sparFX_replaceTarget);			
master_grid_add_spar_effect(SPAR_EFFECTS.BALL_LIGHTNING_SET_ACTIVE,			textGrid[# 1, SPAR_EFFECTS.BALL_LIGHTNING_SET_ACTIVE],			ball_lightning_set_active,			sparFX_ballLightning);			
master_grid_add_spar_effect(SPAR_EFFECTS.BALL_LIGHTNING_ABSORB_SPELL,		textGrid[# 1, SPAR_EFFECTS.BALL_LIGHTNING_ABSORB_SPELL],		ball_lightning_absorb_spell,		sparFX_ballLightning);			
master_grid_add_spar_effect(SPAR_EFFECTS.BALL_LIGHTNING_APPLY_DAMAGE,		textGrid[# 1, SPAR_EFFECTS.BALL_LIGHTNING_APPLY_DAMAGE],		ball_lightning_apply_damage,		sparFX_energyBlast);			
master_grid_add_spar_effect(SPAR_EFFECTS.BLACK_HOLE_SET_ACTIVE,				textGrid[# 1, SPAR_EFFECTS.BLACK_HOLE_SET_ACTIVE],				black_hole_set_active,				sparFX_blackHole);				
master_grid_add_spar_effect(SPAR_EFFECTS.BLACK_HOLE_ABSORB_SPELL,			textGrid[# 1, SPAR_EFFECTS.BLACK_HOLE_ABSORB_SPELL],			black_hole_absorb_spell,			sparFX_blackHole);				
master_grid_add_spar_effect(SPAR_EFFECTS.BLACK_HOLE_APPLY_DAMAGE,			textGrid[# 1, SPAR_EFFECTS.BLACK_HOLE_APPLY_DAMAGE],			black_hole_apply_damage,			sparFX_energyBlast);			
master_grid_add_spar_effect(SPAR_EFFECTS.APPLY_SELF_DAMAGE,					textGrid[# 1, SPAR_EFFECTS.APPLY_SELF_DAMAGE],					apply_self_damage,					EMPTY_SPRITE);							
master_grid_add_spar_effect(SPAR_EFFECTS.SET_BERSERK,						textGrid[# 1, SPAR_EFFECTS.SET_BERSERK],						set_berserk,						sparFX_berserk);				
master_grid_add_spar_effect(SPAR_EFFECTS.SET_BERSERK_NEARBY_ALLIES,			textGrid[# 1, SPAR_EFFECTS.SET_BERSERK_NEARBY_ALLIES],			set_berserk_nearby_allies,			sparFX_berserk);				
master_grid_add_spar_effect(SPAR_EFFECTS.SET_BERSERK_NEARBY_ENEMIES,		textGrid[# 1, SPAR_EFFECTS.SET_BERSERK_NEARBY_ENEMIES],			set_berserk_nearby_enemies,			sparFX_berserk);				
master_grid_add_spar_effect(SPAR_EFFECTS.SET_BERSERK_NEARBY_SPRITES,		textGrid[# 1, SPAR_EFFECTS.SET_BERSERK_NEARBY_SPRITES],			set_berserk_nearby_sprites,			sparFX_berserk);				
master_grid_add_spar_effect(SPAR_EFFECTS.SET_BERSERK_TEAM,					textGrid[# 1, SPAR_EFFECTS.SET_BERSERK_TEAM],					set_berserk_team,					sparFX_berserk);				
master_grid_add_spar_effect(SPAR_EFFECTS.SET_BERSERK_GLOBAL,				textGrid[# 1, SPAR_EFFECTS.SET_BERSERK_GLOBAL],					set_berserk_global,					sparFX_berserk);				
master_grid_add_spar_effect(SPAR_EFFECTS.SET_INVULNERABLE,					textGrid[# 1, SPAR_EFFECTS.SET_INVULNERABLE],					set_invulnerable,					sparFX_invulnerable);			
master_grid_add_spar_effect(SPAR_EFFECTS.SET_INVULNERABLE_NEARBY_ALLIES,	textGrid[# 1, SPAR_EFFECTS.SET_INVULNERABLE_NEARBY_ALLIES],		set_invulnerable_nearby_allies,		sparFX_invulnerable);			
master_grid_add_spar_effect(SPAR_EFFECTS.SET_INVULNERABLE_NEARBY_ENEMIES,	textGrid[# 1, SPAR_EFFECTS.SET_INVULNERABLE_NEARBY_ENEMIES],	set_invulnerable_nearby_enemies,	sparFX_invulnerable);			
master_grid_add_spar_effect(SPAR_EFFECTS.SET_INVULNERABLE_NEARBY_SPRITES,	textGrid[# 1, SPAR_EFFECTS.SET_INVULNERABLE_NEARBY_SPRITES],	set_invulnerable_nearby_sprites,	sparFX_invulnerable);			
master_grid_add_spar_effect(SPAR_EFFECTS.SET_INVULNERABLE_TEAM,				textGrid[# 1, SPAR_EFFECTS.SET_INVULNERABLE_TEAM],				set_invulnerable_team,				sparFX_invulnerable);			
master_grid_add_spar_effect(SPAR_EFFECTS.SET_INVULNERABLE_GLOBAL,			textGrid[# 1, SPAR_EFFECTS.SET_INVULNERABLE_GLOBAL],			set_invulnerable_global,			sparFX_invulnerable);			
master_grid_add_spar_effect(SPAR_EFFECTS.SET_PARRYING,						textGrid[# 1, SPAR_EFFECTS.SET_PARRYING],						set_parrying,						sparFX_parry);					
master_grid_add_spar_effect(SPAR_EFFECTS.APPLY_PARRY,						textGrid[# 1, SPAR_EFFECTS.APPLY_PARRY],						apply_parry,						spr_spellFX_basicAttack);				
master_grid_add_spar_effect(SPAR_EFFECTS.IGNORE_PARRY,						textGrid[# 1, SPAR_EFFECTS.IGNORE_PARRY],						ignore_parry,						sparFX_ignoreParry);			
master_grid_add_spar_effect(SPAR_EFFECTS.SET_DIVIDING,						textGrid[# 1, SPAR_EFFECTS.SET_DIVIDING],						set_dividing,						sparFX_divide);					
master_grid_add_spar_effect(SPAR_EFFECTS.SET_MULTIPLYING,					textGrid[# 1, SPAR_EFFECTS.SET_MULTIPLYING],					set_multiplying,					sparFX_multiply);				
master_grid_add_spar_effect(SPAR_EFFECTS.DIVIDE_HEALING,					textGrid[# 1, SPAR_EFFECTS.DIVIDE_HEALING],						divide_healing,						sparFX_divide);					
master_grid_add_spar_effect(SPAR_EFFECTS.DIVIDE_DAMAGE,						textGrid[# 1, SPAR_EFFECTS.DIVIDE_DAMAGE],						divide_damage,						sparFX_divide);					
master_grid_add_spar_effect(SPAR_EFFECTS.MULTIPLY_HEALING,					textGrid[# 1, SPAR_EFFECTS.MULTIPLY_HEALING],					multiply_healing,					sparFX_multiply);				
master_grid_add_spar_effect(SPAR_EFFECTS.MULTIPLY_DAMAGE,					textGrid[# 1, SPAR_EFFECTS.MULTIPLY_DAMAGE],					multiply_damage,					sparFX_multiply);				
master_grid_add_spar_effect(SPAR_EFFECTS.SET_DEFLECTIVE,					textGrid[# 1, SPAR_EFFECTS.SET_DEFLECTIVE],						set_deflective,						sparFX_deflect);				
master_grid_add_spar_effect(SPAR_EFFECTS.DEFLECT_SPELL,						textGrid[# 1, SPAR_EFFECTS.DEFLECT_SPELL],						deflect_spell,						sparFX_deflect);				
master_grid_add_spar_effect(SPAR_EFFECTS.FORCE_TURN_END,					textGrid[# 1, SPAR_EFFECTS.FORCE_TURN_END],						force_turn_end,						sparFX_time);					
master_grid_add_spar_effect(SPAR_EFFECTS.REPEAT_LAST_TURN,					textGrid[# 1, SPAR_EFFECTS.REPEAT_LAST_TURN],					repeat_last_turn,					sparFX_time);					
master_grid_add_spar_effect(SPAR_EFFECTS.PSYCHIC_ATTACK,					textGrid[# 1, SPAR_EFFECTS.PSYCHIC_ATTACK],						psychic_attack,						EMPTY_SPRITE);							
master_grid_add_spar_effect(SPAR_EFFECTS.CHANGE_ALIGNMENT,					textGrid[# 1, SPAR_EFFECTS.CHANGE_ALIGNMENT],					change_alignment,					sparFX_alignment);				
master_grid_add_spar_effect(SPAR_EFFECTS.CHANGE_SIZE,						textGrid[# 1, SPAR_EFFECTS.CHANGE_SIZE],						change_size,						sparFX_size);					
master_grid_add_spar_effect(SPAR_EFFECTS.ENERGY_BLAST_SELF,					textGrid[# 1, SPAR_EFFECTS.ENERGY_BLAST_SELF],					energy_blast_self,					sparFX_energyBlast);			
master_grid_add_spar_effect(SPAR_EFFECTS.FORCE_BEST_LUCK,					textGrid[# 1, SPAR_EFFECTS.FORCE_BEST_LUCK],					force_best_luck,					sparFX_luck);					
master_grid_add_spar_effect(SPAR_EFFECTS.FORCE_WORST_LUCK,					textGrid[# 1, SPAR_EFFECTS.FORCE_WORST_LUCK],					force_worst_luck,					sparFX_luck);					
master_grid_add_spar_effect(SPAR_EFFECTS.FORCE_BEST_LUCK_TEAM,				textGrid[# 1, SPAR_EFFECTS.FORCE_BEST_LUCK_TEAM],				force_best_luck_team,				sparFX_luck);					
master_grid_add_spar_effect(SPAR_EFFECTS.FORCE_WORST_LUCK_TEAM,				textGrid[# 1, SPAR_EFFECTS.FORCE_WORST_LUCK_TEAM],				force_worst_luck_team,				sparFX_luck);					
master_grid_add_spar_effect(SPAR_EFFECTS.FORCE_BEST_LUCK_GLOBAL,			textGrid[# 1, SPAR_EFFECTS.FORCE_BEST_LUCK_GLOBAL],				force_best_luck_global,				sparFX_luck);					
master_grid_add_spar_effect(SPAR_EFFECTS.FORCE_WORST_LUCK_GLOBAL,			textGrid[# 1, SPAR_EFFECTS.FORCE_WORST_LUCK_GLOBAL],			force_worst_luck_global,			sparFX_luck);					
master_grid_add_spar_effect(SPAR_EFFECTS.SET_HAIL_SPHERA,					textGrid[# 1, SPAR_EFFECTS.SET_HAIL_SPHERA],					set_hail_sphera,					EMPTY_SPRITE);							
master_grid_add_spar_effect(SPAR_EFFECTS.HAIL_SPHERA_SET_INVULNERABLE,		textGrid[# 1, SPAR_EFFECTS.HAIL_SPHERA_SET_INVULNERABLE],		hail_sphera_set_invulnerable,		sparFX_invulnerable);			
master_grid_add_spar_effect(SPAR_EFFECTS.BERSERK_INCREASE_DAMAGE,			textGrid[# 1, SPAR_EFFECTS.BERSERK_INCREASE_DAMAGE],			berserk_increase_damage,			sparFX_berserk);				
master_grid_add_spar_effect(SPAR_EFFECTS.APPLY_BERSERK,						textGrid[# 1, SPAR_EFFECTS.APPLY_BERSERK],						apply_berserk,						sparFX_berserk);				
master_grid_add_spar_effect(SPAR_EFFECTS.APPLY_INVULNERABLE,				textGrid[# 1, SPAR_EFFECTS.APPLY_INVULNERABLE],					apply_invulnerable,					sparFX_invulnerable);			
master_grid_add_spar_effect(SPAR_EFFECTS.END_BERSERK,						textGrid[# 1, SPAR_EFFECTS.END_BERSERK],						end_berserk,						sparFX_clearStatus);			
master_grid_add_spar_effect(SPAR_EFFECTS.END_BERSERK_NEARBY_ALLIES,			textGrid[# 1, SPAR_EFFECTS.END_BERSERK_NEARBY_ALLIES],			end_berserk_nearby_allies,			sparFX_clearStatus);			
master_grid_add_spar_effect(SPAR_EFFECTS.END_BERSERK_NEARBY_ENEMIES,		textGrid[# 1, SPAR_EFFECTS.END_BERSERK_NEARBY_ENEMIES],			end_berserk_nearby_allies,			sparFX_clearStatus);			
master_grid_add_spar_effect(SPAR_EFFECTS.END_BERSERK_NEARBY_SPRITES,		textGrid[# 1, SPAR_EFFECTS.END_BERSERK_NEARBY_SPRITES],			end_berserk_nearby_sprites,			sparFX_clearStatus);			
master_grid_add_spar_effect(SPAR_EFFECTS.END_BERSERK_TEAM,					textGrid[# 1, SPAR_EFFECTS.END_BERSERK_TEAM],					end_berserk_team,					sparFX_clearStatus);			
master_grid_add_spar_effect(SPAR_EFFECTS.END_BERSERK_GLOBAL,				textGrid[# 1, SPAR_EFFECTS.END_BERSERK_GLOBAL],					end_berserk_global,					sparFX_clearStatus);			
master_grid_add_spar_effect(SPAR_EFFECTS.END_INVULNERABLE,					textGrid[# 1, SPAR_EFFECTS.END_INVULNERABLE],					end_invulnerable,					sparFX_clearStatus);			
master_grid_add_spar_effect(SPAR_EFFECTS.END_INVULNERABLE_NEARBY_ALLIES,	textGrid[# 1, SPAR_EFFECTS.END_INVULNERABLE_NEARBY_ALLIES],		end_invulnerable_nearby_allies,		sparFX_clearStatus);			
master_grid_add_spar_effect(SPAR_EFFECTS.END_INVULNERABLE_NEARBY_ENEMIES,	textGrid[# 1, SPAR_EFFECTS.END_INVULNERABLE_NEARBY_ENEMIES],	end_invulnerable_nearby_enemies,	sparFX_clearStatus);			
master_grid_add_spar_effect(SPAR_EFFECTS.END_INVULNERABLE_NEARBY_SPRITES,	textGrid[# 1, SPAR_EFFECTS.END_INVULNERABLE_NEARBY_SPRITES],	end_invulnerable_nearby_sprites,	sparFX_clearStatus);			
master_grid_add_spar_effect(SPAR_EFFECTS.END_INVULNERABLE_TEAM,				textGrid[# 1, SPAR_EFFECTS.END_INVULNERABLE_TEAM],				end_invulnerable_team,				sparFX_clearStatus);			
master_grid_add_spar_effect(SPAR_EFFECTS.END_INVULNERABLE_GLOBAL,			textGrid[# 1, SPAR_EFFECTS.END_INVULNERABLE_GLOBAL],			end_invulnerable_global,			sparFX_clearStatus);			
master_grid_add_spar_effect(SPAR_EFFECTS.RESTORE_ALIGNMENT,					textGrid[# 1, SPAR_EFFECTS.RESTORE_ALIGNMENT],					restore_alignment,					sparFX_clearStatus);			
master_grid_add_spar_effect(SPAR_EFFECTS.RESTORE_SIZE,						textGrid[# 1, SPAR_EFFECTS.RESTORE_SIZE],						restore_size,						sparFX_clearStatus);			
master_grid_add_spar_effect(SPAR_EFFECTS.SKYDIVE_APPLY_DAMAGE,				textGrid[# 1, SPAR_EFFECTS.SKYDIVE_APPLY_DAMAGE],				skydive_apply_damage,				spr_spellFX_basicAttack);				
master_grid_add_spar_effect(SPAR_EFFECTS.SNEAK_ATTACK_APPLY_DAMAGE,			textGrid[# 1, SPAR_EFFECTS.SNEAK_ATTACK_APPLY_DAMAGE],			sneak_attack_apply_damage,			spr_spellFX_basicAttack);				
master_grid_add_spar_effect(SPAR_EFFECTS.SKYDIVE_FAILURE,					textGrid[# 1, SPAR_EFFECTS.SKYDIVE_FAILURE],					skydive_failure,					sparFX_failure);				
master_grid_add_spar_effect(SPAR_EFFECTS.SNEAK_ATTACK_FAILURE,				textGrid[# 1, SPAR_EFFECTS.SNEAK_ATTACK_FAILURE],				sneak_attack_failure,				sparFX_failure);				
master_grid_add_spar_effect(SPAR_EFFECTS.ACTIVATE_ABILITY,					textGrid[# 1, SPAR_EFFECTS.ACTIVATE_ABILITY],					activate_ability,					EMPTY_SPRITE);		
master_grid_add_spar_effect(SPAR_EFFECTS.BONUS_SPELL,						textGrid[# 1, SPAR_EFFECTS.BONUS_SPELL],						bonus_spell,						EMPTY_SPRITE);
master_grid_add_spar_effect(SPAR_EFFECTS.IMPROVE_RANGE,						textGrid[# 1, SPAR_EFFECTS.IMPROVE_RANGE],						improve_range_spar_effect,			EMPTY_SPRITE);
master_grid_add_spar_effect(SPAR_EFFECTS.SYNCHRONIZE_SPRITES,				textGrid[# 1, SPAR_EFFECTS.SYNCHRONIZE_SPRITES],				synchronize_sprites,				EMPTY_SPRITE);
master_grid_add_spar_effect(SPAR_EFFECTS.ARBITRATE_TURN,					textGrid[# 1, SPAR_EFFECTS.ARBITRATE_TURN],						arbitrate_turn,						EMPTY_SPRITE);
master_grid_add_spar_effect(SPAR_EFFECTS.BASIC_ATTACK_FIRE,					textGrid[# 1, SPAR_EFFECTS.BASIC_ATTACK_FIRE],					basic_attack_fire,					EMPTY_SPRITE);
master_grid_add_spar_effect(SPAR_EFFECTS.BASIC_ATTACK_WATER,				textGrid[# 1, SPAR_EFFECTS.BASIC_ATTACK_WATER],					basic_attack_water,					EMPTY_SPRITE);
master_grid_add_spar_effect(SPAR_EFFECTS.BASIC_ATTACK_STORM,				textGrid[# 1, SPAR_EFFECTS.BASIC_ATTACK_STORM],					basic_attack_storm,					EMPTY_SPRITE);
master_grid_add_spar_effect(SPAR_EFFECTS.BASIC_ATTACK_EARTH,				textGrid[# 1, SPAR_EFFECTS.BASIC_ATTACK_EARTH],					basic_attack_earth,					EMPTY_SPRITE);
master_grid_add_spar_effect(SPAR_EFFECTS.BASIC_ATTACK_RESISTANCE,			textGrid[# 1, SPAR_EFFECTS.BASIC_ATTACK_RESISTANCE],			basic_attack_resistance,			EMPTY_SPRITE);
master_grid_add_spar_effect(SPAR_EFFECTS.BASIC_ATTACK_AGILITY,				textGrid[# 1, SPAR_EFFECTS.BASIC_ATTACK_AGILITY],				basic_attack_agility,				EMPTY_SPRITE);
master_grid_add_spar_effect(SPAR_EFFECTS.SET_IMMOBILIZED,					textGrid[# 1, SPAR_EFFECTS.SET_IMMOBILIZED],					set_immobilized,					EMPTY_SPRITE);
master_grid_add_spar_effect(SPAR_EFFECTS.REMOVE_IMMOBILIZED,				textGrid[# 1, SPAR_EFFECTS.REMOVE_IMMOBILIZED],					remove_immobilized,					EMPTY_SPRITE);
master_grid_add_spar_effect(SPAR_EFFECTS.NEGATE_DAMAGE,						textGrid[# 1, SPAR_EFFECTS.NEGATE_DAMAGE],						negate_damage,						EMPTY_SPRITE);
master_grid_add_spar_effect(SPAR_EFFECTS.NEGATE_SPELL_COST,					textGrid[# 1, SPAR_EFFECTS.NEGATE_SPELL_COST],					negate_spell_cost,					EMPTY_SPRITE);
master_grid_add_spar_effect(SPAR_EFFECTS.FORCE_SPELL_FAILURE,				textGrid[# 1, SPAR_EFFECTS.FORCE_SPELL_FAILURE],				force_spell_failure,				EMPTY_SPRITE);
master_grid_add_spar_effect(SPAR_EFFECTS.OUT_OF_RANGE_SELECTION,			textGrid[# 1, SPAR_EFFECTS.OUT_OF_RANGE_SELECTION],				out_of_range_selection,				EMPTY_SPRITE);
master_grid_add_spar_effect(SPAR_EFFECTS.OUT_OF_RANGE_ACTION,				textGrid[# 1, SPAR_EFFECTS.OUT_OF_RANGE_ACTION],				out_of_range_action,				EMPTY_SPRITE);
#endregion

// encode the spar effect grid
global.allSparEffects = encode_grid(global.sparEffectGrid);

// delete the spar effect grid and the text grid
ds_grid_destroy(global.sparEffectGrid);
ds_grid_destroy(textGrid);