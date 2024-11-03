/// @description Insert description here
// You can write your code in this editor

ds_map_destroy(responseMap);
ds_grid_destroy(dialogueGrid);

ds_list_destroy(responseList);

ds_list_destroy(leftList);
ds_list_destroy(rightList);
ds_list_destroy(topList);
ds_list_destroy(bottomList);

// set the speaking NPC
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