// enum containing action menu options
enum ACTION_MENU_OPTIONS {
	CHANGE_APPEARANCE,
	CAST_SPELL,
	PLAY_WAVEPHONE,
	GET_ITEM,
	HEIGHT
}

// enum containing parameters for action menu options
enum ACTION_MENU_OPTION_PARAMS {
	ID, 
	SPRITE,
	FUNCTION,
	HEIGHT
}

// create all action menu option functions
function open_appearance_editor() {
	
}

function open_overworld_spells() {
	
}

function open_wavephone_player() {
	player.state = humanStates.playingWavephone;
	
	create_once(x, y, LAYER.meta, wavephoneController);
}

function open_inventory() {
	
}

// create master grid
global.actionMenuOptionGrid = ds_grid_create(ACTION_MENU_OPTION_PARAMS.HEIGHT, ACTION_MENU_OPTIONS.HEIGHT);

// create function to add action menu options to main grid
function master_grid_add_action_menu_option(_ID) {
	var i = 0;	repeat (ACTION_MENU_OPTION_PARAMS.HEIGHT) {
		global.actionMenuOptionGrid[# i, _ID] = argument[i];
		
		i++;
	}
}

// add all action menu options to master grid
master_grid_add_action_menu_option(ACTION_MENU_OPTIONS.CHANGE_APPEARANCE,	EMPTY_SPRITE,	open_appearance_editor);
master_grid_add_action_menu_option(ACTION_MENU_OPTIONS.CAST_SPELL,			EMPTY_SPRITE,	open_overworld_spells);
master_grid_add_action_menu_option(ACTION_MENU_OPTIONS.PLAY_WAVEPHONE,		EMPTY_SPRITE,	open_wavephone_player);
master_grid_add_action_menu_option(ACTION_MENU_OPTIONS.GET_ITEM,			EMPTY_SPRITE,	open_inventory);

// encode the master grid
global.allActionMenuOptions = encode_grid(global.actionMenuOptionGrid);

// delete the temp grid
ds_grid_destroy(global.actionMenuOptionGrid);