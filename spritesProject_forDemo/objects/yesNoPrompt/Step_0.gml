/// @description Insert description here
// You can write your code in this editor

index -= global.menu_up;
index += global.menu_down;

if (index > 1) index = 0;
if (index < 0) index = 1;

if !(index) {selectorX = yesButtonX;	selectorY = yesButtonY;}
if (index)	{selectorX = noButtonX;		selectorY = noButtonY;}

if (index == 0) {
	noButtonFrame = 0;	
	yesButtonFrame = 1;
	selectorFrame = 1;
	noColor = c_black;
	yesColor = c_white;
	
	if (global.select) {
		if (caller == overworldAlert) {
			overworldAlert.visible = false;
			ds_list_delete(overworld.alertStack, 0);
		}
		execute(func);
		instance_destroy(id);
	}
}

if (index == 1) {
	yesButtonFrame = 0;
	noButtonFrame = 1;
	selectorFrame = 1;
	yesColor = c_black;
	noColor = c_white;
	
	if (global.select) {
		if (caller == overworldAlert) {
			overworldAlert.visible = false;
			ds_list_delete(overworld.alertStack, 0);
		}
		instance_destroy(id);
	}
}