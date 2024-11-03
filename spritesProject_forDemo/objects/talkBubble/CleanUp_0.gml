if (presentGift) {
	
}

if (beginSpar) {
	global.opponent = npcs.mercurioGallant;
	spar_begin_ingame();	
}

if (ds_grid_height(dialogueGrid) > dialogueRow + 1) {
	// reset dialogueKey, dialogueColumn, and dialogueRow so the response menu knows which response grid to search for
	global.dialogueKey		= dialogueKey;
	global.dialogueColumn	= dialogueColumn;
	global.dialogueRow		= dialogueRow;
	
	// create response map for player 
}

ds_grid_destroy(emoGrid);
ds_grid_destroy(pathGrid);
ds_grid_destroy(speedGrid);
ds_list_destroy(dialogueQueue);