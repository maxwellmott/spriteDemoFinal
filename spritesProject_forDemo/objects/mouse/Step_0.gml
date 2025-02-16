/// @desc
hvrSet = false;

// check if spar is active
if (instance_exists(spar)) {
	var count = ds_list_size(spar.spriteList);
	
	var i = 0; repeat (count) {
		// get sprite
		var inst = spar.spriteList[| i];
		
		if (collision_rectangle(inst.bbLeft, inst.bbTop, inst.bbRight, inst.bbBottom, mouse, false, false)) {
			if (spar.selectionPhase == SELECTION_PHASES.ALLY) 
			|| (spar.selectionPhase == SELECTION_PHASES.TARGET) {
				if (global.shiftPressed) image_index = 2;
				else image_index = 0;
				
				global.hoverSprite = inst;
				hvrSet = true;
				break;
			}
		}
		
		// increment i
		i++;
	}
	
	// if hoverSprite was not set just now and it is not -1,
	// reset hoverSprite to -1
	if !(hvrSet)
	&& (global.hoverSprite != -1) {
		image_index = 0;
		global.hoverSprite = -1;	
	}
	
	// check if hoverSprite is currently set
	if (global.hoverSprite != -1) {
		// check if player is selecting a target
		if (spar.selectionPhase == SELECTION_PHASES.TARGET) {
			// check if hoverSprite is on the list of out of range spots
			if (ds_list_find_index(spar.inRangeSprites, global.hoverSprite) == -1) {
				// check if image_index is not 3
				if (image_index != 3) {
					// if so, change image_index to 3
					image_index = 3;
				}
			}
		}
	}
}

// check if spellBookBuilder is active
if (instance_exists(spellBookBuilder)) {
	if (global.shiftPressed) image_index = 2;
	else image_index = 0;
}

// get input from gamepad
if (global.controllerType == controllerTypes.gamepad) {
	x += global.gpMouseRight;
	x -= global.gpMouseLeft;
	y += global.gpMouseDown;
	y -= global.gpMouseUp;	
	
	x = clamp(x, leftEdge, rightEdge);
	y = clamp(y, topEdge, bottomEdge);
}

// get input from mouse
if (global.controllerType == controllerTypes.keyboard) {
	x = mouse_x;
	y = mouse_y;
}

// fade out if idle (and back in if not)
if (idle) {
	if (alpha > 0.0) {
		alpha -= fadeRate;
	}
}
else {
	if (alpha < 1.0) {
		alpha += fadeRate;
	}
}

// turn to idle
if ((alarm[0] == -1) && (x == xprevious) && (y == yprevious)) {
	alarm[0] = 120;	
}

// turn back from idle
if (alarm[0] != -1) {
	if (x != xprevious) || (y != yprevious) {
		alarm[0] = -1;
		idle = false;
	}
}

// if inspecting during a spar, turn back from idle
if instance_exists(spar)
&& global.shiftPressed {
	alarm[0] = -1;
	idle = false;	
}


// manage click animation
if ((alarm[1] == -1) and (global.click > 0)) {
	image_index = 1;
	alarm[1] = 15;	
}