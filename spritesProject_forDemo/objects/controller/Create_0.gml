/// @desc
enum controllerTypes {
	keyboard,
	gamepad,
	height
}

#region INITIALIZE GLOBAL VARS
global.shiftPressed		=	noone;
global.shiftReleased	=	noone;

global.click		=	noone;
global.select		=	noone;
global.back			=	noone;
global.start		=	noone;

global.rightBumper	=	noone;
global.leftBumper	=	noone;

global.char_left	=	noone;
global.char_right	=	noone;
global.char_up		=	noone;
global.char_down	=	noone;

global.menu_left	=	noone;
global.menu_right	=	noone;
global.menu_up		=	noone;
global.menu_down	=	noone;
#endregion

// initialize controllerType
global.controllerType = controllerTypes.keyboard;

// make mouse cursor invisible
window_set_cursor(cr_none);