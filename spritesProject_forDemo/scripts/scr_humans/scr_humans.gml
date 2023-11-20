#macro humanSheetWidth		384
#macro humanSheetHeight		42

enum directions {
	south,
	east,
	north,
	west
}

global.speaker		= noone;
global.dialogue		= "";

#macro appearanceGridSectionHeight	168

#macro humanMaskWidth		18
#macro humanMaskHeight		4

#macro humanSpriteWidth		24
#macro humanSpriteHeight	42

enum humanStates {
	standard,
	eating,
	drinking,
	playingWavephone,
	meditating,
	wandering,
	height
}

function draw_standard_human(_skintone, _outfit, _outfitColor, _hair, _hairColor, _hat, _hatColor, _shoes, _shoeColor, _accessory, _accColor) {
	draw_sprite_part_ext(humanBody,		0, 0,	0,								humanSheetWidth, humanSheetHeight, 0, 0, 1, 1, _skintone,		1.0);
	draw_sprite_part_ext(outfitSheet,	0, 0,	humanSheetHeight * _outfit,		humanSheetWidth, humanSheetHeight, 0, 0, 1, 1, _outfitColor,	1.0);
	draw_sprite_part_ext(hairSheet,		0, 0,	humanSheetHeight * _hair,		humanSheetWidth, humanSheetHeight, 0, 0, 1, 1, _hairColor,		1.0);
	draw_sprite_part_ext(hatSheet,		0, 0,	humanSheetHeight * _hat,		humanSheetWidth, humanSheetHeight, 0, 0, 1, 1, _hatColor,		1.0);
	draw_sprite_part_ext(shoeSheet,		0, 0,	humanSheetHeight * _shoes,		humanSheetWidth, humanSheetHeight, 0, 0, 1, 1, _shoeColor,		1.0);
	//draw_sprite_part_ext(accessorySheet,0, 0,	humanSheetHeight * _accessory,	humanSheetWidth, humanSheetHeight, 0, 0, 1, 1, _accColor,		1.0);
}

function draw_eating_human(_skintone, _outfit, _outfitColor, _hair, _hairColor, _hat, _hatColor, _shoes, _shoeColor, _accessory, _accColor) {
}

function draw_drinking_human(_skintone, _outfit, _outfitColor, _hair, _hairColor, _hat, _hatColor, _shoes, _shoeColor, _accessory, _accColor) {	
}

function draw_wavephone_human(_skintone, _outfit, _outfitColor, _hair, _hairColor, _hat, _hatColor, _shoes, _shoeColor, _accessory, _accColor) {	
}

function draw_meditating_human(_skintone, _outfit, _outfitColor, _hair, _hairColor, _hat, _hatColor, _shoes, _shoeColor, _accessory, _accColor) {	
}

function draw_swimming_human(_skintone, _hair, _hairColor, _hat, _hatColor) {
	draw_sprite_part_ext(swimmingHumanBody,		0,	0,	0,							humanSheetWidth, humanSheetHeight,	0,	0,	1,	1,	_skintone,	1.0);
	// add 19 to y to correct height for hair and hat
	draw_sprite_part_ext(hairSheet,				0,	0,	humanSheetHeight * _hair,	humanSheetWidth, humanSheetHeight,	0,	19,	1,	1,	_hairColor,	1.0);
	draw_sprite_part_ext(hatSheet,				0,	0,	humanSheetHeight * _hat,	humanSheetWidth, humanSheetHeight,	0,	19,	1,	1,	_hatColor,	1.0);
}

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

function human_check_moving() {
	if abs(hmove) + abs(vmove) > 0		moving = true;
	if abs(hmove) + abs(vmove) == 0		moving = false;
}

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

// this function will get the proper coordinates by which to stretch the shadow, depending
// on the position of the sun, which will be calculated by the overworld object
function human_set_shadow_y() {
	shadowY = y + (humanSpriteHeight / 2);
}
	
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

function get_interactable() {
	if instance_exists(menu) {
		exit;
	}
	
	// talk to npc	
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
		global.dialogue	= execute_return(interactable.responseFunction);
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
	
	// check door
	if (place_meeting(pointerX, pointerY, door)) return interactions.doorCheck;
	
	// read literature
	if (place_meeting(pointerX, pointerY, literature)) return interactions.read;
	
	// check bookcase
	
	// if nothing, return noone
	return noone;
}

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
	}
}

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

function human_set_sprite() {
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
	human_set_frames();
}

// this function can be called to set the minFrame and maxFrame for a human object
function human_set_frames() {
	var minPrev	= minFrame;
	var maxPrev = maxFrame;
	
	minFrame = facing * frameCount;
	maxFrame = (facing * frameCount) + (frameCount - 1);
	
	// if they are not the same as before the calculation, change  frame to minFrame
	if (minPrev != minFrame) || (maxPrev != maxFrame)	frame = minFrame;
}

function animate_human() {
	// increment frame when appropriate
	if !(global.gameTime mod 8) frame++;

	// wrap using min and maxFrame
	if frame > maxFrame frame = minFrame;
}

function app_surface_draw_human() {
	if (sprite >= 0) {
		draw_sprite(sprite, frame, x, y);
	}
}

function human_get_depthY() {
	depthY = y + (spriteHeight / 2);
}

function human_set_depth() {
	depth = get_layer_depth(LAYER.collidableTiles) - depthY;	
}