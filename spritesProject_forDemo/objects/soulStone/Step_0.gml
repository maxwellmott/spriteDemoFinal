/// @desc

// move up to center upon creation
if (y > targetY) {
	y -= 4;
}

// execute after reaching center 
if (y == targetY) {
	
	// fade in the proper background
	if (alpha < targetAlpha) {alpha += 0.05;}
	
	// once faded in, create the mainMenu and set it as currentMenu
	if (alpha == targetAlpha) {
		if !instance_exists(currentMenu) currentMenu = instance_create_depth(x, y, get_layer_depth(LAYER.uiFront), mainMenu);
		player.visible = false;
	}
}

// execute if currentMenu has not been changed to newMenu
if (newMenu >= 0) and (currentMenu != instanceof(newMenu)) {
	
	// execute if currentMenu is faded out
	if (currentMenu.alpha == 0.0) {
		
		// fade out proper background
		if (alpha > 0.0) {alpha -= 0.05;}
		
		// execute if faded out
		if (alpha == 0.0) {
			
			// destroy currentMenu
			instance_destroy(currentMenu);
			
			// create currentMenu from newMenu ID
			currentMenu = instance_create_depth(x, y, get_layer_depth(LAYER.uiFront), newMenu);
			
			// reset newMenu
			newMenu = noone;
		}
	}
}

// if currentMenu has been set, fade the background back in
if (currentMenu == instanceof(newMenu)) {
	if (alpha < targetAlpha) {alpha += 0.05;}
}

if (instance_exists(currentMenu)) {
	if (instance_exists(mainMenu)) {
		if (global.back) close_soulStone();
	}
	
	if (global.start) close_soulStone();
}