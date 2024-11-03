create_once(0, 0, LAYER.meta, mouse);

zeroX = camera.x - (guiWidth / 2);
zeroY = camera.y - (guiHeight / 2);

speaker = global.speaker;
dialogueKey		= global.dialogueKey;
dialogueRow		= global.dialogueRow;
dialogueColumn	= -1;

responseMap = ds_map_create();

decode_map(global.playerResponses, responseMap);

dialogueGrid	= ds_grid_create(1, 1);

var eg = ds_map_find_value(responseMap, dialogueKey);

decode_grid(eg, dialogueGrid);

responseList	= ds_list_create();

var i = 1;	repeat (ds_grid_width(dialogueGrid) - 1) {
	if (dialogueGrid[# i, dialogueRow] != "0")
	&& (dialogueGrid[# i, dialogueRow] != "-1") {
		ds_list_add(responseList, dialogueGrid[# i, dialogueRow]);
	}
	
	i++;
}

responseCount = ds_list_size(responseList);

question = dialogueGrid[# 0, dialogueRow];

leftList		= ds_list_create();
rightList		= ds_list_create();
topList			= ds_list_create();
bottomList		= ds_list_create();

var rowWidth = 2;
var leftBuffer = zeroX + 12;
var bottomBuffer = (zeroY + guiHeight) - 8;

buttonSprite = spr_responseMenuButton;
buttonWidth = sprite_get_width(buttonSprite);
buttonHeight = sprite_get_height(buttonSprite);

var highestTop = 1200;

var i = 0;	repeat (responseCount) {
	var rowNum = i div rowWidth;
	var colNum = i mod rowWidth;
	
	var left	= leftBuffer + (colNum * (buttonWidth + 8)); 
	var right	= left + buttonWidth;
	
	var bottom	= bottomBuffer - (rowNum * (buttonHeight + 4));
	var top		= bottom - buttonHeight;
	
	if (top < highestTop)	highestTop = top;
	
	leftList[| i]	= left;
	rightList[| i]	= right;
	topList[| i]	= top;
	bottomList[| i]	= bottom;
	
	i++;
}

selectedResponse = 0;

questionDisplaySprite = spr_responseMenuQuestionDisplay;
questionDisplayHeight = sprite_get_height(questionDisplaySprite);
questionDisplayWidth = sprite_get_width(questionDisplaySprite);

questionDisplayX = camera.x;
questionDisplayY = highestTop - 12 - (questionDisplayHeight / 2);

questionX = questionDisplayX;
questionY = questionDisplayY;