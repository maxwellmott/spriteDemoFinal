/// @description Insert description here
// You can write your code in this editor

var connected = os_is_network_connected(false);

if (connected) {
	client = network_create_socket(network_socket_udp);	
	
	network_connect_raw(client, SERVER_ADDRESS, PORT_NUM);
	
	onlineBuffer = buffer_create(120, buffer_fixed, 120);
	
	data = ds_map_create();
}

if !(connected) {
//	instance_create_depth(x, y, get_layer_depth(LAYER.meta), networkFailureAlert);	
	instance_destroy(id);
}

// make sure mouse object exists
if !(instance_exists(mouse)) {
	instance_create_depth(mouse_x, mouse_y, get_layer_depth(LAYER.mouse), mouse);	
}

inLobby = false;

#region MAIN MENU CREATE
mmButtonX		= guiWidth / 2;

mmButtonOneY	= (guiHeight / 2) - 32;
mmButtonTwoY	= (guiHeight / 2);
mmButtonThreeY	= (guiHeight / 2) + 32;

var w = sprite_get_width(spr_onlineMainMenuButton);
var h = sprite_get_height(spr_onlineMainMenuButton);

mmButton_bboxLeft			= mmButtonX			- (w / 2);
mmButton_bboxRight			= mmButtonX			+ (w / 2);

mmButtonOne_bboxTop			= mmButtonOneY		- (h / 2);
mmButtonOne_bboxBottom		= mmButtonOneY		+ (h / 2);

mmButtonTwo_bboxTop			= mmButtonTwoY		- (h / 2);
mmButtonTwo_bboxBottom		= mmButtonTwoY		+ (h / 2);

mmButtonThree_bboxTop		= mmButtonThreeY	- (h / 2);
mmButtonThree_bboxBottom	= mmButtonThreeY	+ (h / 2);

mmButtonOneFrame			= 0;
mmButtonTwoFrame			= 0;
mmButtonThreeFrame			= 0;

mmButtonOneName				= "Find Ranked Match";
mmButtonTwoName				= "Make Private Room";
mmButtonThreeName			= "Join Private Room";

mmButtonPressed = false;
mmSelectedFunction = -4;

#endregion

#region LOBBY CREATE
labelX = 0;
labelY = 0;

roomNumX = guiWidth;
roomNumY = 0;

nameSlotOneX = 88;
nameSlotOneY = 72;

nameSlotTwoX = 168;
nameSlotTwoY = 168;

labelSprite = -1;

roomStringX = 217;
roomStringY = 11;

#endregion

searchID = "";

testActive = false;

global.roomBuilt = true;