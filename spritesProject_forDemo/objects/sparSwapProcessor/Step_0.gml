if (global.select) {
	var i = 0;	repeat (ds_list_size(swapList)) {
		// get sprite's instance id
		var inst = swapList[| i];
		
		with (inst) {
			spriteID = newSpriteID;
			newSpriteID = -1;
			swapping = false;
			sprite_load_parameters();
		}
		
		i++;
	}
	
	instance_destroy(id);
}