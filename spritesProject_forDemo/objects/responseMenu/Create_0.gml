create_once(0, 0, LAYER.meta, mouse);

zeroX = camera.x - (guiWidth / 2);
zeroY = camera.y - (guiHeight / 2);

speaker			= global.speaker;
dialogueKey		= global.dialogueKey;
dialogueRow		= global.dialogueRow;
dialogueColumn	= -1;

responseMap		= ds_map_create();
responseList	= ds_list_create();
dialogueGrid	= ds_grid_create(1, 1);

bookList		= ds_list_create();
bookTypes		= ds_list_create();

// check if this is being created because the player is in dialogue
if (speaker.object_index == npc)
|| (speaker.object_index == owSprite) {
	decode_map(global.playerResponses, responseMap);
	
	var eg = ds_map_find_value(responseMap, dialogueKey);
	
	decode_grid(eg, dialogueGrid);
	
	var i = 1;	repeat (ds_grid_width(dialogueGrid) - 1) {
		if (dialogueGrid[# i, dialogueRow] != "0")
		&& (dialogueGrid[# i, dialogueRow] != "-1") {
			ds_list_add(responseList, dialogueGrid[# i, dialogueRow]);
		}
		
		i++;
	}
}
// check if this is being created because the player is checking a bookcase
else if (speaker.object_index == bookcase) {
	// get the book list
	ds_list_copy(bookList, speaker.bookList);
	
	// decode the literature grid
	var lg = ds_grid_create(literatureParams.height, literatureIDs.height);
	decode_grid(global.allLiterature, lg);
	
	// get the height of the bookList
	var size = ds_list_size(bookList);
	
	// use a repeat loop to populate the response map
	var i = 0;	repeat (size) {
		// get the next bookID
		var bID = bookList[| i];
		
		// get the title
		var t = lg[# literatureParams.title,	bID];
		
		// get the author
		var a = lg[# literatureParams.author,	bID];
		
		// add a combination of the title and author to the responseList
		ds_list_add(responseList, "\"" + t + "\"" + " by " + a);
		
		// add the type to bookTypes list
		ds_list_add(bookTypes, correct_string_after_decode(lg[# literatureParams.object, bID]));
		
		// increment i
		i++;
	}
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