/// @description Insert description here
// You can write your code in this editor

if (selectedButton != -1) {
	var func = correct_string_after_decode(optionGrid[# ACTION_MENU_OPTION_PARAMS.FUNCTION, selectedButton]);
	func();	
}

ds_list_destroy(leftList);
ds_list_destroy(rightList);
ds_list_destroy(topList);
ds_list_destroy(bottomList);

ds_grid_destroy(optionGrid);