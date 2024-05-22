// these functions are used to store all important info during a transition
global.newX			= -1;
global.newY			= -1;
global.newRoom		= -1;
global.roomBuilt	= false;

///@desc This function is called whenever the game needs to transition to a totally
/// different room. The function stores all the given arguments in the global vars
/// initialized at the top of this page, then creates the transitionManager
function room_transition(_newX, _newY, _newFacing, _newRoom) {
	if (instance_exists(transitionManager)) instance_destroy(transitionManager);

	global.newX			= _newX;
	global.newY			= _newY;
	global.newFacing	= _newFacing;
	global.newRoom		= _newRoom;
	
	instance_create_depth(x, y, get_layer_depth(LAYER.meta), transitionManager);
}

///@desc This function is called whenever the game needs to transition to a different
/// overworld location. The function stores all the given arguments in the global
/// vars initialized at the top of this page, then creates the transitionManager
function overworld_transition(_newX, _newY, _newFacing, _newLocation) {
	global.newX			= _newX;
	global.newY			= _newY;
	global.newFacing	= _newFacing;
	player.location		= _newLocation;
	global.newRoom		= rm_overworld;
	create_once(0, 0, LAYER.meta, transitionManager);
}

///@desc This function is called whenever the game has finished transitioning and the
/// player's parameters need to be updated using the global vars initialized at the top
/// of this page
function player_change_room() {
	player.facing	= global.newFacing;
	player.x		= global.newX;
	player.y		= global.newY;
	global.newFacing = -1;
	global.newX = -1;
	global.newY = -1;
}