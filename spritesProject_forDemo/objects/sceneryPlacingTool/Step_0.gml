/// @description Insert description here
// You can write your code in this editor

if !(instance_exists(overworld))
|| (instance_exists(menu)) {
	exit;	
}

if keyboard_check_released(ord("W")) currentID += 1;
if keyboard_check_released(ord("S")) currentID -= 1;

if currentID >= sceneryIDs.height	currentID -= sceneryIDs.height;
if currentID < 0					currentID += sceneryIDs.height;

currentObjName	= grid[# sceneryParams.name, currentID];

if (device_mouse_check_button_released(0, mb_left)) {
	
		// store current x and y
		var clickX	= mouse_x;
		var clickY	= mouse_y;
		var ID		= currentID;
		var _name	= currentObjName;
		
		// get params from grid using ID
		var type		= string_digits(grid[# sceneryParams.type,			ID]);
		var spr			= string_digits(grid[# sceneryParams.sprite,		ID]);
		var mask		= string_digits(grid[# sceneryParams.mask,			ID]);

		// get the proper object and create it
		var obj		= scenery_get_object_index(type);
		var inst	= instance_create_depth(clickX, clickY, get_layer_depth(LAYER.collidableTiles), obj);
		
		// set object vars
		inst.type			= type;
		inst.spriteID		= spr;
		inst.sprite_index	= mask;
		inst.spriteWidth	= sprite_get_width(spr);
		inst.spriteHeight	= sprite_get_height(spr);

		var _x	= clickX;
		var _y	= clickY - (sprite_get_height(spr) / 2);
		
		inst.x				= _x;
		inst.y				= _y;

		inst.depth			= scenery_get_depth(_y);

		// set lightY if lamppost
		if type == sceneryTypes.lamppost {
			switch (ID) {
				case sceneryIDs.cityStreetlight:	inst.lightY = _y - 46;	inst.lightScale = 2;	break;
				case sceneryIDs.cityShortLamp:		inst.lightY = _y - 27;	inst.lightScale = 2;	break;
				case sceneryIDs.crystalLampPost:	inst.lightY = _y - 30;	inst.lightScale = 3;	break;
			}
		}
	
		// add inst to objList and params to paramList
		var params	= string(_x) + "," + string(_y) + "||" + string(_name);
		ds_list_add(objList, inst);
		ds_list_add(paramList, params);
}

if (ds_list_size(objList) > 0) {
	if (global.back) {
		// get lastNum
		var lastNum	= ds_list_size(objList) - 1;
	
		// destroy the last instance created
		instance_destroy(objList[|lastNum]);
	
		// delete its entry on both lists
		ds_list_delete(objList,		lastNum);
		ds_list_delete(paramList,	lastNum);
	}
}

if keyboard_check_released(ord("P")) {
	var i = 0;	repeat (ds_list_size(paramList)) {
		show_debug_message(paramList[|i]);
		i++;
	}
}