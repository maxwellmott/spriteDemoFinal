/// @description Insert description here
// You can write your code in this editor

// constantly try to create the controller just in case
create_once(0, 0, LAYER.meta, controller);

// constantly try to create the camera just in case
create_once(0, 0, LAYER.meta, camera);

// keeps a timer called global.gameTime
game_timer();

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

//if global.overworld && (global.shiftReleased) debugDraw = !debugDraw;

//if !(global.gameTime mod 16)	drawNums = string(fps_real);