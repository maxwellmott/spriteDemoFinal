// @desc

if (y >= 0) {
	if !upperFloor object_set_depth();	
	if upperFloor depth = get_layer_depth(LAYER.uiFront);
}

if open {
	frame = 1;
	if (alarm[0] < 0) alarm[0] = 60;
}

if (spriteTop == invisiblePortalDoorSpriteTop) {
	if (collision_rectangle(bbox_left, bbox_top, bbox_right, bbox_bottom, player, true, false)) {
		open = true;
		overworld_transition(newX, newY, newFacing, newLocation);
	}
}

if !open frame = 0;