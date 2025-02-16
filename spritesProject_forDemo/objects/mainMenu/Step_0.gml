/// @description Insert description here
// You can write your code in this editor

if !(introFinished) {
	if (image_index >= 8) {
		introFinished = true;	
	}
}

if (introFinished) {
	if (buttonAlpha < 1.0) {
		buttonAlpha += 0.025;
		
		shineAlpha -= 0.0125;
	}
}

if !(outroStarted) {
	if (introFinished) {
		if (global.back) 
		|| (global.start) {
			image_index = 0;
			outroStarted = true;	
		}
	}
}

var i = 0;	repeat (MAIN_MENU_BUTTONS.HEIGHT) {
	var left	= buttonLeftList[| i];
	var top		= buttonTopList[| i];
	var bottom	= buttonBottomList[| i];
	var right	= buttonRightList[| i];
	var nm		= newMenuList[| i];
	
	if (collision_rectangle(left, top, right, bottom, mouse, false, false)) {
		selectedButton = i;
		
		if (global.click) {
			// open the linked menu
			if (nm >= 0) {
				room_transition(player.x, player.y, player.facing, nm, bgm_menuTheme);
			}
		}
	}

	i++;	
}

if (global.menuDown) {
	selectedButton++;
}

if (global.menuUp) {
	selectedButton--;
}

if (selectedButton >= MAIN_MENU_BUTTONS.HEIGHT) {
	selectedButton -= MAIN_MENU_BUTTONS.HEIGHT;	
}

if (selectedButton < 0) {
	selectedButton += MAIN_MENU_BUTTONS.HEIGHT;	
}

if (global.select) {
	var nm = newMenuList[| selectedButton];
	
	room_transition(player.x, player.y, player.facing, nm, bgm_menuTheme);
}

if (outroStarted) {
	if (image_index >= 5) {
		instance_destroy(id);	
	}
}