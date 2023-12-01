/// @desc

// check if spar is active
if (instance_exists(spar)) {
	var count = ds_list_size(spar.spriteList);
	
	var hvrSet = false;
	
	var i = 0; repeat (count) {
		// get sprite
		var inst = spar.spriteList[| i];
		
		if (collision_rectangle(inst.bbLeft, inst.bbTop, inst.bbRight, inst.bbBottom, mouse, false, false)) {
			global.hoverSprite = inst;
			hvrSet = true;
			break;
		}
		
		// increment i
		i++;
	}
	
	// if hoverSprite was not set just now and it is not -1,
	// reset hoverSprite to -1
	if !(hvrSet)
	&& (global.hoverSprite != -1) {
		global.hoverSprite = -1;	
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
if ((alarm[0] == -1) and (x == xPrev) and (y == yPrev)) {
	alarm[0] = 60;	
}

// manage click animation
if ((alarm[1] == -1) and (global.click > 0)) {
	frame = 1;
	alarm[1] = 15;	
}

// make sure x and y are on whole pixel values
x = round(x);
y = round(y);