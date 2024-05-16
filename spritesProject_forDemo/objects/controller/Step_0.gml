/// @desc


switch(global.controllerType) {
	
	case controllerTypes.gamepad:
		global.shiftPressed		=	gamepad_button_check(0, gp_shoulderlb);
		global.shiftReleased	=	gamepad_button_check(0, gp_shoulderrb);
		
		global.click		=	gamepad_button_check_released(0, gp_stickr);
		global.select		=	gamepad_button_check_released(0, gp_face1);
		global.back			=	gamepad_button_check_released(0, gp_face2);
		global.start		=	gamepad_button_check_released(0, gp_start);
		
		global.menu_left	=	gamepad_button_check_released(0, gp_padl);
		global.menu_right	=	gamepad_button_check_released(0, gp_padr);
		global.menu_up		=	gamepad_button_check_released(0, gp_padu);
		global.menu_down	=	gamepad_button_check_released(0, gp_padd);

		var left_h_axis		=	gamepad_axis_value(0, gp_axislh);
		var left_v_axis		=	gamepad_axis_value(0, gp_axislv);
		
		if (gamepad_button_check_released(0, gp_select) > 0) {
			if (window_get_fullscreen() == 0) {window_set_fullscreen(1);}
			if (window_get_fullscreen() == 1) {window_set_fullscreen(0);}
		}
		
		switch (left_h_axis) {
			case -1:	global.char_left = 1;	global.char_right = 0;	break;
			case 0:		global.char_left = 0;	global.char_right = 0;	break;
			case 1:		global.char_left = 0;	global.char_right = 1;	break;
			default:	global.char_left = 0;	global.char_right = 0;	break;
		}
		
		switch (left_v_axis) {
			case -1:	global.char_down = 1;	global.char_up = 0;	break;
			case 0:		global.char_down = 0;	global.char_up = 0;	break;
			case 1:		global.char_down = 0;	global.char_up = 1;	break;
			default:	global.char_down = 0;	global.char_up = 0;	break;
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
		
		global.shiftPressed		=	keyboard_check_direct(vk_shift);
		global.shiftReleased	=	keyboard_check_released(vk_shift);
		
		global.click		=	device_mouse_check_button_released(0, mb_any);
		global.back			=	keyboard_check_released(vk_tab);
		global.start		=	keyboard_check_released(vk_enter);
			
		global.menu_left	=	keyboard_check_released(vk_left);
		global.menu_right	=	keyboard_check_released(vk_right);
		global.menu_down	=	keyboard_check_released(vk_down);
		global.menu_up		=	keyboard_check_released(vk_up);
		
		global.char_left	=	keyboard_check(vk_left);
		global.char_right	=	keyboard_check(vk_right);
		global.char_down	=	keyboard_check(vk_down);
		global.char_up		=	keyboard_check(vk_up);
		break;
}