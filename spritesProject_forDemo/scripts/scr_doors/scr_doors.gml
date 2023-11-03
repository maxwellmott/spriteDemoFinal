#macro	invisiblePortalDoorSpriteTop	288

enum doors {
	placidValleyToPit,
	pitFoyerToPlacidValley,
	pitFoyerToThePit,
	thePitToPitFoyer,
	placidValleyToVerdmanFarms,
	verdmanFarmsToPlacidValley,
	height
}

enum doorParams {
	ID,
	location,
	X,
	Y,
	hasKeypad,
	locked,
	newLocation,
	newFacing,
	newX,
	newY,
	keypadCode,
	spriteTop,
	upperFloor,
	height
}

#region prepare allDoors encoded grid
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
function master_grid_add_door(_id, _location, _x, _y, _hasKeypad, _locked, _newLocation, _newFacing, _newX, _newY, _keypadCode, _spriteTop, _upperFloor) {
	var i = 0; repeat (doorParams.height) {
		global.doorGrid[# i, _id] = argument[i];	
		i++;
	}
}

//						ID									LOCATION					X		Y		HASKP	LOCKED	NEWLOCATION					NEWFACING			NEW X	NEW Y	KEYPAD CODE	SPRITETOP				UPPER FLOOR
//master_grid_add_door(	doors.placidValleyToPit,			locations.placidValley,		672,	80,		true,	true,	locations.pitFoyer,			directions.north,	118,	118,	12345,		beachStoneSpriteTop,	false);

// encode master grid
global.allDoors = encode_grid(global.doorGrid);

// destroy master grid
ds_grid_destroy(global.doorGrid);
#endregion


#region all door related functions
// this function takes the enum ID of a door and adds that to the player's encoded unlockedDoors list
function player_add_unlocked_door(_doorID) {
	var list = ds_list_create();
	
	decode_list(player.unlockedDoors, list);
	
	ds_list_add(list, _doorID);
	
	player.unlockedDoors = encode_list(list);
	
	ds_list_destroy(list);
}

function door_check() {
	
	player.currentDoor = instance_place(player.pointerX, player.pointerY, door);
	var inst = player.currentDoor;
	
	if (inst.locked) {
		if (inst.hasKeypad) {
			ds_list_push(overworld.alertStack, overworldAlerts.keypadStart);
		}
		
		if !(inst.hasKeypad) {
			ds_list_push(overworld.alertStack, overworldAlerts.doorLocked);
		}
	}
	
	if !(inst.locked) {
		inst.open = true;
		overworld_transition(inst.newX, inst.newY, inst.newFacing, inst.newLocation);
	}
}

// this function takes the ID of a door from the doors enumerator and checks if it is
// on the player's encoded list of unlocked doors
function check_player_unlocked_door(_doorID) {
	
	var d		= _doorID;
	var list	= ds_list_create();
	
	decode_list(player.unlockedDoors, list);
	
	if (ds_list_find_index(list, d) >= 0) var returnBool = true;
	
	if (ds_list_find_index(list, d) == -1) var returnBool = false;
	
	ds_list_destroy(list);
	return returnBool;
}

// this door takes the instance id of a door in the overworld and unlocks it
function door_unlock(_inst) {
	_inst.locked = false;
	ds_list_push(overworld.alertStack, overworldAlerts.doorUnlocked);
	player_add_unlocked_door(_inst.ID);
}

// this function takes the encoded grid containing all of the doors for the location
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
			d.hasKeypad		= real(grid[# doorParams.hasKeypad, i]);
			var l			= real(grid[# doorParams.locked, i]);
			
			// it might be better to check the locked door list in the door_check function
			if l		d.locked = !check_player_unlocked_door(i);
			
			d.newLocation	= real(grid[# doorParams.newLocation, i]);
			d.newFacing		= real(grid[# doorParams.newFacing, i]);
			d.newX			= real(grid[# doorParams.newX, i]);
			d.newY			= real(grid[# doorParams.newY, i]);
			d.keypadCode	= grid[# doorParams.keypadCode, i];
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