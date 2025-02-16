/// @desc


switch(global.controllerType) {
	
	case controllerTypes.gamepad:
		global.shiftPressed		=	gamepad_button_check(0, gp_stickl);
		global.shiftReleased	=	gamepad_button_check(0, gp_stickl);
		
		if (gamepad_button_check_released(0, gp_stickr))
		|| (gamepad_button_check_released(0, gp_face1)) {
			global.click		=	1;
		}	else {
			global.click = 0;
		}
		
		global.select		=	gamepad_button_check_released(0, gp_face1);
		global.back			=	gamepad_button_check_released(0, gp_face2);
		global.start		=	gamepad_button_check_released(0, gp_start);
		
		global.rightBumper	=	gamepad_button_check_released(0, gp_shoulderr);
		global.leftBumper	=	gamepad_button_check_released(0, gp_shoulderl);
		
		if (gamepad_button_check_released(0, gp_select) > 0) {
			if (window_get_fullscreen() == 0) {window_set_fullscreen(1);}
			if (window_get_fullscreen() == 1) {window_set_fullscreen(0);}
		}
		
		// get the current axis (-1 -- 1) of the left analog stick
		var left_h_axis		=	gamepad_axis_value(0, gp_axislh);
		var left_v_axis		=	gamepad_axis_value(0, gp_axislv);
	
		// CHARACTER MOVEMENT
		// check if the left analog stick is at least halfway to the left (or if left on the dpad is being pressed)
		if (left_h_axis < -0.5) 
		|| (gamepad_button_check_pressed(0, gp_padl)) {
			global.charLeft = 1;	global.charRight = 0;
		}
		// otherwise, check if the left analog stick is at least halfway to the right (or if right on the dpad is being pressed)
		else if (left_h_axis > 0.5) 
		|| (gamepad_button_check_pressed(0, gp_padr)) {
			global.charLeft = 0;	global.charRight = 1;
		}
		// if the left analog stick is neither halfway to the left or to the right
		else {
			global.charLeft = 0;	global.charRight = 0;
		}
		
		// check if the left analog stick is at least halfway down (or if down on the dpad is being pressed)
		if (left_v_axis < -0.5) 
		|| (gamepad_button_check_pressed(0, gp_padu)) {
			global.charUp = 1;		global.charDown = 0;
		}
		// otherwise, check if the left analog stick is at least halfway up (or if up on the dpad is being pressed)
		else if (left_v_axis > 0.5) 
		|| (gamepad_button_check_pressed(0, gp_padd)) {
			global.charUp = 0;		global.charDown = 1;
		}
		// if the left analog stick is neither halfway up or down
		else {
			global.charUp = 0;		global.charDown = 0;
		}
		
		
		// MENU NAVIGATION
		//check if the left analog stick is at least halfway toward the center in all directions
		if (left_h_axis >= -0.5)	&&	(left_h_axis <= 0.5)
		&& (left_v_axis >= -0.5)	&&	(left_v_axis <= 0.5) {
			// set global.menuStop to back false
			global.menuStop = false;	
		}
		// if there is any motion being indicated
		else {
			if (global.menuStop) {
				global.menuUp	= 0;	global.menuDown		= 0;
				global.menuLeft = 0;	global.menuRight	= 0;
			}
		}		
		
		// check if the left analog stick is at least halfway to the left (or if left on the dpad is being pressed)
		if (left_h_axis < -0.5) 
		|| (gamepad_button_check_released(0, gp_padl)) {
			// check that global.menuStop is not still true
			if !(global.menuStop) {
				global.menuLeft = 1;	global.menuRight = 0;
				global.menuStop = true;
			}
		}	
		// otherwise, check if the left analog stick is at least halfway to the right (or if right on the dpad is being pressed)
		else if (left_h_axis > 0.5) 
		|| (gamepad_button_check_released(0, gp_padr)) {
			// check that global.menuStop is not still true
			if !(global.menuStop) {
				global.menuLeft = 0;	global.menuRight = 1;
				global.menuStop = true;
			}
		}
		// if the left analog stick is neither halfway to the left or to the right
		else {
			global.menuLeft = 0;	global.menuRight = 0;
		}
		
		if (left_v_axis < -0.5) 
		// check if the left analog stick is at least halfway down (or if down on the dpad is being pressed)
		|| (gamepad_button_check_released(0, gp_padu)) {
			// check that global.menuStop is not still true
			if !(global.menuStop) {
				global.menuUp = 1;		global.menuDown = 0;
				global.menuStop = true;
			}
		}
		else if (left_v_axis > 0.5) 
		// otherwise, check if the left analog stick is at least halfway up (or if up on the dpad is being pressed)
		|| (gamepad_button_check_released(0, gp_padd)) {
			// check that global.menuStop is not still true
			if !(global.menuStop) {
				global.menuUp = 0;		global.menuDown = 1;
				global.menuStop = true;
			}
		}
		// if the left analog stick is neither halfway up or down
		else {
			global.menuUp = 0;		global.menuDown = 0;
		}	
		
		var right_h_axis		=	gamepad_axis_value(0, gp_axisrh);
		var right_v_axis		=	gamepad_axis_value(0, gp_axisrv);
		
		if (instance_exists(mouse)) {
			mouse.x += round(3 * right_h_axis);
			mouse.y += round(3 * right_v_axis);
		}
		
		break;
		
	case controllerTypes.keyboard:
		var alt = keyboard_check(vk_alt);
		
		if (alt <= 0) {
			global.select	=	keyboard_check_released(vk_space);
		}
		else {
			if (alt > 0) {
				var enter = keyboard_check_released(vk_space);
				
				if (enter > 0) {
					if (window_get_fullscreen() == 0) {window_set_fullscreen(1);}
					if (window_get_fullscreen() == 1) {window_set_fullscreen(0);}
				}
			}
		}
		
		global.shiftPressed		=	keyboard_check(vk_shift);
		global.shiftReleased	=	keyboard_check_released(vk_shift);
		
		global.click		=	device_mouse_check_button_released(0, mb_any);
		global.back			=	keyboard_check_released(vk_tab);
		global.start		=	keyboard_check_released(vk_enter);
			
		global.rightBumper	=	keyboard_check_released(ord("0"));
		global.leftBumper	=	keyboard_check_released(ord("9"));
			
		global.menuUp		=	keyboard_check_released(ord("W"));
		global.menuLeft	=	keyboard_check_released(ord("A"));
		global.menuDown	=	keyboard_check_released(ord("S"));
		global.menuRight	=	keyboard_check_released(ord("D"));
		
		global.charUp		=	keyboard_check(ord("W"));
		global.charLeft	=	keyboard_check(ord("A"));
		global.charDown	=	keyboard_check(ord("S"));
		global.charRight	=	keyboard_check(ord("D"));
		break;
}