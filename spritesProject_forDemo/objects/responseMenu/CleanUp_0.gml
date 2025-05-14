/// @description Insert description here
// You can write your code in this editor

ds_map_destroy(responseMap);
ds_grid_destroy(dialogueGrid);

ds_list_destroy(responseList);

ds_list_destroy(leftList);
ds_list_destroy(rightList);
ds_list_destroy(topList);
ds_list_destroy(bottomList);

// check if this is happening because the player is in dialogue
if (speaker.object_index == npc)
|| (speaker.object_index == owSprite) {
	global.speaker	= speaker;

	// set the dialogue row
	global.dialogueRow		= dialogueRow + 1;
	global.dialogueColumn	= selectedResponse;

	// get the encoded grid of dialogue for this situation using the given npc's response function
	var eg = ds_map_find_value(global.speaker.responseMap, dialogueKey);

	// create the dialogueGrid (will be resized in the decode grid function)
	global.dialogueGrid	= ds_grid_create(0, 0);

	// decode the dialogue grid from the given encoded grid
	decode_grid(eg, global.dialogueGrid);

	create_once(0, 0, LAYER.meta, talkBubble);
}
// check if this is happening because the player is checking a bookcase
if (speaker.object_index == bookcase) {
	global.speaker = -1;
	
	// set the get the literatureID
	var lID = bookList[| selectedResponse];
	
	// get the type of object to create
	var obj = bookTypes[| selectedResponse];
	
	// create the literature
	var lit = instance_create_depth(x, y, depth, obj);
	lit.ID = lID;
	
	// destroy the bookList and bookTypes list
	ds_list_destroy(bookList);
	ds_list_destroy(bookTypes);
}