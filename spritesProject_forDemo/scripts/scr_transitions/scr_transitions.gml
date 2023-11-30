global.newX			= -1;
global.newY			= -1;
global.newRoom		= -1;
global.roomBuilt	= false;

function room_transition(_newX, _newY, _newFacing, _newRoom) {
	if (instance_exists(transitionManager)) instance_destroy(transitionManager);

	global.newX			= _newX;
	global.newY			= _newY;
	global.newFacing	= _newFacing;
	global.newRoom		= _newRoom;
	
	instance_create_depth(x, y, get_layer_depth(LAYER.meta), transitionManager);
}

function overworld_transition(_newX, _newY, _newFacing, _newLocation) {
	global.newX			= _newX;
	global.newY			= _newY;
	global.newFacing	= _newFacing;
	player.location		= _newLocation;
	global.newRoom		= rm_overworld;
	create_once(0, 0, LAYER.meta, transitionManager);
}

function player_change_room() {
	player.facing	= global.newFacing;
	player.x		= global.newX;
	player.y		= global.newY;
	global.newFacing = -1;
	global.newX = -1;
	global.newY = -1;
}

function ssMenu_transition(_newMenu) {
	soulStone.newMenu = _newMenu;
}

function open_soulStone() {
	create_once(camera.x, camera.y, LAYER.ui, soulStone);
	create_once(camera.x, camera.y, LAYER.uiFront, mouse);
	global.overworld = false;
}

// this must be used from within the soulStone object
function close_soulStone() {
	instance_destroy(currentMenu);
	instance_destroy(soulStone);
}