player_check_update_todo_list(TODO_LIST_CHECK_TYPES.DIALOGUE_PERFORMED);

global.select = 0;

if (presentGift) {
	
}

if (beginSpar) {
	global.opponent = npcs.mercurioGallant;
	spar_begin_ingame();	
}

if (ds_grid_height(dialogueGrid) > dialogueRow + 1) {
	// reset speaker, dialogueKey, and dialogueRow so the response menu knows which response grid to search for
	global.speaker			= speaker;
	global.dialogueKey		= dialogueKey;
	global.dialogueRow		= dialogueRow;
	
	create_once(x, y, LAYER.meta, responseMenu);
}

ds_grid_destroy(dialogueEmotes);
ds_grid_destroy(dialoguePaths);