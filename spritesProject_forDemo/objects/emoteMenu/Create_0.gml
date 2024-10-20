create_once(camera.x, camera.y, LAYER.mouse, mouse);

outroStarted = false;
introFinished = false;

// check if x isn't too close to the right side
if (player.x < (overworld.locationWidth - sprite_width - 12)) {
	// set x and y if there are no positioning problems
	x = player.x + 8;
}
// if x is too close to the right side
else {
	x = player.x - sprite_width - 16;	
}

y = player.y;

// get sprite top
var st = round(y - (sprite_get_height(sprite_index) / 2) - 8);

// get sprite left
var sl = round(x - (sprite_get_width(sprite_index) / 2) + 6.5);

colOneX		= sl + 12;
colTwoX		= sl + 61;

rowOneY		= st + 3;
rowTwoY		= st + 12;
rowThreeY	= st + 21;
rowFourY	= st + 30;
rowFiveY	= st + 39;
rowSixY		= st + 48;
rowSevenY	= st + 57;
rowEightY	= st + 66;

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
var i = 0;	repeat (emotions.height) {
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
	
	right = left + btnWidth;
	
	// use a switch statement to set the top and bottom
	switch (rowNum) {
		case 0: top = rowOneY + btnHeight;		break;
		case 1: top = rowTwoY + btnHeight;		break;
		case 2: top = rowThreeY + btnHeight;	break;
		case 3: top = rowFourY + btnHeight;		break;
		case 4: top = rowFiveY + btnHeight;		break;
		case 5:	top = rowSixY + btnHeight;		break;
		case 6: top = rowSevenY + btnHeight;	break;
		case 7: top = rowEightY + btnHeight;	break;
	}
	
	bottom = top + btnHeight;
	
	// set all bb vars to all bb lists
	leftList[| i]	= left;
	rightList[| i]	= right;
	topList[| i]	= top;
	bottomList[| i] = bottom;
	
	// increment i
	i++;
}

selectedButton = 0;

nameList = ds_list_create();

decode_list(global.emotionNames, nameList);