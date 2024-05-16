/// @desc
hvrSet = false;

// check if spar is active
if (instance_exists(spar)) {
	var count = ds_list_size(spar.spriteList);
	
	var i = 0; repeat (count) {
		// get sprite
		var inst = spar.spriteList[| i];
		
		if (collision_rectangle(inst.bbLeft, inst.bbTop, inst.bbRight, inst.bbBottom, mouse, false, false)) {
			if (spar.selectionPhase == selectionPhases.ally) 
			|| (spar.selectionPhase == selectionPhases.target) {
				if (global.shiftPressed) frame = 2;
				else frame = 0;
				
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
		frame = 0;
		global.hoverSprite = -1;	
	}
	
	// check if hoverSprite is currently set
	if (global.hoverSprite != -1) {
		// check if player is selecting a target
		if (spar.selectionPhase == selectionPhases.target) {
			// check if hoverSprite is on the list of out of range spots
			if (ds_list_find_index(spar.inRangeSprites, global.hoverSprite) == -1) {
				// check if frame is less than 3
				if (frame < 3) {
					// if so, add 3 to frame
					frame += 3;
				}
			}
		}
	}
}

// get input from gamepad
if (global.controllerType == controllerTypes.gamepad) {
	x += gamepad_axis_value(0, gp_axisrh);
	y += gamepad_axis_value(0, gp_axislh);
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
	frame = 1;
	alarm[1] = 15;	
}

// make sure x and y are on whole pixel values
x = round(x);
y = round(y);