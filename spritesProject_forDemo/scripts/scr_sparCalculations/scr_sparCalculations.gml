#macro MAX_LUCK		1075
#macro MIN_LUCK		725

global.averageWeaknesses		= ds_list_create();
global.averageStrengths			= ds_list_create();
global.agilityOdds				= 0;
global.damageMultiplierIndex	= 0;

enum elements {
	fire,
	water,
	storm,
	earth,
	height
}

///@desc This function can be called to process the actual increase to current HP
/// that occurs when restoring HP
function restore_hp(_player, _amount) {
	var p = _player;
	var a = _amount;
	
	if ((p.currentHP + a) > MAX_HP) {
		a = MAX_HP - p.currentHP;	
	}
	
	p.currentHP += a;
	
	// perform an ability check for hp restored
	ability_check(ABILITY_TYPES.HP_RESTORED);
}

///@desc This function can be called to process the actual increase to current MP
/// that occurs when restoring MP
function restore_mp(_player, _amount) {
	var p = _player;
	var a = _amount;
	
	if ((p.currentMP + a) > MAX_MP) {
		a = MAX_MP - p.currentMP;	
	}
	
	p.currentMP += a;
	
	// perform an ability check for mp restored
	ability_check(ABILITY_TYPES.MP_RESTORED);
}

///@desc This function can be called to process the actual decrease to current HP
/// that occurs when depleting HP
function deplete_hp(_player, _amount) {
	var p = _player;
	var a = _amount;
	
	if ((p.currentHP - a) < 0) {
		a = p.currentHP;	
	}
	
	p.currentHP -= a;
	
	// perform an ability check for hp depleted
	ability_check(ABILITY_TYPES.HP_DEPLETED);
}

///@desc This function can be called to process the actual decrease to current MP
/// that occurs when depleting MP
function deplete_mp(_player, _amount) {
	var p = _player;
	var a = _amount;
	
	if ((p.currentMP - a) < 0) {
		a = p.currentMP;	
	}
	
	p.currentMP -= a;
	
	// perform an ability check for mp depleted
	ability_check(ABILITY_TYPES.MP_DEPLETED);
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
	
	var luckFloor = MIN_LUCK;
	var luckCeiling = MAX_LUCK;
	
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

	// get damage multiplier from dmi
	var m = get_multiplier_from_index();

	// calculate damage
	var damage = sp * casterRatio * affinityRatio * weaknessRatio * resistanceRatio * m;
	
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
	
	// get damage multiplier from dmi
	var m = get_multiplier_from_index();	
	
	// calculate damage
	var damage = sp * damageRatio * m;
	
	// return damage multiplied by average luck
	return damage;
}

function arbitrate_physical_damage(_atkr, _targ, _spellType, _spellPower) {
	// store args in locals
	var atkr = _atkr;
	var targ = _targ;
	var st = _spellType;
	var sp = _spellPower;
	
	// initialize atkStat and targStat
	var atkStat = 0;
	var targStat = 0;
	
	// use a switch statement to set atkStat and targStat
	switch (st) {
		case SPRITE_PARAMS.FIRE:
			atkStat = atkr.currentFire;
			targStat = atkr.currentFire;
		break;
		
		case SPRITE_PARAMS.WATER:
			atkStat = atkr.currentWater;
			targStat = atkr.currentWater;
		break;
		
		case SPRITE_PARAMS.STORM:
			atkStat = atkr.currentStorm;
			targStat = atkr.currentStorm;
		break;
		
		case SPRITE_PARAMS.EARTH:
			atkStat = atkr.currentEarth;
			targStat = atkr.currentEarth;
		break;
		
		case SPRITE_PARAMS.RESISTANCE:
			atkStat = atkr.currentResistance;
			targStat = atkr.currentResistance;
		break;
		
		case SPRITE_PARAMS.AGILITY:
			atkStat = atkr.currentAgility;
			targStat = atkr.currentAgility;
		break;
	}
	
	// get attacker's and target's luck rolls
	var atkrLuck = atkr.luckRoll;
	var targLuck = targ.luckRoll;
	
	// calculate physical style damage ratio using the now set atkrStat and targStat
	var damageRatio = (atkStat * atkrLuck) / (targStat * targLuck);
	
	// get damage multiplier from dmi
	var m = get_multiplier_from_index();
	
	// calculate damage
	var damage = sp * damageRatio * m;
	
	// return damage multiplied by average luck
	return damage;
}
	
function get_psychic_damage(_atkr, _targ, _power) {
	// store args in locals	
	var atkr = _atkr;
	var targ = _targ;
	var powr = _power;
	
	var atkStat = atkr.currentPower;
	var resStat = targ.currentPower;
	
	// deduce optimum stats
	var i = 0;	repeat (5) {
		switch (i) {
			case 0:
				if (atkr.currentResistance> atkStat)	atkStat = atkr.currentResistance;
				if (targ.currentResistance< resStat)	resStat = targ.currentResistance;
			break;
			
			case 1:
				if (atkr.currentFire > atkStat)		atkStat = atkr.currentFire;
				if (targ.currentFire < resStat)		resStat = targ.currentFire;
			break;
			
			case 2:
				if (atkr.currentWater > atkStat)	atkStat = atkr.currentWater;
				if (targ.currentWater < resStat)	resStat = targ.currentWater;
			break;
			
			case 3:
				if (atkr.currentStorm > atkStat)	atkStat = atkr.currentStorm;
				if (targ.currentStorm < resStat)	resStat = targ.currentStorm;
			break;
			
			case 4:
				if (atkr.currentEarth > atkStat)	atkStat = atkr.currentEarth;
				if (targ.currentEarth < resStat)	resStat = targ.currentEarth;
			break;
		}
	
		i++;
	}
	
	// check luckRolls
	var atkrLuck = atkr.luckRoll;
	var targLuck = targ.luckRoll;
	
	// get the ratio that determines the output
	var damageRatio = (atkStat * atkrLuck) / (resStat * targLuck);
	
	// get damage multiplier from dmi
	var m = get_multiplier_from_index();
	
	// calculate damage
	var d = powr * damageRatio * m;
	
	// perform an ability check for damage calc
	ability_check(ABILITY_TYPES.DAMAGE_CALC);
	
	// return damage
	return d;
}

///@desc This function should be called right before the damage calc functions return the damage. It 
/// performs an algorithm that will return a damage multiplier relative to the multiplierIndex (it will
/// then reset the multiplierIndex)
function get_multiplier_from_index() {	
	// store globals in locals
	var dmi = global.damageMultiplierIndex;
	
	// use dmi to get multiplier
	var m = 1;
	m += (dmi * 0.2);
	
	// reset the dmi
	global.damageMultiplierIndex = 0;
	
	// return the multiplier
	return m;
}