// this macro indicates the top position of the invisible door 
// sprite to make it easy to check if that's the type of door
// you're dealing with
#macro	invisiblePortalDoorSpriteTop	288

// enumerator containing door IDs
enum doors {
	MIRIABRAM_FOYER_TO_EXT,
	MIRIABRAM_EXT_TO_FOYER,
	MIRIABRAM_HALLWAY_TO_DORM_1,
	MIRIABRAM_DORM_1_TO_HALLWAY,
	MIRIABRAM_HALLWAY_TO_FOYER_LEFT,
	MIRIABRAM_HALLWAY_TO_FOYER_RIGHT,
	MIRIABRAM_FOYER_TO_HALLWAY_LEFT,
	MIRIABRAM_FOYER_TO_HALLWAY_RIGHT,
	height
}

// enumerator containing door params 
enum doorParams {
	ID,
	location,
	X,
	Y,
	locked,
	newLocation,
	newFacing,
	newX,
	newY,
	spriteTop,
	upperFloor,
	height
}

#region PREPARE DOOR GRID

// these variables all contain the top position for each
// respective type of door on the door sheet sprite
var firmwoodSpriteTop	= 0;
var beachStoneSpriteTop = 48;
var greenGlassSpriteTop	= 96;
var frondweaveSpriteTop	= 144;
var lavaRockSpriteTop	= 192;
var blueGlassSpriteTop	= 240;
var portalSpriteTop		= invisiblePortalDoorSpriteTop;

// create master grid
global.doorGrid = ds_grid_create(doorParams.height, doors.height);

// define add door function
function master_grid_add_door(_id, _location, _x, _y, _locked, _newLocation, _newFacing, _newX, _newY, _spriteTop, _upperFloor) {
	var i = 0; repeat (doorParams.height) {
		global.doorGrid[# i, _id] = argument[i];
		i++;
	}
}

//						ID											LOCATION					X		Y		LOCKED	NEWLOCATION					NEWFACING			NEW X	NEW Y	SPRITETOP						UPPER FLOOR
master_grid_add_door(	doors.MIRIABRAM_EXT_TO_FOYER,				locations.miriabramExt,		352,	240,	false,	locations.miriabramFoyer,	directions.north,	176,	284,	firmwoodSpriteTop,				false);
master_grid_add_door(	doors.MIRIABRAM_HALLWAY_TO_FOYER_LEFT,		locations.miriabramHallway,	128,	32,		false,	locations.miriabramFoyer,	directions.south,	512,	32,		invisiblePortalDoorSpriteTop,	false);
master_grid_add_door(	doors.MIRIABRAM_HALLWAY_TO_FOYER_RIGHT, 	locations.miriabramHallway,	512,	32,		false,	locations.miriabramFoyer,	directions.south,	128,	32,		invisiblePortalDoorSpriteTop,	false);
master_grid_add_door(	doors.MIRIABRAM_FOYER_TO_HALLWAY_LEFT,		locations.miriabramFoyer,	128,	32,		false,	locations.miriabramHallway,	directions.south,	512,	32,		invisiblePortalDoorSpriteTop,	false);
master_grid_add_door(	doors.MIRIABRAM_FOYER_TO_HALLWAY_RIGHT,		locations.miriabramFoyer,	512,	32,		false,	locations.miriabramHallway, directions.south,	128,	32,		invisiblePortalDoorSpriteTop,	false);
master_grid_add_door(	doors.MIRIABRAM_FOYER_TO_EXT,				locations.miriabramFoyer,	128,	276,	false,	locations.miriabramExt,		directions.south,	400,	276,	firmwoodSpriteTop,				true);
master_grid_add_door(	doors.MIRIABRAM_DORM_1_TO_HALLWAY,			locations.miriabramDorm1,	128,	288,	false,	locations.miriabramHallway,	directions.north,	140,	260,	firmwoodSpriteTop,				true);
master_grid_add_door(	doors.MIRIABRAM_HALLWAY_TO_DORM_1,			locations.miriabramHallway,	128,	288,	false,	locations.miriabramDorm1,	directions.north,	400,	276,	firmwoodSpriteTop,				true);

// encode master grid
global.allDoors = encode_grid(global.doorGrid);

// destroy master grid
ds_grid_destroy(global.doorGrid);
#endregion

#region DECLARE ALL DOOR FUNCTIONS

///@desc This function is called whenever the player unlocks a locked door
/// for the first time. The function then adds the ID of the door in question
/// to the unlockedDoors list, then converts it back into a string.
function player_add_unlocked_door(_doorID) {
	var list = ds_list_create();
	
	decode_list(player.unlockedDoors, list);
	
	ds_list_add(list, _doorID);
	
	player.unlockedDoors = encode_list(list);
	
	ds_list_destroy(list);
}

///@desc This function is called whenever the player tries to interact with
/// a door. The function gets the instance ID of the current door, then checks
/// if it's locked or not. If it's unlocked, then the player transitions to the 
/// room behind that door.
function door_check() {
	var inst = player.currentDoor;
	
	if (inst.locked) {		
		ds_list_push(overworld.alertStack, overworldAlerts.doorLocked);
	}
	
	if !(inst.locked) {
		inst.open = true;
		overworld_transition(inst.newX, inst.newY, inst.newFacing, inst.newLocation);
	}
}

///@desc This function takes the ID of a door from the doors enumerator and checks 
/// if it is on the player's encoded list of unlocked doors
function check_player_unlocked_door(_doorID) {
	
	var d		= _doorID;
	var list	= ds_list_create();
	
	decode_list(player.unlockedDoors, list);
	
	if (ds_list_find_index(list, d) >= 0) var returnBool = true;
	
	if (ds_list_find_index(list, d) == -1) var returnBool = false;
	
	ds_list_destroy(list);
	return returnBool;
}

///@desc This door takes the instance id of a door in the overworld and unlocks it
/// then adds it to the player's list of unlocked doors
function door_unlock(_inst) {
	_inst.locked = false;
	player_add_unlocked_door(_inst.ID);
	ds_list_push(overworld.alertStack, overworldAlerts.doorUnlocked);
}

///@desc This function is called when a new location is being loaded. The function
/// gets all of the doors that are meant to be in the current location and places them
/// all in their respective positions
function place_doors() {
	var grid = ds_grid_create(doorParams.height, doors.height);
	
	// decode door grid
	decode_grid(global.allDoors, grid);
	
	// repeat loop to check each row in the grid
	var i = 0; repeat (ds_grid_height(grid)) {
		
		// check if door's location matches player's location
		if (grid[# doorParams.location, i] == player.location) {

			// create the door
			var d = instance_create_depth(x, y, get_layer_depth(LAYER.sprites), door);
		
			// set all of its parameters			
			d.ID			= i;
			d.x				= real(grid[# doorParams.X, i]);
			d.y				= real(grid[# doorParams.Y, i]);
			var l			= real(grid[# doorParams.locked, i]);
			
			// it might be better to check the locked door list in the door_check function
			if l		d.locked = !check_player_unlocked_door(i);
			
			d.newLocation	= real(grid[# doorParams.newLocation, i]);
			d.newFacing		= real(grid[# doorParams.newFacing, i]);
			d.newX			= real(grid[# doorParams.newX, i]);
			d.newY			= real(grid[# doorParams.newY, i]);
			d.spriteTop		= real(grid[# doorParams.spriteTop, i]);
			
			if (d.spriteTop == invisiblePortalDoorSpriteTop) {
				invisiblePortalDoor = true;	
			}

			d.upperFloor	= real(grid[# doorParams.upperFloor, i]);
		}
		
		// increment i
		i++;
	}
	
	ds_grid_destroy(grid);
}

#endregion