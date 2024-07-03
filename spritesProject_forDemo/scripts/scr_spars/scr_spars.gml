#macro REST_BASE_MP_REGEN	20

#macro HEXED_COUNT_MAX			1
#macro BOUND_COUNT_MAX			1
#macro BERSERK_COUNT_MAX		2
#macro INVULNERABLE_COUNT_MAX	0

global.hoverSprite		= -1;
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
			spar.selectionPhase = selectionPhases.ally;
		break;
		
		case sparActions.swap:
			global.targetRange = ranges.anyAlly;
			spar.selectionPhase = selectionPhases.target;
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
		
			var r = (REST_BASE_MP_REGEN * 72.5);
			var c = player.currentMP;
			
			if (r + c > MAX_MP)	r = MAX_MP - c;
		
			spar.totalSelectionCost -= r;
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

function spar_set_spell() {
	// set selectedAction to currentSpell
	player.selectedAlly.selectedAction = currentSpell;
	
	// set spellRange for target selection
	global.targetRange = spellRange;
	
	// set next selectionPhase
	spar.selectionPhase = selectionPhases.target;
	
	inRangeSprites_rebuild(player.selectedAlly, global.targetRange);
	
	// set next phase
	nextPhase = selectionPhases.target;
	
	instance_destroy(sparSpellMenu);
}

function enemyAI_get_params() {
	// create temporary grid
	var grid = ds_grid_create(npcParams.height, npcs.height);
	
	// decode npcGrid
	decode_grid(global.allNPCs, grid);
	
	// use npcID to get params
	talismanString	= grid[# npcParams.talismans,	ID];
	name			= grid[# npcParams.name,		ID];
	spellString		= grid[# npcParams.spells,		ID];
	
	// decode talismanString and spellString
	decode_list(talismanString, roster);
	decode_list(spellString, spellBook);
	
	// delete temporary grid
	ds_grid_destroy(grid);
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
	
	if (instance_exists(onlineEnemy)) {
		var onlineGrid = ds_grid_create(4, 4);
	}
	
	var onlineGrid = ds_grid_create(4, 4);
	
	var i = 0;	repeat (4) {
		// get sprite
		var inst = spar.allyList[| i];
		
		// get luck tier
		var lt = get_luck_tier(inst.currentLuck);

		var roll = roll_for_luck(lt);
		
		// add info to spar.turnGrid
		spar.turnGrid[# selectionPhases.ally,		inst.spotNum]	= inst.spotNum;
		spar.turnGrid[# selectionPhases.action,		inst.spotNum]	= inst.selectedAction;
		spar.turnGrid[# selectionPhases.target,		inst.spotNum]	= inst.selectedTarget;
		spar.turnGrid[# selectionPhases.height,		inst.spotNum]	= roll;
		
		if (instance_exists(onlineEnemy)) {
			// add info to onlineGrid
			onlineGrid[# selectionPhases.ally,		inst.spotNum]	= inst.spotNum;
			onlineGrid[# selectionPhases.action,	inst.spotNum]	= inst.selectedAction;
			onlineGrid[# selectionPhases.target,	inst.spotNum]	= inst.selectedTarget;
			onlineGrid[# selectionPhases.height,	inst.spotNum]	= roll;		
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
		
		network_send_udp_raw(spar.client, SERVER_ADDRESS, 80, spar.onlineBuffer, buffer_tell(spar.onlineBuffer));
		
		spar.onlineWaiting = true;	
	}
}

///@desc This is my first attempt at a basic selection algorithm. Each of them
/// should follow this general structure, I'll comment out the main beats of the process.
/// this should go into the npc script and be added to the npc grid under a new parameter
function mercurio_selection_logic() {
	// use a repeat loop to check in with each sprite on the team.
	var i = 0;	repeat (ds_list_size(spar.enemyList)) {
		var inst = spar.enemyList[| i];
		
		switch (inst.spriteID) {
			case SPRITES.DEMOLITOPS:
				// check for any nearby threats
				
				// check for any ideal nearby targets
				
				// check if the enemy could potentially make a saving swap
				
				// determine if it's worth the risk
			break;
			
			case SPRITES.ZEPHIRA:
			break;
			
			case SPRITES.FISHMONGER:
			break;
			
			case SPRITES.UPROOTER:
			break;
		}
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
		spar.turnGrid[# selectionPhases.ally,	inst.spotNum]		= inst.spotNum;
		spar.turnGrid[# selectionPhases.action,	inst.spotNum]		= inst.selectedAction;
		spar.turnGrid[# selectionPhases.target, inst.spotNum]		= inst.selectedTarget;
		spar.turnGrid[# selectionPhases.height,	inst.spotNum]		= roll;
		
		// increment i
		i++;
	}
	
	ready = true;
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
				readyDisplay = format_text(substring, spriteWidth - 4, 4, 1);
			}
			else {
				var substring = "attacking ally " + numString;
				readyDisplay = format_text(substring, spriteWidth - 4, 4, 1);
			}
		break;
		
		case sparActions.dodge:
			var substring = "dodging";
			readyDisplay = format_text(substring, spriteWidth - 4, 4, 1);
		break;
		
		case sparActions.swap:
			var substring = "swapping with ally " + numString;
			readyDisplay = format_text(substring, spriteWidth - 4, 4, 1);
		break;
		
		case sparActions.rest:
			var substring = "resting";
			readyDisplay = format_text(substring, spriteWidth - 4, 4, 1);
		break;
	}
	
	readyDisplayBuilt = true;
}

///@desc This function sets the selected ally's action and target with global.action and
/// the spotNum of the sprite being clicked, respectively. (This function should only
/// be called by a sprite being clicked during target selection).
function spar_set_target() {
	if (player.selectedAlly.selectedAction == sparActions.swap) {
		var t = spar.spriteList[| player.selectedAlly.selectedTarget];
		
		with (t) {
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
	
	spar.totalSelectionCost += spar.potentialCost;
	spar.potentialCost = 0;
}

///@desc This function sets the selected ally's action and target with global.action
/// and the macro indicating a self targeting action. This function can be called whenever
/// you are ready to do this as it doesn't make any local references.
function self_target_set() {
	if (player.selectedAlly.selectedAction == sparActions.swap) {
		var t = spar.spriteList[| player.selectedAlly.selectedTarget];	
		
		with (t) {
			readyDisplay = "";
			readyDisplayBuilt = false;
			selectedAction = -4;
			selectedTarget = -4;
			turnReady = false;
		}
	}
	
	player.selectedAlly.readyDisplayBuilt = false;
	player.selectedAlly.selectedAction = global.action;
	player.selectedAlly.selectedTarget = -1;
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

///@desc This function is used to draw text in the battle scene. It's just a way of safely ensuring that when text
/// is drawn with a centered alignment, it corrects if the width of the string being drawn is an odd number (can't draw
/// pixels at decimal values) This should only be used when drawing text with a center and/or middle alignment
function draw_text_pixel_perfect(_x, _y, _text, _scale) {
	var xx = _x;
	var yy = _y;
	var tt = _text;
	var ss = _scale;
	
	if ((string_width(tt) / 2) mod 2 != 0) {
		xx -= 1;	
	}
	
	if ((string_height(tt) / 2) mod 2 != 0) {
		yy -= 1;	
	}
	
	draw_text_transformed(xx, yy, tt, ss, ss, 0);
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
	if (player.currentMP - (spar.totalSelectionCost + c) >= 0)	
	{
		spar.potentialCost = c;
		return 1;	
	}
	else {
		return 0;	
	}
}

function spell_set_potential_cost(_spellCost) {
	var c = _spellCost;
	
	// if there's enough MP, set the cost
	if (player.currentMP - (spar.totalSelectionCost + c) >= 0)	{
		spar.potentialCost = c;
		return 1;
	}
	else {
		return 0;	
	}
}
	
function correct_uiAlpha() {
	if !(instance_exists(sparSpellFX))
	&& (uiAlpha < 1.0)	uiAlpha += 0.05;
	
	if (instance_exists(sparSpellFX))
	&& (uiAlpha > 0.0)	uiAlpha -= 0.05;
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
	
function blast_timers_check_ready() {
	
}

function get_best_elemental_stat(_spriteInstance) {
	return -1;
}

function get_worst_elemental_stat(_spriteInstance) {
	return -1;
}

function get_base_stat_value() {
	return -1;
}

function get_base_stat_elemental() {
	return -1;
}

function get_current_stat() {
	return -1;
}

function get_current_stat_elemental() {
	return -1;
}