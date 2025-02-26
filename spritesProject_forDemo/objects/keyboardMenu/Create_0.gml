// set x and y as center (this is for the pronoun window)
x = guiWidth / 2;
y = (guiHeight / 2) - 22;

// get promptID
promptID = global.keyboardPrompt;

// create temp grid
var g = ds_grid_create(KEYBOARD_PROMPT_PARAMS.HEIGHT, KEYBOARD_PROMPTS.HEIGHT);

// decode prompt grid
decode_grid(global.allKeyboardPrompts, g);

// get all params from temp grid
promptString	= g[# KEYBOARD_PROMPT_PARAMS.PROMPT_STRING,			promptID];
acceptFunction	= real(string_digits(g[# KEYBOARD_PROMPT_PARAMS.ACCEPT_FUNCTION,	promptID]));
limit			= real(g[# KEYBOARD_PROMPT_PARAMS.CHAR_LIMIT,		promptID]);

// destroy temp grid
ds_grid_destroy(g);

// initialize inputString
inputString = "";

// initialize charList and shiftList
charList = ds_list_create();
shiftList = ds_list_create();

// create temp list to store all char pairs
var l = ds_list_create();

// decode char string to temp list
decode_list(global.keyboardCharacters, l);

// use a repeat loop to add all characters to charList and shiftList
var i = 0;	repeat (ds_list_size(l)) {
	// get the encoded list stored at i on the temp list
	var el = l[| i];
	
	// initialize decoded list
	var dl = ds_list_create();
	
	// decode the encoded list
	decode_list(el, dl);

	// add first character to char list
	charList[| i] = dl[| 0];
	
	// add second character to shift list
	shiftList[| i] = dl[| 1];
	
	// destroy the decoded list
	ds_list_destroy(dl);
	
	// increment i 
	i++;
}

charCount = ds_list_size(charList) - 1;

// destroy temp list
ds_list_destroy(l);

shiftSet = false;

keyColOneX		= 20;
keyColTwoX		= 44;
keyColThreeX	= 68;
keyColFourX		= 92;
keyColFiveX		= 116;
keyColSixX		= 140;
keyColSevenX	= 164;
keyColEightX	= 188;
keyColNineX		= 212;
keyColTenX		= 236;

keyRowOneY		= 88;
keyRowTwoY		= 108;
keyRowThreeY	= 128;
keyRowFourY		= 148;

shiftKeyX = 212;
shiftKeyY = 148;

deleteKeyX = 36;
deleteKeyY = 204;

clearKeyX = guiWidth / 2;
clearKeyY = 204;

acceptKeyX = guiWidth - 36;
acceptKeyY = 204;

typeLineStartX = 36;
typeLineStartY = 167;

promptStringX = guiWidth / 2;
promptStringY = 28;

inputStringX = 40;
inputStringY = 172;

selectedKey = 0;
pressedKey = -1;

columnCount = 10;

keyLeftList		= ds_list_create();
keyTopList		= ds_list_create();
keyRightList	= ds_list_create();
keyBottomList	= ds_list_create();

// use a repeat loop to populate bbox lists
var i = 0;	repeat (charCount + 4) {
	// initialize colNum and rowNum
	var colNum = -1;
	var rowNum = -1;
	
	// initialize all sides
	var left = -1;
	var right = -1;
	var top = -1;
	var bottom = -1;
	
	// check if current key is one of the normal keys
	if (i < charCount) {
		// use mod to set colNum
		colNum = i mod columnCount;
		
		// use div to set rowNum
		rowNum = i div columnCount;
		
		// use a switch statement to set drawX
		switch (colNum) {
			case 0:		left = keyColOneX - 8;		right = left + 16;	break;
			case 1:		left = keyColTwoX - 8;		right = left + 16;	break;
			case 2:		left = keyColThreeX - 8;	right = left + 16;	break;
			case 3:		left = keyColFourX - 8;		right = left + 16;	break;
			case 4:		left = keyColFiveX - 8;		right = left + 16;	break;
			case 5:		left = keyColSixX - 8;		right = left + 16;	break;
			case 6:		left = keyColSevenX - 8;	right = left + 16;	break;
			case 7:		left = keyColEightX - 8;	right = left + 16;	break;
			case 8:		left = keyColNineX - 8;		right = left + 16;	break;
			case 9:		left = keyColTenX - 8;		right = left + 16;	break;
		}																
		
		// use a switch statement to set drawY
		switch (rowNum) {
			case 0:		top = keyRowOneY - 8;		bottom = top + 16;	break;
			case 1:		top = keyRowTwoY - 8;		bottom = top + 16;	break;
			case 2:		top = keyRowThreeY - 8;		bottom = top + 16;	break;
			case 3:		top = keyRowFourY - 8;		bottom = top + 16;	break;
		}
	}
	// if this is not one of the normal keys
	else {		
		// set sides for the shift key
		if (i == charCount)	{
			left = 192;
			top = 140;
			right = 232;
			bottom = 156;
		}
		
		// set sides for the delete key
		if (i == charCount + 1) {
			left = 8;
			top = 196;
			right = 64;
			bottom = 212;
		}
		
		// set sides for the clear key
		if (i == charCount + 2) {
			left = 100;
			top = 196;
			right = 156;
			bottom = 212;
		}
		
		// set sides for the accept key
		if (i == charCount + 3) {
			left = 192;
			top = 196;
			right = 248;
			bottom = 212;
		}
	}
	
	// add left
	keyLeftList[| i] = left;
	
	// add right
	keyRightList[| i] = right;
	
	// add top
	keyTopList[| i] = top;
	
	// add bottom
	keyBottomList[| i] = bottom;
	
	// increment i
	i++;	
}

pnMenuEntering	= false;
pnMenuExiting	= false;
pnMenuPresent	= false;

selectedPronouns = -1;

pronounWindowMaxFrame = 4;

sheButtonLeft = 32;
theyButtonLeft = 92;
heButtonLeft = 152;

sheButtonTop = 128;
theyButtonTop = 128;
heButtonTop = 128;

sheButtonRight = 56;
theyButtonRight = 116;
heButtonRight = 176;

sheButtonBottom = 140;
theyButtonBottom = 140;
heButtonBottom = 140;

global.roomBuilt = true;