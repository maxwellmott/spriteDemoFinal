/// @desc
enum controllerTypes {
	keyboard,
	gamepad,
	height
}

#region INITIALIZE GLOBAL VARS
global.shiftPressed		=	0;
global.shiftReleased	=	0;

global.click			=	0;
global.select			=	0;
global.back				=	0;
global.start			=	0;
						
global.rightBumper		=	0;
global.leftBumper		=	0;
						
global.charLeft			=	0;
global.charRight		=	0;
global.charUp			=	0;
global.charDown			=	0;
						
global.menuLeft			=	0;
global.menuRight		=	0;
global.menuUp			=	0;
global.menuDown			=	0;
						
global.gpMouseRight		=	0;
global.gpMouseLeft		=	0;
global.gpMouseUp		=	0;
global.gpMouseDown		=	0;

global.menuStop			=	0;

#endregion

// initialize controllerType
global.controllerType = controllerTypes.gamepad;

// make mouse cursor invisible
window_set_cursor(cr_none);