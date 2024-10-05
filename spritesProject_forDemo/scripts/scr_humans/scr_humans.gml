// these macros are used to store the width and height of the human sprite sheets
#macro humanSheetWidth		384
#macro humanSheetHeight		42

// enumerator to store the four cardinal directions
enum directions {
	south,
	east,
	north,
	west
}

// these macros store the width and height of each frame on the
// human appearance sprite sheets
#macro humanSpriteWidth		24
#macro humanSpriteHeight	42

// enumerator containing the states each human can be in
// in the overworld
enum humanStates {
	standard,
	eating,
	drinking,
	playingWavephone,
	meditating,
	wandering,
	height
}

///@desc This function uses the humans hmove and vmove variables
/// to travel on land in the overworld--with respect to any collidable
/// tiles and objects
function human_walk() {
	if instance_exists(menu) {
		exit;
	}
	
	if (instance_exists(overworld)) {
		if (global.overworld) {
			if moving {
				// horizontal movement and collision
				if !(tile_meeting(x + hmove, y, tm_water, waterTileChecker)) 
				&& !(tile_meeting(x + hmove, y, tm_collidables, collidableTileChecker)) 
				&& !(place_meeting(x + hmove, y, sceneryCollidable)) 
				&& !(place_meeting(x + hmove, y, human)) {
					x = round(x + hmove);
				}
			
				// vertical movement and collision
				if !(tile_meeting(x, y + vmove, tm_water, waterTileChecker)) 
				&& !(tile_meeting(x, y + vmove, tm_collidables, collidableTileChecker)) 
				&& !(place_meeting(x, y + vmove, sceneryCollidable)) 
				&& !(place_meeting(x, y + vmove, human)) {
					y = round(y + vmove);
				}
			}
				// switch boolean variable moving depending on hmove and vmove values
				if (abs(hmove) + abs(vmove) > 0)	{moving = true;}
				if (abs(hmove) + abs(vmove) <= 0)	{moving = false;}
		}
	}
}

///@desc This function uses the humans hmove and vmove variables
/// to travel in water in the overworld--with respect to any collidable
/// tiles and objects
function human_swim() {
	if instance_exists(menu) {
		exit;
	}	
	
	if (instance_exists(overworld)) {
		if (global.overworld) {	
			if moving {
				// horizontal movement and collision
				if !(tile_meeting(x + hmove, y, tm_ground, groundTileChecker))
				&& !(tile_meeting(x + hmove, y, tm_collidables, collidableTileChecker)) 
				&& !(place_meeting(x + hmove, y, sceneryCollidable)) 
				&& !(place_meeting(x + hmove, y, human)) {
					x = round(x + hmove);
				}
			
				// vertical movement and collision
				if !(tile_meeting(x, y + vmove, tm_ground, groundTileChecker))
				&& !(tile_meeting(x, y + vmove, tm_collidables, collidableTileChecker))
				&& !(place_meeting(x, y + vmove, sceneryCollidable))
				&& !(place_meeting(x, y + vmove, human)) {
					y = round(y + vmove);
				}
			}
			
			// switch boolean variable moving depending on move and vmove values
			if (abs(hmove) + abs(vmove) > 0)	{moving = true;}
			if (abs(hmove) + abs(vmove) <= 0)	{moving = false;}
		}
	}
}

///@desc This function checks to see if the human is successfully moving, 
/// and should therefore be animated
function human_check_moving() {
	if abs(hmove) + abs(vmove) > 0		moving = true;
	if abs(hmove) + abs(vmove) == 0		moving = false;
}

///@desc This function gets the direction that the human is facing (north,
/// east, south, west--according to their respective IDs in the directions enum)
function human_set_facing() {
	var dir	= point_direction(0, 0, hmove, vmove);
	
	switch(dir) {
		case 0:
			facing = directions.east;
		break;
		
		case 90:
			facing = directions.north;
		break;
		
		case 180:
			facing = directions.west;
		break;
		
		case 270:
			facing = directions.south;
		break;
		}	
}

///@desc This function sets the position of the humans interaction pointer depending on
/// their x and y position as well as the direction they're facing
function human_pointer_set() {	
	switch (facing) {
		case directions.east:
			pointerX = x + 12;
			pointerY = y;
		break;
		
		case directions.south:
			pointerX = x;
			pointerY = y + 6;
		break;

		case directions.west:
			pointerX = x - 12;
			pointerY = y;
		break;
		
		case directions.north:
			pointerX = x;
			pointerY = y - 18;
		break;
	}
}
	
///@desc This function is called by the interact function. The function gets the
/// interactable object or tile that the human is interacting with
function get_interactable() {
	if instance_exists(menu) {
		exit;
	}
	
	var checkY = y;
	var checkY = bbox_bottom - 3;

	switch (facing) {		
		case directions.east:
			var interactable = collision_line(x, checkY, x + 20, checkY, npc, false, true);
		break;
		
		case directions.south:
			var interactable = collision_line(x, checkY, x, checkY + 12, npc, false, true);
		break;
		
		case directions.west:
			var interactable = collision_line(x, checkY, x - 20, checkY, npc, false, true);
		break;
		
		case directions.north:
			var interactable = collision_line(x, checkY, x, checkY - 36, npc, false, true);
		break;
	}

	if interactable != noone {
		global.speaker	= interactable;
		global.dialogue	= interactable.responseFunction();
		return interactions.talk;
	}

	// start swimming
	if !(swimming) 
	&& (tile_meeting(pointerX, pointerY, tm_water, waterTileChecker)) 
	&& !(tile_meeting(pointerX, pointerY, tm_collidables, collidableTileChecker))
	&& !(place_meeting(pointerX, pointerY, sceneryCollidable)) {
		return interactions.swimStart;
	}
	
	// stop swimming
	if (swimming) 
	&& (tile_meeting(pointerX, pointerY, tm_ground, groundTileChecker)) 
	&& !(tile_meeting(pointerX, pointerY, tm_collidables, collidableTileChecker))
	&& !(place_meeting(pointerX, pointerY, sceneryCollidable)) {
		return interactions.swimStop;
	}
	
	// check sendport
	if (place_meeting(pointerX, pointerY, sendport))	return interactions.sendport;
	
	// check door
	if (place_meeting(pointerX, pointerY, door))		return interactions.doorCheck;
	
	// read literature
	if (place_meeting(pointerX, pointerY, literature))	return interactions.read;
	
	// check bookcase
	
	// if nothing, return noone
	return noone;
}

///@desc This function is called whenever a human indicates that they want to interact
/// with the object or tile that is in front of them while they're in the overworld.
/// The function finds the proper object index and pushes an alert to the overworldAlerts
/// list, indicating that the given interaction should begin to take place
function interact() {
	if instance_exists(menu) {
		exit;
	}	
	
	var interactable = get_interactable();
	
	switch (interactable) {
			case interactions.swimStart:	ds_list_push(overworld.alertStack, overworldAlerts.swimStart);		break;
		
			case interactions.swimStop:		ds_list_push(overworld.alertStack, overworldAlerts.swimStop);		break;
		
			case interactions.doorCheck:	door_check();														break;
			
			case interactions.read:			read_literature();													break;
			
			case interactions.talk:			instance_create_depth(0, 0, get_layer_depth(LAYER.ui), talkBubble);	break;
			
			case interactions.sendport:		sendport.frame = 1;	sendport.alarm[0] = 12;							break;
	}
}

///@desc This function is called whenever a human indicates that they want to 
/// get out of the water and stop swimming. The function switches the swimming variable
/// to false after placing the human in a safe location on land
function check_water_get_out(_x, _y) {
	// get local vars
	var spawnX = _x;
	var spawnY = _y;
	
	// get all necessary tilemaps
	var tmCollidable	= player.tm_collidables;
	var tmWater			= player.tm_water;
	
	// set maskWidth and maskHeight (should be 18 and 3)
	var maskWidth	= 18;
	var maskHeight	= 3;

	// get the dimensions of the spawnChecker's bbox
	var bbLeft		= spawnX - (maskWidth / 2);
	var bbRight		= spawnX + (maskWidth / 2);
	var bbBottom	= spawnY + (maskHeight / 2);
	var bbTop		= bbBottom - maskHeight;

	// if the spawnChecker is offscreen at all, return true to avoid bugs
	var rw = overworld.locationWidth; var rh = overworld.locationHeight;
	if (bbLeft < 0) || (bbTop < 0) || (bbRight > rw) || (bbBottom > rh) return true;
	
	// get the column and row of each tile being touched by the spawnChecker
	var column1	= tilemap_get_cell_x_at_pixel(tmWater, bbLeft,	spawnY);
	var column2 = tilemap_get_cell_x_at_pixel(tmWater, bbRight, spawnY);
	var row1	= tilemap_get_cell_y_at_pixel(tmWater, spawnX,	bbTop);
	var row2	= tilemap_get_cell_y_at_pixel(tmWater, spawnX,	bbBottom);
	
	// use two for loops to create all the tile checkers
	for (var checkerX = column1; checkerX <= column2; checkerX++) {
		for (var checkerY = row1; checkerY <= row2; checkerY++) {
			// create the tile checkers
			var waterChecker		= instance_create_depth(checkerX * TILEWIDTH, checkerY * TILEHEIGHT, get_layer_depth(LAYER.uiFront), waterTileChecker);
			var collidableChecker	= instance_create_depth(checkerX * TILEWIDTH, checkerY * TILEHEIGHT, get_layer_depth(LAYER.uiFront), collidableTileChecker);
			
			// get index of water and collidable tiles
			var waterTile		= tile_get_index(tilemap_get(tmWater,		checkerX, checkerY));
			var collidableTile	= tile_get_index(tilemap_get(tmCollidable,	checkerX, checkerY));
			
			// set the frame of each checker as the tile index for each
			waterChecker.image_index		= waterTile;
			collidableChecker.image_index	= collidableTile;
			
			// check for collisions using a collision rectangle the size of the playerMask
			var waterCollision	= collision_rectangle(bbLeft, bbTop, bbRight, bbBottom, waterChecker, true, true);
			var tileCollision	= collision_rectangle(bbLeft, bbTop, bbRight, bbBottom, collidableChecker, true, true);
			var objectCollision	= collision_rectangle(bbLeft, bbTop, bbRight, bbBottom, sceneryCollidable, true, true);
			
			// if any instance IDs are returned, return false
			if waterCollision	>= 0 return false;
			if tileCollision	>= 0 return false;
			if objectCollision	>= 0 return false;
		}
	}
	
	// if it gets through the for loop without returning false, return true
	return true;
}

///@desc This function is called whenever a human indicates that they want to
/// get into the water and start swimming. The function switches the swimming variable
/// to true after placing the human in a safe location on land
function check_water_get_in(_x, _y) {
	// get local vars
	var spawnX = _x;
	var spawnY = _y;
	
	// get all necessary tilemaps
	var tmCollidable	= player.tm_collidables;
	var tmGround		= player.tm_ground;
	
	// set maskWidth and maskHeight (should be 18 and 3)
	var maskWidth	= 18;
	var maskHeight	= 3;

	// get the dimensions of the spawnChecker's bbox
	var bbLeft		= spawnX - (maskWidth / 2);
	var bbRight		= spawnX + (maskWidth / 2);
	var bbBottom	= spawnY + (maskHeight / 2);
	var bbTop		= bbBottom - maskHeight;

	// if the spawnChecker is offscreen at all, return true to avoid bugs
	var rw = overworld.locationWidth; var rh = overworld.locationHeight;
	if (bbLeft < 0) || (bbTop < 0) || (bbRight > rw) || (bbBottom > rh) return true;
	
	// get the column and row of each tile being touched by the spawnChecker
	var column1	= tilemap_get_cell_x_at_pixel(tmGround, bbLeft,	spawnY);
	var column2 = tilemap_get_cell_x_at_pixel(tmGround, bbRight, spawnY);
	var row1	= tilemap_get_cell_y_at_pixel(tmGround, spawnX,	bbTop);
	var row2	= tilemap_get_cell_y_at_pixel(tmGround, spawnX,	bbBottom);
	
	// use two for loops to create all the tile checkers
	for (var checkerX = column1; checkerX <= column2; checkerX++) {
		for (var checkerY = row1; checkerY <= row2; checkerY++) {
			// create the tile checkers
			var groundChecker		= instance_create_depth(checkerX * TILEWIDTH, checkerY * TILEHEIGHT, get_layer_depth(LAYER.uiFront), groundTileChecker);
			var collidableChecker	= instance_create_depth(checkerX * TILEWIDTH, checkerY * TILEHEIGHT, get_layer_depth(LAYER.uiFront), collidableTileChecker);
			
			// get index of water and collidable tiles
			var waterTile		= tile_get_index(tilemap_get(tmGround,		checkerX, checkerY));
			var collidableTile	= tile_get_index(tilemap_get(tmCollidable,	checkerX, checkerY));
			
			// set the frame of each checker as the tile index for each
			groundChecker.image_index		= waterTile;
			collidableChecker.image_index	= collidableTile;
			
			// check for collisions using a collision rectangle the size of the playerMask
			var groundCollision	= collision_rectangle(bbLeft, bbTop, bbRight, bbBottom, groundChecker, true, true);
			var tileCollision	= collision_rectangle(bbLeft, bbTop, bbRight, bbBottom, collidableChecker, true, true);
			var objectCollision	= collision_rectangle(bbLeft, bbTop, bbRight, bbBottom, sceneryCollidable, true, true);
			
			// if any instance IDs are returned, return false
			if groundCollision	>= 0 return false;
			if tileCollision	>= 0 return false;
			if objectCollision	>= 0 return false;
		}
	}
	
	// if it gets through the for loop without returning false, return true
	return true;
}

///@desc This function is called in the NPC step event to set the proper sprite 
/// depending on the NPC's current state
function npc_set_sprite() {
	// use the state to set the sprite
	switch (state) {
		case humanStates.standard:	
			if !swimming	sprite = walkingSprite;
			if swimming		sprite = swimmingSprite;
		break;
		case humanStates.eating:			sprite = eatingSprite;		break;
		case humanStates.drinking:			sprite = drinkingSprite;	break;
		case humanStates.playingWavephone:	sprite = wavephoneSprite;	break;
		case humanStates.meditating:		sprite = meditatingSprite;	break;
	}
	
	// get frameCount
	frameCount = sprite_get_number(sprite) / 4;
	
	// set min and maxFrame
	npc_set_frames();
}

///@desc This function is called in the NPC and player step events to set the min and max
/// frames for their current animation
function npc_set_frames() {
	var minPrev	= minFrame;
	var maxPrev = maxFrame;
	
	minFrame = facing * frameCount;
	maxFrame = (facing * frameCount) + (frameCount - 1);
	
	// if they are not the same as before the calculation, change  frame to minFrame
	if (minPrev != minFrame) || (maxPrev != maxFrame)	frame = minFrame;
}

///@desc This function is called to increment the frame variable for humans and npcs
function animate_human() {
	// increment frame when appropriate
	if !(global.gameTime mod 8) frame++;

	// wrap using min and maxFrame
	if frame > maxFrame frame = minFrame;
}

///@desc This function can be used to set the depthY variable for a human. The depthY
/// variable is just the y value of the human's feet. This is used to determine how far
/// forward or back the player is from the screen
function human_get_depthY() {
	depthY = y + (spriteHeight / 2);
}

///@desc This function can be used to set the human's depth depending on their depthY
/// variable. I believe this is the same math as the math being done in the 
/// object_set_depth function, so....we'll see....
function human_set_depth() {
	depth = get_layer_depth(LAYER.collidableTiles) - depthY;	
}

///@desc This function is called at the beginning of a spar. It takes the human's
/// spell selections and builds a ds_grid of all their parameters so that the info
/// can be quickly accessed.
function player_build_spellBookGrid() {	
	// decode spell grid
	var grid = ds_grid_create(SPELL_PARAMS.HEIGHT, SPELLS.HEIGHT);
	decode_grid(global.allSpells, grid);

	// build spellBook list
	spellBook = ds_list_create();
	decode_list(spellBookString, spellBook);

	// resize spellBookGrid if needed
	if (ds_grid_height(spellBookGrid) != ds_list_size(spellBook)) {
		ds_grid_resize(spellBookGrid, SPELL_PARAMS.HEIGHT, ds_list_size(spellBook));
	}

	// use a repeat loop to add the info for each spell in spellBook
	var i = 0;	repeat (ds_list_size(spellBook)) {
		// get id
		var spellID = spellBook[| i];
		
		// use a repeat loop to set all vars
		var j = 0;	repeat (SPELL_PARAMS.HEIGHT) {
			// set proper value
			spellBookGrid[# j,	i] = grid[# j, spellID];
			
			if (j == SPELL_PARAMS.EFFECT)
			|| (j == SPELL_PARAMS.DODGEABLE)
			|| (j == SPELL_PARAMS.POWER)
			|| (j == SPELL_PARAMS.RANGE)
			|| (j == SPELL_PARAMS.ID)
			|| (j == SPELL_PARAMS.TYPE)	{
				spellBookGrid[# j, i] = real(string_digits(spellBookGrid[# j, i]));	
			}
			
			// increment j
			j++;
		}
		
		// increment i
		i++;
	}
}