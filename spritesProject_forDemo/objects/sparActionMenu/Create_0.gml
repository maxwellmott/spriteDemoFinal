/// @description Insert description here
// You can write your code in this editor

x = guiWidth / 2;
y = 102;

selectedButton = -1;

actionButtons = ds_list_create();

repeat (SPAR_ACTIONS.HEIGHT) {
	instance_create_depth(x, y, get_layer_depth(LAYER.meta), sparActionButton);
}

index = 0;