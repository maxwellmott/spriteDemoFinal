/// @description Insert description here
// You can write your code in this editor

spar.turnMsg = "";

spar.sprite_index = spr_sparSwapCloud;
spar.image_index = 0;
spar.image_speed = 1;

ds_list_delete(spar.effectAlertList, 0);

if (ds_exists(effectedSprites, ds_type_list)) {
	ds_list_destroy(effectedSprites);
}

if (ds_exists(xList, ds_type_list)) {
	ds_list_destroy(xList);
}

if (ds_exists(yList, ds_type_list)) {
	ds_list_destroy(yList);
}