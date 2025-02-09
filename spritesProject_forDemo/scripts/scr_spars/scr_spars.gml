#macro REST_BASE_MP_REGEN	30

#macro HEXED_COUNT_MAX			1
#macro BOUND_COUNT_MAX			1
#macro BERSERK_COUNT_MAX		2
#macro INVULNERABLE_COUNT_MAX	0

// global.mpCostDiff is the mp that the selecting ally will save after switching
// to their new selection. So if they were previously swapping, this would be the
// cost of that swap. This is being initialized here, but otherwise it should only
// be referenced inside of the "set_potential_cost" functions
global.mpCostDiff		= 0;

// global.hoverSprite is the instance ID of the sparAlly or sparEnemy that the mouse
// is currently hovering over.
global.hoverSprite		= -1;

// 
global.arena			= -1;
global.targetRange		= -1;
global.action			= -1;
global.selectedSpell	= -1;

enum TRIGGER_TYPES {
	TURN_BEGIN,
	TURN_END,
	SPELL_TARGETING,
	ATTACK_TARGETING,
	SUCCESSFUL_SPELL_DAMAGE,
	SUCCESSFUL_ATTACK_DAMAGE,
	SUCCESSFUL_ELEMENTAL_DAMAGE,
	SUCCESSFUL_PHYSICAL_DAMAGE,
	SUCCESSFUL_FIRE_DAMAGE,
	SUCCESSFUL_WATER_DAMAGE,
	SUCCESSFUL_STORM_DAMAGE,
	SUCCESSFUL_EARTH_DAMAGE,
	SUCCESSFUL_DODGE,
	FAILED_DODGE,
	ATTEMPTING_DODGE,
	NOT_ENOUGH_MP,
	SUCCESSFUL_REST,
	SUCCESSFUL_SWAP,
	DODGE_SET,
	BOUND_SET,
	HEXED_SET,
	CURSE_SET,
	BLESSING_SET,
	MINDSET_SET,
	CURSE_SHIFTED,
	BLESSING_SHIFTED,
	MINDSET_SHIFTED,
	ARENA_CHANGED,
	ARENA_DESTROYED,
	SUCCESSUL_HEAL,
	SUCCESSUL_HINDRANCE_CLEAR,
	BOUND_REMOVED,
	HEXED_REMOVED,
	MIASMA_SET,
	HUM_SET,
	RUST_SET,
	MIASMA_APPLIED,
	HUM_APPLIED,
	RUST_APPLIED,
	ALIGNMENT_CHANGED,
	BALL_LIGHTNING_SET,
	BALL_LIGHTNING_ABSORB,
	BALL_LIGHTNING_DAMAGE,
	BLACK_HOLE_SET,
	BLACK_HOLE_ABSORB,
	BLACK_HOLE_DAMAGE,
	SWAP_FORCED,
	TIMED_BLAST_SET,
	ENERGY_BLAST_DAMAGE,
	SUCCESSFUL_SNEAK_ATTACK,
	SUCCESSFUL_SKYDIVE,
	MP_CUT,
	HEALTH_DRAINED,
	MP_DRAINED,
	SELF_DAMAGE,
	OUT_OF_RANGE,
	TARGET_REPLACED,
	BERSERK_ACTIVATED,
	HEIGHT	
}

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

enum ARENAS {
	VOLCANO,
	OCEAN,
	CLOUDS,
	FOREST,
	HEIGHT
}

enum sparTypes {
	inGame,
	localMulti,
	onlineMulti,
	height
}

function reset_all_stats(_spriteInstance) {
	// store args in locals
	var inst = _spriteInstance;
	
	// reset all stats
	with (inst) {
		currentPower		= basePower;
		currentResistance	= baseResistance;
		currentFire			= baseFire;
		currentWater		= baseWater;
		currentStorm		= baseStorm;
		currentEarth		= baseEarth;
		currentAgility		= baseAgility;
		currentLuck			= baseLuck;
	}
}

function spell_get_cost(_spellID) {
	// store args in locals
	var sid = _spellID;
	
	// create temp grid
	var g = ds_grid_create(SPELL_PARAMS.HEIGHT, SPELLS.HEIGHT);
	
	// decode spell grid
	decode_grid(global.allSpells, g);
	
	// get spell cost
	var c = g[# SPELL_PARAMS.COST, sid];
	
	// delete temp grid
	ds_grid_destroy(g);
	
	// return spell cost
	return c;
}

function spar_set_action() {	
	// store the selected action in global.action
	global.action = action;
	
	// get the selected ally
	var sa = player.selectedAlly;
	
	switch (action) {
		case sparActions.attack:
			global.targetRange = ranges.nearestFiveSprites;
			spar.selectionPhase = SELECTION_PHASES.TARGET;
		break;
		
		case sparActions.spell:
			instance_create_depth(x, y, get_layer_depth(LAYER.meta), sparSpellMenu);
			instance_destroy(sparActionMenu);
		break;
		
		case sparActions.dodge:
			if (sprite.selectedAction == sparActions.swap) {
				var t = spar.spriteList[| sprite.selectedTarget];
				
				with (t) {
					readyDisplay = "";
					readyDisplayBuilt = false;	
					selectedAction = -4;
					selectedTarget = -4;
					turnReady = false;
				}
			}
		
			sprite.readyDisplayBuilt = false;
			sprite.selectedTarget = -1;
			sprite.selectedAction = action;
			sprite.turnReady = true;
			spar.selectionPhase = SELECTION_PHASES.ALLY;
			
		break;
		
		case sparActions.swap:		
			global.targetRange = ranges.anyAlly;
			spar.selectionPhase = SELECTION_PHASES.TARGET;
		break;
		
		case sparActions.rest:
			if (sprite.selectedAction == sparActions.swap) {
				var t = spar.spriteList[| sprite.selectedTarget];
				with (t) {
					readyDisplay = "";
					readyDisplayBuilt = false;
					selectedAction = -4;
					selectedTarget = -4;
					turnReady = false;
				}
			}
	
			sprite.readyDisplayBuilt = false;
			sprite.selectedTarget = -1;
			sprite.selectedAction = action;
			sprite.turnReady = true;
			spar.selectionPhase = SELECTION_PHASES.ALLY;
		break;
	}

	// perform an ability check for target selection
	ability_check(ABILITY_TYPES.RANGE_CHECK);

	inRangeSprites_rebuild(sprite);

	instance_destroy(sparActionMenu);
}

function spar_set_spell() {
	// set selectedAction to currentSpell
	global.action = currentSpell + sparActions.height;
	
	// set spellRange for target selection
	global.targetRange = spellRange;
	
	// set next selectionPhase
	spar.selectionPhase = SELECTION_PHASES.TARGET;
	
	// perform an ability check for target selection
	ability_check(ABILITY_TYPES.RANGE_CHECK);
	
	inRangeSprites_rebuild(player.selectedAlly);
	
	// set next phase
	nextPhase = SELECTION_PHASES.TARGET;
	
	instance_destroy(sparSpellMenu);
}

// this function is commented out for now. Once I start doing the ingame AI
// logic, this function will call some pre-written logic for the enemy in question. It will
// use their chosen team as well as the player's "favorites" to select a list of spells to
// use during the match.
function enemyAI_set_spellbook() {
	
}

function enemyAI_set_team() {
	randomize_list(roster);
	
	teamList[|0] = real(roster[|0]);
	teamList[|1] = real(roster[|1]);
	teamList[|2] = real(roster[|2]);
	teamList[|3] = real(roster[|3]);
}

///@desc This function is called when the player hits the "READY" button
/// after selecting an action and target for each of their allies. It places
/// each of those selections on the turnGrid.
///
/// This function is where the ally sprites get their luck for the turn.
function player_submit_turn() {	
	
	var onlineGrid = ds_grid_create(4, 4);
	
	var i = 0;	repeat (4) {
		// get sprite
		var inst = spar.allyList[| i];
		
		// get luck tier
		var lt = get_luck_tier(inst.currentLuck);

		var roll = roll_for_luck(lt);
		
		// add info to spar.turnGrid
		spar.turnGrid[# TURN_GRID.ALLY,		inst.spotNum]	= inst.spotNum;
		spar.turnGrid[# TURN_GRID.ACTION,		inst.spotNum]	= inst.selectedAction;
		spar.turnGrid[# TURN_GRID.TARGET,		inst.spotNum]	= inst.selectedTarget;
		spar.turnGrid[# TURN_GRID.LUCK,		inst.spotNum]	= roll;
		
		// set lastAction and lastTarget to selectedAction and selectedTarget
		inst.lastAction = inst.selectedAction;
		inst.lastTarget = inst.selectedTarget;
		
		// set turnRepeat to false
		inst.turnRepeat = false;
		
		if (instance_exists(onlineEnemy)) {
			// add info to onlineGrid
			onlineGrid[# TURN_GRID.ALLY,		inst.spotNum]	= inst.spotNum;
			onlineGrid[# TURN_GRID.ACTION,	inst.spotNum]	= inst.selectedAction;
			onlineGrid[# TURN_GRID.TARGET,	inst.spotNum]	= inst.selectedTarget;
			onlineGrid[# TURN_GRID.LUCK,	inst.spotNum]	= roll;		
		}
		
		// increment i
		i++;
	}
	
	// if player is online, send grid to server
	if (instance_exists(onlineEnemy)) {
		ds_map_add(spar.data, "type",		MESSAGE_TYPES.CLIENT_SUBMIT_TURN);
		ds_map_add(spar.data, "clientID",	player.clientID);
		ds_map_add(spar.data, "turn",		encode_grid(onlineGrid));
		
		var dataJson = json_encode(spar.data);
		
		ds_map_clear(spar.data);
		
		buffer_seek(spar.onlineBuffer, buffer_seek_start, 0);
		
		buffer_write(spar.onlineBuffer, buffer_text, dataJson);
		
		network_send_udp_raw(spar.client, SERVER_ADDRESS, PORT_NUM, spar.onlineBuffer, buffer_tell(spar.onlineBuffer));
		
		player.ready = true;
		
		spar.onlineWaiting = true;	
	}
}

///@desc This function is called when the player hits tab after submitting their 
/// turn. This cancels their turn submission and allows them to reselect.
function player_cancel_turn() {
	if (instance_exists(onlineEnemy)) {
		ds_map_add(spar.data, "type",		MESSAGE_TYPES.CLIENT_CANCEL_TURN);
		ds_map_add(spar.data, "clientID",	player.clientID);
		
		var dataJson = json_encode(spar.data);
		
		ds_map_clear(spar.data);
		
		buffer_seek(spar.onlineBuffer, buffer_seek_start, 0);
		
		buffer_write(spar.onlineBuffer, buffer_text, dataJson);
		
		network_send_udp_raw(spar.client, SERVER_ADDRESS, PORT_NUM, spar.onlineBuffer, buffer_tell(spar.onlineBuffer));
		
		turnCancelled = true;
	}
}

///@desc This function posts all the AI enemy's selection data to the turnGrid. Similarly to 
/// the player, this is also where their sprite's have their luckRoll set
function local_enemy_submit_turn() {
	var i = 0;	repeat (4) {
		// get sprite
		var inst = spar.enemyList[| i];

		// get luck tier
		var lt = get_luck_tier(inst.currentLuck);

		// roll for luck
		var roll = roll_for_luck(lt);

		// add info to grid
		spar.turnGrid[# TURN_GRID.ALLY,		inst.spotNum]		= inst.spotNum;
		spar.turnGrid[# TURN_GRID.ACTION,	inst.spotNum]		= inst.selectedAction;
		spar.turnGrid[# TURN_GRID.TARGET,	inst.spotNum]		= inst.selectedTarget;
		spar.turnGrid[# TURN_GRID.LUCK,	inst.spotNum]		= roll;
		
		// set lastAction and lastTarget to selectedAction and selectedTarget
		inst.lastAction = inst.selectedAction;
		inst.lastTarget = inst.selectedTarget;
		
		// set turnRepeat to false
		inst.turnRepeat = false;
		
		// increment i
		i++;
	}
	
	ready = true;
}

function sprite_process_rest(_instanceID) {
	var inst = _instanceID;
	
	var t = inst.team;
	var lr = inst.luckRoll;
	
	var mpRegen = REST_BASE_MP_REGEN;
	
	restore_mp(t, mpRegen);
	
	if (inst.berserk)							spar_effect_push_alert(SPAR_EFFECTS.END_BERSERK, inst);
	
	if (inst.currentAlign != inst.baseAlign)	spar_effect_push_alert(SPAR_EFFECTS.RESTORE_ALIGNMENT, inst);
	
	if (inst.currentSize != inst.baseSize)		spar_effect_push_alert(SPAR_EFFECTS.RESTORE_SIZE, inst);
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
	if (playerDisplayHP < playerOne.currentHP)	{
		if (abs(playerDisplayHP - playerOne.currentHP) >= 10)	playerDisplayHP += 10;
		else playerDisplayHP = playerOne.currentHP;
	}
	
	if (playerDisplayHP > playerOne.currentHP)	{
		if (abs(playerDisplayHP - playerOne.currentHP) >= 10)	playerDisplayHP -= 10;
		else playerDisplayHP = playerOne.currentHP;
	}
	
	if (playerDisplayMP < playerOne.currentMP)	playerDisplayMP++
	if (playerDisplayMP > playerOne.currentMP)	playerDisplayMP--
	
	if (enemyDisplayHP < playerTwo.currentHP)	{	
		if (abs(enemyDisplayHP - playerTwo.currentHP) >= 10)	enemyDisplayHP += 10;
		else enemyDisplayHP = playerTwo.currentHP;
	}
	
	if (enemyDisplayHP > playerTwo.currentHP)	{	
		if (abs(enemyDisplayHP - playerTwo.currentHP) >= 10)	enemyDisplayHP -= 10;
		else enemyDisplayHP = playerTwo.currentHP;
	}
	
	if (enemyDisplayMP < playerTwo.currentMP)	enemyDisplayMP++;
	if (enemyDisplayMP > playerTwo.currentMP)	enemyDisplayMP--;
}

///@desc This function is called by an ally or enemy object to set that sprite's
/// list of inRangeSprites depending on the range of the action in question.
function inRangeSprites_rebuild(_sprite) {
	var s = _sprite;
	var r = global.targetRange;
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
		
		var rowNum = ds_grid_value_y(turnGrid, TURN_GRID.ALLY, 0, TURN_GRID.ALLY, h, sn);
		
		var lr = turnGrid[# TURN_GRID.LUCK, rowNum];
		
		inst.luckRoll = lr;
		
		i++;
	}
}
	
///@desc This function will be called by each ally after their turn has been set. It will
/// take the details of their turn and produce a short description of their plan for the
/// upcoming action phase.
function sprite_build_ready_display() {	
	if (turnRepeat) {
		readyDisplay = "repeating last turn";
		readyDisplayBuilt = true;
		
		// set mpCalculated to false so that the spar object can
		// recalculate the nextTurnFinalMP
		spar.mpCalculated = false;
		
		return -1;
	}
	
	if (immobilized) {
		readyDisplay = "immobilized!";
		readyDisplayBuilt = true;
		
		// set mpCalculated to false so that the spar object can
		// recalculate the nextTurnFinalMP
		spar.mpCalculated = false;
		
		return -1;
	}
	
	if (selectedTarget != -1) {
		var num = selectedTarget;
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
				readyDisplay = "attacking enemy " + numString;
			}
			else {
				readyDisplay = "attacking ally " + numString;
			}
		break;
		
		case sparActions.dodge:
			readyDisplay = "dodging";
		break;
		
		case sparActions.swap:
			readyDisplay = "swapping with ally " + numString;
		break;
		
		case sparActions.rest:
			readyDisplay = "resting";
		break;
	}
	
	if (selectedAction >= sparActions.height) {
		readyDisplay = "casting " + player.spellBookGrid[# SPELL_PARAMS.NAME, ds_list_find_index(player.spellBook, selectedAction - sparActions.height)];
	}
	
	readyDisplayBuilt = true;
	
	// set mpCalculated to false so that the spar object can
	// recalculate the nextTurnFinalMP
	spar.mpCalculated = false;
}

///@desc This function sets the selected ally's action and target with global.action and
/// the spotNum of the sprite being clicked, respectively. (This function should only
/// be called by a sprite being clicked during target selection).
function spar_set_target() {
	// check if target selection is for a swap
	if (global.action == sparActions.swap) {
		// check if the sprite being selected as a swap target has already selected a swap
		if (selectedAction == sparActions.swap) {
			// get the instance id of the previously selected swap partner
			var pid = spar.allyList[| selectedTarget];
			
			// reset all of the values set for the previously selected swap partner
			with (pid) {
				readyDisplay = "";
				readyDisplayBuild = false;
				selectedAction = -4;
				selectedTarget = -4;
				turnReady = false;
			}
		}	
		
		// reset potentialSwapCost
		spar.potentialSwapCost = 0;
	}
	
	// check if the selected ally has already selected a swap
	if (player.selectedAlly.selectedAction == sparActions.swap) {
		// get the instance id of the selected ally
		var sid = player.selectedAlly;
		
		// get the instance id of the previously selected swap partner
		var pid = spar.allyList[| sid.selectedTarget];
		
		// reset all of the values set for the previously selected swap parter
		with (pid) {
			readyDisplay = "";
			readyDisplayBuilt = false;
			selectedAction = -4;
			selectedTarget = -4;
			turnReady = false;
		}
	}
	
	player.selectedAlly.readyDisplayBuilt = false;
	player.selectedAlly.selectedAction = global.action;
	player.selectedAlly.selectedTarget = spotNum;
	player.selectedAlly.turnReady = true;
	
	if (global.action == sparActions.swap) {
		if (selectedAction == sparActions.swap) {
			var t = spar.spriteList[| selectedTarget];
			
			with (t) {
				readyDisplay = "";
				readyDisplayBuilt = false;
				selectedAction = -4;	
				selectedTarget = -4;
				turnReady = false;
			}
		}
		
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
	// check if the selected ally previously selected a swap
	if (player.selectedAlly.selectedAction == sparActions.swap) {
		// get their swap partner
		var t = spar.spriteList[| player.selectedAlly.selectedTarget];	
		
		// get the selected ally
		var p = player.selectedAlly;
		
		// reset all variables for the swap partner's turn selection
		with (t) {
			readyDisplay = "";
			readyDisplayBuilt = false;
			selectedAction = -4;
			selectedTarget = -4;
			turnReady = false;
		}
	}
	
	// set all variables for this sprite's turn with self target
	player.selectedAlly.readyDisplayBuilt = false;
	player.selectedAlly.selectedAction = global.action;
	player.selectedAlly.selectedTarget = -1;
	player.selectedAlly.turnReady = true;
}

///@desc This function should be called at the beginning of a spar since
/// the nearby sprites for each spot will remain the same through the match.
function sprite_build_nearby_lists() {
	// clear all lists
	ds_list_clear(nearbyAllies);
	ds_list_clear(nearbyEnemies);
	ds_list_clear(nearbySprites);
	
	// rebuild ally and enemy lists depending on position
	switch (spotNum) {
		case 0:
			ds_list_add(nearbyAllies,
				spar.spriteList[| 1]
			);
			
			ds_list_add(nearbyEnemies,
				spar.spriteList[| 7],
				spar.spriteList[| 6]
			);
		break;
		
		case 1:
			ds_list_add(nearbyAllies,
				spar.spriteList[| 0],
				spar.spriteList[| 1]
			);
			
			ds_list_add(nearbyEnemies,
				spar.spriteList[| 7],
				spar.spriteList[| 6],
				spar.spriteList[| 5]
			);
		break;
		
		case 2:
			ds_list_add(nearbyAllies,
				spar.spriteList[| 1],
				spar.spriteList[| 3]
			);
			
			ds_list_add(nearbyEnemies,
				spar.spriteList[| 6],
				spar.spriteList[| 5],
				spar.spriteList[| 4]
			);
		break;
		
		case 3:
			ds_list_add(nearbyAllies,
				spar.spriteList[| 2]
			);
			
			ds_list_add(nearbyEnemies,
				spar.spriteList[| 5],
				spar.spriteList[| 4]
			);
		break;
		
		case 4:
			ds_list_add(nearbyAllies,
				spar.spriteList[| 5]
			);
			
			ds_list_add(nearbyEnemies,
				spar.spriteList[| 3],
				spar.spriteList[| 2]
			);
		break;
		
		case 5:
			ds_list_add(nearbyAllies,
				spar.spriteList[| 4],
				spar.spriteList[| 6]
			);
			
			ds_list_add(nearbyEnemies,
				spar.spriteList[| 3],
				spar.spriteList[| 2],
				spar.spriteList[| 1]
			);
		break;
		
		case 6:
			ds_list_add(nearbyAllies,
				spar.spriteList[| 5],
				spar.spriteList[| 7]
			);
			
			ds_list_add(nearbyEnemies,
				spar.spriteList[| 2],
				spar.spriteList[| 1],
				spar.spriteList[| 0]
			);
		break;
		
		case 7:
			ds_list_add(nearbyAllies,
				spar.spriteList[| 6]
			);
			
			ds_list_add(nearbyEnemies,
				spar.spriteList[| 1],
				spar.spriteList[| 0]
			);
		break;
	}
	
	// combine enemy and ally lists to get nearbySprites list
	ds_list_append(nearbyAllies, nearbyEnemies, nearbySprites);
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
	global.mpCostDiff = 0;
	
	// check if selected sprite has already selected a spell this turn
	if (player.selectedAlly.selectedAction >= sparActions.height) {
		global.mpCostDiff = spell_get_cost(player.selectedAlly.selectedAction - sparActions.height);
	}

	// check if selected sprite has already selected a swap this turn
	if (player.selectedAlly.selectedAction == sparActions.swap) {
		global.mpCostDiff = swap_get_cost(player.selectedAlly, spar.allyList[| player.selectedAlly.selectedTarget]);	
	}	
	
	// store args in locals
	var i1 = _inst1;
	var i2 = _inst2;

	// check if inst1 is using a spell
	if (i1.selectedAction >= sparActions.height) {
		global.mpCostDiff += spell_get_cost(i1.selectedAction - sparActions.height);	
	}

	// check if inst1 is already swapping
	if (i1.selectedAction == sparActions.swap) {
		global.mpCostDiff += swap_get_cost(i1, spar.spriteList[| i1.selectedTarget]);
	}
	
	// check if inst2 is using a spell
	if (i2.selectedAction >= sparActions.height) {
		global.mpCostDiff += spell_get_cost(i2.selectedAction - sparActions.height);
	}
	
	// check if inst2 is already swapping
	if (i2.selectedAction == sparActions.swap) {
		global.mpCostDiff += swap_get_cost(i2, spar.spriteList[| i2.selectedTarget]);	
	}

	var c = swap_get_cost(i1, i2);
	
	spar.potentialSwapCost = c;
	
	// set mpCalculated to false so that the spar object can
	// recalculate the nextTurnFinalMP
	spar.mpCalculated = false;
}

function spell_set_potential_cost(_spellCost) {
	global.mpCostDiff = 0;
	
	// check if selected sprite has already selected a spell this turn
	if (player.selectedAlly.selectedAction >= sparActions.height) {
		global.mpCostDiff = spell_get_cost(player.selectedAlly.selectedAction - sparActions.height);
	}
	
	// check if selected sprite has already selected a swap this turn
	if (player.selectedAlly.selectedAction == sparActions.swap) {
		global.mpCostDiff = swap_get_cost(player.selectedAlly, spar.allyList[| player.selectedAlly.selectedTarget]);
	}	
	
	// set cost as the given spellCost - mpCostDiff
	var c = _spellCost - global.mpCostDiff;
	
	spar.potentialSpellCost = c;
	
	// set mpCalculated to false so that the spar object can
	// recalculate the nextTurnFinalMP
	spar.mpCalculated = false;
}
	
function correct_uiAlpha() {
	if !(instance_exists(sparSpellFX))
	&& (uiAlpha < 1.0)	uiAlpha += 0.05;
	
	if (instance_exists(sparSpellFX))
	&& (uiAlpha > 0.0)	uiAlpha -= 0.05;
}

///@desc This function returns true if NO sprites are
/// flashing. It sets a variable to true at the beginning and
/// only changes it to false if one of the sprites in the spar is
/// flashing.
function check_sprites_done_flashing() {
	// set boolean var to true
	var doneFlashing = true;
	
	var i = 0;	repeat (ds_list_size(spar.spriteList)) {
		var inst = spar.spriteList[| i];
		
		// if flashRate has been set
		if (inst.flashRate != -1) {
			// set doneFlashing to false
			doneFlashing = false;
			
			// return doneFlashing
			return doneFlashing;
		}
		
		i++;
	}
	
	return doneFlashing;
}
	
///@desc This function accepts an integer 1-8 and returns a string of that number's name.
/// This is meant specifically for the rest, dodge, and swap processors (hence the casing of the text).
function turn_message_get_number_text(_int) {
	var int = _int;
	
	switch (int) {
		case 1: return "One";
		case 2: return "Two";
		case 3: return "Three";
		case 4: return "Four";
		case 5: return "Five";
		case 6: return "Six";
		case 7: return "Seven";
		case 8: return "Eight";
	}
}

function get_best_elemental_stat(_spriteInstance) {
	// store args in locals
	var si = _spriteInstance;
	
	// initialize highest val
	var highest = 0;
	var highestStat = -1;
	
	// use a repeat loop to check each stat
	var i = 0;	repeat (4) {
		// use a switch statement to check each stat
		switch (i) {
			case 0:			
				if (si.baseFire > highest) {
					highest = si.baseFire;
					highestStat = elements.fire;	
				}
				else if (si.baseFire == highest) {
					randomize();
					
					var r = irandom_range(0, 1);
					
					if (r == 0) {
						highest = si.baseFire;
						highestStat = elements.fire;
					}
				}
			break;
			
			case 1:
				if (si.baseWater > highest) {
					highest = si.baseWater;
					highestStat = elements.water;
				}
				else if (si.baseWater == highest) {
					randomize();
					
					var r = irandom_range(0, 1);
					
					if (r == 0) {
						highest = si.baseWater;
						highestStat = elements.water;
					}
				}
			break;
		
			case 2:
				if (si.baseStorm > highest) {
					highest = si.baseStorm;
					highestStat = elements.storm;
				}
				else if (si.baseStorm == highest) {
					randomize();
					
					var r = irandom_range(0, 1);
					
					if (r == 0) {
						highest = si.baseStorm;
						highestStat = elements.storm;
					}
				}	
			break;
			
			case 3:
				if (si.baseEarth > highest) {
					highest = si.baseEarth;
					highestStat = elements.earth;
				}	
				else if (si.baseEarth == highest) {
					randomize();
					
					var r = irandom_range(0, 1);
					
					if (r == 0) {
						highest = si.baseEarth;
						highestStat = elements.earth;
					}
				}
			break;
		}
		
		// increment i
		i++;
	}
	
	// return the highest stat ID
	return highestStat;
}

function get_worst_elemental_stat(_spriteInstance) {
	// store args in locals
	var si = _spriteInstance;
	
	// initialize highest val
	var lowest = 1000;
	var lowestStat = -1;
	
	// use a repeat loop to check each stat
	var i = 0;	repeat (4) {
		// use a switch statement to check each stat
		switch (i) {
			case 0:			
				if (si.baseFire < lowest) {
					lowest = si.baseFire;
					lowestStat = elements.fire;	
				}
				else if (si.baseFire == lowest) {
					randomize();
					
					var r = irandom_range(0, 1);
					
					if (r == 0) {
						lowest = si.baseFire;
						lowestStat = elements.fire;
					}
				}
			break;
			
			case 1:
				if (si.baseWater < lowest) {
					lowest = si.baseWater;
					lowestStat = elements.water;
				}
				else if (si.baseWater == lowest) {
					randomize();
					
					var r = irandom_range(0, 1);
					
					if (r == 0) {
						lowest = si.baseWater;
						lowestStat = elements.water;
					}
				}
			break;
		
			case 2:
				if (si.baseStorm < lowest) {
					lowest = si.baseStorm;
					lowestStat = elements.storm;
				}
				else if (si.baseStorm == lowest) {
					randomize();
					
					var r = irandom_range(0, 1);
					
					if (r == 0) {
						lowest = si.baseStorm;
						lowestStat = elements.storm;
					}
				}	
			break;
			
			case 3:
				if (si.baseEarth < lowest) {
					lowest = si.baseEarth;
					lowestStat = elements.earth;
				}	
				else if (si.baseEarth == lowest) {
					randomize();
					
					var r = irandom_range(0, 1);
					
					if (r == 0) {
						lowest = si.baseEarth;
						lowestStat = elements.earth;
					}
				}
			break;
		}
		
		// increment i
		i++;
	}
	
	// return the lowest stat ID
	return lowestStat;
}

function get_base_stat_value(_spriteInstance) {
	return -1;
}

function get_base_stat_elemental(_spriteInstance) {
	return -1;
}

function get_current_stat(_spriteInstance) {
	return -1;
}

function get_current_stat_elemental(_spriteInstance) {
	return -1;
}

function spar_check_complete() {
	if (spar.playerOne.currentHP <= 0)
	|| (spar.playerTwo.currentHP <= 0) {
		ds_list_clear(spar.effectAlertList);
		
		spar.sparPhase = SPAR_PHASES.HEIGHT;
		return true;	
	}
	else	{
		return false;	
	}
}

function improve_range() {
	// use a switch statement to correct range as necesssary
	switch (global.targetRange) {
		case ranges.nearestOneEnemy:
			global.targetRange = ranges.anyEnemy;
		break;
		
		case ranges.nearestTwoAllies:
			global.targetRange = ranges.anyAlly;
		break;
		
		case ranges.nearestThreeSprites:
			global.targetRange = ranges.anySprite;
		break;
		
		case ranges.nearestFiveSprites:
			global.targetRange = ranges.anySprite;
		break;
		
		case ranges.nearestThreeEnemies:
			global.targetRange = ranges.anyEnemy;
		break;
	}	
}