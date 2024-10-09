/// @description Insert description here
// You can write your code in this editor

// Inherit the parent event
event_inherited();

	// set x1 and y1 for collision rectangle
	var x1 = -1;
	var y1 = -1;
	
	// initialize x2 and y2 for collision rectangle
	var x2 = -1;
	var y2 = -1;

	// set position depending on whic direction the character is facing
	switch (facing) {		
		case directions.east:
			x1 = x;
			x2 = x + 20;
			y1 = bbox_bottom - 8;
			y2 = bbox_bottom;
		break;
		
		case directions.south:
			x1 = x - 4;
			x2 = x + 4;
			y1 = y;
			y2 = bbox_bottom + 8;
		break;
		
		case directions.west:
			x1 = x - 20;
			x2 = x;
			y1 = bbox_bottom - 8;
			y2 = bbox_bottom;
		break;
		
		case directions.north:
			x1 = x - 4;
			x2 = x + 4;
			y1 = bbox_bottom - 32;
			y2 = bbox_bottom;
		break;
	}


draw_rectangle_color(x1, y1, x2, y2, c_red, c_red, c_red, c_red, false);