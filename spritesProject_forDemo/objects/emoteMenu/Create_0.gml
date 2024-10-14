/// @description Insert description here
// You can write your code in this editor

outroStarted = false;
introFinished = false;

x = (guiWidth / 2) + 8;
y = guiHeight / 2;

// get sprite top
var st = y - (sprite_get_height(sprite_index) / 2);

// get sprite left
var sl = x - (sprite_get_width(sprite_index) / 2);

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
	var rowNum = i mod 2;
	
	// get colNum
	var colNum = i div 2;
	
	// initialize all bbox vars
	var left = -1;
	var right = -1;
	var top = -1;
	var bottom = -1;
	
	// use a switch statement to set the left and right
	switch (colNum) {
		case 0:	left = colOneX;	break;
		case 1: left = colTwoX; break;
	}
	
	right = left + btnWidth;
	
	// use a switch statement to set the top and bottom
	switch (rowNum) {
		case 0: top = rowOneY;		break;
		case 1: top = rowTwoY;		break;
		case 2: top = rowThreeY;	break;
		case 3: top = rowFourY;		break;
		case 4: top = rowFiveY;		break;
		case 5:	top = rowSixY;		break;
		case 6: top = rowSevenY;	break;
		case 7: top = rowEightY;	break;
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

pressedButton = -1;