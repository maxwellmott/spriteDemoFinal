// create an enumerator of owSprite parameters
enum OVERWORLD_SPRITE_PARAMS {
	ID,
	COLLISION_MASK,
	WALKING_ANIMATION,
	IDLE_ANIMATION,
	SPECIAL_ANIMATIONS_LIST,
	ANIMATION_SPEED,
	SPRITE_WIDTH,	
	SPRITE_HEIGHT,
	BEHAVIOR_FUNCTION,
	RESPOND_FUNCTION,
	RESPONSE_MAP,
	LOCATION_LIST,
	LOCATION_CHECK_FUNCTION,
	HEIGHT
}

// create an enumerator of owSprite states
enum OVERWORLD_SPRITE_STATES {
	IDLE,
	ERRATIC_LOOKING,
	SPINNING_CLOCKWISE,
	SPINNING_COUNTERCLOCKWISE,
	FOLLOWING_PATH,
	HORIZONTAL_DISTANCE_FROM_TARGET,
	VERTICAL_DISTANCE_FROM_TARGET,
	TENDING_SHOP,
	SPECIAL_ANIMATION,
	HEIGHT	
}

function overworld_sprite_load_parameters() {
	var g = ds_grid_create(OVERWORLD_SPRITE_PARAMS.HEIGHT, SPRITES.HEIGHT);
	decode_grid(global.allOverworldSprites, g);
	
	sprite_index		= correct_string_after_decode(g[# OVERWORLD_SPRITE_PARAMS.COLLISION_MASK,			ID]);
	walkingAnimation	= correct_string_after_decode(g[# OVERWORLD_SPRITE_PARAMS.WALKING_ANIMATION,		ID]);
	idleAnimation		= correct_string_after_decode(g[# OVERWORLD_SPRITE_PARAMS.IDLE_ANIMATION,			ID]);
	specialAnimations	= g[# OVERWORLD_SPRITE_PARAMS.SPECIAL_ANIMATIONS_LIST,	ID];
	animationSpeed		= correct_string_after_decode(g[# OVERWORLD_SPRITE_PARAMS.ANIMATION_SPEED,			ID]);
	spriteWidth			= correct_string_after_decode(g[# OVERWORLD_SPRITE_PARAMS.SPRITE_WIDTH,				ID]);
	spriteHeight		= correct_string_after_decode(g[# OVERWORLD_SPRITE_PARAMS.SPRITE_HEIGHT,			ID]);
	behaviorFunction	= correct_string_after_decode(g[# OVERWORLD_SPRITE_PARAMS.BEHAVIOR_FUNCTION,		ID]);
	respondFunction		= correct_string_after_decode(g[# OVERWORLD_SPRITE_PARAMS.RESPOND_FUNCTION,			ID]);
	responseMap			= g[# OVERWORLD_SPRITE_PARAMS.RESPONSE_MAP,				ID];
	sprite				= idleAnimation;
	
	loaded = true;
}

function overworld_sprite_get_draw_position() {
	drawX = x - (spriteWidth / 2);
	drawY = y - (spriteHeight / 2);
}

function overworld_sprite_animate() {
	if (global.gameTime mod animationSpeed == 0) {
		frame++;
		
		if (frame >= sprite_get_number(sprite)) {
			frame = 0;	
		}
	}
}

function overworld_sprite_manage_moving() {
	if (moving) {
		sprite = walkingAnimation;
	}
	else {
		sprite = idleAnimation;	
	}
}

function draw_overworld_sprite() {
	if (state != OVERWORLD_SPRITE_STATES.SPECIAL_ANIMATION) {
		draw_sprite_part(sprite, frame, 0, spriteHeight * facing, spriteWidth, spriteHeight, drawX, drawY);
	}
}

function overworld_sprite_state_machine() {
	switch (state) {
		case OVERWORLD_SPRITE_STATES.ERRATIC_LOOKING:
			if (global.gameTime mod 8 == 0) {
				randomize();
				facing = irandom_range(0, 3);
			}
		break;
		
		case OVERWORLD_SPRITE_STATES.SPINNING_CLOCKWISE:
			if (global.gameTime mod 8 == 0) {
				facing++;
				if (facing < 0) {
					facing = directions.west;	
				}
			}
		break;
		
		case OVERWORLD_SPRITE_STATES.SPINNING_COUNTERCLOCKWISE:
			if (global.gameTime mod 8 == 0) {
				facing++;
				if (facing > directions.west) {
					facing = 0;	
				}
			}
		break;
		
		case OVERWORLD_SPRITE_STATES.FOLLOWING_PATH:
			// check if the pathlist has been set
			if (pathList != -1) {
				// check if nextCoords have been set
				if (nextCoords != -1) {
					// check if x has reached target
					if (x != nextX) {
						// get difference between x and target
						var diff = nextX - x;
						
						// set moving to true
						moving = true;
						
						// check for a collision
						if !(tile_meeting(x + (diff / abs(diff)), y, overworld.tm_water, waterTileChecker)) 
						&& !(tile_meeting(x + (diff / abs(diff)), y, overworld.tm_collidables, collidableTileChecker)) 
						&& !(place_meeting(x + (diff / abs(diff)), y, sceneryCollidable)) 
						&& !(place_meeting(x + (diff / abs(diff)), y, human)) 
						&& !(place_meeting(x + (diff / abs(diff)), y, owSprite)) {
							// move x toward target by 1
							x += (diff / abs(diff));
							
							if (diff > 0)	{
								facing = directions.east;
							}
							else {			
								facing = directions.west;
							}
						}
					}
					// else, check if y has reached target
					else if (y != nextY) {
						// get difference between y and target
						var diff = nextY - y;
						
						// set moving to true
						moving = true;
						
						// check for a collision
						if !(tile_meeting(x, y + (diff / abs(diff)), overworld.tm_water, waterTileChecker)) 
						&& !(tile_meeting(x, y + (diff / abs(diff)), overworld.tm_collidables, collidableTileChecker)) 
						&& !(place_meeting(x, y + (diff / abs(diff)), sceneryCollidable)) 
						&& !(place_meeting(x, y + (diff / abs(diff)), human)) 
						&& !(place_meeting(x, y + (diff / abs(diff)), owSprite)) {
							// move y toward target by 1
							y += (diff / abs(diff));
							
							if (diff > 0) {
								facing = directions.south;
							}
							else {
								facing = directions.north;
							}
						}
					}
					// if we have reached our target
					else {
						// increment pathstep
						pathStep++;
						
						// check if we have completed the path
						if (pathStep >= ds_list_size(pathList)) {
							// check if we are looping the path
							if (loopingPath) {
								// reset pathStep
								pathStep = 0;
								
								// reset nextCoords list
								ds_list_reset(nextCoords);
								
								if (nextCoords = -1) {
									nextCoords = ds_list_create();	
								}
								
								decode_list(pathList[| pathStep], nextCoords);
								
								nextX = correct_string_after_decode(nextCoords[| 0]);
								nextY = correct_string_after_decode(nextCoords[| 1]);
							}
							// if we are not looping the path
							else {
								// destroy the pathList
								ds_list_destroy(pathList);
								
								// set pathList to -1
								pathList = -1;
								
								// set nextCoords to -1
								nextCoords = -1;
							}
						}
						// if we have not completed the path
						else {
							// reset nextCoords list
							ds_list_reset(nextCoords);
							
							if (nextCoords = -1) {
								nextCoords = ds_list_create();	
							}
							
							// decode the nextCoords
							decode_list(pathList[| pathStep], nextCoords);	
						
							// get nextX and nextY
							nextX = correct_string_after_decode(nextCoords[| 0]);
							nextY = correct_string_after_decode(nextCoords[| 1]);
							
							// check if a negative value was given to indicate a temporary change in state
							if (nextX < 0) {
								// set state as equal to the absolute value of the negative number given
								state = abs(nextX);	
								
								// set the alarm using the number given for y (this is how long we will remain in this state)
								if (alarm[0] == -1) {
									alarm[0] = nextY;	
								}
							}
						}
					}
				}
				// if nextCoords have NOT been set
				else {
					// check if we have completed the path
					if (pathStep > ds_list_size(pathList)) {
						// check if we are looping the path
						if (loopingPath) {
							// reset pathStep
							pathStep = 0;
							
							// reset nextCoords list
							ds_list_reset(nextCoords);
							
							if (nextCoords = -1) {
								nextCoords = ds_list_create();	
							}
							
							decode_list(pathList[| pathStep], nextCoords);
						}
						// if we are not looping the path
						else {
							// destroy the pathList
							ds_list_destroy(pathList);
							
							// set pathList to -1
							pathList = -1;
							
							// set nextCoords to -1
							nextCoords = -1;
						}
					}
					// if we have not completed the path
					else {
						// reset nextCoords list
						ds_list_reset(nextCoords);
						
						if (nextCoords = -1) {
							nextCoords = ds_list_create();	
						}
						
						// decode the nextCoords
						decode_list(pathList[| pathStep], nextCoords);	
					
						// get nextX and nextY
						nextX = correct_string_after_decode(nextCoords[| 0]);
						nextY = correct_string_after_decode(nextCoords[| 1]);
						
						// check if a negative value was given to indicate a temporary change in state
						if (nextX < 0) {
							// set state as equal to the absolute value of the negative number given
							state = abs(nextX);	
							
							// set the alarm using the number given for y (this is how long we will remain in this state)
							if (alarm[0] == -1) {
								alarm[0] = nextY;	
							}
						}
					}
				}
			}
		break;
		
		case OVERWORLD_SPRITE_STATES.HORIZONTAL_DISTANCE_FROM_TARGET:
		
		break;
		
		case OVERWORLD_SPRITE_STATES.VERTICAL_DISTANCE_FROM_TARGET:
		
		break;
		
		case OVERWORLD_SPRITE_STATES.TENDING_SHOP:
		
		break;
		
		case OVERWORLD_SPRITE_STATES.SPECIAL_ANIMATION:
		
		break;
	}
}
	
function overworld_sprite_set_depthY() {
	depthY = y + (spriteHeight / 2);	
}

function overworld_sprite_set_depth() {
	depth = get_layer_depth(LAYER.collidableTiles) - depthY;
}

#region		CREATE ALL SPECIAL ANIMATION LISTS
	var bookishSpecialAnimations = ds_list_create();
#endregion

#region		CREATE ALL BEHAVIOR FUNCTIONS
	
	function bookish_behavior() {
		switch (overworld.locationID) {
			case locations.miriabramLibrary:
				if (state != OVERWORLD_SPRITE_STATES.FOLLOWING_PATH) {
					state = OVERWORLD_SPRITE_STATES.FOLLOWING_PATH;
					
					var l = ds_list_create();
					decode_list(global.allPaths, l);
					
					if !(ds_exists(pathList, ds_type_list)) {
						pathList = ds_list_create();
					}
					
					decode_list(l[| PATHS.BOOKISH_LIBRARY_PATH], pathList);
					pathStep = 0;
					
					loopingPath = true;
				}
			break;
		}
	}
	
	function sparmate_behavior() {
		
	}
	
#endregion

#region		CREATE ALL RESPOND FUNCTIONS
	
	function bookish_respond() {
		// decode player todoList
		var tdl = ds_list_create();
		decode_list(player.todoList, tdl);
		
		// check if player is on first step of first quest
		if (tdl[| TASKS.PREFESTIVAL_JITTERS] == 0) {
			// FOR TESTING ONLY
			global.dialogueKey = "bookishTaskPrompt";
			
			// set the encoded grid as the value stored at the dialogueKey
			var eg = ds_map_find_value(responseMap, global.dialogueKey);
			
			return eg;	
		}
	}
	
#endregion

#region		LOAD ALL RESPONSE MAPS
	// load response maps from csv files
	var bookishResponseGrid = load_csv("DEMO_BOOKISH_ENGLISH.csv");
	
	fix_response_grid(bookishResponseGrid);
	var bookishResponseMap = ds_map_create();
	convert_grid_to_map(bookishResponseGrid, bookishResponseMap);
	
#endregion

#region		CREATE ALL LOCATION LISTS
	
	var bookishLocationList = ds_list_create();
	
	ds_list_add(bookishLocationList, locations.miriabramLibrary);
	
#endregion

#region		CREATE ALL LOCATION CHECK FUNCTIONS
	
	function bookish_location_check() {
		switch (overworld.locationID) {
			case locations.miriabramLibrary:
				var inst = instance_create_depth(200, 200, 0, owSprite);
				
				inst.ID = SPRITES.BOOKISH;
			
				x = 200;
				y = 200;
			break;
		}
	}
	
#endregion

// create the master grid of overworld sprites
global.overworldSpritesGrid = ds_grid_create(OVERWORLD_SPRITE_PARAMS.HEIGHT, SPRITES.HEIGHT);

// create a function to add to the master grid
function master_grid_add_overworld_sprite(_ID, _collisionMask, _walkingAnimation, _idleAnimation, _specialAnimationsList, _animationSpeed, _spriteWidth, spriteHeight, _behaviorFunction, _respondFunction, _responseMap, _locationList, _locationCheckFunction) {
	var i = 0;	repeat (OVERWORLD_SPRITE_PARAMS.HEIGHT) {
		global.overworldSpritesGrid[# i, _ID] = argument[i];
		
		i++;
	}
}

// add all overworld sprites to the master grid
master_grid_add_overworld_sprite(SPRITES.BOOKISH,	spr_bookishCollisionMask,	spr_bookishWalk,	spr_bookishIdle,	encode_list(bookishSpecialAnimations),	2, 24, 42, bookish_behavior, bookish_respond, encode_map(bookishResponseMap), encode_list(bookishLocationList), bookish_location_check);

// encode grid
global.allOverworldSprites = encode_grid(global.overworldSpritesGrid);