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
		if (buttonAlpha >= 1.0) {
			if (global.back) 
			|| (global.start) {
				// push close soul stone sfx
				audio_push_sfx(sfx_closeSoulStone);
				
				image_index = 0;
				outroStarted = true;	
			}
		}
	}
}

var i = 0;	repeat (buttonCount) {
	var left	= buttonLeftList[| i];
	var top		= buttonTopList[| i];
	var bottom	= buttonBottomList[| i];
	var right	= buttonRightList[| i];
	var nm		= newMenuList[| i];
	
	if (global.click) {
		if (collision_rectangle(left, top, right, bottom, mouse, false, false)) {		
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

if (selectedButton >= buttonCount) {
	selectedButton -= buttonCount;	
}

if (selectedButton < 0) {
	selectedButton += buttonCount;	
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