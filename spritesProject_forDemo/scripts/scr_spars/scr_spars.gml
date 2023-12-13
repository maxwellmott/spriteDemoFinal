global.hoverSprite		= -1;
global.arena			= -1;
global.targetRange		= -1;
global.action			= -1;
global.selectedSpell	= -1;

enum ranges {
	onlySelf,
	nearestOneEnemy,
	nearestTwoAllies,
	nearestThreeSprites,
	nearestThreeEnemies,
	nearestFiveSprites,
	anyEnemy,
	anyAlly,
	anySprite,
	height
}

enum arenas {
	volcano,
	ocean,
	stratosphere,
	forest,
	height
}

enum mindsets {
	tree,
	warrior,
	mother,
	imp,
	height
}

enum sparTypes {
	inGame,
	localMulti,
	onlineMulti,
	height
}

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
			atkStat		= SPRITE_PARAMS.fire;
			weakStat	= SPRITE_PARAMS.earth;
			strongStat	= SPRITE_PARAMS.water;
		break;
		
		case elements.water:
			atkStat		= SPRITE_PARAMS.water;
			weakStat	= SPRITE_PARAMS.fire;
			strongStat	= SPRITE_PARAMS.storm;
		break;
		
		case elements.storm:
			atkStat		= SPRITE_PARAMS.storm;
			weakStat	= SPRITE_PARAMS.water;
			strongStat	= SPRITE_PARAMS.earth;
		break;
		
		case elements.earth:
			atkStat		= SPRITE_PARAMS.earth;
			weakStat	= SPRITE_PARAMS.storm;
			strongStat	= SPRITE_PARAMS.fire;
		break;
	}
	
	atkStatTarg		= sprite_get_stat(atkStat, targ);
	weakStatTarg	= sprite_get_stat(weakStat, targ);
	strongStatTarg	= sprite_get_stat(strongStat, targ);
	
	atkStatAtkr		= sprite_get_stat(atkStat, atkr);
	
	var affinityRatio	= atkStatAtkr / atkStatTarg;
	var weaknessRatio	= weakStatTarg / strongStatTarg;
	
	var average = (affinityRatio + weaknessRatio) / 2;
	
	var damage = average * sp;
	return damage;
}

function get_physical_damage(_atkr, _targ, _spellPower) {
	var atkr = _atkr;
	var targ = _targ;
	var sp = real(_spellPower);
	
	var atkrPow = sprite_get_stat(SPRITE_PARAMS.power, atkr);
	var targRes = sprite_get_stat(SPRITE_PARAMS.resistance, targ);
	
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
	
	// get average fire weakness
	var i = 0; repeat (spriteCount) {
		var damage = get_elemental_damage(sprite, i, elements.fire, 120);
		
		fireSum += damage;
		
		i++;
	}
	
	avgFire = fireSum / spriteCount;
	global.averageList[|elements.fire] = avgFire;
	
	// get average water weakness
	var i = 0; repeat (spriteCount) {
		var damage = get_elemental_damage(sprite, i, elements.water, 120);
		
		waterSum += damage;
		
		i++;
	}
	
	avgWater = waterSum / spriteCount;
	global.averageList[|elements.water] = avgWater;
	
	// get average storm weakness
	var i = 0; repeat (spriteCount) {
		var damage = get_elemental_damage(sprite, i, elements.storm, 120);
		
		stormSum += damage;
		
		i++;
	}	
	
	avgStorm = stormSum / spriteCount;
	global.averageList[|elements.storm] = avgStorm;

	// get average earth weakness
	var i = 0; repeat (spriteCount) {
		var damage = get_elemental_damage(sprite, i, elements.earth, 120);
		
		earthSum += damage;
		
		i++;
	}
	
	avgEarth = earthSum / spriteCount;
	global.averageList[|elements.earth] = avgEarth;
	
	// get average physical weakness
	var i = 0; repeat (spriteCount) {
		var damage = get_physical_damage(sprite, i, 120);
		
		physSum += damage;
		
		i++;
	}
	
	avgPhys = physSum / spriteCount;
	global.averageList[|elements.height] = avgPhys;
}

function spar_set_action() {	
	global.action = action;
	
	switch (action) {
		case sparActions.attack:
			global.targetRange = ranges.nearestFiveSprites;
			spar.selectionPhase = selectionPhases.target;
		break;
		
		case sparActions.spell:
		break;
		
		case sparActions.dodge:
			sprite.selectedTarget = -1;
			sprite.selectedAction = action;
			sprite.turnReady = true;
			spar.selectionPhase = selectionPhases.ally;
		break;
		
		case sparActions.swap:
			global.targetRange = ranges.anyAlly;
			spar.selectionPhase = selectionPhases.target;
		break;
		
		case sparActions.rest:
			sprite.selectedTarget = -1;
			sprite.selectedAction = action;
			sprite.turnReady = true;
			spar.selectionPhase = selectionPhases.ally;
		break;
	}
	
	inRangeSprites_rebuild(sprite, global.targetRange);

	instance_destroy(sparActionMenu);
}

function enemyAI_get_params() {
	// create temporary grid
	var grid = ds_grid_create(npcParams.height, npcs.height);
	
	// decode npcGrid
	decode_grid(global.allNPCs, grid);
	
	// use npcID to get params
	talismanString	= grid[# npcParams.talismans,	ID];
	name			= grid[# npcParams.name,		ID];
	spellString		= grid[# npcParams.SPELLS,		ID];
	
	// decode talismanString and spellString
	decode_list(talismanString, roster);
	decode_list(spellString, spellBook);
	
	// delete temporary grid
	ds_grid_destroy(grid);
}

function enemyAI_set_team() {
	randomize_list(roster);
	
	team[|0] = real(roster[|0]);
	team[|1] = real(roster[|1]);
	team[|2] = real(roster[|2]);
	team[|3] = real(roster[|3]);
}

///@desc This function is called when the player hits the "READY" button
/// after selecting an action and target for each of their allies. It places
/// each of those selections on the turnGrid.
function player_submit_turn() {
	var i = 0;	repeat (4) {
		// get sprite
		var inst = spar.allyList[| i];
		
		// add info to grid
		spar.turnGrid[# selectionPhases.ally,	inst.spotNum]	= inst.spotNum;
		spar.turnGrid[# selectionPhases.action,	inst.spotNum]	= inst.selectedAction;
		spar.turnGrid[# selectionPhases.target,	inst.spotNum]	= inst.selectedTarget;
		
		// increment i
		i++;
	}
}

function inRangeSprites_rebuild(_sprite, _range) {
	var s = _sprite;
	var r = _range;
	var spot = s.spotNum;
	
	ds_list_clear(spar.inRangeSprites);
	
	switch (r) {
		case ranges.nearestOneEnemy:
			spar.inRangeSprites[| 0] = spar.spriteList[| 7 - spot];
		break;
		
		case ranges.nearestTwoAllies:
			if (spot == 0) {
				spar.inRangeSprites[| 0] = spar.spriteList[| 1];
			}
			
			else if (spot == 3) {
				spar.inRangeSprites[| 0] = spar.spriteList[| 2];
			}
			
			else {
				spar.inRangeSprites[| 0] = spot - 1;
				spar.inRangeSprites[| 1] = spot + 2;
			}
		break;
		
		case ranges.nearestThreeSprites:
			if (spot == 0) {
				spar.inRangeSprites[| 0] = spar.spriteList[| 1];
				spar.inRangeSprites[| 1] = spar.spriteList[| 7 - spot];
			}
			
			else if (spot == 3) {
				spar.inRangeSprites[| 0] = spar.spriteList[| 2];
				spar.inRangeSprites[| 1] = spar.spriteList[| 7 - spot];
			}
			
			else {
				spar.inRangeSprites[| 0] = spar.spriteList[| spot - 1];
				spar.inRangeSprites[| 1] = spar.spriteList[| spot + 1];
				spar.inRangeSprites[| 2] = spar.spriteList[| 7 - spot];
			}
		break;
		
		case ranges.nearestThreeEnemies:
			if (spot == 0) {
				spar.inRangeSprites[| 0] = spar.spriteList[| 7 - spot];
				spar.inRangeSprites[| 1] = spar.spriteList[| 7 - spot - 1];
			}
			
			else if (spot == 3) {
				spar.inRangeSprites[| 0] = spar.spriteList[| 7 - spot];
				spar.inRangeSprites[| 1] = spar.spriteList[| 7 - spot + 1];				
			}
			
			else {
				spar.inRangeSprites[| 0] = spar.spriteList[| 7 - spot + 1];
				spar.inRangeSprites[| 1] = spar.spriteList[| 7 - spot];
				spar.inRangeSprites[| 2] = spar.spriteList[| 7 - spot - 1];
			}
		break;
		
		case ranges.nearestFiveSprites:
			if (spot == 0) {
				spar.inRangeSprites[| 0] = spar.spriteList[| 1];
				spar.inRangeSprites[| 1] = spar.spriteList[| 7 - spot];
				spar.inRangeSprites[| 2] = spar.spriteList[| 7 - spot - 1];
			}
			
			else if (spot == 3) {
				spar.inRangeSprites[| 0] = spar.spriteList[| 2];
				spar.inRangeSprites[| 1] = spar.spriteList[| 7 - spot + 1];
				spar.inRangeSprites[| 2] = spar.spriteList[| 7 - spot];
			}
			
			else {
				spar.inRangeSprites[| 0] = spar.spriteList[| spot + 1];
				spar.inRangeSprites[| 1] = spar.spriteList[| spot - 1];
				spar.inRangeSprites[| 2] = spar.spriteList[| 7 - spot + 1];
				spar.inRangeSprites[| 3] = spar.spriteList[| 7 - spot];
				spar.inRangeSprites[| 4] = spar.spriteList[| 7 - spot - 1];				
			}
		break;
		
		case ranges.anyEnemy:
			var i = 4;	repeat (4) {
				spar.inRangeSprites[| i - 4] = spar.spriteList[| i];
				
				i++;
			}
		break;
		
		case ranges.anyAlly:
			var i = 0;	repeat (4) {
				if (spot != i) {
					ds_list_add(spar.inRangeSprites, spar.spriteList[| i]);
				}
				
				i++;
			}
		break;
		
		case ranges.anySprite:
			var i = 0;	repeat (8) {
				if (spot != i) {
					ds_list_add(spar.inRangeSprites, spar.spriteList[| i]);
				}
				
				i++;
			}
		break;
	}
}

function check_all_allies_ready() {
	var readyBool = true;
	
	var i = 0;	repeat (ds_list_size(allyList)) {
		if (allyList[| i].selectedAction == -1) readyBool = false;
		i++;
	}
	
	return readyBool;
}
	
function sprite_build_ready_display() {
	var targName = "";
	if selectedTarget != -1 {
		targName = spar.spriteList[| selectedTarget].name;
	}
	
	var spriteWidth = sprite_get_width(spr_readyDisplayBox);
	
	switch (selectedAction) {
		case sparActions.attack:
			var substring = "READY TO ATTACK " + targName;
			readyDisplay = format_text(substring, spriteWidth - 6);
		break;
		
		case sparActions.dodge:
		break;
		
		case sparActions.swap:
		break;
		
		case sparActions.rest:
		break;
	}
	
	readyDisplayBuilt = true;
}

function spar_set_target() {
	player.selectedAlly.readyDisplayBuilt = false;
	player.selectedAlly.selectedAction = global.action;
	player.selectedAlly.selectedTarget = spotNum;
	player.selectedAlly.turnReady = true;
	spar.selectionPhase = selectionPhases.ally;
}