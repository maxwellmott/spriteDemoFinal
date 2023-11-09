enum literatureIDs {
	inhumanEntities,
	twmFirstEdition,
	twmSecondEdition,
	twmThirdEdition,
	sparmastersHandbook,
	illuminiad,							//high level magic book
	sacriLibriI,						//the standard book for learning magic
	sacriLibriII,
	sacriLibriIII,
	sacriLibriIV,
	sacriLibriV,
	epicOfTheAeons,						//genesis
	phremnsBirth,
	astralDoctrine,						//bible
	threeWitchesGrimoireVol1,
	threeWitchesGrimoireVol2,
	threeWitchesGrimoireVol3,
	cosmicTreatise,
	knightsOfAlcompasVol1,
	knightsOfAlcompasVol2,
	knightsOfAlcompasVol3,
	aBookOnSprites1,
	aBookOnSprites2,
	aBookOnSprites3,
	height
}

enum literatureParams {
	ID,
	title,
	author,
	object,
	color,
	text,
	font,
	images,
	height
}

enum bookcaseTypes {
	standardWood1,
	height
}

enum bookcaseParams {
	ID,
	type,
	facing,
	_x,
	_y,
	bookList,
	height
}

var textGrid = load_csv("LITERATURE_ENGLISH.csv");

var inhumanEntitiesImages = ds_list_create();

ds_list_add(inhumanEntitiesImages, string(spr_inhumanEntities1)+",");

var encodedImageList = encode_list(inhumanEntitiesImages);

global.literatureGrid = ds_grid_create(literatureParams.height, literatureIDs.height);

function master_grid_add_literature(_ID) {
	var i = 0; repeat (literatureParams.height) {
		global.literatureGrid[# i, _ID] = argument[i];
		
		i++;
	}
}

master_grid_add_literature(literatureIDs.inhumanEntities, "Inhuman Entities", "Gregoria Von Verstolen", guiBook, colors.brown, textGrid[# 1, literatureIDs.inhumanEntities], cursiveFont, encode_list(inhumanEntitiesImages));

global.allLiterature = encode_grid(global.literatureGrid);

function literature_get_params() {
	var tempGrid = ds_grid_create(literatureParams.height, literatureIDs.height);
	
	decode_grid(global.allLiterature, tempGrid);
	
	var colorNum	=	real(tempGrid[# literatureParams.color,		ID]);
	
	var colorList = ds_list_create();
	decode_list(global.allColors, colorList);
	
	color = real(colorList[|colorNum]);
	
	ds_list_destroy(colorList)
	
	text =	tempGrid[# literatureParams.text, ID];
	font =	real(string_digits(tempGrid[# literatureParams.font, ID]));
	
	var encList = tempGrid[# literatureParams.images,		ID];
	decode_list(encList, spriteIDs);
	
	ds_grid_destroy(tempGrid);
}

function book_build_text(_string) {
	var text = _string;
	
	var length = string_length(text);
	var last_space = 1;
	
	var currentLine = 1;
	var currentPage = 1;
	var substring = "";
	
	var height = string_height(text);
	var maxLines = pageHeight div height;
	
	var count = 1;
	while (count < length) {
		while (currentLine < maxLines) {
			// if the text signals to start a new line, do so
			if (string_char_at(_string, count) == "+") {
				text = string_delete(text, count, 1);
				text = string_insert("\n", text, count);
				currentLine++;
			}
		
			// if the text signals to start a new page, do so
			if (string_char_at(_string, count) == "|") {
				text = string_delete(text, count, 1);
				currentPage++;
			}
		
			// if the text signals to change the alignment, do so
			if (string_char_at(text, count) == "%") {
				text = string_delete(text, count, 1);
				// get the heading and remove it from the text
				var endPos = string_pos("%", text);
				var headingLength = endPos - count - 1;
				var headingString = string_copy(text, count, headingLength + 1);
				
				// get the x and y position for the heading
				var headingY = (height * (currentLine - 1)) + textY;
				if !(currentPage mod 2) var headingX = rightPageX + (pageWidth / 2);
					else var headingX = leftPageX + (pageWidth / 2);
					
				// add all heading parameters to headingGrid
				headingGrid[# 0, headingCount] = headingString;
				headingGrid[# 1, headingCount] = headingX;
				headingGrid[# 2, headingCount] = headingY;
				headingGrid[# 3, headingCount] = currentPage;
				
				// clear a line for the heading
				text = string_insert("\n", text, count);
				currentLine++;
			}
			
			// if the text signals to draw an image, get the sprite to be drawn
			// as well as the position in which to draw it
			if (string_char_at(text, count) == "*") {
				// get the ID and height of the sprite signaled by the text
				text			= string_delete(text, count, 1);
				var endPos		= string_pos("*", text);
				var imageLength = endPos - count;
				var imageString = string_copy(text, count, imageLength + 1);
				var imageIndex	= real(string_digits(imageString));
				var imageID		= real(string_digits(spriteIDs[|imageIndex]));
				var imageHeight = sprite_get_height(imageID);
				
				// delete the signal encoded in the text
				text = string_delete(text, count, imageLength + 1);
				
				// get the x and y at which to draw the image
				var imageY = (height * (currentLine - 1)) + textY;
				if !(currentPage mod 2) var imageX = rightPageX;
					else var imageX = leftPageX;
					
				// resize image grid
				var newGridY = imageCount + 1;
				ds_grid_resize(imageGrid, 4, newGridY);
					
				// add all image parameters to imageGrid
				imageGrid[# 0, imageCount] = imageID;
				imageGrid[# 1, imageCount] = imageX;
				imageGrid[# 2, imageCount] = imageY;
				imageGrid[# 3, imageCount] = currentPage;
					
				// increment imageCount
				imageCount++;
				
				// get the amount of spaces needed to be cleared for the image
				var imageLineCount = (imageHeight div height) + 1;
				
				// clear space for the image
				repeat (imageLineCount) {
					text = string_insert("\n", text, count);
				}
			}

			// copy next character while ensuring that it doesn't exceed the page width
			substring = string_copy(_string, 1, count);
			if (string_char_at(text, count) == " ") {last_space = count;}
		
			// if the next word would exceed the page width, move to the next line
			if (string_width(substring) > pageWidth) {
				text = string_delete(text, last_space, 1);
				text = string_insert("\n", text, last_space);
				currentLine++;
			}
			
			count++;		
		}
		
		// if the currentLine has moved beyond maxLines, move to the next page and start from line 1
		pages[|currentPage] = substring;
		
		count++;
		currentPage++;
		currentLine = 1;
	}
}

function scroll_build_text() {
	
}

function document_build_text() {
	
}

function place_literature(_encodedList) {
	// get local vars
	var el = _encodedList;
	
	// decode list
	var list = ds_list_create();
	decode_list(el, list);

	// get list size
	var size = ds_list_size(list);
	
	// decode the literatureGrid to a temp grid
	var grid = ds_grid_create(literatureParams.height, literatureIDs.height);
	decode_grid(global.allLiterature, grid);
	
	// use a repeat loop to get the parameters of each token and then create it
	var i = 0; repeat (size) {
		// get id and coordinates from list
		var str = list[| i];
		var params = ds_list_create();
		decode_list(str, params);
		
		var _x = real(params[|0]);
		var _y = real(params[|1]);
		var ID = real(params[|2]);
		
		var obj	= grid[# literatureParams.object,	ID];
		obj	= real(string_digits(obj));
		
		var z = scenery_get_depth(_y);
		
		var inst = instance_create_depth(_x, _y, z, literature);
		
		inst.x		= _x;
		inst.y		= _y;
		inst.ID		= ID;
		inst.obj	= obj;
		
		i++;
	}
}

function read_literature() {
	player.currentLiterature = instance_place(player.pointerX, player.pointerY, literature);
	var inst = player.currentLiterature;
	
	var lit = instance_create_depth(x, y, depth, inst.obj);
	lit.ID = inst.ID;
}