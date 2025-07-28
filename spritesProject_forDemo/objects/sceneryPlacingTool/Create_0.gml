/// @description Insert description here
// You can write your code in this editor

window_set_cursor(cr_arrow);

currentID		= 0;

objList		= ds_list_create();
paramList	= ds_list_create();

grid		= ds_grid_create(SCENERY_PARAMS.HEIGHT, SCENERY.HEIGHT);
decode_grid(global.allScenery, grid);

currentObjName	= "";