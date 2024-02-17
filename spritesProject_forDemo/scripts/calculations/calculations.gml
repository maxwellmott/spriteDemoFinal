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

function get_size_val(_size) {
	var s = _size;
	switch (s) {
		case spriteSizes.xLarge:	return 0.0;	break;
		case spriteSizes.large:		return 0.5;	break;
		case spriteSizes.medium:	return 1.0;	break;
		case spriteSizes.small:		return 1.5;	break;
		case spriteSizes.xSmall:	return 2.0;	break;
	}
}

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

function get_luck_tier(_luck) {
	var luck = _luck;
	
	var luckTier = luck div 25;
	
	if (luckTier == 0) luckTier = 1;
	if (luckTier > 7) luckTier = 7;
	
	return luckTier;
}

function get_elemental_damage(_targ, _atkr, _lmnt, _spellPower) {
	var targ = _targ;
	var atkr = _atkr;
	var lmnt = _lmnt;
	var sp = real(_spellPower);
	
	var atkStat;
	var weakStat;
	var strongStat;
	
	switch (lmnt) {
		case elements.fire:
			atkStat		= spriteParams.fire;
			weakStat	= spriteParams.earth;
			strongStat	= spriteParams.water;
		break;
		
		case elements.water:
			atkStat		= spriteParams.water;
			weakStat	= spriteParams.fire;
			strongStat	= spriteParams.storm;
		break;
		
		case elements.storm:
			atkStat		= spriteParams.storm;
			weakStat	= spriteParams.water;
			strongStat	= spriteParams.earth;
		break;
		
		case elements.earth:
			atkStat		= spriteParams.earth;
			weakStat	= spriteParams.storm;
			strongStat	= spriteParams.fire;
		break;
	}
	
	atkStatTarg		= sprite_get_stat(atkStat, targ);
	weakStatTarg	= sprite_get_stat(weakStat, targ);
	strongStatTarg	= sprite_get_stat(strongStat, targ);
	
	atkStatAtkr		= sprite_get_stat(atkStat, atkr);
	
	var casterRatio		= atkStatAtkr / 100;		// increase in stat produces INCREASE in output
	var affinityRatio	= 100 / atkStatTarg;		// increase in stat produces DECREASE in output
	var weaknessRatio	= weakStatTarg / 100;		// increase in stat produces INCREASE in output
	var resistanceRatio	= 100 / strongStatTarg;		// increase in stat produces DECREASE in output
	
	var damage = sp * casterRatio * affinityRatio * weaknessRatio * resistanceRatio;
	return damage;
}

function get_physical_damage(_atkr, _targ, _spellPower) {
	var atkr = _atkr;
	var targ = _targ;
	var sp = real(_spellPower);
	
	var atkrPow = sprite_get_stat(spriteParams.power, atkr);
	var targRes = sprite_get_stat(spriteParams.resistance, targ);
	
	var damageRatio = atkrPow / targRes;
	var damage = sp * damageRatio;
	return damage;
}

function damage_get_low(_damage) {
	return _damage * 0.7;
}

function damage_get_high(_damage) {
	return _damage * 1.1;	
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
	
function averageList_populate(_sprite) {
	var sprite = _sprite;
	
	var avgMltplr = (0.7 + 1.1) / 2;
	
	var avgFire		= 0;
	var avgWater	= 0;
	var avgStorm	= 0;
	var avgEarth	= 0;
	var avgPhys		= 0;
	
	var spriteCount = ds_grid_height(global.spriteGrid);
	
	var fireSum		= 0;
	var waterSum	= 0;
	var stormSum	= 0;
	var earthSum	= 0;
	var physSum		= 0;
	
	#region RECEIVING DAMAGE
	// get average fire weakness
	var i = 0; repeat (spriteCount) {
		var damage = get_elemental_damage(sprite, i, elements.fire, 120);
		
		fireSum += damage;
		
		i++;
	}
	
	avgFire = fireSum / spriteCount;
	global.averageWeaknesses[|elements.fire] = avgFire;
	
	// get average water weakness
	var i = 0; repeat (spriteCount) {
		var damage = get_elemental_damage(sprite, i, elements.water, 120);
		
		waterSum += damage;
		
		i++;
	}
	
	avgWater = waterSum / spriteCount;
	global.averageWeaknesses[|elements.water] = avgWater;
	
	// get average storm weakness
	var i = 0; repeat (spriteCount) {
		var damage = get_elemental_damage(sprite, i, elements.storm, 120);
		
		stormSum += damage;
		
		i++;
	}	
	
	avgStorm = stormSum / spriteCount;
	global.averageWeaknesses[|elements.storm] = avgStorm;

	// get average earth weakness
	var i = 0; repeat (spriteCount) {
		var damage = get_elemental_damage(sprite, i, elements.earth, 120);
		
		earthSum += damage;
		
		i++;
	}
	
	avgEarth = earthSum / spriteCount;
	global.averageWeaknesses[|elements.earth] = avgEarth;
	
	// get average physical weakness
	var i = 0; repeat (spriteCount) {
		var damage = get_physical_damage(i, sprite, 120);
		
		physSum += damage;
		
		i++;
	}
	
	avgPhys = physSum / spriteCount;
	global.averageWeaknesses[|elements.height] = avgPhys;
	
	#endregion
	
	var fireSum		= 0;
	var waterSum	= 0;
	var stormSum	= 0;
	var earthSum	= 0;
	var physSum		= 0;	
	
	#region DEALING DAMAGE
	// get average fire strength
	var i = 0; repeat (spriteCount) {
		var damage = get_elemental_damage(i, sprite, elements.fire, 120);
		
		fireSum += damage;
		
		i++;
	}
	
	avgFire = fireSum / spriteCount;
	global.averageStrengths[|elements.fire] = avgFire;
	
	// get average water strength
	var i = 0; repeat (spriteCount) {
		var damage = get_elemental_damage(i, sprite, elements.water, 120);
		
		waterSum += damage;
		
		i++;
	}
	
	avgWater = waterSum / spriteCount;
	global.averageStrengths[|elements.water] = avgWater;
	
	// get average storm strength
	var i = 0; repeat (spriteCount) {
		var damage = get_elemental_damage(i, sprite, elements.storm, 120);
		
		stormSum += damage;
		
		i++;
	}	
	
	avgStorm = stormSum / spriteCount;
	global.averageStrengths[|elements.storm] = avgStorm;

	// get average earth strength
	var i = 0; repeat (spriteCount) {
		var damage = get_elemental_damage(i, sprite, elements.earth, 120);
		
		earthSum += damage;
		
		i++;
	}
	
	avgEarth = earthSum / spriteCount;
	global.averageStrengths[|elements.earth] = avgEarth;
	
	// get average physical strength
	var i = 0; repeat (spriteCount) {
		var damage = get_physical_damage(sprite, i, 120);
		
		physSum += damage;
		
		i++;
	}
	
	avgPhys = physSum / spriteCount;
	global.averageStrengths[|elements.height] = avgPhys;
		
	#endregion
	
	#region AGILITY COMPARISON
	var victoryCount = 0;
	
	var i = 0;	repeat (spriteCount) {
		var victor = get_faster_sprite(sprite, i);
		
		if (victor == sprite)	victoryCount += 1;
		if (victor == -1)		victoryCount += 0.5;
		
		i++;
	}
	
	global.agilityOdds = (victoryCount / spriteCount) * 100;
	
	#endregion
}