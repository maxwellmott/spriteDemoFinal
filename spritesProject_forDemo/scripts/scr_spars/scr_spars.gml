#macro SELFTARGET			10
#macro REST_BASE_MP_REGEN	30

global.hoverSprite		= -1;
global.arena			= -1;
global.targetRange		= -1;
global.action			= -1;
global.selectedSpell	= -1;
global.potentialMPCost	= -1;

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

function spar_set_action() {	
	global.action = action;
	
	switch (action) {
		case sparActions.attack:
			global.targetRange = ranges.nearestFiveSprites;
			spar.selectionPhase = selectionPhases.target;
		break;
		
		case sparActions.spell:
			instance_create_depth(x, y, get_layer_depth(LAYER.meta), sparSpellMenu);
			instance_destroy(sparActionMenu);
		break;
		
		case sparActions.dodge:
			sprite.readyDisplayBuilt = false;
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
			sprite.readyDisplayBuilt = false;
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

///@desc This function is used to get the number of times that a
/// sprite should roll for luck by checking their luck stat.
function get_luck_tier(_luck) {
	var luck = _luck;
	
	var luckTier = luck div 25;
	
	if (luckTier == 0) luckTier = 1;
	if (luckTier > 7) luckTier = 7;
	
	return luckTier;
}

///@desc This function is called when the player hits the "READY" button
/// after selecting an action and target for each of their allies. It places
/// each of those selections on the turnGrid.
///
/// This function is where the ally sprites get their luck for the turn.
function player_submit_turn() {	
	var i = 0;	repeat (4) {
		// get sprite
		var inst = spar.allyList[| i];
		
		// get luck tier
		var lt = get_luck_tier(inst.currentLuck);

		var roll = roll_for_luck(lt);
		
		// add info to grid
		spar.turnGrid[# selectionPhases.ally,	inst.spotNum]	= inst.spotNum;
		spar.turnGrid[# selectionPhases.action,	inst.spotNum]	= inst.selectedAction;
		spar.turnGrid[# selectionPhases.target,	inst.spotNum]	= inst.selectedTarget;
		spar.turnGrid[# selectionPhases.height,	inst.spotNum]	= roll;
		
		// increment i
		i++;
	}
}

function roll_for_luck(_luckTier) {
	var lt = _luckTier;
	
	var highestRoll = 0;
	
	var luckFloor = 725;
	var luckCeiling = 1075;
	
	repeat (lt ) {
		var roll = irandom_range(luckFloor, luckCeiling);
		if roll > highestRoll {
			if (roll == luckCeiling)	return roll;
			
			highestRoll = roll;
		}
	}
	
	return highestRoll / 1000;
}

function local_enemy_submit_turn() {
	var i = 0;	repeat (4) {
		// get sprite
		var inst = spar.enemyList[| i];

		// get luck tier
		var lt = get_luck_tier(inst.currentLuck);

		// roll for luck
		var roll = roll_for_luck(lt);

		// add info to grid
		spar.turnGrid[# selectionPhases.ally,	inst.spotNum]		= inst.spotNum;
		spar.turnGrid[# selectionPhases.action,	inst.spotNum]		= inst.selectedAction;
		spar.turnGrid[# selectionPhases.target, inst.spotNum]		= inst.selectedTarget;
		spar.turnGrid[# selectionPhases.height,	inst.spotNum]		= roll;
	}
}	

function sprite_process_rest(_instanceID) {
	var inst = _instanceID;
	
	var t = inst.team;
	var lr = inst.luckRoll;
	
	var mpRegen = round(REST_BASE_MP_REGEN * lr);
	
	restore_mp(t, mpRegen);
}

///@desc This function is meant to be called outside of the spar object to see if
/// the spar object's hp and mp values are current. If any of them don't match the
/// current value for the player or enemy, it will return false. If none of them are
/// flagged as nonequal, it will return true.
function spar_check_hpmp() {
	if (spar.playerDisplayHP != spar.playerOne.currentHP)	return false;
	if (spar.playerDisplayMP != spar.playerOne.currentMP)	return false;
	if (spar.enemyDisplayHP	!= spar.playerTwo.currentHP)	return false;
	if (spar.enemyDisplayMP != spar.playerTwo.currentMP)	return false;
	return true;
}

function spar_correct_hpmp() {
	if (playerDisplayHP < playerOne.currentHP)	playerDisplayHP++
	if (playerDisplayHP > playerOne.currentHP)	playerDisplayHP--
	
	if (playerDisplayMP < playerOne.currentMP)	playerDisplayMP++
	if (playerDisplayMP > playerOne.currentMP)	playerDisplayMP--
	
	if (enemyDisplayHP < playerTwo.currentHP)	enemyDisplayHP++;
	if (enemyDisplayHP > playerTwo.currentHP)	enemyDisplayHP--;
	
	if (enemyDisplayMP < playerTwo.currentMP)	enemyDisplayMP++;
	if (enemyDisplayMP > playerTwo.currentMP)	enemyDisplayMP++;
}

///@desc This function is called by an ally or enemy object to set that sprite's
/// list of inRangeSprites depending on the range of the spell in question.
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

///@desc This function is meant to be called by the spar object to 
/// periodically check if all of the player's sprites are ready. It returns
/// a boolean variable.
function check_all_allies_ready() {
	var readyBool = true;
	
	var i = 0;	repeat (ds_list_size(allyList)) {
		if (allyList[| i].turnReady == false) readyBool = false;
		i++;
	}
	
	return readyBool;
}

///@desc This function will be called in the PREPROCESS phase of the process phase of a spar.
/// It gets the sprite's current luck roll off of the turn grid. (all luck rolls are determined
/// and then placed on the turn grid in the submit_turn functions).
function all_sprites_get_luck_roll() {
	var i = 0;	repeat (ds_list_size(spriteList)) {
		var inst = spriteList[| i];
		
		var sn = inst.spotNum;
		
		var h = ds_grid_height(turnGrid);
		
		var rowNum = ds_grid_value_y(turnGrid, selectionPhases.ally, 0, selectionPhases.ally, h, sn);
		
		var lr = turnGrid[# selectionPhases.height, rowNum];
		
		inst.luckRoll = lr;
		
		i++;
	}
}
	
///@desc This function will be called by each ally after their turn has been set. It will
/// take the details of their turn and produce a short description of their plan for the
/// upcoming action phase.
function sprite_build_ready_display() {	
	if (selectedTarget != -1) {
		var num = spar.spriteList[| selectedTarget].allyNum;
		var numString = "";
		
		switch (num) {
			case 0:
				numString = "one";
			break;
			
			case 1:
				numString = "two";
			break;
			
			case 2:
				numString = "three";
			break;
			
			case 3:
				numString = "four";
			break;
		}
	}
	
	var spriteWidth = sprite_get_width(spr_readyDisplayBox);
	
	switch (selectedAction) {
		case sparActions.attack:
			if (selectedTarget > 3) {
				var substring = "attacking enemy " + numString;
				readyDisplay = format_text(substring, spriteWidth - 4);
			}
			else {
				var substring = "attacking ally " + numString;
				readyDisplay = format_text(substring, spriteWidth - 4);
			}
		break;
		
		case sparActions.dodge:
			var substring = "dodging";
			readyDisplay = format_text(substring, spriteWidth - 4);
		break;
		
		case sparActions.swap:
			var substring = "swapping with ally " + numString;
			readyDisplay = format_text(substring, spriteWidth - 4);
		break;
		
		case sparActions.rest:
			var substring = "resting";
			readyDisplay = format_text(substring, spriteWidth - 4);
		break;
	}
	
	readyDisplayBuilt = true;
}

///@desc This function sets the selected ally's action and target with global.action and
/// the spotNum of the sprite being clicked, respectively. (This function should only
/// be called by a sprite being clicked during target selection).
function spar_set_target() {
	player.selectedAlly.readyDisplayBuilt = false;
	player.selectedAlly.selectedAction = global.action;
	player.selectedAlly.selectedTarget = spotNum;
	player.selectedAlly.turnReady = true;
	
	if (global.action == sparActions.swap) {
		readyDisplayBuilt = false;
		selectedAction = global.action;
		selectedTarget = player.selectedAlly.spotNum;
		turnReady = true;
	}
}

///@desc This function sets the selected ally's action and target with global.action
/// and the macro indicating a self targeting action. This function can be called whenever
/// you are ready to do this as it doesn't make any local references.
function self_target_set() {
	player.selectedAlly.readyDisplayBuilt = false;
	player.selectedAlly.selectedAction = global.action;
	player.selectedAlly.selectedTarget = SELFTARGET;
	player.selectedAlly.turnReady = true;
}

///@desc This function should be called by each sprite on the field whenever a swap occurs. The
/// function simply rebuilds all of their "nearby" lists, in case any sprites changed position.
///
/// (these lists store the instance ID of sprites)
function rebuild_nearby_lists() {
	// clear all lists
	ds_list_clear(nearbyAllies);
	ds_list_clear(nearbyEnemies);
	ds_list_clear(nearbySprites);
	
	///@TODO rebuild each list depending on the sprites position
}

///@desc This function is meant to be a quick and obvious way of getting the instance id of a sprite
/// on the field using their spot num. It's meant to improve readability with all of the various lists of
/// sprites and sprite parameters we have going at this point.
function spot_num_get_instance(_spotNum) {
	var s = _spotNum;
	
	return spar.spriteList[| s];
}

///@desc This function is called after the sprite's sprite has been temporarily changed for some reason. It simply
/// gets their sprite from the sprite grid and sets it back to normal.
function sprite_reload_sprite() {	
	// decode sprite grid
	var grid = ds_grid_create(SPRITE_PARAMS.HEIGHT, SPRITES.HEIGHT);
	decode_grid(global.allSprites, grid);
	
	// load sprite from grid
	sprite = real(grid[# SPRITE_PARAMS.SPRITE,		spriteID]);
	
	// destroy grid
	ds_grid_destroy(grid);
}

///@desc This function is used to draw text in the battle scene. It's just a way of safely ensuring that when text
/// is drawn with a centered alignment, it corrects if the width of the string being drawn is an odd number (can't draw
/// pixels at decimal values)
function spar_draw_text(_x, _y, _text) {
	var xx = _x;
	var yy = _y;
	var tt = _text;
	
	if ((string_width(tt) / 2) mod 2 != 0) {
		xx -= 0.5;	
	}
	
	draw_text_transformed(xx, yy, tt, 0.5, 0.5, 0);
}

function action_check_spell(_action) {
	var spellBool = false;
	
	if (_action >= sparActions.height)	spellBool = true;
	
	return spellBool;
}

function swap_get_cost(_inst1, _inst2) {
	// store args in locals
	var i1 = _inst1;
	var i2 = _inst2;
	
	// get sizes
	var size1 = i1.currentSize;
	var size2 = i2.currentSize;
	
	// get spot numbers
	var spot1 = i1.spotNum;
	var spot2 = i2.spotNum;
	
	// initialize sizeSum
	var sizeSum = 0;
	
	// get distance between sprites
	var distance = abs(spot1 - spot2);
	
	// use two switch statements to get a value according to the sizes of the sprites
	var i = 0;	repeat (2) {
		// store correct size in temp variable
		if i	var s = size1;
		if !i	var s = size2;
		
		switch(s) {
			case SPRITE_SIZES.X_SMALL:	sizeSum += 2;
			break;
			
			case SPRITE_SIZES.SMALL:	sizeSum += 4;
			break;
			
			case SPRITE_SIZES.MEDIUM:	sizeSum += 6;
			break;
			
			case SPRITE_SIZES.LARGE:	sizeSum += 8;
			break;
			
			case SPRITE_SIZES.X_LARGE:	sizeSum += 10;
			break;
		}
		
		// increment i
		i++;
	}
	
	// initialize cost value
	var c =	0;
	
	switch(distance) {
		case 1:	c = round(sizeSum * 1.5);
		break;
		
		case 2:	c = sizeSum * 2;
		break;
		
		case 3: c = round(sizeSum * 2.5);
		break;
	}
	
	return c;
}

function swap_set_potential_cost(_inst1, _inst2) {
	// store args in locals
	var i1 = _inst1;
	var i2 = _inst2;

	var c = swap_get_cost(i1, i2);
	
	// if there's enough MP, set the cost
	if (player.currentMP - c >= 0)	global.potentialMPCost = c;
	else global.potentialMPCost = -1;
	
	// prepare the spar object to draw the flashingBar
	spar.sprite_index = spr_sparFlashingSliver;
	spar.image_speed = 1;
}

function spell_set_potential_cost(_spellCost) {
	var c = _spellCost;
	
	// if there's enough MP, set the cost
	if (player.currentMP - c >= 0)	{
		global.potentialMPCost = c;
	}
	else global.potentialMPCost = -1;
	
	// prepare the spar object to draw the flashingBar
	spar.sprite_index = spr_sparFlashingSliver;
	spar.image_speed = 1;
}