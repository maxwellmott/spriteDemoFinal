/// @description Insert description here
// You can write your code in this editor

// constantly try to create the controller just in case
create_once(0, 0, LAYER.meta, controller);

// constantly try to create the camera just in case
create_once(0, 0, LAYER.meta, camera);

// keeps a timer called global.gameTime
game_timer();

// sets a variable called global.frame using global.gameTime and the constant, FRAMERATE
set_frame();

// handle controller presence on PC/Mac/Ubuntu

// room state machine
switch (room) {
	case rm_titleScreen:
		if !(instance_exists(titleScreen)) 	instance_create_depth(x, y, get_layer_depth(LAYER.uiBack), titleScreen);
	break;
}

// create the splashScreen object
if (room == rm_gameStart) {
	create_once(room_width / 2, room_height / 2, LAYER.sprites, splashScreen);
}

// handle scaling
if (room == scalingRoom) {
	var base_w = 768;
	var base_h = 672;
	var max_w = display_get_width();
	var max_h = display_get_height();
	var aspect = display_get_width() / display_get_height();
	if (max_w < max_h)
	    {
	    // portait
	     var VIEW_WIDTH = min(base_w, max_w);
	    var VIEW_HEIGHT = VIEW_WIDTH / aspect;
	    }
	else
	    {
	    // landscape
	    var VIEW_HEIGHT = min(base_h, max_h);
	    var VIEW_WIDTH = VIEW_HEIGHT * aspect;
	    }
	camera_set_view_size(view_camera[0], floor(VIEW_WIDTH), floor(VIEW_HEIGHT))
	view_wport[0] = max_w;
	view_hport[0] = max_h;

	application_surface_draw_enable(false);

	room_goto(rm_gameStart);	
}

if global.overworld && (keyboard_check_direct(vk_shift)) debugDraw = !debugDraw;

//if !(global.gameTime mod 16)	drawNums = string(fps_real);