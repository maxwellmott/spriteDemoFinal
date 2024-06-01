#macro MAX_LUCK		1075
#macro MIN_LUCK		725

global.averageWeaknesses	= ds_list_create();
global.averageStrengths		= ds_list_create();
global.agilityOdds			= 0;

enum elements {
	fire,
	water,
	storm,
	earth,
	height
}

///@desc This function takes a size value from the SPRITE_SIZES and returns
/// a value to use when calculating dodge success
function get_size_val(_size) {
	var s = _size;
	switch (s) {
		case SPRITE_SIZES.X_LARGE:	return 0.0;	break;
		case SPRITE_SIZES.LARGE:	return 0.5;	break;
		case SPRITE_SIZES.MEDIUM:	return 1.0;	break;
		case SPRITE_SIZES.SMALL:	return 1.5;	break;
		case SPRITE_SIZES.X_SMALL:	return 2.0;	break;
	}
}

///@desc This function returns a value that's representative of the difficulty
/// of the dodge attempt currently in question. It takes the attacker's and target's
/// agility and size stats.
function get_dodge_tier(_atkrAgl, _targAgl, _atkrSize, _targSize) {
	var atkrAgl = _atkrAgl;
	var targAgl = _targAgl;
	var atkrSize = _atkrSize;
	var targSize = _targSize;
	
	var aSizeVal = get_size_val(atkrSize);
	var tSizeVal = get_size_val(targSize);
	
	var aglRatio = targAgl / atkrAgl;
	var tierSum = aglRatio + aSizeVal + tSizeVal;
	
	if (tierSum < 1.0)		return 1;
	if (tierSum < 2.0)		return 2;
	if (tierSum < 3.0)		return 3;
	if (tierSum < 4.0)		return 4;
	if (tierSum < 5.0)		return 5;
	if (tierSum < 6.0)		return 6;
	if (tierSum < 7.0)		return 7;
	if (tierSum <= 8.0)		return 8;
}


///@TODO add conditionals to the next function to make the dodge more difficult depending
/// on how many times the dodger has already dodged this turn.

///@desc This function takes the dodge tier value returned by the get_dodge_tier
/// function. It uses a switch statement to return the lowest possible luck roll that
/// would permit the current dodge attempt to be successful.
function get_lowest_luck(_tier) {
	var tier = _tier;
	
	switch (tier) {
		case 1:	return 1.075;
		case 2: return 1.025;
		case 3: return 0.975;
		case 4: return 0.925;
		case 5: return 0.875;
		case 6: return 0.825;
		case 7: return 0.775;
		case 8: return 0.725;
	}
}

///@desc This function is meant to be called by the sparActionProcessor. It uses the get_dodge_tier,
/// and get_lowest_luck functions to determine if the dodging sprite had a high enough luck roll to
/// dodge successfully.
function get_dodge_success() {
	var dt = get_dodge_tier(activeSprite.currentAgility, targetSprite.currentAgility, activeSprite.currentSize, targetSprite.currentSize);
	
	var ll = get_lowest_luck(dt);
	
	if (activeSprite.luckRoll >= ll)	return true;
	
	return false;
}

///@desc This function takes a sprite's luck stat and returns the number of rolls
/// the sprite is allowed to attempt. (1--7)
function get_luck_tier(_luck) {
	var luck = _luck;
	
	var luckTier = luck div 25;
	
	if (luckTier == 0) luckTier = 1;
	if (luckTier > 7) luckTier = 7;
	
	return luckTier;
}

///@desc This function takes a sprite's luck tier returned by the function get_luck_tier
/// and rolls for luck that many times. It returns the highest roll.
function roll_for_luck(_luckTier) {
	var lt = _luckTier;
	
	var highestRoll = 0;
	
	var luckFloor = 725;
	var luckCeiling = 1075;
	
	repeat (lt ) {
		randomize();
		var roll = irandom_range(luckFloor, luckCeiling);
		if roll > highestRoll {
			if (roll == luckCeiling)	return roll;
			
			highestRoll = roll;
		}
	}
	
	return highestRoll / 1000;
}

///@desc This function takes the instance ids of the target and caster of an elemental
/// spell. It also takes the element and power of the spell being cast. It calculates and
/// then returns the damage.
function get_elemental_damage(_targ, _atkr, _lmnt, _spellPower) {
	// store args in locals
	var targ = _targ;
	var atkr = _atkr;
	var lmnt = _lmnt;
	var sp = _spellPower;
	
	// initialize local vars for elemental stats
	var atkStatTarg;
	var atkStatAtkr;
	var weakStatTarg;
	var strongStatTarg;
	
	// get the proper stats to use for damage calc
	switch (lmnt) {
		case elements.fire:
			atkStatTarg		= targ.currentFire;
			atkStatAtkr		= atkr.currentFire;
			weakStatTarg	= targ.currentEarth;
			strongStatTarg	= targ.currentWater;
		break;
		
		case elements.water:
			atkStatTarg		= targ.currentWater;
			atkStatAtkr		= atkr.currentWater;
			weakStatTarg	= targ.currentFire;
			strongStatTarg	= targ.currentStorm;		
		break;
		
		case elements.storm:
			atkStatTarg		= targ.currentStorm;
			atkStatAtkr		= atkr.currentStorm;
			weakStatTarg	= targ.currentWater;
			strongStatTarg	= targ.currentEarth;
		break;
		
		case elements.earth:
			atkStatTarg		= targ.currentEarth;
			atkStatAtkr		= atkr.currentEarth;
			weakStatTarg	= targ.currentStorm;
			strongStatTarg	= targ.currentFire;
		break;
	}
	
	// get luck stats
	var atkrLuck = atkr.luckRoll;
	var targLuck = targ.luckRoll;
	
	// get all ratios necessary for calculating damage
	var casterRatio		= atkStatAtkr * atkrLuck / 100;		// increase in stat produces INCREASE in output
	var affinityRatio	= 100 / atkStatTarg * targLuck;		// increase in stat produces DECREASE in output
	var weaknessRatio	= weakStatTarg * targLuck / 100;		// increase in stat produces INCREASE in output
	var resistanceRatio	= 100 / strongStatTarg * targLuck;		// increase in stat produces DECREASE in output

	// calculate damage
	var damage = sp * casterRatio * affinityRatio * weaknessRatio * resistanceRatio;
	
	// return damage
	return damage;
}

///@desc This function takes the instance ids of the attacker and the target as well as the power
/// of a physical spell or basic attack. It calculates and returns the damage of the attack.
function get_physical_damage(_atkr, _targ, _spellPower) {
	// store args in locals
	var atkr = _atkr;
	var targ = _targ;
	var sp = _spellPower;
	
	// get attacker's power and target's resistance stats
	var atkrPow = atkr.currentPower;
	var targRes = targ.currentPower;
	
	// get attacker's and target's luck rolls
	var atkrLuck = atkr.luckRoll;
	var targLuck = targ.luckRoll;
	
	// get the ratio that determines the damage output
	var damageRatio = (atkrPow * atkrLuck) / (targRes * targLuck);
	
	// calculate damage
	var damage = sp * damageRatio;
	
	// return damage multiplied by average luck
	return damage;
}
	
function get_faster_sprite(_sprite1, _sprite2) {
	var s1 = _sprite1;
	var s2 = _sprite2;
	
	var spd1 = sprite_get_stat(spriteParams.agility, s1);
	var spd2 = sprite_get_stat(spriteParams.agility, s2);
	
	if (spd1 > spd2)	return s1;
	if (spd2 > spd1)	return s2;
	
	if (spd2 == spd1)	return -1;
}

function calculate_psychic_damage(_caster, _target, _power) {
	// physical damage but use their best and worst stat respectively	
}