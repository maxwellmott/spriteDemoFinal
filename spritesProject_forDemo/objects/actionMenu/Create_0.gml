/// @description Insert description here
// You can write your code in this editor

create_once(guiWidth / 2, guiHeight / 2, LAYER.meta, mouse);

outroStarted = false;
introFinished = false;

// check if x isn't too close to the right side
if (player.x > (sprite_width + 12)) {
	// set x and y if there are no positioning problems
	x = player.x - 8;
}
// if x is too close to the right side
else {
	x = player.x + sprite_width + 16;	
}

y = player.y;

// get sprite top
var st = round(y - (sprite_get_height(sprite_index)) + 3);

// get sprite right
var sr = round(x - (sprite_get_width(sprite_index) / 2) + 8);

// initialize column and row positions
colOneX		= sr - 108;
colTwoX		= sr - 59;

rowOneY		= st + 4;
rowTwoY		= st + 40;

// get button width
btnWidth = colTwoX - colOneX - 1;

// get button height
btnHeight = rowTwoY - rowOneY - 1;

// initialize all bbox lists
leftList = ds_list_create();
rightList = ds_list_create();
topList = ds_list_create();
bottomList = ds_list_create();

// use a repeat loop to populate all bbox lists
var i = 0;	repeat (ACTION_MENU_OPTIONS.HEIGHT) {
	// get rowNum
	var rowNum = i div 2;
	
	// get colNum
	var colNum = i mod 2;
	
	// initialize all bbox vars
	var left = -1;
	var right = -1;
	var top = -1;
	var bottom = -1;
	
	// use a switch statement to set the left and right
	switch (colNum) {
		case 0:	left = colOneX + btnWidth;	break;
		case 1: left = colTwoX + btnWidth;	break;
	}
	
	// get right position using left position and btnWidth
	right = left + btnWidth;
	
	// use a switch statement to set the top and bottom
	switch (rowNum) {
		case 0: top = rowOneY + btnHeight;		break;
		case 1: top = rowTwoY + btnHeight;		break;
	}
	
	// get bottom position using top position and btnHeight
	bottom = top + btnHeight;
	
	// set all bb vars to all bb lists
	leftList[| i]	= left;
	rightList[| i]	= right;
	topList[| i]	= top;
	bottomList[| i] = bottom;
	
	// increment i
	i++;
}

// create action menu grid
optionGrid = ds_grid_create(ACTION_MENU_OPTION_PARAMS.HEIGHT, ACTION_MENU_OPTIONS.HEIGHT);

// decode the action menu option grid
decode_grid(global.allActionMenuOptions, optionGrid);

// initialize selectedButton
selectedButton = 0;